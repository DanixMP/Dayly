import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as sf;

import '../state/settings_controller.dart';
import 'app_palette.dart';
/// Font presets selectable after the easter egg unlocks.
enum AppFontPreset {
  auto,
  classic,
  vazirmatn,
  poppins,
  nunito,
  lora,
  spaceGrotesk,
}

extension AppFontPresetX on AppFontPreset {
  String get id => name;

  static AppFontPreset? fromId(String? id) {
    if (id == null || id.isEmpty) return null;
    for (final preset in AppFontPreset.values) {
      if (preset.id == id) return preset;
    }
    return null;
  }
}

/// Labels and resolution for typography presets.
class AppFontPresets {
  const AppFontPresets._();

  static const unlockedOptions = <AppFontPreset>[
    AppFontPreset.auto,
    AppFontPreset.classic,
    AppFontPreset.vazirmatn,
    AppFontPreset.poppins,
    AppFontPreset.nunito,
    AppFontPreset.lora,
    AppFontPreset.spaceGrotesk,
  ];

  static AppFontPreset resolve(AppSettings settings, Locale locale) {
    if (settings.colorCustomizerUnlocked) {
      final selected = AppFontPresetX.fromId(settings.customFontId);
      if (selected != null && selected != AppFontPreset.auto) {
        return selected;
      }
    }
    if (locale.languageCode == 'fa') return AppFontPreset.vazirmatn;
    return AppFontPreset.classic;
  }
}

typedef DaylyFontStyleBuilder = TextStyle Function({
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? letterSpacing,
  Color? color,
});

/// Resolved Google Font builders for display and body styles.
class AppFontStyles {
  const AppFontStyles({
    required this.display,
    required this.body,
    required this.preset,
  });

  final DaylyFontStyleBuilder display;
  final DaylyFontStyleBuilder body;
  final AppFontPreset preset;

  factory AppFontStyles.forPreset(AppFontPreset preset) {
    final raw = switch (preset) {
      AppFontPreset.vazirmatn => AppFontStyles(
        preset: preset,
        display: GoogleFonts.vazirmatn,
        body: GoogleFonts.vazirmatn,
      ),
      AppFontPreset.poppins => AppFontStyles(
        preset: preset,
        display: GoogleFonts.poppins,
        body: GoogleFonts.poppins,
      ),
      AppFontPreset.nunito => AppFontStyles(
        preset: preset,
        display: GoogleFonts.nunito,
        body: GoogleFonts.nunito,
      ),
      AppFontPreset.lora => AppFontStyles(
        preset: preset,
        display: GoogleFonts.lora,
        body: GoogleFonts.lora,
      ),
      AppFontPreset.spaceGrotesk => AppFontStyles(
        preset: preset,
        display: GoogleFonts.spaceGrotesk,
        body: GoogleFonts.spaceGrotesk,
      ),
      AppFontPreset.classic || AppFontPreset.auto => AppFontStyles(
        preset: AppFontPreset.classic,
        display: GoogleFonts.dmSerifDisplay,
        body: GoogleFonts.inter,
      ),
    };
    return AppFontStyles(
      preset: raw.preset,
      display: _guarded(raw.display),
      body: _guarded(raw.body),
    );
  }

  static DaylyFontStyleBuilder _guarded(DaylyFontStyleBuilder inner) {
    return ({
      double? fontSize,
      FontWeight? fontWeight,
      double? height,
      double? letterSpacing,
      Color? color,
    }) {
      try {
        return inner(
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
          color: color,
        );
      } on Object {
        return TextStyle(
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
          color: color,
        );
      }
    };
  }

  /// Material [TextTheme] so native widgets inherit the active font.
  material.TextTheme materialTextTheme(DaylyPalette palette) {
    try {
      final base = switch (preset) {
        AppFontPreset.vazirmatn => GoogleFonts.vazirmatnTextTheme(),
        AppFontPreset.poppins => GoogleFonts.poppinsTextTheme(),
        AppFontPreset.nunito => GoogleFonts.nunitoTextTheme(),
        AppFontPreset.lora => GoogleFonts.loraTextTheme(),
        AppFontPreset.spaceGrotesk => GoogleFonts.spaceGroteskTextTheme(),
        AppFontPreset.classic ||
        AppFontPreset.auto => GoogleFonts.interTextTheme(
          GoogleFonts.dmSerifDisplayTextTheme(),
        ),
      };
      return base.apply(
        bodyColor: palette.textSecondary,
        displayColor: palette.textPrimary,
      );
    } on Object {
      return material.TextTheme(
        bodyMedium: TextStyle(color: palette.textSecondary),
        displayMedium: TextStyle(color: palette.textPrimary),
      );
    }
  }

  /// shadcn typography derived from the active preset.
  sf.Typography shadcnTypography(DaylyPalette palette) {
    final geist = sf.Typography.geist();
    TextStyle bodyStyle({
      double fontSize = 14,
      FontWeight fontWeight = FontWeight.w400,
      Color? color,
    }) {
      return body(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? palette.textPrimary,
      );
    }

    TextStyle displayStyle({
      double fontSize = 24,
      FontWeight fontWeight = FontWeight.w600,
      Color? color,
    }) {
      return display(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? palette.textPrimary,
      );
    }

    final sans = bodyStyle(fontSize: 14);
    return geist.copyWith(
      sans: () => sans,
      mono: () => sans,
      xSmall: () => bodyStyle(fontSize: 12, color: palette.textSecondary),
      small: () => bodyStyle(fontSize: 14),
      base: () => bodyStyle(fontSize: 16),
      large: () => bodyStyle(fontSize: 18),
      xLarge: () => bodyStyle(fontSize: 20),
      x2Large: () => displayStyle(fontSize: 24),
      x3Large: () => displayStyle(fontSize: 30),
      x4Large: () => displayStyle(fontSize: 36),
      x5Large: () => displayStyle(fontSize: 48),
      x6Large: () => displayStyle(fontSize: 60),
      x7Large: () => displayStyle(fontSize: 72),
      x8Large: () => displayStyle(fontSize: 96),
      x9Large: () => displayStyle(fontSize: 144),
      normal: () => bodyStyle(),
      medium: () => bodyStyle(fontWeight: FontWeight.w500),
      semiBold: () => bodyStyle(fontWeight: FontWeight.w600),
      bold: () => bodyStyle(fontWeight: FontWeight.w700),
      h1: () => displayStyle(fontSize: 36, fontWeight: FontWeight.w700),
      h2: () => displayStyle(fontSize: 30, fontWeight: FontWeight.w600),
      h3: () => displayStyle(fontSize: 24, fontWeight: FontWeight.w600),
      h4: () => displayStyle(fontSize: 20, fontWeight: FontWeight.w600),
      p: () => bodyStyle(fontSize: 16),
      lead: () => bodyStyle(fontSize: 20),
      textLarge: () => bodyStyle(fontSize: 20, fontWeight: FontWeight.w600),
      textSmall: () => bodyStyle(fontSize: 14, fontWeight: FontWeight.w500),
      textMuted: () => bodyStyle(fontSize: 14, color: palette.textSecondary),
    );
  }

  /// Default text style for [DefaultTextStyle] fallback.
  TextStyle defaultTextStyle(DaylyPalette palette) =>
      body(fontSize: 14, height: 1.5, color: palette.textSecondary);
}