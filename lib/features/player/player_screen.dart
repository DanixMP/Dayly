import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:saver_gallery/saver_gallery.dart';

import '../../core/platform.dart';
import '../../l10n/app_localizations.dart';
import '../../models/clip.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/framed_video.dart';
import '../../ui/ui_kit.dart';
import 'package:video_player/video_player.dart';

/// Player screen (Design.MD §6.2 / PlayerScreen). Plays the compiled film when
/// a path is supplied (mobile) and exports it to the gallery; on desktop or
/// with no film it shows the empty-state surface through the active [UiKit].
class PlayerScreen extends ConsumerStatefulWidget {
  const PlayerScreen({super.key, this.videoPath, this.clip});

  final String? videoPath;
  final Clip? clip;

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

enum _SaveState { idle, saving, saved, failed, shareUnavailable }

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  VideoPlayerController? _controller;
  _SaveState _save = _SaveState.idle;

  bool get _hasFilm {
    final path = widget.clip?.videoPath ?? widget.videoPath;
    return path != null && isMobilePlatform && File(path).existsSync();
  }

  String? get _path => widget.clip?.videoPath ?? widget.videoPath;

  @override
  void initState() {
    super.initState();
    if (_hasFilm && widget.clip == null) {
      _controller = VideoPlayerController.file(File(_path!))
        ..initialize().then((_) {
          if (!mounted) return;
          setState(() {});
          _controller?.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _saveToGallery() async {
    final path = _path;
    if (path == null) return;
    setState(() => _save = _SaveState.saving);
    try {
      final result = await SaverGallery.saveFile(
        filePath: path,
        fileName: path.split('/').last,
        androidRelativePath: 'Movies/Dayly',
        skipIfExists: false,
      );
      setState(
        () => _save = result.isSuccess ? _SaveState.saved : _SaveState.failed,
      );
    } catch (_) {
      setState(() => _save = _SaveState.failed);
    }
  }

  String? _saveMessage(AppLocalizations t) {
    switch (_save) {
      case _SaveState.saved:
        return t.playerSaved;
      case _SaveState.failed:
        return t.playerSaveFailed;
      case _SaveState.shareUnavailable:
        return t.playerShareUnavailable;
      case _SaveState.idle:
      case _SaveState.saving:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final controller = _controller;
    final ready = controller != null && controller.value.isInitialized;
    final message = _saveMessage(t);

    return AppScaffold(
      leading: AppIconButton(
        icon: AppIcons.back,
        tooltip: t.commonBack,
        onPressed: () => context.go('/compile'),
      ),
      title: Text(t.appTitle, style: tokens.type.sectionTitle),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Expanded(
              child: widget.clip != null && _hasFilm
                  ? FramedVideoPlayer(
                      videoPath: _path!,
                      recordedAt: widget.clip!.recordedAt,
                      loop: false,
                    )
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: p.surface,
                        borderRadius: const BorderRadius.all(AppRadii.lg),
                        border: Border.all(color: p.border),
                      ),
                      child: ready
                          ? _Player(controller: controller, accent: p.accent)
                          : Center(
                              child: _hasFilm
                                  ? Icon(
                                      AppIcons.film,
                                      size: 48,
                                      color: p.accent,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(
                                        AppSpacing.xl,
                                      ),
                                      child: Text(
                                        t.playerEmpty,
                                        textAlign: TextAlign.center,
                                        style: tokens.type.body,
                                      ),
                                    ),
                            ),
                    ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(t.appTagline, style: tokens.type.body),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                message,
                style: tokens.type.caption.copyWith(
                  color: _save == _SaveState.saved ? p.success : p.danger,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    variant: AppButtonVariant.secondary,
                    expand: true,
                    leading: const Icon(AppIcons.share, size: 16),
                    onPressed: () =>
                        setState(() => _save = _SaveState.shareUnavailable),
                    child: Text(t.playerShare),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppButton(
                    variant: AppButtonVariant.primary,
                    expand: true,
                    leading: const Icon(AppIcons.save, size: 16),
                    onPressed: (!_hasFilm || _save == _SaveState.saving)
                        ? null
                        : _saveToGallery,
                    child: Text(t.playerSave),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Minimal, UI-kit-agnostic playback surface: tap to play/pause + a scrubber
/// tinted with the accent color.
class _Player extends StatelessWidget {
  const _Player({required this.controller, required this.accent});

  final VideoPlayerController controller;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(AppRadii.lg),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => controller.value.isPlaying
                ? controller.pause()
                : controller.play(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: accent,
                bufferedColor: accent.withValues(alpha: 0.3),
                backgroundColor: accent.withValues(alpha: 0.12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
