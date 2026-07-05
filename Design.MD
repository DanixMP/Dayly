# DAYLY — Design Document
> One Second Diary · Flutter Mobile App · Android (minSdk 24)

---

## 1. Vision

Dayly is a personal video diary where users record 1–10 seconds of their day. Over time, these clips compile into a living memory film. The experience must feel **intimate, minimal, and emotionally weighty** — not like a social media app. Every design decision should reinforce: *your life, one second at a time.*

---

## 2. Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| Framework | Flutter (Dart) | Cross-platform UI |
| Video Recording | `camera` | Capture 1–10s clips |
| Video Merging | `ffmpeg_kit_flutter_new` (min flavor) | Concat clips into diary film |
| Local Database | `isar` | Clip metadata + user settings |
| File Storage | `path_provider` | Private app directory |
| Thumbnails | `video_thumbnail` | Grid/calendar previews |
| Playback | `chewie` + `video_player` | Diary film playback |
| Notifications | `flutter_local_notifications` | Daily reminder at user-set time |
| Gallery Export | `saver_gallery` | Save compiled video to device |
| State Management | `riverpod` | App-wide state |
| Routing | `go_router` | Navigation |

### pubspec.yaml (core deps)

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Video
  camera: ^0.11.0
  ffmpeg_kit_flutter_new: ^0.1.0   # use min flavor to reduce APK size
  video_player: ^2.9.1
  chewie: ^1.8.0
  video_thumbnail: ^0.5.3

  # Storage
  isar: ^3.1.0
  isar_flutter_libs: ^3.1.0
  path_provider: ^2.1.2

  # Export
  saver_gallery: ^3.0.6

  # State & Navigation
  flutter_riverpod: ^2.5.1
  go_router: ^13.2.1

  # Notifications
  flutter_local_notifications: ^17.2.2

  # Utilities
  intl: ^0.19.0
  uuid: ^4.4.0
  permission_handler: ^11.3.1

dev_dependencies:
  isar_generator: ^3.1.0
  build_runner: ^2.4.9
```

---

## 3. Project Structure

```
lib/
├── main.dart
├── app.dart                        # MaterialApp + GoRouter setup
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_constants.dart      # max clip duration, etc.
│   ├── database/
│   │   └── isar_service.dart       # Isar open/close singleton
│   ├── services/
│   │   ├── ffmpeg_service.dart     # merge logic
│   │   ├── notification_service.dart
│   │   └── storage_service.dart    # file path helpers
│   └── utils/
│       └── date_utils.dart
│
├── features/
│   ├── recording/
│   │   ├── recording_screen.dart   # camera + record button
│   │   ├── recording_provider.dart
│   │   └── clip_preview_screen.dart # confirm/retake after recording
│   │
│   ├── diary/
│   │   ├── diary_screen.dart       # calendar + clip grid
│   │   ├── diary_provider.dart
│   │   └── clip_tile.dart          # thumbnail component
│   │
│   ├── compile/
│   │   ├── compile_screen.dart     # progress + playback
│   │   └── compile_provider.dart
│   │
│   ├── player/
│   │   └── player_screen.dart      # full diary film viewer
│   │
│   └── settings/
│       ├── settings_screen.dart
│       └── settings_provider.dart
│
└── models/
    ├── clip.dart                   # Isar collection
    └── diary_settings.dart         # Isar collection
```

---

## 4. Data Models (Isar)

### Clip

```dart
// lib/models/clip.dart
import 'package:isar/isar.dart';

part 'clip.g.dart';

@collection
class Clip {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uid;               // UUID v4

  late DateTime recordedAt;      // full timestamp

  @Index()
  late String dateKey;           // "2025-06-26" — used for calendar lookup

  late String videoPath;         // absolute path in app private dir
  late String thumbnailPath;     // generated after recording

  late int durationMs;           // 1000–10000

  String? note;                  // optional text annotation
  String? mood;                  // optional emoji tag

  late bool isDeleted;           // soft delete
}
```

### DiarySettings

```dart
// lib/models/diary_settings.dart
import 'package:isar/isar.dart';

part 'diary_settings.g.dart';

@collection
class DiarySettings {
  Id id = 1;                     // singleton

