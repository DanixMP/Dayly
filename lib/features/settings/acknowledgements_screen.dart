import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/motion/app_motion.dart';
import 'app_acknowledgements.dart';
import 'widgets/settings_ui.dart';

class SettingsAcknowledgementsScreen extends StatefulWidget {
  const SettingsAcknowledgementsScreen({super.key});

  @override
  State<SettingsAcknowledgementsScreen> createState() =>
      _SettingsAcknowledgementsScreenState();
}

class _SettingsAcknowledgementsScreenState
    extends State<SettingsAcknowledgementsScreen> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _packageInfo = info);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final grouped = AppAcknowledgements.grouped();

    return SettingsDetailScaffold(
      title: t.settingsAcknowledgements,
      children: [
        StaggeredEntrance(
          index: 0,
          child: AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(AppIcons.code, size: 18, color: p.accent),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      t.settingsAcknowledgementsStackTitle,
                      style: tokens.type.label,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(t.settingsAcknowledgementsIntro, style: tokens.type.body),
                if (_packageInfo != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    t.settingsAcknowledgementsVersion(
                      _packageInfo!.version,
                      _packageInfo!.buildNumber,
                    ),
                    style: tokens.type.caption,
                  ),
                ],
              ],
            ),
          ),
        ),
        ..._categorySections(t, tokens, grouped),
        const SizedBox(height: AppSpacing.lg),
        StaggeredEntrance(
          index: AcknowledgementCategory.values.length + 1,
          child: AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(AppIcons.heart, size: 20, color: p.accent),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    t.settingsAcknowledgementsThanks,
                    style: tokens.type.bodyStrong.copyWith(color: p.accent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _categorySections(
    AppLocalizations t,
    DesignTokens tokens,
    Map<AcknowledgementCategory, List<AppAcknowledgement>> grouped,
  ) {
    final widgets = <Widget>[];
    var index = 1;

    for (final category in AcknowledgementCategory.values) {
      final items = grouped[category];
      if (items == null || items.isEmpty) continue;

      widgets.addAll([
        const SizedBox(height: AppSpacing.md),
        StaggeredEntrance(
          index: index,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.xs,
                  bottom: AppSpacing.sm,
                ),
                child: Text(
                  _categoryLabel(t, category),
                  style: tokens.type.label,
                ),
              ),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var j = 0; j < items.length; j++)
                      _AcknowledgementTile(
                        item: items[j],
                        showDivider: j < items.length - 1,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]);
      index++;
    }

    return widgets;
  }

  String _categoryLabel(AppLocalizations t, AcknowledgementCategory category) {
    return switch (category) {
      AcknowledgementCategory.framework => t.settingsAckCategoryFramework,
      AcknowledgementCategory.ui => t.settingsAckCategoryUi,
      AcknowledgementCategory.state => t.settingsAckCategoryState,
      AcknowledgementCategory.media => t.settingsAckCategoryMedia,
      AcknowledgementCategory.storage => t.settingsAckCategoryStorage,
      AcknowledgementCategory.notifications =>
        t.settingsAckCategoryNotifications,
      AcknowledgementCategory.utilities => t.settingsAckCategoryUtilities,
    };
  }
}

class _AcknowledgementTile extends StatelessWidget {
  const _AcknowledgementTile({
    required this.item,
    required this.showDivider,
  });

  final AppAcknowledgement item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final p = tokens.palette;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: tokens.type.bodyStrong),
                    const SizedBox(height: 2),
                    Text(item.role, style: tokens.type.caption),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                item.version,
                style: tokens.type.caption.copyWith(color: p.textDisabled),
              ),
            ],
          ),
        ),
        if (showDivider)
          Container(
            height: 1,
            color: p.border.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
