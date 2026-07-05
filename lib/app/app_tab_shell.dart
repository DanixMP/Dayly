import 'package:flutter/material.dart' as material;

import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';



import '../l10n/app_localizations.dart';

import '../state/settings_controller.dart';

import '../theme/design_tokens.dart';

import 'navigation/dayly_tab_bars.dart';



class AppTabShell extends ConsumerWidget {

  const AppTabShell({super.key, required this.navigationShell});



  final StatefulNavigationShell navigationShell;



  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final t = AppLocalizations.of(context);

    final tokens = context.tokens;

    final settings = ref.watch(settingsProvider);

    final p = tokens.palette;



    return material.Scaffold(

      backgroundColor: p.background,

      extendBody: true,

      body: navigationShell,

      bottomNavigationBar: Semantics(

        container: true,

        label: t.tabNavigationLabel,

        child: buildDaylyTabBar(

          type: settings.navigationBarType,

          currentIndex: navigationShell.currentIndex,

          onTap: (index) => _onTap(index),

          tokens: tokens,

          crystalStyle: settings.navigationBarStyle,

        ),

      ),

    );

  }



  void _onTap(int index) {

    navigationShell.goBranch(

      index,

      initialLocation: index == navigationShell.currentIndex,

    );

  }

}


