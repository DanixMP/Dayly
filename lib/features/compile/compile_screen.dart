import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/ffmpeg_service.dart';
import '../../l10n/app_localizations.dart';
import '../../models/clip.dart';
import '../../state/diary_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/ui_kit.dart';

/// Compile screen (Design.MD §6.2). On Android/iOS this runs the real FFmpeg
/// concat merge with live progress; on desktop it falls back to a simulated
/// run so the flow and progress UI stay testable across UI kits.
class CompileScreen extends ConsumerStatefulWidget {
  const CompileScreen({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  ConsumerState<CompileScreen> createState() => _CompileScreenState();
}

class _CompileScreenState extends ConsumerState<CompileScreen> {
  Timer? _timer;
  double? _progress; // null = idle
  bool _failed = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _compile(List<Clip> clips) async {
    if (clips.isEmpty) return;
    setState(() {
      _progress = 0;
      _failed = false;
    });

    // Oldest → newest so the film reads chronologically.
    final ordered = clips.reversed.toList();
    final totalMs = ordered.fold<int>(0, (s, c) => s + c.durationMs);

    if (FFmpegService.isSupported) {
      final withVideo = ordered.where((c) => c.videoPath != null).toList();
      if (withVideo.isEmpty) {
        setState(() => _failed = true);
        return;
      }
      try {
        final output = await FFmpegService.mergeClips(
          clips: withVideo,
          totalDurationMs: totalMs,
          onProgress: (v) {
            if (mounted) setState(() => _progress = v);
          },
        );
        if (mounted) context.pushReplacement('/player', extra: output);
      } catch (_) {
        if (mounted) setState(() => _failed = true);
      }
    } else {
      // Desktop/web: simulate progress over the clip count.
      var current = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 220), (timer) {
        current++;
        if (mounted) setState(() => _progress = current / ordered.length);
        if (current >= ordered.length) {
          timer.cancel();
          if (mounted) context.pushReplacement('/player');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final clips = ref.watch(diaryProvider);
    final total = clips.length;
    final seconds = clips.fold<int>(
      0,
      (sum, c) => sum + (c.durationMs / 1000).round(),
    );
    final compiling = _progress != null && !_failed;
    final percent = ((_progress ?? 0) * 100).round();

    return AppScaffold(
      leading: widget.showBackButton
          ? AppIconButton(
              icon: AppIcons.back,
              tooltip: t.commonBack,
              onPressed: () => context.pop(),
            )
          : null,
      title: Text(t.compileTitle, style: tokens.type.sectionTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          128,
        ),
        children: [
          Text(t.compileDateRange, style: tokens.type.label),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Row(
              children: [
                const Icon(AppIcons.film, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    t.compileClips(total, seconds),
                    style: tokens.type.bodyStrong,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (compiling) ...[
            AppProgressBar(value: _progress),
            const SizedBox(height: AppSpacing.sm),
            Text(t.compilePercent(percent), style: tokens.type.caption),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (_failed) ...[
            Text(
              t.compileFailed,
              style: tokens.type.caption.copyWith(color: tokens.palette.danger),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          AppButton(
            variant: AppButtonVariant.primary,
            expand: true,
            leading: const Icon(AppIcons.play, size: 16),
            onPressed: (total == 0 || compiling) ? null : () => _compile(clips),
            child: Text(total == 0 ? t.compileNoClips : t.compileButton),
          ),
        ],
      ),
    );
  }
}
