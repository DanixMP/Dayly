import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import '../core/util/date_stamp.dart';
import '../theme/app_icons.dart';
import '../theme/design_tokens.dart';

/// Film-frame metrics: dark border with a thicker bottom strip for the stamp.
class FilmFrameMetrics {
  const FilmFrameMetrics._();

  static const double borderSide = 12;
  static const double borderTop = 12;
  static const double borderBottom = 56;
  static const Color frameColor = Color(0xFF0A0A0A);
}

/// Wraps video (or a placeholder) in a dark film border with the date stamp in
/// the bottom margin — matching the record viewfinder overlay.
class FramedVideoFrame extends StatelessWidget {
  const FramedVideoFrame({
    super.key,
    required this.recordedAt,
    required this.child,
    this.locale,
    this.borderRadius = AppRadii.md,
  });

  final DateTime recordedAt;
  final Widget child;
  final String? locale;
  final Radius borderRadius;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final stamp = formatFilmDateStamp(recordedAt, locale);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: FilmFrameMetrics.frameColor,
        borderRadius: BorderRadius.all(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          FilmFrameMetrics.borderSide,
          FilmFrameMetrics.borderTop,
          FilmFrameMetrics.borderSide,
          FilmFrameMetrics.borderBottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: child),
            const SizedBox(height: AppSpacing.sm),
            Text(
              stamp,
              textAlign: TextAlign.center,
              style: tokens.type.dateDisplay.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

/// Inline video player inside a [FramedVideoFrame].
class FramedVideoPlayer extends StatefulWidget {
  const FramedVideoPlayer({
    super.key,
    required this.videoPath,
    required this.recordedAt,
    this.locale,
    this.autoPlay = true,
    this.loop = true,
    this.onTap,
  });

  final String videoPath;
  final DateTime recordedAt;
  final String? locale;
  final bool autoPlay;
  final bool loop;
  final VoidCallback? onTap;

  @override
  State<FramedVideoPlayer> createState() => _FramedVideoPlayerState();
}

class _FramedVideoPlayerState extends State<FramedVideoPlayer> {
  VideoPlayerController? _controller;
  bool _initializing = false;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  void didUpdateWidget(FramedVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      _loadVideo();
    } else if (oldWidget.loop != widget.loop && _controller != null) {
      _controller!.setLooping(widget.loop);
    }
  }

  Future<void> _loadVideo() async {
    await _controller?.dispose();
    _controller = null;
    if (!File(widget.videoPath).existsSync()) {
      if (mounted) setState(() {});
      return;
    }

    setState(() => _initializing = true);
    final controller = VideoPlayerController.file(File(widget.videoPath))
      ..setLooping(widget.loop);
    _controller = controller;

    try {
      await controller.initialize();
      if (!mounted || _controller != controller) {
        await controller.dispose();
        return;
      }
      controller.addListener(_onTick);
      if (widget.autoPlay) await controller.play();
    } catch (_) {
      await controller.dispose();
      if (mounted && _controller == controller) _controller = null;
    } finally {
      if (mounted) setState(() => _initializing = false);
    }
  }

  void _onTick() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTick);
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final controller = _controller;
    final ready = controller != null && controller.value.isInitialized;
    final playing = ready && controller.value.isPlaying;

    return FramedVideoFrame(
      recordedAt: widget.recordedAt,
      locale: widget.locale,
      child: AspectRatio(
        aspectRatio: ready ? controller.value.aspectRatio : 9 / 16,
        child: GestureDetector(
          onTap: widget.onTap ?? _togglePlayback,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ColoredBox(
                color: tokens.palette.surface,
                child: ready
                    ? FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: controller.value.size.width,
                          height: controller.value.size.height,
                          child: VideoPlayer(controller),
                        ),
                      )
                    : Center(
                        child: _initializing
                            ? Icon(
                                AppIcons.film,
                                size: 40,
                                color: tokens.palette.textSecondary,
                              )
                            : Icon(
                                AppIcons.film,
                                size: 40,
                                color: tokens.palette.accent,
                              ),
                      ),
              ),
              if (ready && !playing)
                ColoredBox(
                  color: const Color(0x66000000),
                  child: Center(
                    child: Icon(
                      AppIcons.play,
                      size: 48,
                      color: tokens.palette.textPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
