import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../theme/design_tokens.dart';
import '../../../ui/app_widgets.dart';
import '../../../ui/ui_kit.dart';

/// Modal hour + minute picker for daily reminders.
class ReminderTimePickerDialog extends StatefulWidget {
  const ReminderTimePickerDialog({
    super.key,
    required this.initialHour,
    required this.initialMinute,
  });

  final int initialHour;
  final int initialMinute;

  static Future<(int hour, int minute)?> show(
    BuildContext context, {
    required int initialHour,
    required int initialMinute,
  }) {
    return Navigator.of(context).push<(int hour, int minute)?>(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: const Color(0xAA000000),
        transitionDuration: const Duration(milliseconds: 260),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return ReminderTimePickerDialog(
            initialHour: initialHour,
            initialMinute: initialMinute,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  State<ReminderTimePickerDialog> createState() =>
      _ReminderTimePickerDialogState();
}

class _ReminderTimePickerDialogState extends State<ReminderTimePickerDialog> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late int _hour;
  late int _minute;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialHour.clamp(0, 23);
    _minute = widget.initialMinute.clamp(0, 59);
    _hourController = FixedExtentScrollController(initialItem: _hour);
    _minuteController = FixedExtentScrollController(initialItem: _minute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  String _formatTime(BuildContext context, int hour, int minute) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.jm(locale).format(DateTime(2020, 1, 1, hour, minute));
  }

  void _confirm() {
    Navigator.of(context).pop((_hour, _minute));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: GestureDetector(
              onTap: () {},
              child: AppCard(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.md,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      t.settingsReminderPickTime,
                      style: tokens.type.sectionTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _formatTime(context, _hour, _minute),
                      style: tokens.type.monthHeader.copyWith(color: p.accent),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 220,
                      child: Row(
                        children: [
                          Expanded(
                            child: _TimeWheel(
                              label: t.settingsReminderHour,
                              controller: _hourController,
                              itemCount: 24,
                              selectedIndex: _hour,
                              accent: p.accent,
                              textStyle: tokens.type.bodyStrong,
                              captionStyle: tokens.type.caption,
                              onSelected: (index) =>
                                  setState(() => _hour = index),
                              itemBuilder: (index) =>
                                  index.toString().padLeft(2, '0'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Text(':', style: tokens.type.monthHeader),
                          ),
                          Expanded(
                            child: _TimeWheel(
                              label: t.settingsReminderMinute,
                              controller: _minuteController,
                              itemCount: 60,
                              selectedIndex: _minute,
                              accent: p.accent,
                              textStyle: tokens.type.bodyStrong,
                              captionStyle: tokens.type.caption,
                              onSelected: (index) =>
                                  setState(() => _minute = index),
                              itemBuilder: (index) =>
                                  index.toString().padLeft(2, '0'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            variant: AppButtonVariant.ghost,
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(t.commonCancel),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: AppButton(
                            variant: AppButtonVariant.primary,
                            onPressed: _confirm,
                            child: Text(t.commonSave),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeWheel extends StatelessWidget {
  const _TimeWheel({
    required this.label,
    required this.controller,
    required this.itemCount,
    required this.selectedIndex,
    required this.accent,
    required this.textStyle,
    required this.captionStyle,
    required this.itemBuilder,
    required this.onSelected,
  });

  final String label;
  final FixedExtentScrollController controller;
  final int itemCount;
  final int selectedIndex;
  final Color accent;
  final TextStyle textStyle;
  final TextStyle captionStyle;
  final String Function(int index) itemBuilder;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final p = context.tokens.palette;

    return Column(
      children: [
        Text(label, style: captionStyle),
        const SizedBox(height: AppSpacing.xs),
        Expanded(
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 44,
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.all(AppRadii.sm),
                    border: Border.all(color: accent.withValues(alpha: 0.35)),
                  ),
                ),
              ),
              ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 44,
                diameterRatio: 1.4,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: onSelected,
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: itemCount,
                  builder: (context, index) {
                    final selected = index == selectedIndex;
                    return Center(
                      child: Text(
                        itemBuilder(index),
                        style: selected
                            ? textStyle.copyWith(color: accent)
                            : textStyle.copyWith(
                                color: p.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Preset reminder times shown as quick picks.
const kReminderPresetTimes = [
  [8, 0],
  [12, 0],
  [18, 0],
  [20, 0],
  [22, 0],
];

bool isReminderPresetTime(int hour, int minute) {
  return kReminderPresetTimes.any(
    (preset) => preset[0] == hour && preset[1] == minute,
  );
}
