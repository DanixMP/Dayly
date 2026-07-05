import 'package:flutter/widgets.dart';

import '../../core/services/dev_contact_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_assets.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/motion/app_motion.dart';
import 'dev_contact.dart';
import 'widgets/settings_ui.dart';

class ConnectWithDevScreen extends StatelessWidget {
  const ConnectWithDevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;

    return SettingsDetailScaffold(
      title: t.settingsConnectWithDev,
      children: [
        StaggeredEntrance(
          index: 0,
          child: AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const AppLogo(size: 72),
                const SizedBox(height: AppSpacing.md),
                Text(t.aboutDevName, style: tokens.type.monthHeader),
                const SizedBox(height: AppSpacing.xs),
                Text(t.aboutDevRole, style: tokens.type.label),
                const SizedBox(height: AppSpacing.md),
                Text(
                  t.settingsConnectWithDevIntro,
                  style: tokens.type.body,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        StaggeredEntrance(
          index: 1,
          child: SettingsGroup(
            children: [
              SettingsTile(
                icon: AppIcons.github,
                iconColor: p.textPrimary,
                title: DevContact.github.label,
                subtitle: DevContact.github.handle,
                onTap: () => DevContactLauncher.open(DevContact.github),
              ),
              SettingsTile(
                icon: AppIcons.instagram,
                iconColor: const Color(0xFFE86A6A),
                title: DevContact.instagram.label,
                subtitle: DevContact.instagram.handle,
                onTap: () => DevContactLauncher.open(DevContact.instagram),
              ),
              SettingsTile(
                icon: AppIcons.telegram,
                iconColor: const Color(0xFF5B9FD4),
                title: DevContact.telegram.label,
                subtitle: DevContact.telegram.handle,
                onTap: () => DevContactLauncher.open(DevContact.telegram),
              ),
              SettingsTile(
                icon: AppIcons.email,
                iconColor: p.accent,
                title: DevContact.email.label,
                subtitle: DevContact.email.handle,
                showDivider: false,
                onTap: () => DevContactLauncher.open(DevContact.email),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
