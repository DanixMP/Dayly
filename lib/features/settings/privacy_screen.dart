import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/motion/app_motion.dart';
import 'widgets/settings_ui.dart';

class SettingsPrivacyScreen extends StatelessWidget {
  const SettingsPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return SettingsDetailScaffold(
      title: t.settingsPrivacy,
      children: [
        StaggeredEntrance(
          index: 0,
          child: _PrivacySection(
            title: t.settingsPrivacyIntroTitle,
            body: t.settingsPrivacyIntroBody,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        StaggeredEntrance(
          index: 1,
          child: _PrivacySection(
            title: t.settingsPrivacyDataTitle,
            body: t.settingsPrivacyDataBody,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        StaggeredEntrance(
          index: 2,
          child: _PrivacySection(
            title: t.settingsPrivacyPermissionsTitle,
            body: t.settingsPrivacyPermissionsBody,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        StaggeredEntrance(
          index: 3,
          child: _PrivacySection(
            title: t.settingsPrivacyThirdPartyTitle,
            body: t.settingsPrivacyThirdPartyBody,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        StaggeredEntrance(
          index: 4,
          child: _PrivacySection(
            title: t.settingsPrivacyYourControlTitle,
            body: t.settingsPrivacyYourControlBody,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        StaggeredEntrance(
          index: 5,
          child: Text(
            t.settingsPrivacyFooter,
            style: context.tokens.type.caption,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: tokens.type.bodyStrong),
          const SizedBox(height: AppSpacing.sm),
          Text(body, style: tokens.type.body),
        ],
      ),
    );
  }
}