  int reminderHour = 20;         // default 8 PM
  int reminderMinute = 0;
  bool reminderEnabled = true;

  int defaultDurationSec = 1;    // 1–10
  bool saveToGallery = false;
}
```

---

## 5. Core Services

### FFmpegService — clip merging

```dart
// lib/core/services/ffmpeg_service.dart
import 'dart:io';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:path_provider/path_provider.dart';

class FFmpegService {

  /// Merges all [clipPaths] into a single video saved to [outputPath].
  /// Returns output path on success, throws on failure.
  static Future<String> mergeClips({
    required List<String> clipPaths,
    String? outputPath,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final output = outputPath ??
        '${dir.path}/dayly_compiled_${DateTime.now().millisecondsSinceEpoch}.mp4';

    // Build FFmpeg concat list file
    final listFile = File('${dir.path}/concat_list.txt');
    final buffer = StringBuffer();
    for (final path in clipPaths) {
      buffer.writeln("file '$path'");
    }
    await listFile.writeAsString(buffer.toString());

    // Run FFmpeg concat (stream copy = no re-encode, very fast)
    final command =
        '-f concat -safe 0 -i "${listFile.path}" -c copy "$output"';

    final session = await FFmpegKit.execute(command);
    final rc = await session.getReturnCode();

    if (!ReturnCode.isSuccess(rc)) {
      final logs = await session.getOutput();
      throw Exception('FFmpeg merge failed: $logs');
    }

    return output;
  }

  /// Merges clips for a specific date range filter.
  /// [from] and [to] are inclusive date boundaries.
  static Future<String> mergeClipsByDateRange({
    required List<String> clipPaths, // pre-filtered by caller
    required DateTime from,
    required DateTime to,
  }) async {
    return mergeClips(clipPaths: clipPaths);
  }
}
```

### StorageService

```dart
// lib/core/services/storage_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static const _clipsDir = 'dayly_clips';
  static const _thumbsDir = 'dayly_thumbs';

  static Future<String> newClipPath() async {
    final dir = await _subDir(_clipsDir);
    return '${dir.path}/${const Uuid().v4()}.mp4';
  }

  static Future<String> newThumbPath() async {
    final dir = await _subDir(_thumbsDir);
    return '${dir.path}/${const Uuid().v4()}.jpg';
  }

