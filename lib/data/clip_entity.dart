import 'package:isar_community/isar.dart';

import '../models/clip.dart';

part 'clip_entity.g.dart';

/// Isar persistence model for a recorded second (Design.MD §4).
///
/// Kept separate from the immutable domain [Clip] used by the UI layer so the
/// database schema can evolve independently of the widgets. Conversions go
/// through [fromModel] / [toModel].
@Collection()
class ClipEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uid; // UUID v4

  late DateTime recordedAt;

  @Index()
  late String dateKey; // "yyyy-MM-dd" — calendar lookup

  String? videoPath;
  String? thumbnailPath;

  late int durationMs; // 1000–10000

  String? note;
  String? mood;

  bool isDeleted = false; // soft delete

  ClipEntity();

  factory ClipEntity.fromModel(Clip c) => ClipEntity()
    ..uid = c.uid
    ..recordedAt = c.recordedAt
    ..dateKey = c.dateKey
    ..videoPath = c.videoPath
    ..thumbnailPath = c.thumbnailPath
    ..durationMs = c.durationMs
    ..note = c.note
    ..mood = c.mood;

  Clip toModel() => Clip(
    uid: uid,
    recordedAt: recordedAt,
    durationMs: durationMs,
    videoPath: videoPath,
    thumbnailPath: thumbnailPath,
    note: note,
    mood: mood,
  );
}
