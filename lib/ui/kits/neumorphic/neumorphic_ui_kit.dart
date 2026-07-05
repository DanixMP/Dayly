import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../../../theme/app_fonts.dart';
import '../../../theme/dayly_themed_child.dart';
import '../../../theme/app_palette.dart';
import '../../../theme/design_tokens.dart';
import '../../performance/gpu_effects.dart';
import '../../ui_kit.dart';

/// Neumorphic soft-UI implementation of [UiKit].
///
/// Each raised surface is wrapped in a [RepaintBoundary] so shadow layers are
/// cached on the GPU instead of repainting every frame while scrolling.
class NeumorphicUiKit implements UiKit {
  const NeumorphicUiKit();

  static const _surfaceDuration = Duration(milliseconds: 80);

  @override
  String get id => 'neumorphic';

  @override
  String get displayName => 'Neumorphic';

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
    return NeumorphicTheme(
      theme: _neumorphicTheme(lightTokens.palette),
      darkTheme: _neumorphicTheme(darkTokens.palette),
      child: MaterialApp.router(
        title: title,
        theme: _materialTheme(lightTokens),
        darkTheme: _materialTheme(darkTokens),
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
      ),
    );
  }

  NeumorphicThemeData _neumorphicTheme(DaylyPalette p) {
    return NeumorphicThemeData(
      baseColor: p.surface,
      accentColor: p.accent,
      lightSource: LightSource.topLeft,
      depth: 2,
      intensity: 0.5,
      variantColor: p.surfaceElevated,
    );
  }

  ThemeData _materialTheme(DesignTokens tokens) {
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

  NeumorphicStyle _style(
    DaylyPalette p, {
    double depth = 2,
    Color? color,
    NeumorphicShape shape = NeumorphicShape.convex,
    BorderRadius? radius,
  }) {
    return NeumorphicStyle(
      depth: depth,
      intensity: 0.55,
      color: color ?? p.surface,
      lightSource: LightSource.topLeft,
      shape: shape,
      boxShape: NeumorphicBoxShape.roundRect(
        radius ?? BorderRadius.circular(14),
      ),
    );
  }

  /// Caches neumorphic shadow layers on the GPU via [RepaintBoundary].
  Widget _cachedNeumorphic({
    required NeumorphicStyle style,
    required Widget child,
    EdgeInsets padding = EdgeInsets.zero,
    Duration duration = _surfaceDuration,
    bool drawSurfaceAboveChild = false,
  }) {
    return GpuEffects.cached(
      Neumorphic(
        style: style,
        duration: duration,
        drawSurfaceAboveChild: drawSurfaceAboveChild,
        padding: padding,
        child: child,
      ),
    );
  }

  EdgeInsets _edgeInsets(EdgeInsetsGeometry? value, {required EdgeInsets fallback}) {
    if (value == null) return fallback;
    if (value is EdgeInsets) return value;
    return value.resolve(TextDirection.ltr);
  }

  Widget _withAffixes(Widget child, Widget? leading, Widget? trailing) {
    if (leading == null && trailing == null) return child;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading, const SizedBox(width: 8)],
        Flexible(child: child),
        if (trailing != null) ...[const SizedBox(width: 8), trailing],
      ],
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
      bottomNavigationBar: bottomBar != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: bottomBar,
              ),
            )
          : null,
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
        final style = switch (variant) {
          AppButtonVariant.primary => _style(
            p,
            depth: -1.2,
            color: p.accent.withValues(alpha: 0.32),
          ),
          AppButtonVariant.secondary => _style(p, depth: 1.8),
          AppButtonVariant.ghost => _style(
            p,
            depth: 0.6,
            shape: NeumorphicShape.flat,
          ),
          AppButtonVariant.destructive => _style(
            p,
            depth: -1.2,
            color: p.danger.withValues(alpha: 0.32),
          ),
        };

        final button = NeumorphicButton(
          style: style,
          duration: _surfaceDuration,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          onPressed: onPressed,
          child: label,
        );
        final cached = GpuEffects.cached(button);
        return expand
            ? SizedBox(width: double.infinity, child: cached)
            : cached;
      },
    );
  }

  @override
  Widget iconButton({
    required IconData icon,
    VoidCallback? onPressed,
    String? tooltip,
  }) {
    return GpuEffects.cached(
      NeumorphicButton(
        style: NeumorphicStyle(
          boxShape: const NeumorphicBoxShape.circle(),
          depth: 1.2,
          intensity: 0.5,
        ),
        duration: _surfaceDuration,
        padding: const EdgeInsets.all(12),
        onPressed: onPressed,
        child: Icon(icon, size: 20),
      ),
    );
  }

  @override
  Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    final card = _cachedNeumorphic(
      style: NeumorphicStyle(
        depth: 1.8,
        intensity: 0.58,
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(16)),
        ),
      ),
      padding: _edgeInsets(padding, fallback: const EdgeInsets.all(16)),
      child: child,
    );
    if (onTap == null) return card;
    return GestureDetector(onTap: onTap, child: card);
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
    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: row,
    );
    if (onTap == null) return content;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: content,
    );
  }

  @override
  Widget toggle({required bool value, ValueChanged<bool>? onChanged}) {
    return GpuEffects.cached(
      NeumorphicSwitch(
        value: value,
        onChanged: onChanged,
        duration: _surfaceDuration,
      ),
    );
  }

  @override
  Widget choiceChip({
    required Widget label,
    required bool selected,
    VoidCallback? onTap,
  }) {
    return GpuEffects.cached(
      NeumorphicButton(
        style: NeumorphicStyle(
          depth: selected ? -1.2 : 1.2,
          intensity: selected ? 0.65 : 0.52,
          shape: selected ? NeumorphicShape.concave : NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
        ),
        duration: _surfaceDuration,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        onPressed: onTap,
        child: label,
      ),
    );
  }

  @override
  Widget textField({
    TextEditingController? controller,
    String? hint,
    ValueChanged<String>? onChanged,
    int? maxLines,
  }) {
    return _cachedNeumorphic(
      style: NeumorphicStyle(
        depth: -1.2,
        intensity: 0.52,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(12)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        maxLines: maxLines,
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }

  @override
  Widget progressBar({double? value}) {
    if (value == null) {
      return const NeumorphicProgressIndeterminate();
    }
    return NeumorphicProgress(percent: value.clamp(0.0, 1.0));
  }

  @override
  Widget divider() => Divider(height: 1, color: Colors.black12);
}
