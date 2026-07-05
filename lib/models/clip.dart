/// A single recorded second of a day.
///
/// Plain immutable model for the cross-platform shell. When the on-device data
/// layer lands (phase 2), this maps directly onto the Isar `Clip` collection
/// from the design doc (uid, dateKey, videoPath, thumbnailPath, durationMs).
class Clip {
  const Clip({
    required this.uid,
    required this.recordedAt,
    required this.durationMs,
    this.videoPath,
    this.thumbnailPath,
    this.note,
    this.mood,
  });

  final String uid;
  final DateTime recordedAt;
  final int durationMs;
  final String? videoPath;
  final String? thumbnailPath;
  final String? note;
  final String? mood;

  /// `yyyy-MM-dd` calendar key used for grouping and lookup.
  String get dateKey =>
      '${recordedAt.year.toString().padLeft(4, '0')}-'
      '${recordedAt.month.toString().padLeft(2, '0')}-'
      '${recordedAt.day.toString().padLeft(2, '0')}';
}
