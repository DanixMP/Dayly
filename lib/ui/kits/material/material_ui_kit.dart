import 'package:flutter/material.dart';

import '../../../theme/app_fonts.dart';
import '../../../theme/dayly_themed_child.dart';
import '../../../theme/design_tokens.dart';
import '../../ui_kit.dart';

/// Material 3 implementation of [UiKit].
///
/// Exists alongside the shadcn kit to validate the abstraction: the same
/// feature screens render through a completely different component library by
/// swapping this in. The only file allowed to import `package:flutter/material`
/// for components (besides icon glyph data).
class MaterialUiKit implements UiKit {
  const MaterialUiKit();

  @override
  String get id => 'material';

  @override
  String get displayName => 'Material 3';

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
    final scheme = ColorScheme(
      brightness: p.brightness,
      primary: p.accent,
      onPrimary: p.onAccent,
      secondary: p.accentDim,
      onSecondary: p.textPrimary,
      error: p.danger,
      onError: p.onAccent,
      surface: p.surface,
      onSurface: p.textPrimary,
      surfaceContainerHighest: p.surfaceElevated,
      outline: p.border,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.transparent,
      dividerColor: p.border,
      textTheme: fonts.materialTextTheme(p),
      primaryTextTheme: fonts.materialTextTheme(p),
    );
  }

  Widget _withAffixes(Widget child, Widget? leading, Widget? trailing) {
    if (leading == null && trailing == null) return child;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading, const SizedBox(width: 8)],
        child,
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
    final label = _withAffixes(child, leading, trailing);
    final Widget button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: onPressed,
        child: label,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: onPressed,
        child: label,
      ),
      AppButtonVariant.ghost => TextButton(onPressed: onPressed, child: label),
      AppButtonVariant.destructive => FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(backgroundColor: const Color(0xFFD95F5F)),
        child: label,
      ),
    };
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }

  @override
  Widget iconButton({
    required IconData icon,
    VoidCallback? onPressed,
    String? tooltip,
  }) {
    return IconButton(icon: Icon(icon), onPressed: onPressed, tooltip: tooltip);
  }

  @override
  Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
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
    return ListTile(
      leading: leadingIcon != null ? Icon(leadingIcon) : null,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
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
    return ChoiceChip(
      label: label,
      selected: selected,
      onSelected: onTap != null ? (_) => onTap() : null,
    );
  }

  @override
  Widget textField({
    TextEditingController? controller,
    String? hint,
    ValueChanged<String>? onChanged,
    int? maxLines,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget progressBar({double? value}) {
    return LinearProgressIndicator(value: value);
  }

  @override
  Widget divider() => const Divider(height: 1);
}
