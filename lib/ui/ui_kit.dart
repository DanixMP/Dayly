import 'package:flutter/widgets.dart';

import '../theme/design_tokens.dart';

/// Button intents, mapped by each kit to its own variant system.
enum AppButtonVariant { primary, secondary, ghost, destructive }

/// {@template ui_kit}
/// A pluggable component library.
///
/// This is the seam that makes the whole app UI-library-agnostic. Screens
/// build with the semantic widgets in `app_widgets.dart` (AppButton, AppCard,
/// …); those widgets resolve the active [UiKit] from the [UiKitScope] and
/// delegate every primitive to it. Swapping libraries = providing a different
/// [UiKit] implementation. The first one is the shadcn_flutter kit.
///
/// A [UiKit] owns two things:
///   1. The application root ([buildApp]) — because each library ships its own
///      app widget (ShadcnApp, MaterialApp, …) and theming system.
///   2. The set of primitives every screen needs (buttons, cards, fields, …).
///
/// Implementations must keep their library import *contained to their own
/// file*. No app/feature code may import a concrete UI library.
/// {@endtemplate}
abstract class UiKit {
  /// Stable id used for persistence and equality (e.g. `'shadcn'`).
  String get id;

  /// Human-readable name shown in the UI-library picker.
  String get displayName;

  /// Builds the application root for this library: its app widget, native
  /// light/dark theme (derived from [lightTokens]/[darkTokens]) and router.
  ///
  /// Implementations must wrap the navigator subtree with [UiKitScope] (this
  /// kit) and a [DaylyThemeScope] whose tokens match the *resolved* brightness,
  /// so screens can read both `context.ui` and `context.tokens`.
  Widget buildApp({
    required DesignTokens lightTokens,
    required DesignTokens darkTokens,
    required AppThemeMode themeMode,
    required Locale? locale,
    required RouterConfig<Object> routerConfig,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
    required List<Locale> supportedLocales,
    required String title,
  });

  // --- Primitives -----------------------------------------------------------

  /// A page scaffold with an app-bar-like header.
  Widget scaffold({
    Key? key,
    Widget? title,
    Widget? leading,
    List<Widget> actions,
    required Widget body,
    Widget? bottomBar,
    bool centerTitle,
  });

  Widget button({
    required AppButtonVariant variant,
    required Widget child,
    VoidCallback? onPressed,
    Widget? leading,
    Widget? trailing,
    bool expand,
  });

  Widget iconButton({
    required IconData icon,
    VoidCallback? onPressed,
    String? tooltip,
  });

  Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  });

  /// A tappable row: leading icon, title, optional subtitle, optional trailing.
  Widget listTile({
    IconData? leadingIcon,
    required Widget title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  });

  Widget toggle({required bool value, ValueChanged<bool>? onChanged});

  /// A selectable chip (used for segmented option pickers).
  Widget choiceChip({
    required Widget label,
    required bool selected,
    VoidCallback? onTap,
  });

  Widget textField({
    TextEditingController? controller,
    String? hint,
    ValueChanged<String>? onChanged,
    int? maxLines,
  });

  /// Linear progress in the range 0..1, or null for indeterminate.
  Widget progressBar({double? value});

  Widget divider();
}

/// Provides the active [UiKit] to the subtree.
class UiKitScope extends InheritedWidget {
  const UiKitScope({super.key, required this.kit, required super.child});

  final UiKit kit;

  static UiKit of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<UiKitScope>();
    assert(scope != null, 'No UiKitScope found in context');
    return scope!.kit;
  }

  @override
  bool updateShouldNotify(UiKitScope oldWidget) => oldWidget.kit.id != kit.id;
}

extension UiKitContext on BuildContext {
  /// Shorthand for the active [UiKit].
  UiKit get ui => UiKitScope.of(this);
}
