import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as sf;

import '../../../theme/app_fonts.dart';
import '../../../theme/dayly_themed_child.dart';
import '../../../theme/app_palette.dart';
import '../../../theme/design_tokens.dart';
import '../../ui_kit.dart';

/// shadcn_flutter implementation of [UiKit].
///
/// This is the ONLY file in the app permitted to import `shadcn_flutter`.
/// Everything library-specific is contained here; swapping to another kit is a
/// matter of providing a different [UiKit] (see `MaterialUiKit`).
class ShadcnUiKit implements UiKit {
  const ShadcnUiKit();

  @override
  String get id => 'shadcn';

  @override
  String get displayName => 'shadcn_flutter';

  // --- Root -----------------------------------------------------------------

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
    return sf.ShadcnApp.router(
      title: title,
      theme: _theme(lightTokens),
      darkTheme: _theme(darkTokens),
      themeMode: switch (themeMode) {
        AppThemeMode.system => sf.ThemeMode.system,
        AppThemeMode.light => sf.ThemeMode.light,
        AppThemeMode.dark => sf.ThemeMode.dark,
      },
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final brightness = sf.Theme.of(context).colorScheme.brightness;
        return DaylyThemedChild(
          uiKit: this,
          brightness: brightness,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }

  sf.ThemeData _theme(DesignTokens tokens) {
    final fonts = AppFontStyles.forPreset(tokens.fontPreset);
    return sf.ThemeData(
      colorScheme: _scheme(tokens.palette),
      radius: 0.6,
      typography: fonts.shadcnTypography(tokens.palette),
    );
  }

  sf.ColorScheme _scheme(DaylyPalette p) => sf.ColorScheme(
    brightness: p.brightness,
    background: p.background,
    foreground: p.textPrimary,
    card: p.surface,
    cardForeground: p.textPrimary,
    popover: p.surfaceElevated,
    popoverForeground: p.textPrimary,
    primary: p.accent,
    primaryForeground: p.onAccent,
    secondary: p.surfaceElevated,
    secondaryForeground: p.textPrimary,
    muted: p.surface,
    mutedForeground: p.textSecondary,
    accent: p.surfaceElevated,
    accentForeground: p.textPrimary,
    destructive: p.danger,
    destructiveForeground: p.onAccent,
    border: p.border,
    input: p.border,
    ring: p.accent,
    chart1: p.accent,
    chart2: p.accentDim,
    chart3: p.success,
    chart4: p.danger,
    chart5: p.textSecondary,
  );

  // --- Primitives -----------------------------------------------------------

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
    return sf.Scaffold(
      key: key,
      backgroundColor: const Color(0x00000000),
      headers: [
        sf.AppBar(
          leading: leading != null ? [leading] : const [],
          title: title,
          trailing: actions,
          alignment: centerTitle
              ? Alignment.center
              : AlignmentDirectional.centerStart,
        ),
        const sf.Divider(),
      ],
      footers: bottomBar != null
          ? [
              const sf.Divider(),
              Padding(padding: const EdgeInsets.all(16), child: bottomBar),
            ]
          : const [],
      child: body,
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
    final button = switch (variant) {
      AppButtonVariant.primary => sf.PrimaryButton(
        onPressed: onPressed,
        leading: leading,
        trailing: trailing,
        child: child,
      ),
      AppButtonVariant.secondary => sf.SecondaryButton(
        onPressed: onPressed,
        leading: leading,
        trailing: trailing,
        child: child,
      ),
      AppButtonVariant.ghost => sf.GhostButton(
        onPressed: onPressed,
        leading: leading,
        trailing: trailing,
        child: child,
      ),
      AppButtonVariant.destructive => sf.DestructiveButton(
        onPressed: onPressed,
        leading: leading,
        trailing: trailing,
        child: child,
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
    return sf.GhostButton(
      onPressed: onPressed,
      density: sf.ButtonDensity.icon,
      child: Icon(icon, size: 20),
    );
  }

  @override
  Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) {
    final card = sf.Card(
      padding: padding as EdgeInsets? ?? const EdgeInsets.all(16),
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
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
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
    return sf.Switch(value: value, onChanged: onChanged);
  }

  @override
  Widget choiceChip({
    required Widget label,
    required bool selected,
    VoidCallback? onTap,
  }) {
    return sf.Chip(
      onPressed: onTap,
      style: selected
          ? const sf.ButtonStyle.primary()
          : const sf.ButtonStyle.outline(),
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
    return sf.TextField(
      controller: controller,
      onChanged: onChanged,
      placeholder: hint != null ? Text(hint) : null,
      maxLines: maxLines,
    );
  }

  @override
  Widget progressBar({double? value}) {
    return sf.LinearProgressIndicator(value: value);
  }

  @override
  Widget divider() => const sf.Divider();
}
