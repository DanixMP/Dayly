import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../../theme/app_fonts.dart';
import '../../../theme/app_palette.dart';
import '../../../theme/dayly_themed_child.dart';
import '../../../theme/design_tokens.dart';
import '../../ui_kit.dart';

/// Neubrutalism UI implementation of [UiKit].
class NeubrutalismUiKit implements UiKit {
  const NeubrutalismUiKit();

  @override
  String get id => 'neubrutalism';

  @override
  String get displayName => 'Neubrutalism';

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
        return DaylyThemedChild(
          uiKit: this,
          brightness: Theme.of(context).brightness,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }

  Color _buttonColor(DaylyPalette p, AppButtonVariant variant) =>
      switch (variant) {
        AppButtonVariant.primary => p.accent,
        AppButtonVariant.secondary => p.surfaceElevated,
        AppButtonVariant.ghost => p.surface,
        AppButtonVariant.destructive => p.danger,
      };

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

  Widget _pressable({
    required DaylyPalette p,
    required AppButtonVariant variant,
    required Widget child,
    VoidCallback? onPressed,
    double? width,
    BorderRadius? radius,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: NeuContainer(
        width: width,
        color: _buttonColor(p, variant),
        borderRadius: radius ?? BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: variant == AppButtonVariant.ghost
                  ? p.textPrimary
                  : p.onAccent,
              fontWeight: FontWeight.w700,
            ),
            child: Center(child: child),
          ),
        ),
      ),
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
        final button = _pressable(
          p: p,
          variant: variant,
          onPressed: onPressed,
          width: expand ? double.infinity : null,
          child: label,
        );
        return button;
      },
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
        return NeuIconButton(
          enableAnimation: true,
          icon: Icon(icon, size: 20, color: p.textPrimary),
          buttonColor: p.surfaceElevated,
          buttonHeight: 44,
          buttonWidth: 44,
          borderRadius: BorderRadius.circular(10),
          onPressed: onPressed,
        );
      },
    );
  }

  EdgeInsets _edgeInsets(EdgeInsetsGeometry? value, {required EdgeInsets fallback}) {
    if (value == null) return fallback;
    if (value is EdgeInsets) return value;
    return value.resolve(TextDirection.ltr);
  }

  @override
  Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        final p = context.tokens.palette;
        final card = NeuCard(
          cardColor: p.surface,
          cardBorderColor: neuBlack,
          paddingData: _edgeInsets(padding, fallback: const EdgeInsets.all(16)),
          borderRadius: BorderRadius.circular(12),
          child: child,
        );
        if (onTap == null) return card;
        return GestureDetector(onTap: onTap, child: card);
      },
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
      builder: (context) {
        final p = context.tokens.palette;
        return NeuCard(
          cardColor: p.surface,
          paddingData: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          borderRadius: BorderRadius.circular(12),
          child: onTap == null
              ? row
              : GestureDetector(
                  onTap: onTap,
                  behavior: HitTestBehavior.opaque,
                  child: row,
                ),
        );
      },
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
        return _pressable(
          p: p,
          variant: selected ? AppButtonVariant.primary : AppButtonVariant.secondary,
          onPressed: onTap,
          radius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            child: label,
          ),
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
        return NeuContainer(
          color: p.surface,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
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
  Widget divider() => Divider(height: 1, color: neuBlack.withValues(alpha: 0.35));
}
