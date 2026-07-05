import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/services/notification_service.dart';
import 'state/settings_controller.dart';
import 'theme/app_assets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      debugPrint('FlutterError: ${details.exceptionAsString()}');
    }
  };

  ErrorWidget.builder = (details) => const _StartupErrorView();

  runApp(const DaylyBootstrap());
}

/// Paints immediately while [SharedPreferences] loads — avoids sitting on the
/// native Android launch theme with no Flutter content.
class DaylyBootstrap extends StatefulWidget {
  const DaylyBootstrap({super.key});

  @override
  State<DaylyBootstrap> createState() => _DaylyBootstrapState();
}

class _DaylyBootstrapState extends State<DaylyBootstrap> {
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (!mounted) return;
      setState(() => _prefs = prefs);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _bootstrapNotifications(prefs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefs = _prefs;
    if (prefs == null) {
      return const _LaunchPlaceholder();
    }

    return ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const DaylyApp(),
    );
  }
}

/// Native launch color + logo until prefs and the router are ready.
class _LaunchPlaceholder extends StatelessWidget {
  const _LaunchPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: ColoredBox(
        color: Color(0xFF0E0E0E),
        child: Center(
          child: AppLogo(size: 72, circular: true),
        ),
      ),
    );
  }
}

class _StartupErrorView extends StatelessWidget {
  const _StartupErrorView();

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: ColoredBox(
        color: Color(0xFF0E0E0E),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Dayly could not start. Please reinstall the app.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFF5C842), fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _bootstrapNotifications(SharedPreferences prefs) async {
  try {
    await NotificationService.init();
    final settings = AppSettings.fromPrefs(prefs);
    if (settings.reminderEnabled) {
      await NotificationService.scheduleDaily(
        hour: settings.reminderHour,
        minute: settings.reminderMinute,
        title: 'Record your day 🎬',
        body: "One second. That's all it takes.",
      );
    }
  } catch (e, st) {
    debugPrint('Notification bootstrap failed: $e\n$st');
  }
}
