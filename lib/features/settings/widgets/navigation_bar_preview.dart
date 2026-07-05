import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/navigation/dayly_tab_bars.dart';
import '../../../l10n/app_localizations.dart';
import '../../../state/settings_controller.dart';
import '../../../theme/design_tokens.dart';
import '../../../ui/motion/app_motion.dart';

/// Live preview of the selected navigation bar in Appearance settings.
class NavigationBarPreview extends ConsumerStatefulWidget {
  const NavigationBarPreview({super.key});

  @override
  ConsumerState<NavigationBarPreview> createState() =>
      _NavigationBarPreviewState();
}

class _NavigationBarPreviewState extends ConsumerState<NavigationBarPreview> {
  int _previewIndex = 2;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final settings = ref.watch(settingsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.settingsNavigationBarPreview, style: tokens.type.bodyStrong),
        const SizedBox(height: AppSpacing.xs),
        Text(
          t.settingsNavigationBarPreviewHint,
          style: tokens.type.caption,
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: p.background,
            borderRadius: const BorderRadius.all(AppRadii.lg),
            border: Border.all(color: p.border.withValues(alpha: 0.55)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  88,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      width: 96,
                      decoration: BoxDecoration(
                        color: p.textSecondary.withValues(alpha: 0.25),
                        borderRadius: const BorderRadius.all(AppRadii.sm),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: p.textSecondary.withValues(alpha: 0.12),
                        borderRadius: const BorderRadius.all(AppRadii.sm),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      height: 8,
                      width: 180,
                      decoration: BoxDecoration(
                        color: p.textSecondary.withValues(alpha: 0.12),
                        borderRadius: const BorderRadius.all(AppRadii.sm),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSwitcher(
                  duration: AppMotion.normal,
                  switchInCurve: AppMotion.curve,
                  switchOutCurve: AppMotion.curve,
                  child: KeyedSubtree(
                    key: ValueKey(
                      '${settings.navigationBarType.name}_${settings.navigationBarStyle.name}',
                    ),
                    child: buildDaylyTabBar(
                      type: settings.navigationBarType,
                      currentIndex: _previewIndex,
                      onTap: (index) => setState(() => _previewIndex = index),
                      tokens: tokens,
                      crystalStyle: settings.navigationBarStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
