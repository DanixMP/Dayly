import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/background_image_service.dart';
import '../core/services/notification_service.dart';
import '../theme/app_background.dart';
import '../theme/app_fonts.dart';
import '../theme/design_tokens.dart';
import '../ui/ui_kit.dart';
import '../ui/ui_kit_registry.dart';

enum NavigationBarType { crystal, curved }

enum NavigationBarStyle { blur, frosted, floating, rounded, modern }

/// Background + box overrides for one theme brightness.
@immutable
class ThemeColorOverrides {
  const ThemeColorOverrides({
    this.background,
    this.surface,
    this.backgroundImagePath,
  });

  final Color? background;
  final Color? surface;
  final String? backgroundImagePath;

  ThemeColorOverrides copyWith({
    Object? background = _sentinel,
    Object? surface = _sentinel,
    Object? backgroundImagePath = _sentinel,
  }) {
    return ThemeColorOverrides(
      background: identical(background, _sentinel)
          ? this.background
          : background as Color?,
      surface: identical(surface, _sentinel)
          ? this.surface
          : surface as Color?,
      backgroundImagePath: identical(backgroundImagePath, _sentinel)
          ? this.backgroundImagePath
          : backgroundImagePath as String?,
    );
  }

  static const Object _sentinel = Object();
}

/// Preset swatches exposed after the version-tap easter egg unlocks.
class CustomColorPresets {
  const CustomColorPresets._();

  static const accentOptions = <Color>[
    Color(0xFFF5C842), // default amber
    Color(0xFFE86A6A), // rose
    Color(0xFF5B9FD4), // ocean
    Color(0xFF6BCB8B), // emerald
    Color(0xFF9B7EDE), // violet
    Color(0xFFE8A04C), // sunset
  ];

  static const lightBackgroundOptions = <Color>[
    Color(0xFFFAF6EE), // default cream
    Color(0xFFF0F4F8), // cool paper
    Color(0xFFF5F0E8), // warm paper
    Color(0xFFEEF6F0), // sage mist
    Color(0xFFF8F2F5), // blush
    Color(0xFFE8F0FA), // sky wash
  ];

  static const darkBackgroundOptions = <Color>[
    Color(0xFF0E0E0E), // default dark
    Color(0xFF121820), // midnight
    Color(0xFF1A1410), // espresso
    Color(0xFF0D1B1E), // teal night
    Color(0xFF141018), // plum night
    Color(0xFF101410), // forest black
  ];

  static const lightSurfaceOptions = <Color>[
    Color(0xFFFFFFFF), // white card
    Color(0xFFF1EADB), // cream box
    Color(0xFFF7F2E8), // parchment
    Color(0xFFE8F0EA), // mint card
    Color(0xFFF5ECE8), // rose card
    Color(0xFFE6EEF5), // slate card
  ];

  static const darkSurfaceOptions = <Color>[
    Color(0xFF1A1916), // default surface
    Color(0xFF242220), // elevated
    Color(0xFF2C2A26), // charcoal
    Color(0xFF1C2228), // slate box
    Color(0xFF221A24), // plum box
    Color(0xFF1A221C), // pine box
  ];

  static List<Color> backgroundOptionsFor(Brightness brightness) =>
      brightness == Brightness.dark
          ? darkBackgroundOptions
          : lightBackgroundOptions;

  static List<Color> surfaceOptionsFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkSurfaceOptions : lightSurfaceOptions;
}

/// Injected at startup (see `main.dart`) with the loaded [SharedPreferences].
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider not overridden'),
);

/// Persisted, app-wide settings.
@immutable
class AppSettings {
  const AppSettings({
    required this.localeCode,
    required this.themeMode,
    required this.uiKitId,
    required this.reminderEnabled,
    required this.reminderHour,
    required this.reminderMinute,
    required this.defaultDurationSec,
    required this.saveToGallery,
    required this.navigationBarStyle,
    required this.navigationBarType,
    required this.colorCustomizerUnlocked,
    this.customAccent,
    this.customFontId,
    this.lightColorOverrides = const ThemeColorOverrides(),
    this.darkColorOverrides = const ThemeColorOverrides(),
  });

  /// Language code, or `null`/empty to follow the system locale.
  final String? localeCode;
  final AppThemeMode themeMode;
  final String uiKitId;
  final bool reminderEnabled;
  final int reminderHour;
  final int reminderMinute;
  final int defaultDurationSec;
  final bool saveToGallery;
  final NavigationBarStyle navigationBarStyle;
  final NavigationBarType navigationBarType;
  final bool colorCustomizerUnlocked;
  final Color? customAccent;
  final String? customFontId;
  final ThemeColorOverrides lightColorOverrides;
  final ThemeColorOverrides darkColorOverrides;

