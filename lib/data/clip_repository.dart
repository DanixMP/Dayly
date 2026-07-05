import 'dart:math';

import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/clip.dart';
import 'clip_entity.dart';

/// Storage boundary for diary clips. The UI talks to this interface only; the
/// concrete store (Isar today) can be swapped without touching screens —
/// mirroring the UI-kit swap pattern, one layer down.
abstract class ClipRepository {
  Future<void> init();
  Future<List<Clip>> getAll();
  Future<void> add(Clip clip);
  Future<void> deleteByUid(String uid);
  Future<void> deleteAll();
  Future<void> close();
}

/// Isar-backed implementation. Works on Android + desktop (isar_community ships
/// native libs for both). On desktop, where the camera is unavailable, the
/// store is seeded once with metadata-only sample clips so the diary/calendar/
/// compile UI can be exercised while testing UI kits.
class IsarClipRepository implements ClipRepository {
  IsarClipRepository({this.seedSamples = false});

  final bool seedSamples;
  late final Isar _isar;

  @override
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ClipEntitySchema],
      directory: dir.path,
      name: 'dayly',
    );
    if (seedSamples && await _isar.clipEntitys.count() == 0) {
      await _seed();
    }
  }

  @override
  Future<List<Clip>> getAll() async {
    final rows = await _isar.clipEntitys
        .filter()
        .isDeletedEqualTo(false)
        .sortByRecordedAtDesc()
        .findAll();
    return rows.map((e) => e.toModel()).toList(growable: false);
  }

  @override
  Future<void> add(Clip clip) async {
    await _isar.writeTxn(() async {
      await _isar.clipEntitys.putByUid(ClipEntity.fromModel(clip));
    });
  }

  @override
  Future<void> deleteByUid(String uid) async {
    await _isar.writeTxn(() async {
      await _isar.clipEntitys.deleteByUid(uid);
    });
  }

  @override
  Future<void> deleteAll() async {
    await _isar.writeTxn(() async {
      await _isar.clipEntitys.clear();
    });
  }

  @override
  Future<void> close() => _isar.close();

  Future<void> _seed() async {
    final rng = Random(7);
    final now = DateTime.now();
    const moods = ['🌅', '☕', '🌧️', '🎬', '🌙', '🍂', '✨', null];
    final entities = <ClipEntity>[];
    for (var i = 0; i < 18; i++) {
      if (i == 3 || i == 9) continue; // gap days exercise streak/calendar logic
      final day = now.subtract(Duration(days: i));
      entities.add(
        ClipEntity.fromModel(
          Clip(
            uid: 'seed-$i',
            recordedAt: DateTime(day.year, day.month, day.day, 20, 0),
            durationMs: 1000 * (1 + rng.nextInt(8)),
            mood: moods[rng.nextInt(moods.length)],
          ),
        ),
      );
    }
    await _isar.writeTxn(() async {
      await _isar.clipEntitys.putAllByUid(entities);
    });
  }
}
