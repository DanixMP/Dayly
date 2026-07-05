import 'package:go_router/go_router.dart';

import '../features/onboarding/onboarding_screen.dart';
import '../features/onboarding/splash_screen.dart';
import '../features/stats/stats_videos_screen.dart';
import '../features/compile/compile_screen.dart';
import '../features/diary/diary_screen.dart';
import '../features/player/player_screen.dart';
import '../models/clip.dart';
import '../features/recording/clip_preview_screen.dart';
import '../features/recording/recording_screen.dart';
import '../features/settings/about_dev_screen.dart';
import '../features/settings/acknowledgements_screen.dart';
import '../features/settings/connect_with_dev_screen.dart';
import '../features/settings/privacy_screen.dart';
import '../features/settings/settings_detail_screens.dart';
import '../features/settings/settings_screen.dart';
import '../features/today/today_screen.dart';
import '../ui/motion/app_motion.dart';
import 'app_tab_shell.dart';

/// App routes. Kept library-agnostic — go_router drives whichever app root the
/// active [UiKit] builds (ShadcnApp.router / MaterialApp.router).
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/splash'),
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
      ),
    ),
    StatefulShellRoute(
      builder: (context, state, navigationShell) =>
          AppTabShell(navigationShell: navigationShell),
      navigatorContainerBuilder: AppMotion.tabBranchContainer,
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendar',
              name: 'calendar',
              builder: (context, state) => const DiaryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              name: 'stats',
              builder: (context, state) => const StatsVideosScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/today',
              name: 'today',
              builder: (context, state) => const TodayScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/compile',
              name: 'compile',
              builder: (context, state) =>
                  const CompileScreen(showBackButton: false),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) =>
                  const SettingsScreen(showBackButton: false),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/record',
      name: 'record',
      builder: (context, state) => const RecordingScreen(),
    ),
    GoRoute(
      path: '/preview',
      name: 'preview',
      builder: (context, state) => ClipPreviewScreen(
        args: (state.extra as Map<String, Object?>?) ?? const {},
      ),
    ),
    GoRoute(
      path: '/player',
      name: 'player',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is Clip) {
          return PlayerScreen(clip: extra);
        }
        return PlayerScreen(videoPath: extra as String?);
      },
    ),
    GoRoute(
      path: '/settings/about-dev',
      name: 'about-dev',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const AboutDevScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/appearance',
      name: 'settings-appearance',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const SettingsAppearanceScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/reminders',
      name: 'settings-reminders',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const SettingsRemindersScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/capture',
      name: 'settings-capture',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const SettingsCaptureScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/about',
      name: 'settings-about',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const SettingsAboutScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/connect',
      name: 'settings-connect',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const ConnectWithDevScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/privacy',
      name: 'settings-privacy',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const SettingsPrivacyScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/acknowledgements',
      name: 'settings-acknowledgements',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const SettingsAcknowledgementsScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/reset',
      name: 'settings-reset',
      pageBuilder: (context, state) => AppMotion.detailPage(
        key: state.pageKey,
        child: const SettingsResetScreen(),
      ),
    ),
  ],
);
