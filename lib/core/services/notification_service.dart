import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../platform.dart';

/// Daily reminder notifications (Design.MD §11). No-ops off mobile so the
/// settings screen stays functional while testing UI kits on desktop.
class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static const _dailyId = 100;
  static const _channelId = 'dayly_reminder';

  static bool _ready = false;

  static AndroidFlutterLocalNotificationsPlugin? get _android =>
      _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  static Future<void> init() async {
    if (!isMobilePlatform) return;
    tzdata.initializeTimeZones();
    try {
      tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()),
      );
    } catch (_) {
      /* fall back to UTC if the platform name can't be resolved */
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      settings: const InitializationSettings(android: android),
    );

    const channel = AndroidNotificationChannel(
      _channelId,
      'Daily reminder',
      description: 'Reminds you to record your one second.',
      importance: Importance.high,
    );
    await _android?.createNotificationChannel(channel);

    _ready = true;
  }

  /// Requests notification + exact-alarm permissions on Android.
  /// Call from settings when the user enables reminders — not at cold start.
  static Future<void> ensurePermissions() async {
    if (!isMobilePlatform) return;
    await _android?.requestNotificationsPermission();
    await _android?.requestExactAlarmsPermission();
  }

  /// Schedules (or reschedules) the repeating daily reminder.
  static Future<void> scheduleDaily({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    if (!isMobilePlatform || !_ready) return;

    await cancelDaily();

    try {
      await _plugin.zonedSchedule(
        id: _dailyId,
        title: title,
        body: body,
        scheduledDate: _nextInstanceOf(hour, minute),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            'Daily reminder',
            channelDescription: 'Reminds you to record your one second.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time, // repeats daily
      );
    } catch (e, st) {
      debugPrint('NotificationService.scheduleDaily failed: $e\n$st');
    }
  }

  static Future<void> cancelDaily() async {
    if (!isMobilePlatform || !_ready) return;
    await _plugin.cancel(id: _dailyId);
  }

  static tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
