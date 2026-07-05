import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../state/settings_controller.dart';
import '../theme/design_tokens.dart';
import 'router.dart';

/// Application root.
///
/// Owns nothing visual itself — it reads settings (theme mode, locale, active
/// UI library) and hands the entire app shell to the selected [UiKit]. Changing
/// the UI library, theme, or language here re-renders through a different root
/// with zero changes to any feature screen.
class DaylyApp extends ConsumerWidget {
  const DaylyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final kit = ref.watch(activeUiKitProvider);
    final locale =
        settings.locale ?? WidgetsBinding.instance.platformDispatcher.locale;

    return kit.buildApp(
      title: 'Dayly',
      lightTokens: DesignTokens.forSettings(
        settings,
        Brightness.light,
        locale: locale,
      ),
      darkTokens: DesignTokens.forSettings(
        settings,
        Brightness.dark,
        locale: locale,
      ),
      themeMode: settings.themeMode,
      locale: settings.locale,
      routerConfig: appRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
