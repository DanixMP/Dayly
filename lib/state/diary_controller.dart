import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/platform.dart';
import '../core/services/storage_service.dart';
import '../data/clip_repository.dart';
import '../data/day_note_store.dart';
import '../models/clip.dart';
import '../state/settings_controller.dart';

/// Opens the Isar-backed clip store. Seeds sample metadata on desktop (no
/// camera) so the diary/calendar/compile UI is populated while testing UI
/// kits; starts empty on mobile for real recordings.
final clipRepositoryProvider = FutureProvider<ClipRepository>((ref) async {
  final repo = IsarClipRepository(seedSamples: !isMobilePlatform);
  await repo.init();
  ref.onDispose(repo.close);
  return repo;
});

/// Diary store exposed to the UI as a plain `List<Clip>`. Backed by the async
/// repository: the list starts empty, fills once Isar opens, and reloads after
/// every mutation. Screens are unaffected by the storage swap (Design.MD §12).
class DiaryNotifier extends Notifier<List<Clip>> {
  bool _disposed = false;

  @override
  List<Clip> build() {
    _disposed = false;
    ref.onDispose(() => _disposed = true);
    ref.watch(clipRepositoryProvider).whenData(_reload);
    return const <Clip>[];
  }

  Future<void> _reload(ClipRepository repo) async {
    final clips = await repo.getAll();
    if (!_disposed) state = clips;
  }

  Future<void> add(Clip clip) async {
    final repo = await ref.read(clipRepositoryProvider.future);
    await repo.add(clip);
    await _reload(repo);
  }

  Future<void> remove(String uid) async {
    final repo = await ref.read(clipRepositoryProvider.future);
    await repo.deleteByUid(uid);
    await _reload(repo);
  }

  Future<void> clearAll() async {
    final repo = await ref.read(clipRepositoryProvider.future);
    final clips = await repo.getAll();
    await StorageService.deleteFiles(
      clips.expand((c) => [c.videoPath, c.thumbnailPath]),
    );
    await repo.deleteAll();
    await StorageService.clearCapturedMedia();
    await ref.read(dayNotesProvider.notifier).clearAll();
    if (!_disposed) state = const <Clip>[];
  }
}

class DayNotesNotifier extends Notifier<Map<String, String>> {
  late final SharedPreferences _prefs;

  @override
  Map<String, String> build() {
    _prefs = ref.read(sharedPreferencesProvider);
    return DayNoteStore.fromPrefs(_prefs);
  }

  void setNote(String dateKey, String text) {
    final trimmed = text.trim();
    final next = Map<String, String>.from(state);
    if (trimmed.isEmpty) {
      next.remove(dateKey);
    } else {
      next[dateKey] = trimmed;
    }
    state = next;
    DayNoteStore.persist(_prefs, next);
  }

  Future<void> clearAll() async {
    state = const {};
    await DayNoteStore.persist(_prefs, const {});
  }
}

final dayNotesProvider = NotifierProvider<DayNotesNotifier, Map<String, String>>(
  DayNotesNotifier.new,
);

final diaryProvider = NotifierProvider<DiaryNotifier, List<Clip>>(
  DiaryNotifier.new,
);

String _keyFor(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

/// True if a clip exists for today.
final hasClipTodayProvider = Provider<bool>((ref) {
  final clips = ref.watch(diaryProvider);
  final key = _keyFor(DateTime.now());
  return clips.any((c) => c.dateKey == key);
});

/// Consecutive-day streak ending today (or yesterday).
final streakProvider = Provider<int>((ref) {
  final keys = ref.watch(diaryProvider).map((c) => c.dateKey).toSet();
  var cursor = DateTime.now();
  // Allow the streak to start from yesterday if today isn't recorded yet.
  if (!keys.contains(_keyFor(cursor))) {
    cursor = cursor.subtract(const Duration(days: 1));
  }
  var streak = 0;
  while (keys.contains(_keyFor(cursor))) {
    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return streak;
});
