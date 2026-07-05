import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../../state/settings_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/motion/app_motion.dart';
import 'widgets/settings_ui.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final settings = ref.watch(settingsProvider);

    return AppScaffold(
      leading: showBackButton
          ? AppIconButton(
              icon: AppIcons.back,
              tooltip: t.commonBack,
              onPressed: () => context.pop(),
            )
          : null,
      title: Text(t.settingsTitle, style: tokens.type.sectionTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          128,
        ),
        children: [
          SettingsProfileHeader(
            onTap: () => context.push('/settings/about-dev'),
          ),
          const SizedBox(height: AppSpacing.lg),
          StaggeredEntrance(
            index: 1,
            child: SettingsSectionLabel(label: t.settingsSectionPersonal),
          ),
          StaggeredEntrance(
            index: 2,
            child: SettingsGroup(
              children: [
                SettingsTile(
                  icon: AppIcons.palette,
                  iconColor: const Color(0xFF6B8CFF),
                  title: t.settingsAppearance,
                  value: _themeSummary(t, settings),
                  showDivider: settings.colorCustomizerUnlocked,
                  onTap: () => context.push('/settings/appearance'),
                ),
                if (settings.colorCustomizerUnlocked)
                  SettingsTile(
                    icon: AppIcons.palette,
                    iconColor: const Color(0xFFE86A6A),
                    title: t.settingsCustomColors,
                    value: t.settingsCustomColorsUnlocked,
                    showDivider: false,
                    onTap: () => context.push('/settings/appearance'),
                  ),
              ],
            ),
          ),
          StaggeredEntrance(
            index: 3,
            child: SettingsSectionLabel(label: t.settingsSectionNotifications),
          ),
          StaggeredEntrance(
            index: 4,
            child: SettingsGroup(
              children: [
                SettingsTile(
                  icon: AppIcons.reminder,
                  iconColor: const Color(0xFFFF9F43),
                  title: t.settingsReminders,
                  value: _reminderSummary(t, settings),
                  showDivider: false,
                  onTap: () => context.push('/settings/reminders'),
                ),
              ],
            ),
          ),
          StaggeredEntrance(
            index: 5,
            child: SettingsSectionLabel(label: t.settingsSectionRecording),
          ),
          StaggeredEntrance(
            index: 6,
            child: SettingsGroup(
              children: [
                SettingsTile(
                  icon: AppIcons.record,
                  iconColor: const Color(0xFFFF6B6B),
                  title: t.settingsCapture,
                  value: t.settingsSeconds(settings.defaultDurationSec),
                  showDivider: false,
                  onTap: () => context.push('/settings/capture'),
                ),
              ],
            ),
          ),
          StaggeredEntrance(
            index: 7,
            child: SettingsSectionLabel(label: t.settingsSectionAbout),
          ),
          StaggeredEntrance(
            index: 8,
            child: SettingsGroup(
              children: [
                SettingsTile(
                  icon: AppIcons.info,
                  iconColor: const Color(0xFF6BCB8B),
                  title: t.settingsAbout,
                  subtitle: t.appTagline,
                  showDivider: true,
                  onTap: () => context.push('/settings/about'),
                ),
                SettingsTile(
                  icon: AppIcons.connect,
                  iconColor: const Color(0xFF6B8CFF),
                  title: t.settingsConnectWithDev,
                  subtitle: t.settingsConnectWithDevHint,
                  showDivider: true,
                  onTap: () => context.push('/settings/connect'),
                ),
                SettingsTile(
                  icon: AppIcons.privacy,
                  iconColor: const Color(0xFF5B9FD4),
                  title: t.settingsPrivacy,
                  subtitle: t.settingsPrivacyHint,
                  showDivider: true,
                  onTap: () => context.push('/settings/privacy'),
                ),
                SettingsTile(
                  icon: AppIcons.openSource,
                  iconColor: const Color(0xFF9B7EDE),
                  title: t.settingsAcknowledgements,
                  subtitle: t.settingsAcknowledgementsHint,
                  showDivider: false,
                  onTap: () => context.push('/settings/acknowledgements'),
                ),
              ],
            ),
          ),
          StaggeredEntrance(
            index: 9,
            child: SettingsSectionLabel(label: t.settingsSectionReset),
          ),
          StaggeredEntrance(
            index: 10,
            child: SettingsGroup(
              children: [
                SettingsTile(
                  icon: AppIcons.reset,
                  iconColor: const Color(0xFFE86A6A),
                  title: t.settingsResetAll,
                  subtitle: t.settingsResetAllHint,
                  showDivider: true,
                  onTap: () => context.push('/settings/reset'),
                ),
                SettingsTile(
                  icon: AppIcons.delete,
                  iconColor: const Color(0xFFE86A6A),
                  title: t.settingsResetClips,
                  subtitle: t.settingsResetClipsHint,
                  showDivider: false,
                  onTap: () => context.push('/settings/reset'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          StaggeredEntrance(
            index: 11,
            child: Center(
              child: Text(
                t.settingsFooter,
                style: tokens.type.caption.copyWith(color: p.textDisabled),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _themeSummary(AppLocalizations t, AppSettings settings) {
    final theme = switch (settings.themeMode) {
      AppThemeMode.system => t.settingsThemeSystem,
      AppThemeMode.light => t.settingsThemeLight,
      AppThemeMode.dark => t.settingsThemeDark,
    };
    return theme;
  }

  String _reminderSummary(AppLocalizations t, AppSettings settings) {
    if (!settings.reminderEnabled) return t.settingsReminderOff;
    return _formatTime(settings.reminderHour, settings.reminderMinute);
  }

  String _formatTime(int h, int m) =>
      '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
}
