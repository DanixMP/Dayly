import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../../state/diary_controller.dart';
import '../../state/settings_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/ui_kit.dart';
import '../../ui/ui_kit_registry.dart';
import 'about_dev_screen.dart';
import 'widgets/navigation_bar_preview.dart';
import 'widgets/reminder_time_picker.dart';
import 'widgets/settings_ui.dart';

class SettingsAppearanceScreen extends ConsumerWidget {
  const SettingsAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);

    return SettingsDetailScaffold(
      title: t.settingsAppearance,
      children: [
        _SettingsPanel(
          children: [
            _ChipRow(
              label: t.settingsTheme,
              children: [
                _modeChip(t.settingsThemeSystem, AppThemeMode.system, settings, controller),
                _modeChip(t.settingsThemeLight, AppThemeMode.light, settings, controller),
                _modeChip(t.settingsThemeDark, AppThemeMode.dark, settings, controller),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _ChipRow(
              label: t.settingsNavigationBarType,
              hint: t.settingsNavigationBarTypeHint,
              children: [
                for (final type in NavigationBarType.values)
                  AppChoiceChip(
                    label: Text(_navTypeLabel(t, type)),
                    selected: settings.navigationBarType == type,
                    onTap: () => controller.setNavigationBarType(type),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const NavigationBarPreview(),
            if (settings.navigationBarType == NavigationBarType.crystal) ...[
              const SizedBox(height: AppSpacing.md),
              _ChipRow(
                label: t.settingsNavigationBarStyle,
                hint: t.settingsNavigationBarStyleHint,
                children: [
                  for (final style in NavigationBarStyle.values)
                    AppChoiceChip(
                      label: Text(_navStyleLabel(t, style)),
                      selected: settings.navigationBarStyle == style,
                      onTap: () => controller.setNavigationBarStyle(style),
                    ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            _ChipRow(
              label: t.settingsLanguage,
              children: [
                _langChip('System', null, settings, controller),
                _langChip('English', 'en', settings, controller),
                _langChip('Español', 'es', settings, controller),
                _langChip('العربية', 'ar', settings, controller),
                _langChip('فارسی', 'fa', settings, controller),
                _langChip('Türkçe', 'tr', settings, controller),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _ChipRow(
              label: t.settingsUiLibrary,
              hint: t.settingsUiLibraryHint,
              children: [
                for (final kit in UiKitRegistry.kits)
                  AppChoiceChip(
                    label: Text(kit.displayName),
                    selected: settings.uiKitId == kit.id,
                    onTap: () => controller.setUiKit(kit.id),
                  ),
              ],
            ),
          ],
        ),
        if (settings.colorCustomizerUnlocked) ...[
          const SizedBox(height: AppSpacing.md),
          const ColorCustomizerSection(),
        ],
      ],
    );
  }
}

class SettingsRemindersScreen extends ConsumerWidget {
  const SettingsRemindersScreen({super.key});

  Future<void> _pickCustomTime(
    BuildContext context,
    SettingsNotifier controller,
    AppSettings settings,
  ) async {
    final picked = await ReminderTimePickerDialog.show(
      context,
      initialHour: settings.reminderHour,
      initialMinute: settings.reminderMinute,
    );
    if (picked == null || !context.mounted) return;
    controller.setReminderTime(picked.$1, picked.$2);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final settings = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);
    final isCustom = !isReminderPresetTime(
      settings.reminderHour,
      settings.reminderMinute,
    );

    return SettingsDetailScaffold(
      title: t.settingsReminders,
      children: [
        _SettingsPanel(
          children: [
            _SettingRow(
              icon: AppIcons.reminder,
              label: t.settingsDailyReminder,
              trailing: AppToggle(
                value: settings.reminderEnabled,
                onChanged: controller.setReminderEnabled,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            GestureDetector(
              onTap: settings.reminderEnabled
                  ? () => _pickCustomTime(context, controller, settings)
                  : null,
              behavior: HitTestBehavior.opaque,
              child: _SettingRow(
                icon: AppIcons.clock,
                label: t.settingsReminderTime,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatTime(settings.reminderHour, settings.reminderMinute),
                      style: tokens.type.label,
                    ),
                    if (settings.reminderEnabled) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Icon(
                        AppIcons.chevronRight,
                        size: 18,
                        color: tokens.palette.textSecondary,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (settings.reminderEnabled) ...[
              const SizedBox(height: AppSpacing.sm),
              _ChipWrap(
                children: [
                  for (final hm in kReminderPresetTimes)
                    AppChoiceChip(
                      label: Text(_formatTime(hm[0], hm[1])),
                      selected:
                          settings.reminderHour == hm[0] &&
                          settings.reminderMinute == hm[1],
                      onTap: () => controller.setReminderTime(hm[0], hm[1]),
                    ),
                  AppChoiceChip(
                    label: Text(t.settingsReminderCustom),
                    selected: isCustom,
                    onTap: () => _pickCustomTime(context, controller, settings),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class SettingsCaptureScreen extends ConsumerWidget {
  const SettingsCaptureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);

    return SettingsDetailScaffold(
      title: t.settingsCapture,
      children: [
        _SettingsPanel(
          children: [
            _ChipRow(
              label: t.settingsDefaultDuration,
              children: [
                for (final sec in const [1, 2, 3, 5, 10])
                  AppChoiceChip(
                    label: Text(t.settingsSeconds(sec)),
                    selected: settings.defaultDurationSec == sec,
                    onTap: () => controller.setDefaultDuration(sec),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _SettingRow(
              icon: AppIcons.gallery,
              label: t.settingsSaveToGallery,
              trailing: AppToggle(
                value: settings.saveToGallery,
                onChanged: controller.setSaveToGallery,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsAboutScreen extends ConsumerWidget {
  const SettingsAboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);

    return SettingsDetailScaffold(
      title: t.settingsAbout,
      children: [
        _SettingsPanel(
          children: [
            Text(t.appTagline, style: context.tokens.type.body),
            const SizedBox(height: AppSpacing.md),
            AppListTile(
              leadingIcon: AppIcons.person,
              title: Text(t.aboutDevTitle, style: context.tokens.type.bodyStrong),
              subtitle: Text(t.aboutDevSubtitle, style: context.tokens.type.caption),
              trailing: Icon(
                AppIcons.chevronRight,
                size: 20,
                color: context.tokens.palette.textSecondary,
              ),
              onTap: () => context.push('/settings/about-dev'),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppListTile(
              leadingIcon: AppIcons.connect,
              title: Text(
                t.settingsConnectWithDev,
                style: context.tokens.type.bodyStrong,
              ),
              subtitle: Text(
                t.settingsConnectWithDevHint,
                style: context.tokens.type.caption,
              ),
              trailing: Icon(
                AppIcons.chevronRight,
                size: 20,
                color: context.tokens.palette.textSecondary,
              ),
              onTap: () => context.push('/settings/connect'),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppListTile(
              leadingIcon: AppIcons.privacy,
              title: Text(t.settingsPrivacy, style: context.tokens.type.bodyStrong),
              subtitle: Text(t.settingsPrivacyHint, style: context.tokens.type.caption),
              trailing: Icon(
                AppIcons.chevronRight,
                size: 20,
                color: context.tokens.palette.textSecondary,
              ),
              onTap: () => context.push('/settings/privacy'),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppListTile(
              leadingIcon: AppIcons.openSource,
              title: Text(
                t.settingsAcknowledgements,
                style: context.tokens.type.bodyStrong,
              ),
              subtitle: Text(
                t.settingsAcknowledgementsHint,
                style: context.tokens.type.caption,
              ),
              trailing: Icon(
                AppIcons.chevronRight,
                size: 20,
                color: context.tokens.palette.textSecondary,
              ),
              onTap: () => context.push('/settings/acknowledgements'),
            ),
          ],
        ),
      ],
    );
  }
}

class SettingsResetScreen extends ConsumerWidget {
  const SettingsResetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final controller = ref.read(settingsProvider.notifier);
    final clipCount = ref.watch(diaryProvider).length;

    return SettingsDetailScaffold(
      title: t.settingsSectionReset,
      children: [
        _SettingsPanel(
          children: [
            Text(t.settingsResetAllHint, style: tokens.type.body),
            const SizedBox(height: AppSpacing.md),
            Text(t.settingsResetAllDetails, style: tokens.type.caption),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              variant: AppButtonVariant.destructive,
              onPressed: () {
                controller.resetAll();
                context.pop();
              },
              child: Text(t.settingsResetAllButton),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _DeleteAllClipsPanel(clipCount: clipCount),
      ],
    );
  }
}

class _DeleteAllClipsPanel extends ConsumerStatefulWidget {
  const _DeleteAllClipsPanel({required this.clipCount});

  final int clipCount;

  @override
  ConsumerState<_DeleteAllClipsPanel> createState() =>
      _DeleteAllClipsPanelState();
}

class _DeleteAllClipsPanelState extends ConsumerState<_DeleteAllClipsPanel> {
  bool _confirming = false;
  bool _busy = false;

  Future<void> _deleteAll() async {
    setState(() => _busy = true);
    await ref.read(diaryProvider.notifier).clearAll();
    if (!mounted) return;
    setState(() {
      _busy = false;
      _confirming = false;
    });
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;

    return _SettingsPanel(
      children: [
        Text(t.settingsResetClipsHint, style: tokens.type.body),
        const SizedBox(height: AppSpacing.md),
        Text(
          t.settingsResetClipsDetails(widget.clipCount),
          style: tokens.type.caption,
        ),
        const SizedBox(height: AppSpacing.lg),
        if (_confirming) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: p.danger.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.all(AppRadii.md),
              border: Border.all(color: p.danger.withValues(alpha: 0.35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.settingsResetClipsConfirmTitle,
                  style: tokens.type.bodyStrong.copyWith(color: p.danger),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  t.settingsResetClipsConfirmBody,
                  style: tokens.type.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        variant: AppButtonVariant.ghost,
                        onPressed: _busy ? null : () => setState(() => _confirming = false),
                        child: Text(t.commonCancel),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppButton(
                        variant: AppButtonVariant.destructive,
                        onPressed: _busy ? null : _deleteAll,
                        child: Text(t.settingsResetClipsButton),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ] else
          AppButton(
            variant: AppButtonVariant.destructive,
            onPressed: widget.clipCount == 0 || _busy
                ? null
                : () => setState(() => _confirming = true),
            child: Text(t.settingsResetClipsButton),
          ),
      ],
    );
  }
}

// --- Shared controls ----------------------------------------------------------

class _SettingsPanel extends StatelessWidget {
  const _SettingsPanel({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final p = context.tokens.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: const BorderRadius.all(AppRadii.lg),
        border: Border.all(color: p.border.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.label,
    required this.trailing,
  });

  final IconData icon;
  final String label;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 18, color: tokens.palette.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(label, style: tokens.type.bodyStrong)),
          const SizedBox(width: AppSpacing.sm),
          trailing,
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.label, required this.children, this.hint});

  final String label;
  final String? hint;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: tokens.type.bodyStrong),
        if (hint != null) ...[
          const SizedBox(height: 2),
          Text(hint!, style: tokens.type.caption),
        ],
        const SizedBox(height: AppSpacing.xs),
        _ChipWrap(children: children),
      ],
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: children,
    );
  }
}

Widget _modeChip(
  String label,
  AppThemeMode mode,
  AppSettings settings,
  SettingsNotifier controller,
) => AppChoiceChip(
  label: Text(label),
  selected: settings.themeMode == mode,
  onTap: () => controller.setThemeMode(mode),
);

Widget _langChip(
  String label,
  String? code,
  AppSettings settings,
  SettingsNotifier controller,
) => AppChoiceChip(
  label: Text(label),
  selected:
      settings.localeCode == code ||
      (code == null && (settings.localeCode?.isEmpty ?? true)),
  onTap: () => controller.setLocale(code),
);

String _navTypeLabel(AppLocalizations t, NavigationBarType type) {
  return switch (type) {
    NavigationBarType.crystal => t.settingsNavTypeCrystal,
    NavigationBarType.curved => t.settingsNavTypeCurved,
  };
}

String _navStyleLabel(AppLocalizations t, NavigationBarStyle style) {
  return switch (style) {
    NavigationBarStyle.blur => t.settingsNavStyleBlur,
    NavigationBarStyle.frosted => t.settingsNavStyleFrosted,
    NavigationBarStyle.floating => t.settingsNavStyleFloating,
    NavigationBarStyle.rounded => t.settingsNavStyleRounded,
    NavigationBarStyle.modern => t.settingsNavStyleModern,
  };
}

String _formatTime(int h, int m) =>
    '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