  Locale? get locale =>
      (localeCode == null || localeCode!.isEmpty) ? null : Locale(localeCode!);

  ThemeColorOverrides colorOverridesFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkColorOverrides : lightColorOverrides;

  AppSettings copyWith({
    Object? localeCode = _sentinel,
    AppThemeMode? themeMode,
    String? uiKitId,
    bool? reminderEnabled,
    int? reminderHour,
    int? reminderMinute,
    int? defaultDurationSec,
    bool? saveToGallery,
    NavigationBarStyle? navigationBarStyle,
    NavigationBarType? navigationBarType,
    bool? colorCustomizerUnlocked,
    Object? customAccent = _sentinel,
    Object? customFontId = _sentinel,
    ThemeColorOverrides? lightColorOverrides,
    ThemeColorOverrides? darkColorOverrides,
  }) {
    return AppSettings(
      localeCode: identical(localeCode, _sentinel)
          ? this.localeCode
          : localeCode as String?,
      themeMode: themeMode ?? this.themeMode,
      uiKitId: uiKitId ?? this.uiKitId,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      defaultDurationSec: defaultDurationSec ?? this.defaultDurationSec,
      saveToGallery: saveToGallery ?? this.saveToGallery,
      navigationBarStyle: navigationBarStyle ?? this.navigationBarStyle,
      navigationBarType: navigationBarType ?? this.navigationBarType,
      colorCustomizerUnlocked:
          colorCustomizerUnlocked ?? this.colorCustomizerUnlocked,
      customAccent: identical(customAccent, _sentinel)
          ? this.customAccent
          : customAccent as Color?,
      customFontId: identical(customFontId, _sentinel)
          ? this.customFontId
          : customFontId as String?,
      lightColorOverrides: lightColorOverrides ?? this.lightColorOverrides,
      darkColorOverrides: darkColorOverrides ?? this.darkColorOverrides,
    );
  }

  static const Object _sentinel = Object();

  static const _kLocale = 'locale_code';
  static const _kTheme = 'theme_mode';
  static const _kKit = 'ui_kit_id';
  static const _kReminderEnabled = 'reminder_enabled';
  static const _kReminderHour = 'reminder_hour';
  static const _kReminderMinute = 'reminder_minute';
  static const _kDuration = 'default_duration_sec';
  static const _kSaveToGallery = 'save_to_gallery';
  static const _kNavigationBarStyle = 'nav_bar_style';
  static const _kNavigationBarType = 'nav_bar_type';
  static const _kColorCustomizerUnlocked = 'color_customizer_unlocked';
  static const _kCustomAccent = 'custom_accent_argb';
  static const _kCustomFont = 'custom_font_id';
  static const _kLightBackground = 'custom_light_background_argb';
  static const _kLightSurface = 'custom_light_surface_argb';
  static const _kDarkBackground = 'custom_dark_background_argb';
  static const _kDarkSurface = 'custom_dark_surface_argb';
  static const _kLegacyBackground = 'custom_background_argb';
  static const _kLightBackgroundImage = 'custom_light_background_image_path';
  static const _kDarkBackgroundImage = 'custom_dark_background_image_path';

  /// Factory defaults — mirrors [fromPrefs] when no keys are stored.
  static const defaults = AppSettings(
    localeCode: null,
    themeMode: AppThemeMode.dark,
    uiKitId: UiKitRegistry.defaultKitId,
    reminderEnabled: true,
    reminderHour: 20,
    reminderMinute: 0,
    defaultDurationSec: 1,
    saveToGallery: false,
    navigationBarStyle: NavigationBarStyle.blur,
    navigationBarType: NavigationBarType.crystal,
    colorCustomizerUnlocked: false,
  );

