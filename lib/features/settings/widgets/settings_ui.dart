import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../state/diary_controller.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_icons.dart';
import '../../../theme/design_tokens.dart';
import '../../../ui/app_widgets.dart';
import '../../../ui/motion/app_motion.dart';

/// Samsung One UI–style profile header shown at the top of Settings.
class SettingsProfileHeader extends ConsumerWidget {
  const SettingsProfileHeader({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final streak = ref.watch(streakProvider);
    final clips = ref.watch(diaryProvider);

    return StaggeredEntrance(
      index: 0,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                p.surface,
                Color.lerp(p.surface, p.accent, 0.08)!,
              ],
            ),
            borderRadius: const BorderRadius.all(AppRadii.lg),
            border: Border.all(color: p.border.withValues(alpha: 0.6)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: const AppLogo(size: 72),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.aboutDevName, style: tokens.type.monthHeader),
                    const SizedBox(height: 2),
                    Text(t.aboutDevRole, style: tokens.type.caption),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      t.settingsProfileStats(clips.length, streak),
                      style: tokens.type.body,
                    ),
                  ],
                ),
              ),
              Icon(
                AppIcons.chevronRight,
                size: 22,
                color: p.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Uppercase section label between Samsung-style setting groups.
class SettingsSectionLabel extends StatelessWidget {
  const SettingsSectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Text(
        label.toUpperCase(),
        style: tokens.type.caption.copyWith(
          letterSpacing: 1.1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Rounded group container for Samsung-style setting rows.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final p = context.tokens.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: const BorderRadius.all(AppRadii.lg),
        border: Border.all(color: p.border.withValues(alpha: 0.55)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(AppRadii.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

/// A single tappable settings row with icon badge, title, value, and chevron.
class SettingsTile extends StatefulWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.value,
    this.showDivider = true,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final String? value;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final p = tokens.palette;

    final row = AnimatedScale(
      scale: _pressed ? 0.985 : 1,
      duration: AppMotion.fast,
      curve: AppMotion.curve,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            _IconBadge(icon: widget.icon, color: widget.iconColor),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: tokens.type.bodyStrong),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(widget.subtitle!, style: tokens.type.caption),
                  ],
                ],
              ),
            ),
            if (widget.value != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Text(widget.value!, style: tokens.type.caption),
            ],
            const SizedBox(width: AppSpacing.xs),
            Icon(AppIcons.chevronRight, size: 20, color: p.textSecondary),
          ],
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          onTapDown: widget.onTap != null
              ? (_) => setState(() => _pressed = true)
              : null,
          onTapUp: widget.onTap != null
              ? (_) => setState(() => _pressed = false)
              : null,
          onTapCancel:
              widget.onTap != null ? () => setState(() => _pressed = false) : null,
          behavior: HitTestBehavior.opaque,
          child: row,
        ),
        if (widget.showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 68),
            child: Container(height: 1, color: p.border.withValues(alpha: 0.45)),
          ),
      ],
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }
}

/// Standard scaffold for settings drill-down pages.
class SettingsDetailScaffold extends StatelessWidget {
  const SettingsDetailScaffold({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return AppScaffold(
      leading: AppIconButton(
        icon: AppIcons.back,
        tooltip: AppLocalizations.of(context).commonBack,
        onPressed: () => context.pop(),
      ),
      title: Text(title, style: tokens.type.sectionTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          128,
        ),
        children: [
          for (var i = 0; i < children.length; i++)
            StaggeredEntrance(index: i, child: children[i]),
        ],
      ),
    );
  }
}
