import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../../theme/app_fonts.dart';
import '../../../theme/dayly_themed_child.dart';
import '../../../theme/app_palette.dart';
import '../../../theme/design_tokens.dart';
import '../../performance/gpu_effects.dart';
import '../../ui_kit.dart';

/// Liquid glass (frosted refraction) implementation of [UiKit].
///
/// Uses Impeller GPU shaders per card when available; falls back to lightweight
/// tinted surfaces on Skia or low-end devices.
class LiquidGlassUiKit implements UiKit {
  const LiquidGlassUiKit();

  @override
  String get id => 'liquid_glass';

  @override
  String get displayName => 'Liquid Glass';

  LiquidGlassSettings _glassSettings(DaylyPalette p) => LiquidGlassSettings(
        blur: GpuEffects.isShaderSupported ? 8 : 0,
        thickness: 4,
        glassColor: p.surface.withValues(alpha: p.isDark ? 0.36 : 0.5),
        lightIntensity: 0.5,
        ambientStrength: 0.08,
        chromaticAberration: 0,
        saturation: 1.15,
      );

  @override
  Widget buildApp({
    required DesignTokens lightTokens,
    required DesignTokens darkTokens,
    required AppThemeMode themeMode,
    required Locale? locale,
    required RouterConfig<Object> routerConfig,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
    required List<Locale> supportedLocales,
    required String title,
  }) {
    return MaterialApp.router(
      title: title,
      theme: _theme(lightTokens),
      darkTheme: _theme(darkTokens),
      themeMode: switch (themeMode) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      },
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final brightness = Theme.of(context).brightness;
        return DaylyThemedChild(
          uiKit: this,
          brightness: brightness,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }

  ThemeData _theme(DesignTokens tokens) {
    final p = tokens.palette;
    final fonts = AppFontStyles.forPreset(tokens.fontPreset);
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: fonts.materialTextTheme(p),
      primaryTextTheme: fonts.materialTextTheme(p),
      colorScheme: ColorScheme(
        brightness: p.brightness,
        primary: p.accent,
        onPrimary: p.onAccent,
        secondary: p.accentDim,
        onSecondary: p.textPrimary,
        error: p.danger,
        onError: p.onAccent,
        surface: p.surface,
        onSurface: p.textPrimary,
      ),
    );
  }

  Widget _softSurface({
    required DaylyPalette p,
    required Widget child,
    EdgeInsetsGeometry? padding,
    double radius = 14,
    Color? tint,
    VoidCallback? onTap,
  }) {
    final surface = DecoratedBox(
      decoration: BoxDecoration(
        color: (tint ?? p.surface).withValues(alpha: p.isDark ? 0.34 : 0.46),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: p.border.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
    if (onTap == null) return surface;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: surface,
    );
  }

  Widget _glassCard({
    required DaylyPalette p,
    required Widget child,
    EdgeInsetsGeometry? padding,
    double radius = 16,
    VoidCallback? onTap,
  }) {
    final shape = LiquidRoundedSuperellipse(borderRadius: radius);
    final content = Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );

    final Widget card;
    if (GpuEffects.isShaderSupported) {
      card = GpuEffects.cached(
        LiquidGlass.withOwnLayer(
          settings: _glassSettings(p),
          fake: false,
          shape: shape,
          child: content,
        ),
      );
    } else {
      card = _softSurface(p: p, radius: radius, child: child, padding: padding);
    }

    if (onTap == null) return card;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: card,
    );
  }

  @override
  Widget scaffold({
    Key? key,
    Widget? title,
    Widget? leading,
    List<Widget> actions = const [],
    required Widget body,
    Widget? bottomBar,
    bool centerTitle = false,
  }) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.transparent,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: leading,
        title: title,
        actions: actions,
        centerTitle: centerTitle,
      ),
      body: body,
      bottomNavigationBar: bottomBar,
    );
  }

  @override
  Widget button({
    required AppButtonVariant variant,
    required Widget child,
    VoidCallback? onPressed,
    Widget? leading,
    Widget? trailing,
    bool expand = false,
  }) {
    return Builder(
      builder: (context) {
        final p = context.tokens.palette;
        final label = _withAffixes(child, leading, trailing);
        final tint = switch (variant) {
          AppButtonVariant.primary => p.accent.withValues(alpha: 0.48),
          AppButtonVariant.secondary => p.surface.withValues(alpha: 0.55),
          AppButtonVariant.ghost => p.surface.withValues(alpha: 0.2),
          AppButtonVariant.destructive => p.danger.withValues(alpha: 0.48),
        };

        final button = _softSurface(
          p: p,
          radius: 14,
          tint: tint,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          onTap: onPressed,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: variant == AppButtonVariant.ghost
                  ? p.textPrimary
                  : p.onAccent,
              fontWeight: FontWeight.w600,
            ),
            child: Center(child: label),
          ),
        );
        return expand
            ? SizedBox(width: double.infinity, child: button)
            : button;
      },
    );
  }

  Widget _withAffixes(Widget child, Widget? leading, Widget? trailing) {
    if (leading == null && trailing == null) return child;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[leading, const SizedBox(width: 8)],
        Flexible(child: child),
        if (trailing != null) ...[const SizedBox(width: 8), trailing],
      ],
    );
  }

  @override
  Widget iconButton({
    required IconData icon,
    VoidCallback? onPressed,
    String? tooltip,
  }) {
    return Builder(
      builder: (context) {
        final p = context.tokens.palette;
        return _softSurface(
          p: p,
          radius: 12,
          padding: const EdgeInsets.all(10),
          onTap: onPressed,
          child: Icon(icon, size: 20, color: p.textPrimary),
        );
      },
    );
  }

  @override
  Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) => _glassCard(
        p: context.tokens.palette,
        padding: padding,
        onTap: onTap,
        child: child,
      ),
    );
  }

  @override
  Widget listTile({
    IconData? leadingIcon,
    required Widget title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final row = Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 20),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              title,
              if (subtitle != null) ...[const SizedBox(height: 2), subtitle],
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 12), trailing],
      ],
    );
    return Builder(
      builder: (context) => _softSurface(
        p: context.tokens.palette,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        radius: 14,
        onTap: onTap,
        child: row,
      ),
    );
  }

  @override
  Widget toggle({required bool value, ValueChanged<bool>? onChanged}) {
    return Switch(value: value, onChanged: onChanged);
  }

  @override
  Widget choiceChip({
    required Widget label,
    required bool selected,
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        final p = context.tokens.palette;
        return _softSurface(
          p: p,
          radius: 20,
          tint: (selected ? p.accent : p.surface).withValues(
            alpha: selected ? 0.48 : 0.34,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          onTap: onTap,
          child: label,
        );
      },
    );
  }

  @override
  Widget textField({
    TextEditingController? controller,
    String? hint,
    ValueChanged<String>? onChanged,
    int? maxLines,
  }) {
    return Builder(
      builder: (context) {
        final p = context.tokens.palette;
        return _softSurface(
          p: p,
          radius: 12,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget progressBar({double? value}) {
    return LinearProgressIndicator(value: value);
  }

  @override
  Widget divider() => const Divider(height: 1);
}