  factory AppSettings.fromPrefs(SharedPreferences p) {
    var lightBackground = _colorFromPrefs(p, _kLightBackground);
    var darkBackground = _colorFromPrefs(p, _kDarkBackground);
    final legacyBackground = _colorFromPrefs(p, _kLegacyBackground);
    if (legacyBackground != null) {
      if (legacyBackground.computeLuminance() < 0.5) {
        darkBackground ??= legacyBackground;
      } else {
        lightBackground ??= legacyBackground;
      }
    }

    return AppSettings(
      localeCode: p.getString(_kLocale),
      themeMode: AppThemeMode.values.byNameOr(
        p.getString(_kTheme),
        AppThemeMode.dark,
      ),
      uiKitId: p.getString(_kKit) ?? UiKitRegistry.defaultKitId,
      reminderEnabled: p.getBool(_kReminderEnabled) ?? true,
      reminderHour: p.getInt(_kReminderHour) ?? 20,
      reminderMinute: p.getInt(_kReminderMinute) ?? 0,
      defaultDurationSec: p.getInt(_kDuration) ?? 1,
      saveToGallery: p.getBool(_kSaveToGallery) ?? false,
      navigationBarStyle: NavigationBarStyle.values.byNameOr(
        p.getString(_kNavigationBarStyle),
        NavigationBarStyle.blur,
      ),
      navigationBarType: NavigationBarType.values.byNameOr(
        p.getString(_kNavigationBarType),
        NavigationBarType.crystal,
      ),
      colorCustomizerUnlocked: p.getBool(_kColorCustomizerUnlocked) ?? false,
      customAccent: _colorFromPrefs(p, _kCustomAccent),
      customFontId: p.getString(_kCustomFont),
      lightColorOverrides: ThemeColorOverrides(
        background: lightBackground,
        surface: _colorFromPrefs(p, _kLightSurface),
        backgroundImagePath: p.getString(_kLightBackgroundImage),
      ),
      darkColorOverrides: ThemeColorOverrides(
        background: darkBackground,
        surface: _colorFromPrefs(p, _kDarkSurface),
        backgroundImagePath: p.getString(_kDarkBackgroundImage),
      ),
    );
  }

  static Color? _colorFromPrefs(SharedPreferences p, String key) {
    if (!p.containsKey(key)) return null;
    return Color(p.getInt(key)!);
  }

  Future<void> persist(SharedPreferences p) async {
    await p.setString(_kLocale, localeCode ?? '');
    await p.setString(_kTheme, themeMode.name);
    await p.setString(_kKit, uiKitId);
    await p.setBool(_kReminderEnabled, reminderEnabled);
    await p.setInt(_kReminderHour, reminderHour);
    await p.setInt(_kReminderMinute, reminderMinute);
    await p.setInt(_kDuration, defaultDurationSec);
    await p.setBool(_kSaveToGallery, saveToGallery);
    await p.setString(_kNavigationBarStyle, navigationBarStyle.name);
    await p.setString(_kNavigationBarType, navigationBarType.name);
    await p.setBool(_kColorCustomizerUnlocked, colorCustomizerUnlocked);
    await _persistColor(p, _kCustomAccent, customAccent);
    if (customFontId == null || customFontId!.isEmpty) {
      await p.remove(_kCustomFont);
    } else {
      await p.setString(_kCustomFont, customFontId!);
    }
    await _persistColor(
      p,
      _kLightBackground,
      lightColorOverrides.background,
    );
    await _persistColor(p, _kLightSurface, lightColorOverrides.surface);
    await _persistColor(p, _kDarkBackground, darkColorOverrides.background);
    await _persistColor(p, _kDarkSurface, darkColorOverrides.surface);
    await _persistImagePath(
      p,
      _kLightBackgroundImage,
      lightColorOverrides.backgroundImagePath,
    );
    await _persistImagePath(
      p,
      _kDarkBackgroundImage,
      darkColorOverrides.backgroundImagePath,
    );
    await p.remove(_kLegacyBackground);
  }

  static Future<void> _persistImagePath(
    SharedPreferences p,
    String key,
    String? path,
  ) async {
    if (path == null || path.isEmpty) {
      await p.remove(key);
    } else {
      await p.setString(key, path);
    }
  }

  static Future<void> _persistColor(
    SharedPreferences p,
    String key,
    Color? color,
  ) async {
    if (color == null) {
      await p.remove(key);
    } else {
      await p.setInt(key, color.toARGB32());
    }
  }
}

extension _EnumListByName<T extends Enum> on List<T> {
  T byNameOr(String? name, T fallback) {
    for (final v in this) {
      if (v.name == name) return v;
    }
    return fallback;
  }
}

class SettingsNotifier extends Notifier<AppSettings> {
  late final SharedPreferences _prefs;

  @override
  AppSettings build() {
    _prefs = ref.read(sharedPreferencesProvider);
    return AppSettings.fromPrefs(_prefs);
  }

  void _update(AppSettings next) {
    state = next;
    next.persist(_prefs);
  }

  void setLocale(String? code) => _update(state.copyWith(localeCode: code));
  void setThemeMode(AppThemeMode mode) =>
      _update(state.copyWith(themeMode: mode));
  void setUiKit(String id) => _update(state.copyWith(uiKitId: id));
  void setReminderEnabled(bool v) {
    _update(state.copyWith(reminderEnabled: v));
    if (v) {
      NotificationService.ensurePermissions().then((_) => _syncReminder());
    } else {
      _syncReminder();
    }
  }

