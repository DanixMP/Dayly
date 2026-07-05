import 'dart:io';

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
import '../../ui/framed_video.dart';
import '../../ui/motion/app_motion.dart';
import '../../ui/ui_kit.dart';
import '../day_note/day_note_editor.dart';

/// Groups [clips] by calendar date key, newest first within each day.
Map<String, List<Clip>> groupClipsByDate(List<Clip> clips) {
  final grouped = <String, List<Clip>>{};
  for (final clip in clips) {
    grouped.putIfAbsent(clip.dateKey, () => []).add(clip);
  }
  for (final list in grouped.values) {
    list.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
  }
  return grouped;
}

class DiaryScreen extends ConsumerStatefulWidget {
  const DiaryScreen({super.key});

  @override
  ConsumerState<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
  String? _selectedDateKey;
  String? _selectedClipUid;

  @override
  void initState() {
    super.initState();
    _selectedDateKey = _dateKeyFor(DateTime.now());
  }

  static String _dateKeyFor(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  void _selectDay(String dateKey, {String? clipUid, List<Clip>? dayClips}) {
    final clipsForDay = dayClips ?? const <Clip>[];
    setState(() {
      _selectedDateKey = dateKey;
      if (clipUid != null) {
        _selectedClipUid = clipUid;
      } else if (clipsForDay.isNotEmpty) {
        _selectedClipUid = clipsForDay.first.uid;
      } else {
        _selectedClipUid = null;
      }
    });
  }

  void _selectClip(Clip clip) {
    setState(() {
      _selectedDateKey = clip.dateKey;
      _selectedClipUid = clip.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final clips = ref.watch(diaryProvider);
    final dayNotes = ref.watch(dayNotesProvider);
    final streak = ref.watch(streakProvider);
    final locale = Localizations.localeOf(context).toString();

    final clipsByDate = groupClipsByDate(clips);
    final selectedKey = _selectedDateKey;
    final dayClips = selectedKey == null
        ? const <Clip>[]
        : clipsByDate[selectedKey] ?? const <Clip>[];
    final selectedClip = _clipForUid(dayClips, _selectedClipUid);
    final selectedDate = selectedKey == null
        ? null
        : _parseDateKey(selectedKey);

    return AppScaffold(
      title: Text(t.tabCalendar, style: tokens.type.sectionTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          128,
        ),
        children: [
          StaggeredEntrance(
            index: 0,
            child: Text(
              DateFormat.yMMMM(locale).format(DateTime.now()),
              style: tokens.type.monthHeader,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          StaggeredEntrance(
            index: 1,
            child: _MonthCalendar(
              clipsByDate: clipsByDate,
              dayNotes: dayNotes,
              selectedDateKey: selectedKey,
              onDayTap: (key) => _selectDay(
                key,
                dayClips: clipsByDate[key] ?? const [],
              ),
            ),
          ),
          if (selectedDate != null) ...[
            const SizedBox(height: AppSpacing.lg),
            StaggeredEntrance(
              index: 2,
              child: _DayDetailPanel(
                date: selectedDate,
                dateKey: selectedKey!,
                dayClips: dayClips,
                selectedClip: selectedClip,
                locale: locale,
                onClipSelected: _selectClip,
              ),
            ),
          ],
          if (clips.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            StaggeredEntrance(
              index: 3,
              child: Text(t.diaryRecentSection, style: tokens.type.label),
            ),
            const SizedBox(height: AppSpacing.sm),
            StaggeredEntrance(
              index: 4,
              child: _RecentStrip(
                clips: clips,
                locale: locale,
                selectedClipUid: _selectedClipUid,
                onClipTap: _selectClip,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            StaggeredEntrance(
              index: 5,
              child: _StreakCard(label: t.diaryStreak(streak)),
            ),
          ] else ...[
            const SizedBox(height: AppSpacing.xl),
            StaggeredEntrance(
              index: 3,
              child: AppCard(
                child: Text(
                  t.diaryEmpty,
                  textAlign: TextAlign.center,
                  style: tokens.type.body,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Clip? _clipForUid(List<Clip> dayClips, String? uid) {
    if (dayClips.isEmpty) return null;
    if (uid == null) return dayClips.first;
    for (final clip in dayClips) {
      if (clip.uid == uid) return clip;
    }
    return dayClips.first;
  }

  DateTime _parseDateKey(String key) {
    final parts = key.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }
}

class _DayDetailPanel extends StatelessWidget {
  const _DayDetailPanel({
    required this.date,
    required this.dateKey,
    required this.dayClips,
    required this.selectedClip,
    required this.locale,
    required this.onClipSelected,
  });

  final DateTime date;
  final String dateKey;
  final List<Clip> dayClips;
  final Clip? selectedClip;
  final String locale;
  final ValueChanged<Clip> onClipSelected;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final hasClips = dayClips.isNotEmpty;
    final clip = selectedClip;
    final videoPath = clip?.videoPath;
    final hasVideo =
        videoPath != null && videoPath.isNotEmpty && File(videoPath).existsSync();

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            DateFormat.yMMMMEEEEd(locale).format(date),
            style: tokens.type.sectionTitle,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                hasClips ? AppIcons.check : AppIcons.today,
                size: 20,
                color: hasClips ? p.success : p.textSecondary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  hasClips
                      ? t.diaryDayClipCount(dayClips.length)
                      : t.diaryDayNotRecorded,
                  style: tokens.type.bodyStrong,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          DayNoteEditor(dateKey: dateKey),
          if (hasClips && dayClips.length > 1) ...[
            const SizedBox(height: AppSpacing.md),
            _ClipPicker(
              clips: dayClips,
              selectedUid: clip?.uid,
              locale: locale,
              onSelected: onClipSelected,
            ),
          ],
          if (clip != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              t.diaryRecordedAt(
                DateFormat.jm(locale).format(clip.recordedAt),
                (clip.durationMs / 1000).round(),
              ),
              style: tokens.type.caption,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          if (clip != null && hasVideo)
            SizedBox(
              height: 320,
              child: FramedVideoPlayer(
                key: ValueKey(clip.uid),
                videoPath: videoPath,
                recordedAt: clip.recordedAt,
                locale: locale,
                autoPlay: false,
                loop: false,
              ),
            )
          else if (clip != null)
            FramedVideoFrame(
              recordedAt: clip.recordedAt,
              locale: locale,
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: ColoredBox(
                  color: p.surfaceElevated,
                  child: Center(
                    child: Text(
                      clip.mood ?? '🎞️',
                      style: const TextStyle(fontSize: 56),
                    ),
                  ),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(AppIcons.record, size: 32, color: p.textSecondary),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    t.diaryDayNotRecordedHint,
                    textAlign: TextAlign.center,
                    style: tokens.type.body,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    variant: AppButtonVariant.primary,
                    leading: const Icon(AppIcons.record, size: 16),
                    onPressed: () => context.push('/record'),
                    child: Text(t.commonRecord),
                  ),
                ],
              ),
            ),
          if (clip != null && hasVideo) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.diaryTapToPlay,
              textAlign: TextAlign.center,
              style: tokens.type.caption,
            ),
          ],
        ],
      ),
    );
  }
}

class _ClipPicker extends StatelessWidget {
  const _ClipPicker({
    required this.clips,
    required this.selectedUid,
    required this.locale,
    required this.onSelected,
  });

  final List<Clip> clips;
  final String? selectedUid;
  final String locale;
  final ValueChanged<Clip> onSelected;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final p = tokens.palette;

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: [
        for (var i = 0; i < clips.length; i++)
          GestureDetector(
            onTap: () => onSelected(clips[i]),
            child: AnimatedContainer(
              duration: AppMotion.fast,
              curve: AppMotion.curve,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: clips[i].uid == selectedUid
                    ? p.accent.withValues(alpha: 0.22)
                    : p.surfaceElevated,
                borderRadius: const BorderRadius.all(AppRadii.sm),
                border: Border.all(
                  color: clips[i].uid == selectedUid ? p.accent : p.border,
                  width: clips[i].uid == selectedUid ? 1.5 : 1,
                ),
              ),
              child: Text(
                DateFormat.jm(locale).format(clips[i].recordedAt),
                style: tokens.type.caption.copyWith(
                  fontWeight: clips[i].uid == selectedUid
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({
    required this.clipsByDate,
    required this.dayNotes,
    required this.selectedDateKey,
    required this.onDayTap,
  });

  final Map<String, List<Clip>> clipsByDate;
  final Map<String, String> dayNotes;
  final String? selectedDateKey;
  final ValueChanged<String> onDayTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, 1);
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final leadingBlanks = (first.weekday - 1) % 7;

    final cells = <Widget>[];
    for (var i = 0; i < leadingBlanks; i++) {
      cells.add(const SizedBox.shrink());
    }
    for (var day = 1; day <= daysInMonth; day++) {
      final key =
          '${now.year.toString().padLeft(4, '0')}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${day.toString().padLeft(2, '0')}';
      final count = clipsByDate[key]?.length ?? 0;
      final hasNote = dayNotes[key]?.trim().isNotEmpty ?? false;
      cells.add(
        _DayCell(
          day: day,
          clipCount: count,
          hasNote: hasNote,
          isToday: day == now.day,
          isSelected: key == selectedDateKey,
          onTap: () => onDayTap(key),
        ),
      );
    }

    const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            for (final w in weekdays)
              Expanded(
                child: Center(child: Text(w, style: tokens.type.caption)),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          children: cells,
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.clipCount,
    required this.hasNote,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
  });

  final int day;
  final int clipCount;
  final bool hasNote;
  final bool isToday;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final p = tokens.palette;
    final hasClip = clipCount > 0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.fast,
        curve: AppMotion.curve,
        decoration: BoxDecoration(
          color: isSelected
              ? p.accent.withValues(alpha: 0.28)
              : hasClip
              ? p.accentDim
              : p.surface,
          borderRadius: const BorderRadius.all(AppRadii.sm),
          border: Border.all(
            color: isSelected
                ? p.accent
                : isToday
                ? p.accent.withValues(alpha: 0.7)
                : const Color(0x00000000),
            width: isSelected ? 2 : isToday ? 1.5 : 0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: tokens.type.caption.copyWith(
                color: hasClip || isSelected ? p.textPrimary : p.textSecondary,
                fontWeight:
                    isToday || isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
            if (clipCount > 1) ...[
              const SizedBox(height: 2),
              Text(
                '$clipCount',
                style: tokens.type.caption.copyWith(
                  fontSize: 9,
                  color: p.accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ] else if (hasNote) ...[
              const SizedBox(height: 2),
              Icon(AppIcons.note, size: 10, color: p.accent),
            ],
          ],
        ),
      ),
    );
  }
}

class _RecentStrip extends StatelessWidget {
  const _RecentStrip({
    required this.clips,
    required this.locale,
    required this.selectedClipUid,
    required this.onClipTap,
  });

  final List<Clip> clips;
  final String locale;
  final String? selectedClipUid;
  final ValueChanged<Clip> onClipTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final p = tokens.palette;
    final recent = clips.take(8).toList();

    return SizedBox(
      height: 132,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: recent.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final clip = recent[i];
          final selected = clip.uid == selectedClipUid;
          return GestureDetector(
            onTap: () => onClipTap(clip),
            child: AnimatedContainer(
              duration: AppMotion.fast,
              width: 100,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: selected
                    ? p.accent.withValues(alpha: 0.18)
                    : p.surface,
                borderRadius: const BorderRadius.all(AppRadii.md),
                border: Border.all(
                  color: selected ? p.accent : p.border,
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        clip.mood ?? '🎞️',
                        style: const TextStyle(fontSize: 34),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat.MMMd(locale).format(clip.recordedAt),
                    style: tokens.type.caption,
                  ),
                  Text(
                    DateFormat.jm(locale).format(clip.recordedAt),
                    style: tokens.type.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return AppCard(
      child: Row(
        children: [
          const Icon(AppIcons.film, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(label, style: tokens.type.bodyStrong)),
        ],
      ),
    );
  }
}
