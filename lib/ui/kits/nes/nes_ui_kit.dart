import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../../theme/app_fonts.dart';
import '../../../theme/dayly_themed_child.dart';
import '../../../theme/design_tokens.dart';
import '../../ui_kit.dart';

/// Retro NES-style implementation of [UiKit].
class NesUiKit implements UiKit {
  const NesUiKit();

  @override
  String get id => 'nes';

  @override
  String get displayName => 'NES UI';

  ThemeData _theme(DesignTokens tokens) {
    final p = tokens.palette;
    final fonts = AppFontStyles.forPreset(tokens.fontPreset);
    final body = fonts.materialTextTheme(p);
    return flutterNesTheme(
      primaryColor: p.accent,
      brightness: p.brightness,
      textTheme: body,
      nesButtonTheme: NesButtonTheme(
        normal: p.surface,
        primary: p.accent,
        success: p.accentDim,
        warning: const Color(0xfff7d51d),
        error: p.danger,
        lightLabelColor: p.onAccent,
        darkLabelColor: p.textPrimary,
        lightIconTheme: NesIconTheme(
          primary: p.textPrimary,
          secondary: p.surface,
          accent: p.textSecondary,
          shadow: p.border,
        ),
        darkIconTheme: NesIconTheme(
          primary: p.textPrimary,
          secondary: p.surface,
          accent: p.textSecondary,
          shadow: p.border,
        ),
      ),
      nesContainerTheme: NesContainerTheme(
        backgroundColor: p.surface,
        borderColor: p.textPrimary,
        labelTextStyle: body.labelMedium ?? const TextStyle(),
        padding: const EdgeInsets.all(16),
      ),
    ).copyWith(scaffoldBackgroundColor: Colors.transparent);
  }

  NesButtonType _buttonType(AppButtonVariant variant) => switch (variant) {
        AppButtonVariant.primary => NesButtonType.primary,
        AppButtonVariant.secondary => NesButtonType.normal,
        AppButtonVariant.ghost => NesButtonType.normal,
        AppButtonVariant.destructive => NesButtonType.error,
      };

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
    final label = _withAffixes(child, leading, trailing);
    final button = NesButton(
      type: _buttonType(variant),
      onPressed: onPressed,
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: variant == AppButtonVariant.ghost ? null : null,
          fontWeight: FontWeight.w600,
        ),
        child: label,
      ),
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }

  @override
  Widget iconButton({
    required IconData icon,
    VoidCallback? onPressed,
    String? tooltip,
  }) {
    return NesButton(
      type: NesButtonType.normal,
      onPressed: onPressed,
      child: Icon(icon, size: 20),
    );
  }

  @override
  Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    final card = NesContainer(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
    if (onTap == null) return card;
    return GestureDetector(onTap: onTap, behavior: HitTestBehavior.opaque, child: card);
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
    return NesContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: onTap == null
            ? row
            : GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.opaque,
                child: row,
              ),
      ),
    );
  }

  @override
  Widget toggle({required bool value, ValueChanged<bool>? onChanged}) {
    return NesCheckBox(
      value: value,
      onChange: onChanged,
    );
  }

  @override
  Widget choiceChip({
    required Widget label,
    required bool selected,
    VoidCallback? onTap,
  }) {
    return NesButton(
      type: selected ? NesButtonType.primary : NesButtonType.normal,
      onPressed: onTap,
      child: label,
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
      decoration: InputDecoration(hintText: hint),
    );
  }

  @override
  Widget progressBar({double? value}) {
    if (value == null) {
      return const Center(child: NesHourglassLoadingIndicator());
    }
    return NesProgressBar(value: value.clamp(0.0, 1.0));
  }

  @override
  Widget divider() => const Divider(height: 1);
}
