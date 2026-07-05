/// Open-source packages that power Dayly, grouped for the credits screen.
enum AcknowledgementCategory {
  framework,
  ui,
  state,
  media,
  storage,
  notifications,
  utilities,
}

class AppAcknowledgement {
  const AppAcknowledgement({
    required this.name,
    required this.version,
    required this.category,
    required this.role,
  });

  final String name;
  final String version;
  final AcknowledgementCategory category;
  final String role;
}

/// Curated dependency list — mirrors [pubspec.yaml] at release time.
class AppAcknowledgements {
  const AppAcknowledgements._();

  static const packages = <AppAcknowledgement>[
    AppAcknowledgement(
      name: 'Flutter',
      version: 'SDK',
      category: AcknowledgementCategory.framework,
      role: 'UI framework & rendering engine',
    ),
    AppAcknowledgement(
      name: 'Dart',
      version: 'SDK',
      category: AcknowledgementCategory.framework,
      role: 'Language runtime',
    ),
    AppAcknowledgement(
      name: 'shadcn_flutter',
      version: '^0.0.52',
      category: AcknowledgementCategory.ui,
      role: 'Primary UI component library',
    ),
    AppAcknowledgement(
      name: 'liquid_glass_renderer',
      version: '^0.2.0-dev.4',
      category: AcknowledgementCategory.ui,
      role: 'Liquid glass UI kit',
    ),
    AppAcknowledgement(
      name: 'flutter_neumorphic_plus',
      version: '^3.5.0',
      category: AcknowledgementCategory.ui,
      role: 'Neumorphic UI kit',
    ),
    AppAcknowledgement(
      name: 'nes_ui',
      version: '^0.30.0',
      category: AcknowledgementCategory.ui,
      role: 'Retro NES UI kit',
    ),
    AppAcknowledgement(
      name: 'chicago',
      version: '^0.4.3-dev',
      category: AcknowledgementCategory.ui,
      role: 'Chicago desktop UI kit',
    ),
    AppAcknowledgement(
      name: 'neubrutalism_ui',
      version: '^2.0.2',
      category: AcknowledgementCategory.ui,
      role: 'Neubrutalism UI kit',
    ),
    AppAcknowledgement(
      name: 'crystal_navigation_bar',
      version: '^1.1.0',
      category: AcknowledgementCategory.ui,
      role: 'Floating tab navigation',
    ),
    AppAcknowledgement(
      name: 'curved_navigation_bar',
      version: '^1.0.6',
      category: AcknowledgementCategory.ui,
      role: 'Curved bottom navigation with center button',
    ),
    AppAcknowledgement(
      name: 'google_fonts',
      version: '>=6.2.1 <7.0.0',
      category: AcknowledgementCategory.ui,
      role: 'Typography (Inter, Vazirmatn, DM Serif, …)',
    ),
    AppAcknowledgement(
      name: 'flutter_riverpod',
      version: '^3.3.2',
      category: AcknowledgementCategory.state,
      role: 'App state & settings',
    ),
    AppAcknowledgement(
      name: 'go_router',
      version: '^17.3.0',
      category: AcknowledgementCategory.state,
      role: 'Declarative routing',
    ),
    AppAcknowledgement(
      name: 'shared_preferences',
      version: '^2.5.5',
      category: AcknowledgementCategory.storage,
      role: 'Settings persistence',
    ),
    AppAcknowledgement(
      name: 'isar_community',
      version: '^3.3.2',
      category: AcknowledgementCategory.storage,
      role: 'On-device clip database',
    ),
    AppAcknowledgement(
      name: 'path_provider',
      version: '^2.1.6',
      category: AcknowledgementCategory.storage,
      role: 'App documents & file paths',
    ),
    AppAcknowledgement(
      name: 'camera',
      version: '^0.12.0',
      category: AcknowledgementCategory.media,
      role: 'Video capture',
    ),
    AppAcknowledgement(
      name: 'video_player',
      version: '^2.11.1',
      category: AcknowledgementCategory.media,
      role: 'Clip playback',
    ),
    AppAcknowledgement(
      name: 'chewie',
      version: '^1.14.1',
      category: AcknowledgementCategory.media,
      role: 'Player controls',
    ),
    AppAcknowledgement(
      name: 'ffmpeg_kit_flutter_new',
      version: '^4.2.1',
      category: AcknowledgementCategory.media,
      role: 'Merge clips & thumbnails on-device',
    ),
    AppAcknowledgement(
      name: 'saver_gallery',
      version: '^4.1.2',
      category: AcknowledgementCategory.storage,
      role: 'Optional gallery export',
    ),
    AppAcknowledgement(
      name: 'permission_handler',
      version: '^12.0.3',
      category: AcknowledgementCategory.utilities,
      role: 'Camera, storage & notification permissions',
    ),
    AppAcknowledgement(
      name: 'image_picker',
      version: '^1.1.2',
      category: AcknowledgementCategory.utilities,
      role: 'Custom background photos',
    ),
    AppAcknowledgement(
      name: 'flutter_local_notifications',
      version: '^22.0.1',
      category: AcknowledgementCategory.notifications,
      role: 'Daily recording reminders',
    ),
    AppAcknowledgement(
      name: 'timezone',
      version: '^0.11.0',
      category: AcknowledgementCategory.notifications,
      role: 'Reminder scheduling',
    ),
    AppAcknowledgement(
      name: 'flutter_timezone',
      version: '^4.1.1',
      category: AcknowledgementCategory.notifications,
      role: 'Local timezone detection',
    ),
    AppAcknowledgement(
      name: 'package_info_plus',
      version: '^10.2.0',
      category: AcknowledgementCategory.utilities,
      role: 'App version display',
    ),
    AppAcknowledgement(
      name: 'intl',
      version: 'SDK',
      category: AcknowledgementCategory.utilities,
      role: 'Dates, times & formatting',
    ),
    AppAcknowledgement(
      name: 'uuid',
      version: '^4.4.0',
      category: AcknowledgementCategory.utilities,
      role: 'Unique clip identifiers',
    ),
  ];

  static Map<AcknowledgementCategory, List<AppAcknowledgement>> grouped() {
    final map = <AcknowledgementCategory, List<AppAcknowledgement>>{};
    for (final item in packages) {
      map.putIfAbsent(item.category, () => []).add(item);
    }
    return map;
  }
}