  void setReminderTime(int hour, int minute) {
    _update(state.copyWith(reminderHour: hour, reminderMinute: minute));
    if (state.reminderEnabled) {
      NotificationService.ensurePermissions().then((_) => _syncReminder());
    }
  }

  /// Pushes the current reminder settings to the OS scheduler. Fire-and-forget;
  /// no-ops on platforms without local notifications.
  void _syncReminder() {
    final s = state;
    if (s.reminderEnabled) {
      NotificationService.scheduleDaily(
        hour: s.reminderHour,
        minute: s.reminderMinute,
        title: 'Record your day 🎬',
        body: "One second. That's all it takes.",
      );
    } else {
      NotificationService.cancelDaily();
    }
  }

  void setDefaultDuration(int sec) =>
      _update(state.copyWith(defaultDurationSec: sec));
  void setSaveToGallery(bool v) => _update(state.copyWith(saveToGallery: v));
  void setNavigationBarStyle(NavigationBarStyle style) =>
      _update(state.copyWith(navigationBarStyle: style));

  void setNavigationBarType(NavigationBarType type) =>
      _update(state.copyWith(navigationBarType: type));

  void unlockColorCustomizer() =>
      _update(state.copyWith(colorCustomizerUnlocked: true));

  void setCustomAccent(Color? color) =>
      _update(state.copyWith(customAccent: color));

  void setCustomFont(AppFontPreset preset) =>
      _update(state.copyWith(customFontId: preset.id));

  void setCustomBackground(Brightness brightness, Color color) {
    if (brightness == Brightness.dark) {
      _update(
        state.copyWith(
          darkColorOverrides: state.darkColorOverrides.copyWith(
            background: color,
          ),
        ),
      );
    } else {
      _update(
        state.copyWith(
          lightColorOverrides: state.lightColorOverrides.copyWith(
            background: color,
          ),
        ),
      );
    }
  }

  void setCustomSurface(Brightness brightness, Color color) {
    if (brightness == Brightness.dark) {
      _update(
        state.copyWith(
          darkColorOverrides: state.darkColorOverrides.copyWith(surface: color),
        ),
      );
    } else {
      _update(
        state.copyWith(
          lightColorOverrides: state.lightColorOverrides.copyWith(
            surface: color,
          ),
        ),
      );
    }
  }

  Future<void> setCustomBackgroundImage(
    Brightness brightness,
    String sourcePath,
  ) async {
    final oldPath = state.colorOverridesFor(brightness).backgroundImagePath;
    await evictBackgroundImage(oldPath);
    final savedPath = await BackgroundImageService.save(brightness, sourcePath);
    await evictBackgroundImage(savedPath);
    if (brightness == Brightness.dark) {
      _update(
        state.copyWith(
          darkColorOverrides: state.darkColorOverrides.copyWith(
            backgroundImagePath: savedPath,
          ),
        ),
      );
    } else {
      _update(
        state.copyWith(
          lightColorOverrides: state.lightColorOverrides.copyWith(
            backgroundImagePath: savedPath,
          ),
        ),
      );
    }
  }

  Future<void> clearCustomBackgroundImage(Brightness brightness) async {
    final oldPath = state.colorOverridesFor(brightness).backgroundImagePath;
    await evictBackgroundImage(oldPath);
    await BackgroundImageService.delete(brightness);
    if (brightness == Brightness.dark) {
      _update(
        state.copyWith(
          darkColorOverrides: state.darkColorOverrides.copyWith(
            backgroundImagePath: null,
          ),
        ),
      );
    } else {
      _update(
        state.copyWith(
          lightColorOverrides: state.lightColorOverrides.copyWith(
            backgroundImagePath: null,
          ),
        ),
      );
    }
  }

  void resetCustomColors() {
    BackgroundImageService.deleteAll();
    _update(
      state.copyWith(
        customAccent: null,
        customFontId: null,
        lightColorOverrides: const ThemeColorOverrides(),
        darkColorOverrides: const ThemeColorOverrides(),
      ),
    );
  }

  void resetAll() {
    BackgroundImageService.deleteAll();
    _update(AppSettings.defaults);
    _syncReminder();
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

/// The currently active UI library, resolved from settings.
final activeUiKitProvider = Provider<UiKit>(
  (ref) => UiKitRegistry.byId(ref.watch(settingsProvider).uiKitId),
);

/// Resolves the brightness used for theme-scoped color customization.
Brightness effectiveThemeBrightness(BuildContext context, AppSettings settings) {
  return switch (settings.themeMode) {
    AppThemeMode.light => Brightness.light,
    AppThemeMode.dark => Brightness.dark,
    AppThemeMode.system => MediaQuery.platformBrightnessOf(context),
  };
}
