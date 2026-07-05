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

class StatsVideosScreen extends ConsumerWidget {
  const StatsVideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final clips = ref.watch(diaryProvider);
    final streak = ref.watch(streakProvider);
    final seconds = clips.fold<int>(
      0,
      (sum, clip) => sum + (clip.durationMs / 1000).round(),
    );
    final locale = Localizations.localeOf(context).toString();
    final recent = clips.take(12).toList();

    return AppScaffold(
      title: Text(t.statsTitle, style: tokens.type.sectionTitle),
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
            child: Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    icon: AppIcons.film,
                    label: t.statsClipsLabel,
                    value: t.statsClipCount(clips.length),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _MetricCard(
                    icon: AppIcons.stats,
                    label: t.statsDurationLabel,
                    value: t.statsDuration(seconds),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          StaggeredEntrance(
            index: 1,
            child: _MetricCard(
              icon: AppIcons.today,
              label: t.statsStreakLabel,
              value: t.diaryStreak(streak),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          StaggeredEntrance(
            index: 2,
            child: Text(t.statsRecentVideos, style: tokens.type.label),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (clips.isEmpty)
            StaggeredEntrance(
              index: 3,
              child: AppCard(child: Text(t.statsEmpty, style: tokens.type.body)),
            )
          else
            for (var i = 0; i < recent.length; i++) ...[
              StaggeredEntrance(
                index: 3 + i,
                child: _ClipTile(clip: recent[i], locale: locale),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: tokens.palette.accent),
          const SizedBox(height: AppSpacing.sm),
          Text(label, style: tokens.type.caption),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: tokens.type.bodyStrong),
        ],
      ),
    );
  }
}

class _ClipTile extends StatelessWidget {
  const _ClipTile({required this.clip, required this.locale});

  final Clip clip;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final seconds = (clip.durationMs / 1000).round();
    final hasVideo = clip.videoPath != null;

    return AppListTile(
      leadingIcon: AppIcons.play,
      title: Text(
        DateFormat.yMMMd(locale).format(clip.recordedAt),
        style: tokens.type.bodyStrong,
      ),
      subtitle: Text(
        DateFormat.jm(locale).format(clip.recordedAt),
        style: tokens.type.caption,
      ),
      trailing: Text(t.settingsSeconds(seconds), style: tokens.type.label),
      onTap: hasVideo
          ? () => context.push('/player', extra: clip)
          : null,
    );
  }
}
