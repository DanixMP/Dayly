import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../../theme/app_fonts.dart';
import '../../../theme/dayly_themed_child.dart';
import '../../../theme/design_tokens.dart';
import '../../ui_kit.dart';

/// Apache Pivot–inspired Chicago desktop UI implementation of [UiKit].
class ChicagoUiKit implements UiKit {
  const ChicagoUiKit();

  static const _bg = material.Color(0xffdddcd5);
  static const _border = material.Color(0xff999999);
  static const _accent = material.Color(0xff3c77b2);

  @override
  String get id => 'chicago';

  @override
  String get displayName => 'Chicago';

  material.ThemeData _theme(DesignTokens tokens) {
    final p = tokens.palette;
    final fonts = AppFontStyles.forPreset(tokens.fontPreset);
    return material.ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: material.Colors.transparent,
      textTheme: fonts.materialTextTheme(p),
      primaryTextTheme: fonts.materialTextTheme(p),
      colorScheme: material.ColorScheme(
        brightness: p.brightness,
        primary: _accent,
        onPrimary: material.Colors.white,
        secondary: p.accentDim,
        onSecondary: p.textPrimary,
        error: p.danger,
        onError: p.onAccent,
        surface: _bg,
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
    return material.MaterialApp.router(
      title: title,
      theme: _theme(lightTokens),
      darkTheme: _theme(darkTokens),
      themeMode: switch (themeMode) {
        AppThemeMode.system => material.ThemeMode.system,
        AppThemeMode.light => material.ThemeMode.light,
        AppThemeMode.dark => material.ThemeMode.dark,
      },
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return DaylyThemedChild(
          uiKit: this,
          brightness: material.Theme.of(context).brightness,
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

  Widget _surfaceButton({
    required Widget child,
    VoidCallback? onPressed,
    Color backgroundColor = _bg,
    Color foregroundColor = material.Colors.black,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
  }) {
    return chicago.HoverBuilder(
      builder: (context, hover) {
        final bg = hover && onPressed != null
            ? material.Color.lerp(backgroundColor, material.Colors.white, 0.12)!
            : backgroundColor;
        return GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: onPressed == null ? backgroundColor.withValues(alpha: 0.7) : bg,
              border: Border.all(color: _border),
            ),
            child: Padding(
              padding: padding,
              child: DefaultTextStyle(
                style: TextStyle(
                  color: onPressed == null
                      ? const material.Color(0xff999999)
                      : foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
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
    return material.Scaffold(
      key: key,
      backgroundColor: material.Colors.transparent,
      extendBody: true,
      appBar: material.PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: chicago.Sheet(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          content: Row(
            children: [
              ?leading,
              if (leading != null) const SizedBox(width: 8),
              Expanded(
                child: Align(
                  alignment: centerTitle
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: material.Colors.black,
                    ),
                    child: title ?? const SizedBox.shrink(),
                  ),
                ),
              ),
              ...actions,
            ],
          ),
        ),
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
    final (bg, fg) = switch (variant) {
      AppButtonVariant.primary => (_accent, material.Colors.white),
      AppButtonVariant.secondary => (_bg, material.Colors.black),
      AppButtonVariant.ghost => (const material.Color(0xfff6f4ed), material.Colors.black),
      AppButtonVariant.destructive => (const material.Color(0xffcc4444), material.Colors.white),
    };
    final button = _surfaceButton(
      onPressed: onPressed,
      backgroundColor: bg,
      foregroundColor: fg,
      child: label,
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }

  @override
  Widget iconButton({
    required IconData icon,
    VoidCallback? onPressed,
    String? tooltip,
  }) {
    return _surfaceButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(6),
      child: Icon(icon, size: 18),
    );
  }

  @override
  Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    final card = chicago.Sheet(
      padding: padding ?? const EdgeInsets.all(16),
      content: child,
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
          Icon(leadingIcon, size: 18),
          const SizedBox(width: 10),
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
        if (trailing != null) ...[const SizedBox(width: 10), trailing],
      ],
    );
    return chicago.Sheet(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      content: onTap == null
          ? row
          : GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: row,
            ),
    );
  }

  @override
  Widget toggle({required bool value, ValueChanged<bool>? onChanged}) {
    return _ChicagoToggle(value: value, onChanged: onChanged);
  }

  @override
  Widget choiceChip({
    required Widget label,
    required bool selected,
    VoidCallback? onTap,
  }) {
    return _surfaceButton(
      onPressed: onTap,
      backgroundColor: selected ? _accent : _bg,
      foregroundColor: selected ? material.Colors.white : material.Colors.black,
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
    return chicago.TextInput(
      controller: controller,
      onTextUpdated: onChanged,
    );
  }

  @override
  Widget progressBar({double? value}) {
    if (value == null) {
      return const chicago.ActivityIndicator();
    }
    return chicago.Meter(percentage: value.clamp(0.0, 1.0));
  }

  @override
  Widget divider() {
    return Container(height: 1, color: _border);
  }
}

class _ChicagoToggle extends StatefulWidget {
  const _ChicagoToggle({required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  State<_ChicagoToggle> createState() => _ChicagoToggleState();
}

class _ChicagoToggleState extends State<_ChicagoToggle> {
  late chicago.CheckboxController _controller;

  @override
  void initState() {
    super.initState();
    _controller = chicago.CheckboxController.simple(widget.value);
    _controller.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant _ChicagoToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.checked = widget.value;
    }
  }

  void _handleChange() {
    widget.onChanged?.call(_controller.checked);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chicago.Checkbox(
      controller: _controller,
      isEnabled: widget.onChanged != null,
    );
  }
}
