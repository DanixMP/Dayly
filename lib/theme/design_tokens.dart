import 'package:flutter/widgets.dart';

import '../state/settings_controller.dart';
import 'app_fonts.dart';
import 'app_palette.dart';

/// Spacing scale (8px rhythm). Use these instead of magic numbers.
class AppSpacing {
  const AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Corner radii. The film aesthetic favours soft, small radii.
class AppRadii {
  const AppRadii._();
  static const Radius sm = Radius.circular(8);
  static const Radius md = Radius.circular(14);
  static const Radius lg = Radius.circular(20);
  static const Radius pill = Radius.circular(999);
}

/// Typography derived from a [DaylyPalette] so text colors stay in sync with
/// the active theme.
class DaylyTypography {
  DaylyTypography(DaylyPalette p, AppFontStyles fonts)
    : dateDisplay = fonts.display(
        fontSize: 42,
        height: 1.0,
        letterSpacing: fonts.preset == AppFontPreset.classic ? -1.0 : 0,
        color: p.textPrimary,
      ),
      monthHeader = fonts.display(
        fontSize: 28,
        color: p.textPrimary,
      ),
      sectionTitle = fonts.display(
        fontSize: 22,
        color: p.textPrimary,
      ),
      bodyStrong = fonts.body(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w600,
        color: p.textPrimary,
      ),
      body = fonts.body(
        fontSize: 14,
        height: 1.5,
        color: p.textSecondary,
      ),
      caption = fonts.body(
        fontSize: 11,
        letterSpacing: 0.4,
        color: p.textSecondary,
      ),
      label = fonts.body(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: p.accent,
      );

  final TextStyle dateDisplay;
  final TextStyle monthHeader;
  final TextStyle sectionTitle;
  final TextStyle bodyStrong;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle label;
}

/// Library-agnostic theme mode. Each [UiKit] maps this to its own `ThemeMode`.
enum AppThemeMode { system, light, dark }

/// The complete, kit-agnostic design token set: colors + type + metrics.
class DesignTokens {
  DesignTokens(this.palette, {required this.fontPreset})
    : type = DaylyTypography(
        palette,
        AppFontStyles.forPreset(fontPreset),
      );

  final DaylyPalette palette;
  final AppFontPreset fontPreset;
  final DaylyTypography type;

  static DesignTokens forBrightness(Brightness brightness, {Locale? locale}) {
    final resolvedLocale = locale ?? const Locale('en');
    return DesignTokens(
      DaylyPalette.forBrightness(brightness),
      fontPreset: AppFontPresets.resolve(AppSettings.defaults, resolvedLocale),
    );
  }

  static DesignTokens forSettings(
    AppSettings settings,
    Brightness brightness, {
    required Locale locale,
  }) {
    final base = DaylyPalette.forBrightness(brightness);
    final fontPreset = AppFontPresets.resolve(settings, locale);
    if (!settings.colorCustomizerUnlocked) {
      return DesignTokens(base, fontPreset: fontPreset);
    }
    final overrides = brightness == Brightness.dark
        ? settings.darkColorOverrides
        : settings.lightColorOverrides;
    return DesignTokens(
      base.withOverrides(
        accent: settings.customAccent,
        background: overrides.background,
        surface: overrides.surface,
      ),
      fontPreset: fontPreset,
    );
  }
}

/// Inherited scope that exposes [DesignTokens] to the whole subtree.
class DaylyThemeScope extends InheritedWidget {
  const DaylyThemeScope({
    super.key,
    required this.tokens,
    required super.child,
  });

  final DesignTokens tokens;

  static DesignTokens of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<DaylyThemeScope>();
    assert(scope != null, 'No DaylyThemeScope found in context');
    return scope!.tokens;
  }

  @override
  bool updateShouldNotify(DaylyThemeScope oldWidget) =>
      oldWidget.tokens.palette != tokens.palette ||
      oldWidget.tokens.fontPreset != tokens.fontPreset;
}

extension DaylyThemeContext on BuildContext {
  DesignTokens get tokens => DaylyThemeScope.of(this);
}
