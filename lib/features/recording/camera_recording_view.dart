import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/services/ffmpeg_service.dart';
import '../../core/services/permission_service.dart';
import '../../core/services/storage_service.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';

const _minClipMs = 1000;
const _maxClipMs = 10000;

/// The real camera viewfinder + hold-to-record interaction (Design.MD §6.1).
/// Mobile only — [RecordingScreen] branches to this when a camera is present.
class CameraRecordingView extends ConsumerStatefulWidget {
  const CameraRecordingView({super.key});

  @override
  ConsumerState<CameraRecordingView> createState() =>
      _CameraRecordingViewState();
}

class _CameraRecordingViewState extends ConsumerState<CameraRecordingView>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  int _cameraIndex = 0;

  bool _permissionDenied = false;
  bool _cameraError = false;
  bool _recording = false;
  bool _tooShort = false;

  Timer? _ticker;
  DateTime? _startedAt;
  int _elapsedMs = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setup();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      c.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initController(_cameras[_cameraIndex]);
    }
  }

  Future<void> _setup() async {
    final granted = await PermissionService.requestCameraAndMic();
    if (!mounted) return;
    if (!granted) {
      setState(() => _permissionDenied = true);
      return;
    }
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() => _cameraError = true);
        return;
      }
      _cameraIndex = _cameras.indexWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
      );
      if (_cameraIndex < 0) _cameraIndex = 0;
      await _initController(_cameras[_cameraIndex]);
    } catch (_) {
      if (mounted) setState(() => _cameraError = true);
    }
  }

  Future<void> _initController(CameraDescription description) async {
    final controller = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: true,
    );
    try {
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _cameraError = false;
      });
    } catch (_) {
      if (mounted) setState(() => _cameraError = true);
    }
  }

  Future<void> _flipCamera() async {
    if (_cameras.length < 2 || _recording) return;
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    await _controller?.dispose();
    if (mounted) setState(() => _controller = null);
    await _initController(_cameras[_cameraIndex]);
  }

  Future<void> _startRecording() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized || c.value.isRecordingVideo) return;
    try {
      await c.startVideoRecording();
    } catch (_) {
      return;
    }
    _startedAt = DateTime.now();
    setState(() {
      _recording = true;
      _tooShort = false;
      _elapsedMs = 0;
    });
    _ticker = Timer.periodic(const Duration(milliseconds: 50), (_) {
      final ms = DateTime.now().difference(_startedAt!).inMilliseconds;
      setState(() => _elapsedMs = ms);
      if (ms >= _maxClipMs) _stopRecording();
    });
  }

  Future<void> _stopRecording() async {
    final c = _controller;
    if (c == null || !c.value.isRecordingVideo) return;
    _ticker?.cancel();
    final durationMs = _elapsedMs;
    setState(() => _recording = false);

    final XFile raw;
    try {
      raw = await c.stopVideoRecording();
    } catch (_) {
      return;
    }

    // Discard takes shorter than the 1s minimum.
    if (durationMs < _minClipMs) {
      await StorageService.deleteFiles([raw.path]);
      if (mounted) setState(() => _tooShort = true);
      return;
    }

    final dest = await StorageService.newClipPath();
    await File(raw.path).copy(dest);
    await StorageService.deleteFiles([raw.path]);
    final thumb = await FFmpegService.generateThumbnail(dest);

    if (!mounted) return;
    context.push(
      '/preview',
      extra: {
        'videoPath': dest,
        'thumbnailPath': thumb,
        'durationMs': durationMs.clamp(_minClipMs, _maxClipMs),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final controller = _controller;

    if (_permissionDenied) {
      return _Centered(
        icon: AppIcons.record,
        message: t.recordPermissionDenied,
        actionLabel: t.recordGrantPermission,
        onAction: () {
          setState(() => _permissionDenied = false);
          _setup();
        },
      );
    }
    if (_cameraError) {
      return _Centered(icon: AppIcons.film, message: t.recordCameraError);
    }
    if (controller == null || !controller.value.isInitialized) {
      return Container(
        color: p.background,
        child: Center(
          child: Icon(AppIcons.film, size: 48, color: p.textSecondary),
        ),
      );
    }

    final progress = (_elapsedMs / _maxClipMs).clamp(0.0, 1.0);
    final seconds = (_elapsedMs / 1000).floor();
    final now = DateTime.now();

    return Container(
      color: p.background,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Viewfinder (cover-fit the preview into the available space).
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.previewSize?.height ?? 1080,
              height: controller.value.previewSize?.width ?? 1920,
              child: CameraPreview(controller),
            ),
          ),

          // Date stamp, bottom-left (DM Serif via tokens).
          Positioned(
            left: AppSpacing.lg,
            bottom: 160,
            child: Text(
              '${DateFormat('EEE d').format(now).toUpperCase()} · '
              '${DateFormat('MMM yyyy').format(now).toUpperCase()}',
              style: tokens.type.dateDisplay.copyWith(fontSize: 22),
            ),
          ),

          // Flip camera, top-right.
          if (_cameras.length > 1)
            Positioned(
              top: AppSpacing.md,
              right: AppSpacing.md,
              child: _GlassButton(
                icon: AppIcons.flipCamera,
                onTap: _flipCamera,
              ),
            ),

          // Record button + captions, centered bottom.
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSpacing.xxl,
            child: Column(
              children: [
                GestureDetector(
                  onLongPressStart: (_) => _startRecording(),
                  onLongPressEnd: (_) => _stopRecording(),
                  child: _RecordButton(
                    recording: _recording,
                    progress: progress,
                    accent: p.accent,
                    recordingColor: p.danger,
                    idleCenter: p.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _recording ? t.settingsSeconds(seconds) : t.recordHold,
                  style: tokens.type.body.copyWith(color: p.textPrimary),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _tooShort ? t.recordTooShort(1) : t.recordHint(1, 10),
                  style: tokens.type.caption.copyWith(
                    color: _tooShort ? p.danger : p.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Idle: amber ring + light center. Recording: pulsing red fill with an arc
/// timer sweeping the ring (Design.MD §7.2 record button behavior).
class _RecordButton extends StatelessWidget {
  const _RecordButton({
    required this.recording,
    required this.progress,
    required this.accent,
    required this.recordingColor,
    required this.idleCenter,
  });

  final bool recording;
  final double progress;
  final Color accent;
  final Color recordingColor;
  final Color idleCenter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 96,
      child: CustomPaint(
        painter: _RingPainter(
          progress: recording ? progress : 0,
          ring: accent,
          sweep: recordingColor,
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: recording ? 44 : 64,
            height: recording ? 44 : 64,
            decoration: BoxDecoration(
              color: recording ? recordingColor : idleCenter,
              borderRadius: BorderRadius.circular(recording ? 8 : 64),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.ring,
    required this.sweep,
  });

  final double progress;
  final Color ring;
  final Color sweep;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - 6) / 2;
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = ring;
    canvas.drawCircle(center, radius, base);

    if (progress > 0) {
      final arc = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..color = sweep;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        arc,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.ring != ring || old.sweep != sweep;
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.tokens.palette;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: p.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(icon, size: 22, color: p.textPrimary),
      ),
    );
  }
}

class _Centered extends StatelessWidget {
  const _Centered({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final p = tokens.palette;
    return Container(
      color: p.background,
      padding: const EdgeInsets.all(AppSpacing.xl),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: p.accent),
          const SizedBox(height: AppSpacing.lg),
          Text(
            message,
            textAlign: TextAlign.center,
            style: tokens.type.body.copyWith(color: p.textPrimary),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: AppSpacing.lg),
            GestureDetector(
              onTap: onAction,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: p.accent,
                  borderRadius: const BorderRadius.all(AppRadii.md),
                ),
                child: Text(
                  actionLabel!,
                  style: tokens.type.label.copyWith(color: p.background),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
