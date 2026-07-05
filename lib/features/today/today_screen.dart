import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../../models/clip.dart';
import '../../state/diary_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/motion/app_motion.dart';
import '../../ui/ui_kit.dart';
import '../day_note/day_note_editor.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final locale = Localizations.localeOf(context).toString();
    final clips = ref.watch(diaryProvider);
    final hasClipToday = ref.watch(hasClipTodayProvider);
    final streak = ref.watch(streakProvider);
    final todayClip = _todayClip(clips);

    return AppScaffold(
      title: Text(t.todayTitle, style: tokens.type.sectionTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          128,
        ),
        children: [
          StaggeredEntrance(
            index: 0,
            child: Text(
              DateFormat.yMMMMEEEEd(locale).format(DateTime.now()),
              style: tokens.type.dateDisplay,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          StaggeredEntrance(
            index: 1,
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        hasClipToday ? AppIcons.check : AppIcons.today,
                        color: hasClipToday ? p.success : p.accent,
                        size: 28,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          hasClipToday
                              ? t.todayRecordedTitle
                              : t.todayUnrecordedTitle,
                          style: tokens.type.sectionTitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    hasClipToday ? t.todayRecordedBody : t.todayUnrecordedBody,
                    style: tokens.type.body,
                  ),
                  if (todayClip != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      t.todayClipSummary(
                        DateFormat.jm(locale).format(todayClip.recordedAt),
                        (todayClip.durationMs / 1000).round(),
                      ),
                      style: tokens.type.caption,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          StaggeredEntrance(
            index: 2,
            child: AppButton(
              variant: AppButtonVariant.primary,
              expand: true,
              leading: const Icon(AppIcons.record, size: 16),
              onPressed: () => context.push('/record'),
              child: Text(
                hasClipToday ? t.todayRecordAgainCta : t.todayRecordCta,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          StaggeredEntrance(
            index: 3,
            child: DayNoteEditor(dateKey: _todayDateKey()),
          ),
          const SizedBox(height: AppSpacing.lg),
          StaggeredEntrance(
            index: 4,
            child: AppCard(
              child: Row(
                children: [
                  const Icon(AppIcons.film, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      t.diaryStreak(streak),
                      style: tokens.type.bodyStrong,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Clip? _todayClip(List<Clip> clips) {
    final key = _todayDateKey();
    for (final clip in clips) {
      if (clip.dateKey == key) return clip;
    }
    return null;
  }

  String _todayDateKey() {
    final now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }
}
