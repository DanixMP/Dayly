import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../l10n/app_localizations.dart';
import '../../models/clip.dart';
import '../../state/diary_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/framed_video.dart';
import '../../ui/ui_kit.dart';

/// Confirm / retake after recording (Design.MD §6.1). Receives the recorded
/// file via go_router `extra`; on save it persists a [Clip] through the diary
/// repository and returns to the diary.
class ClipPreviewScreen extends ConsumerStatefulWidget {
  const ClipPreviewScreen({super.key, required this.args});

  final Map<String, Object?> args;

  @override
  ConsumerState<ClipPreviewScreen> createState() => _ClipPreviewScreenState();
}

class _ClipPreviewScreenState extends ConsumerState<ClipPreviewScreen> {
  bool _saving = false;

  String get _videoPath => widget.args['videoPath'] as String;
  String? get _thumbnailPath => widget.args['thumbnailPath'] as String?;
  int get _durationMs => widget.args['durationMs'] as int? ?? 1000;

  Future<void> _save() async {
    setState(() => _saving = true);
    final clip = Clip(
      uid: const Uuid().v4(),
      recordedAt: DateTime.now(),
      durationMs: _durationMs,
      videoPath: _videoPath,
      thumbnailPath: _thumbnailPath,
    );
    await ref.read(diaryProvider.notifier).add(clip);
    if (mounted) context.go('/calendar');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final recordedAt = DateTime.now();
    final hasFile = File(_videoPath).existsSync();

    return AppScaffold(
      leading: AppIconButton(
        icon: AppIcons.back,
        tooltip: t.commonRetake,
        onPressed: () => context.pop(),
      ),
      title: Text(t.previewTitle, style: tokens.type.sectionTitle),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Expanded(
              child: hasFile
                  ? FramedVideoPlayer(
                      videoPath: _videoPath,
                      recordedAt: recordedAt,
                      autoPlay: true,
                      loop: true,
                    )
                  : FramedVideoFrame(
                      recordedAt: recordedAt,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Center(
                          child: Icon(
                            AppIcons.film,
                            size: 48,
                            color: p.accent,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    variant: AppButtonVariant.secondary,
                    expand: true,
                    onPressed: _saving ? null : () => context.pop(),
                    child: Text(t.commonRetake),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppButton(
                    variant: AppButtonVariant.primary,
                    expand: true,
                    leading: const Icon(AppIcons.check, size: 16),
                    onPressed: _saving ? null : _save,
                    child: Text(t.commonSave),
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
