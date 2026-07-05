import 'dart:ui';

/// {@template dayly_palette}
/// The single source of truth for every color in the app.
///
/// This is the "global theming scope": to recolor the entire product — no
/// matter which UI library is active — you edit the values here. Both the
/// active [UiKit]'s native theme and the kit-agnostic [DesignTokens] are
/// derived from one of these palettes, so a change here flows everywhere.
/// {@endtemplate}
class DaylyPalette {
  const DaylyPalette({
    required this.brightness,
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.accent,
    required this.accentDim,
    required this.onAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.border,
    required this.danger,
    required this.success,
  });

  final Brightness brightness;

  // Backgrounds
  final Color background;
  final Color surface;
  final Color surfaceElevated;

  // Accent — aged amber (super-8 film)
  final Color accent;
  final Color accentDim;
  final Color onAccent;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;

  // Lines
  final Color border;

  // Semantic
  final Color danger;
  final Color success;

  bool get isDark => brightness == Brightness.dark;

  /// Dark "super-8 film" palette — the default per the Dayly design vision.
  static const DaylyPalette dark = DaylyPalette(
    brightness: Brightness.dark,
    background: Color(0xFF0E0E0E),
    surface: Color(0xFF1A1916),
    surfaceElevated: Color(0xFF242220),
    accent: Color(0xFFF5C842),
    accentDim: Color(0xFF7A6520),
    onAccent: Color(0xFF0E0E0E),
    textPrimary: Color(0xFFEDEAE0),
    textSecondary: Color(0xFF8A8070),
    textDisabled: Color(0xFF3A3830),
    border: Color(0xFF2C2A26),
    danger: Color(0xFFD95F5F),
    success: Color(0xFF7EC88A),
  );

  /// Warm light variant — same amber identity on a cream paper ground.
  static const DaylyPalette light = DaylyPalette(
    brightness: Brightness.light,
    background: Color(0xFFFAF6EE),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFF1EADB),
    accent: Color(0xFFC9971F),
    accentDim: Color(0xFFE7D199),
    onAccent: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF2A2620),
    textSecondary: Color(0xFF7A7060),
    textDisabled: Color(0xFFB8AE9B),
    border: Color(0xFFE4DBC9),
    danger: Color(0xFFC0443C),
    success: Color(0xFF4F8A5B),
  );

  static DaylyPalette forBrightness(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  /// Applies optional accent/background/surface overrides on top of the base
  /// palette. The base [brightness] is always preserved so light/dark themes
  /// stay consistent with the active theme mode.
  DaylyPalette withOverrides({
    Color? accent,
    Color? background,
    Color? surface,
  }) {
    if (accent == null && background == null && surface == null) return this;

    final nextAccent = accent ?? this.accent;
    final nextBackground = background ?? this.background;
    final nextSurface = surface ?? this.surface;
    final nextElevated = surface != null
        ? Color.lerp(
            nextSurface,
            nextBackground,
            isDark ? 0.35 : 0.12,
          )!
        : surfaceElevated;

    return DaylyPalette(
      brightness: brightness,
      background: nextBackground,
      surface: nextSurface,
      surfaceElevated: nextElevated,
      accent: nextAccent,
      accentDim: Color.lerp(nextAccent, nextBackground, 0.55)!,
      onAccent: onAccent,
      textPrimary: textPrimary,
      textSecondary: textSecondary,
      textDisabled: textDisabled,
      border: border,
      danger: danger,
      success: success,
    );
  }
}
