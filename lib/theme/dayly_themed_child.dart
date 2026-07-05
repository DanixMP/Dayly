import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/settings_controller.dart';
import '../ui/ui_kit.dart';
import 'app_fonts.dart';
import 'design_tokens.dart';

/// Resolves live [DesignTokens] from settings + locale and exposes [UiKitScope].
class DaylyThemedChild extends ConsumerWidget {
  const DaylyThemedChild({
    super.key,
    required this.uiKit,
    required this.brightness,
    required this.child,
  });

  final UiKit uiKit;
  final Brightness brightness;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final locale = Localizations.localeOf(context);
    final tokens = DesignTokens.forSettings(
      settings,
      brightness,
      locale: locale,
    );
    final fonts = AppFontStyles.forPreset(tokens.fontPreset);
    return UiKitScope(
      kit: uiKit,
      child: DaylyThemeScope(
        tokens: tokens,
        child: ColoredBox(
          color: tokens.palette.background,
          child: DefaultTextStyle(
            style: fonts.defaultTextStyle(tokens.palette),
            child: child,
          ),
        ),
      ),
    );
  }
}
