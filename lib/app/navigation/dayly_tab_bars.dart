import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../state/settings_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/motion/app_motion.dart';

/// Shared tab icons (calendar, stats, record, film, settings).
class AppTabNavIcons {
  const AppTabNavIcons._();

  static const icons = [
    AppIcons.calendar,
    AppIcons.stats,
    AppIcons.record,
    AppIcons.film,
    AppIcons.settings,
  ];
}

/// Visual config for the Crystal navigation bar variants.
class CrystalNavBarConfig {
  const CrystalNavBarConfig({
    required this.backgroundColor,
    required this.outlineBorderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.margin,
    required this.marginR,
    required this.paddingR,
    required this.boxShadow,
    required this.enableFloatingNavBar,
  });

  final Color backgroundColor;
  final Color outlineBorderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets margin;
  final EdgeInsetsGeometry marginR;
  final EdgeInsetsGeometry paddingR;
  final List<BoxShadow> boxShadow;
  final bool enableFloatingNavBar;

  factory CrystalNavBarConfig.fromStyle(
    NavigationBarStyle style,
    DesignTokens tokens,
  ) {
    final p = tokens.palette;
    final shadow = BoxShadow(
      color: p.accentDim.withValues(alpha: p.isDark ? 0.28 : 0.20),
      blurRadius: 28,
      spreadRadius: -8,
      offset: const Offset(0, 12),
    );

    return switch (style) {
      NavigationBarStyle.blur => CrystalNavBarConfig(
        backgroundColor: p.surface.withValues(alpha: 0.58),
        outlineBorderColor: p.border.withValues(alpha: 0.72),
        borderWidth: 1,
        borderRadius: 30,
        margin: const EdgeInsets.all(8),
        marginR: const EdgeInsets.symmetric(horizontal: 46, vertical: 20),
        paddingR: const EdgeInsets.only(top: 10, bottom: 5),
        boxShadow: const [],
        enableFloatingNavBar: true,
      ),
      NavigationBarStyle.frosted => CrystalNavBarConfig(
        backgroundColor: p.surfaceElevated.withValues(alpha: 0.72),
        outlineBorderColor: p.textPrimary.withValues(alpha: 0.12),
        borderWidth: 1.2,
        borderRadius: 28,
        margin: const EdgeInsets.all(8),
        marginR: const EdgeInsets.symmetric(horizontal: 34, vertical: 18),
        paddingR: const EdgeInsets.only(top: 11, bottom: 6),
        boxShadow: [shadow],
        enableFloatingNavBar: true,
      ),
      NavigationBarStyle.floating => CrystalNavBarConfig(
        backgroundColor: p.surface.withValues(alpha: 0.86),
        outlineBorderColor: p.border.withValues(alpha: 0.48),
        borderWidth: 0.5,
        borderRadius: 40,
        margin: const EdgeInsets.all(8),
        marginR: const EdgeInsets.symmetric(horizontal: 42, vertical: 18),
        paddingR: const EdgeInsets.only(top: 10, bottom: 6),
        boxShadow: [shadow],
        enableFloatingNavBar: true,
      ),
      NavigationBarStyle.rounded => CrystalNavBarConfig(
        backgroundColor: p.surfaceElevated.withValues(alpha: 0.94),
        outlineBorderColor: p.border,
        borderWidth: 1,
        borderRadius: 22,
        margin: const EdgeInsets.all(8),
        marginR: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        paddingR: const EdgeInsets.symmetric(vertical: 10),
        boxShadow: [shadow],
        enableFloatingNavBar: true,
      ),
      NavigationBarStyle.modern => CrystalNavBarConfig(
        backgroundColor: p.surfaceElevated.withValues(alpha: 0.96),
        outlineBorderColor: p.border,
        borderWidth: 0,
        borderRadius: 0,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        marginR: EdgeInsets.zero,
        paddingR: const EdgeInsets.symmetric(vertical: 8),
        boxShadow: const [],
        enableFloatingNavBar: false,
      ),
    };
  }
}

Widget buildCrystalTabBar({
  required int currentIndex,
  required ValueChanged<int> onTap,
  required DesignTokens tokens,
  required NavigationBarStyle style,
}) {
  final p = tokens.palette;
  final config = CrystalNavBarConfig.fromStyle(style, tokens);

  return CrystalNavigationBar(
    currentIndex: currentIndex,
    onTap: onTap,
    duration: AppMotion.nav,
    curve: AppMotion.navCurve,
    itemPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    items: [
      for (final icon in AppTabNavIcons.icons)
        CrystalNavigationBarItem(icon: icon, unselectedIcon: icon),
    ],
    selectedItemColor: p.accent,
    unselectedItemColor: p.textSecondary,
    indicatorColor: p.accent,
    backgroundColor: config.backgroundColor,
    borderRadius: config.borderRadius,
    margin: config.margin,
    marginR: config.marginR,
    paddingR: config.paddingR,
    outlineBorderColor: config.outlineBorderColor,
    borderWidth: config.borderWidth,
    boxShadow: config.boxShadow,
    enableFloatingNavBar: config.enableFloatingNavBar,
    splashColor: p.accent.withValues(alpha: 0.16),
    splashBorderRadius: config.borderRadius,
  );
}

Widget buildCurvedTabBar({
  required int currentIndex,
  required ValueChanged<int> onTap,
  required DesignTokens tokens,
}) {
  final p = tokens.palette;

  return CurvedNavigationBar(
    index: currentIndex,
    onTap: onTap,
    height: 68,
    animationDuration: AppMotion.curvedNav,
    animationCurve: AppMotion.curvedNavCurve,
    backgroundColor: material.Colors.transparent,
    color: p.surface.withValues(alpha: p.isDark ? 0.62 : 0.72),
    buttonBackgroundColor: p.accent,
    items: [
      for (var i = 0; i < AppTabNavIcons.icons.length; i++)
        material.Icon(
          AppTabNavIcons.icons[i],
          size: 26,
          color: i == currentIndex ? p.onAccent : p.textSecondary,
        ),
    ],
  );
}

Widget buildDaylyTabBar({
  required NavigationBarType type,
  required int currentIndex,
  required ValueChanged<int> onTap,
  required DesignTokens tokens,
  required NavigationBarStyle crystalStyle,
}) {
  return switch (type) {
    NavigationBarType.crystal => buildCrystalTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      tokens: tokens,
      style: crystalStyle,
    ),
    NavigationBarType.curved => buildCurvedTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      tokens: tokens,
    ),
  };
}
