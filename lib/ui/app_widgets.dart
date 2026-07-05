import 'package:flutter/widgets.dart';

import '../theme/app_background.dart';
import 'ui_kit.dart';

/// Semantic, library-agnostic widgets.
///
/// Feature screens import ONLY this file (plus `package:flutter/widgets.dart`
/// for layout primitives) and `theme/design_tokens.dart`. They never reference
/// shadcn_flutter, Material, or any concrete library — each widget here simply
/// asks `context.ui` (the active [UiKit]) to render the primitive.

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.title,
    this.leading,
    this.actions = const [],
    required this.body,
    this.bottomBar,
    this.centerTitle = false,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget> actions;
  final Widget body;
  final Widget? bottomBar;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) => context.ui.scaffold(
    title: title,
    leading: leading,
    actions: actions,
    body: AppBackgroundBody(child: body),
    bottomBar: bottomBar,
    centerTitle: centerTitle,
  );
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.leading,
    this.trailing,
    this.expand = false,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;
  final bool expand;

  @override
  Widget build(BuildContext context) => context.ui.button(
    variant: variant,
    onPressed: onPressed,
    leading: leading,
    trailing: trailing,
    expand: expand,
    child: child,
  );
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) =>
      context.ui.iconButton(icon: icon, onPressed: onPressed, tooltip: tooltip);
}

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.padding, this.onTap});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) =>
      context.ui.card(padding: padding, onTap: onTap, child: child);
}

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData? leadingIcon;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => context.ui.listTile(
    leadingIcon: leadingIcon,
    title: title,
    subtitle: subtitle,
    trailing: trailing,
    onTap: onTap,
  );
}

class AppToggle extends StatelessWidget {
  const AppToggle({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) =>
      context.ui.toggle(value: value, onChanged: onChanged);
}

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final Widget label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) =>
      context.ui.choiceChip(label: label, selected: selected, onTap: onTap);
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final int? maxLines;

  @override
  Widget build(BuildContext context) => context.ui.textField(
    controller: controller,
    hint: hint,
    onChanged: onChanged,
    maxLines: maxLines,
  );
}

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key, this.value});

  final double? value;

  @override
  Widget build(BuildContext context) => context.ui.progressBar(value: value);
}

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) => context.ui.divider();
}