  static Future<Directory> _subDir(String name) async {
    final base = await getApplicationDocumentsDirectory();
    final sub = Directory('${base.path}/$name');
    if (!await sub.exists()) await sub.create(recursive: true);
    return sub;
  }
}
```

---

## 6. Screen Flows

### 6.1 Recording Flow

```
App Launch
    │
    ├─ [No clip today] ──▶ RecordingScreen
    │                           │
    │                    (hold button 1–10s)
    │                           │
    │                     ClipPreviewScreen
    │                           │
    │              ┌────────────┴──────────────┐
    │           [Retake]                    [Save]
    │              │                           │
    │        RecordingScreen            DiaryScreen
    │
    └─ [Clip exists today] ──▶ DiaryScreen
                                    │
                              (tap today's tile)
                                    │
                             ClipPreviewScreen
                            (view / replace / delete)
```

### 6.2 Compile Flow

```
DiaryScreen  ──▶  CompileScreen
                      │
              (select date range)
                      │
              (tap "Compile")
                      │
              FFmpegService.mergeClips()
                      │
              Progress indicator (% via FFmpeg stats)
                      │
              PlayerScreen  ──▶  (share / save to gallery)
```

### 6.3 Notification Flow

```
App Settings: Set reminder time
        │
NotificationService.schedule()
        │
Daily notification at set time
        │
User taps ──▶ deep link ──▶ RecordingScreen
```

---

## 7. UI Design

### 7.1 Visual Identity

Dayly is a **personal, intimate** app. The UI takes cues from analog film — muted warm tones, grain, quiet motion. No social-media energy.

**Color Palette**

```dart
// lib/core/constants/app_colors.dart
class AppColors {
  // Backgrounds
  static const background     = Color(0xFF0E0E0E);  // near-black warm
  static const surface        = Color(0xFF1A1916);  // warm dark card
  static const surfaceElevated = Color(0xFF242220); // slightly lighter card

  // Accent — aged amber (like super-8 film)
  static const accent         = Color(0xFFF5C842);  // warm amber
  static const accentDim      = Color(0xFF7A6520);  // muted amber

  // Text
  static const textPrimary    = Color(0xFFEDEAE0);  // warm off-white
  static const textSecondary  = Color(0xFF8A8070);  // muted warm gray
  static const textDisabled   = Color(0xFF3A3830);

  // Semantic
  static const danger         = Color(0xFFD95F5F);
  static const success        = Color(0xFF7EC88A);
}
```

**Typography**

```dart
// lib/core/constants/app_text_styles.dart
// Font: "DM Serif Display" (dates, headings) + "Inter" (body)
// Add to pubspec: google_fonts: ^6.2.1

class AppTextStyles {
  static final dateDisplay = GoogleFonts.dmSerifDisplay(
    fontSize: 42,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
  );

  static final sectionTitle = GoogleFonts.dmSerifDisplay(
    fontSize: 22,
    color: AppColors.textPrimary,
  );

  static final body = GoogleFonts.inter(
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static final caption = GoogleFonts.inter(
    fontSize: 11,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );

  static final label = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
    letterSpacing: 0.8,
  );
}
```

### 7.2 Screen Designs

#### RecordingScreen

```
┌─────────────────────────────────┐
│                                 │
│       [Camera viewfinder]       │  ← full screen
│          (film grain overlay)   │
│                                 │
│  ┌──────────────────────────┐   │
│  │  FRI 26 · JUN 2025       │   │  ← DM Serif, bottom-left
│  └──────────────────────────┘   │
│                                 │
│         ●                       │  ← record button center-bottom
│     hold to record              │  ← subtle caption
│   (1s min · 10s max)            │
│                                 │
│  [flip cam]           [gallery] │  ← icon buttons corners
└─────────────────────────────────┘

Record button behavior:
- Idle: amber ring, white center dot
- Recording: pulsing red fill + arc timer around it
- Duration label counts up: "3s"
- Auto-stops at 10s
```

#### DiaryScreen

```
┌─────────────────────────────────┐
│  DAYLY              [⚙]  [▶]   │  ← compile button top right
│  ─────────────────────────────  │
│                                 │
│  June 2025                      │  ← DM Serif month header
│                                 │
│  ┌───┬───┬───┬───┬───┬───┬───┐ │
│  │ M │ T │ W │ T │ F │ S │ S │ │  ← week headers
│  ├───┼───┼───┼───┼───┼───┼───┤ │
│  │   │   │   │   │[▓]│   │   │ │  ← [▓] = has clip (thumbnail)
│  ├───┼───┼───┼───┼───┼───┼───┤ │
│  │[▓]│[▓]│   │[▓]│[▓]│   │   │ │
│  └───┴───┴───┴───┴───┴───┴───┘ │
│                                 │
│  ── Recent ────────────────     │
│  ┌──────┐ ┌──────┐ ┌──────┐    │
│  │ [▓] │ │ [▓] │ │  +  │    │  ← thumbnail grid
│  │ Jun26│ │ Jun25│ │today│    │
│  └──────┘ └──────┘ └──────┘    │
│                                 │
│  ── Streak: 12 days 🔥 ──────   │
└─────────────────────────────────┘
```

#### CompileScreen

```
┌─────────────────────────────────┐
│  ←  Compile Your Diary          │
│  ─────────────────────────────  │
│                                 │
│  Date Range                     │
│  ┌─────────────┬──────────────┐ │
│  │  Jun 1 2025 │  Jun 26 2025 │ │
│  └─────────────┴──────────────┘ │
│                                 │
│  26 clips · ~26 seconds         │  ← dynamic count
│                                 │
│  ┌─────────────────────────────┐│
│  │  ████████████░░░░  64%      ││  ← progress bar (accent amber)
│  │  Merging clip 17 of 26...   ││
│  └─────────────────────────────┘│
│                                 │
│  [       Compile Video       ]  │  ← amber CTA button
│                                 │
└─────────────────────────────────┘
```

#### PlayerScreen

```
┌─────────────────────────────────┐
│                                 │
│       [Video player view]       │  ← full screen chewie player
│                                 │
│  ─────────────────────────────  │
│  Jun 1 → Jun 26 · 26 clips      │  ← subtitle
│                                 │
│  [◀◀]  [❚❚]  [▶▶]              │  ← playback controls
│  ───────●──────────────────     │  ← amber scrubber
│  0:04           0:26            │
│                                 │
│  [↗ Share]          [⬇ Save]   │
└─────────────────────────────────┘
```

---

## 8. Permissions

Declare in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
    android:maxSdkVersion="28" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
```

Request at runtime using `permission_handler`:

```dart
await [
  Permission.camera,
  Permission.microphone,
].request();
```

---

## 9. Key App Constants

```dart
// lib/core/constants/app_constants.dart
class AppConstants {
  static const int minClipDurationSec = 1;
  static const int maxClipDurationSec = 10;
  static const int defaultClipDurationSec = 1;

  static const int thumbnailQuality = 75;    // JPEG quality
  static const int thumbnailWidth = 300;     // px

  static const String dbName = 'dayly.isar';

  static const String clipsSubDir = 'dayly_clips';
  static const String thumbsSubDir = 'dayly_thumbs';
  static const String compiledSubDir = 'dayly_compiled';
}
```

---

## 10. FFmpeg Merge Strategy

Two merge strategies depending on clip codec consistency:

### Strategy A — Stream Copy (fast, no quality loss)
Use when all clips are recorded by the same device (same codec/resolution):
```
ffmpeg -f concat -safe 0 -i list.txt -c copy output.mp4
```

### Strategy B — Re-encode (safe, handles mixed sources)
Use if clips come from different quality settings or if stream copy fails:
```
ffmpeg -f concat -safe 0 -i list.txt \
  -vf scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2 \
  -c:v libx264 -preset fast -crf 23 \
  -c:a aac -b:a 128k \
  output.mp4
```

Default to **Strategy A**. Fall back to **Strategy B** on error.

---

## 11. Notification Strategy

Daily reminder using `flutter_local_notifications` with `AndroidFlutterLocalNotificationsPlugin`:

```dart
// Schedule repeating daily notification
await flutterLocalNotificationsPlugin.zonedSchedule(
  0,
  'Record your day 🎬',
  'One second. That\'s all it takes.',
  scheduledDate,             // TZDateTime for user's set time
  notificationDetails,
  androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
  matchDateTimeComponents: DateTimeComponents.time, // repeats daily
);
```

---

## 12. State Management (Riverpod)

```
isarServiceProvider         → singleton Isar instance
clipRepositoryProvider      → CRUD ops on Clip collection
settingsRepositoryProvider  → read/write DiarySettings
recordingProvider           → camera controller + recording state
diaryProvider               → clips list + calendar data
compileProvider             → FFmpeg progress + output path
```

---

## 13. Edge Cases to Handle

| Case | Handling |
|---|---|
| User records twice in one day | Allow — store both, show both in diary, user picks which goes in compile |
| App killed mid-recording | On next launch check for orphaned temp file, offer to save or discard |
| FFmpeg merge fails (Strategy A) | Auto-retry with Strategy B |
| Storage full | Check available space before recording, warn if < 100MB |
| Clip file missing (deleted externally) | Mark clip as `isDeleted = true` in Isar, show broken-film placeholder |
| 0 clips selected for compile | Disable Compile button, show "No clips in range" |

---

## 14. Roadmap

### v1.0 — Core
- [ ] Record 1–10s clip
- [ ] Save with timestamp
- [ ] Calendar diary view
- [ ] Compile all clips → single video
- [ ] Daily reminder notification

### v1.1 — Polish
- [ ] Text note per clip
- [ ] Mood tag per clip (emoji picker)
- [ ] Streak counter
- [ ] Film grain overlay on recording screen

### v1.2 — Export
- [ ] Export to gallery
- [ ] Share to Instagram/WhatsApp (trimmed to 60s)
- [ ] Date range compile filter

### v2.0 — Premium ideas
- [ ] Transition effects between clips (crossfade, flash)
- [ ] Background music layer during compile
- [ ] Cloud backup (Firebase Storage or S3)
- [ ] Widget for quick-record from home screen