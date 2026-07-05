import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// File-path helpers for clips, thumbnails and compiled films (Design.MD §5).
/// All paths live under the app's private documents directory.
class StorageService {
  static const _clipsDir = 'dayly_clips';
  static const _thumbsDir = 'dayly_thumbs';
  static const _compiledDir = 'dayly_compiled';

  static const _uuid = Uuid();

  static Future<String> newClipPath() async =>
      '${(await _subDir(_clipsDir)).path}/${_uuid.v4()}.mp4';

  static Future<String> newThumbPath() async =>
      '${(await _subDir(_thumbsDir)).path}/${_uuid.v4()}.jpg';

  static Future<String> newCompiledPath() async =>
      '${(await _subDir(_compiledDir)).path}/dayly_${DateTime.now().millisecondsSinceEpoch}.mp4';

  /// Temp file for the FFmpeg concat demuxer list.
  static Future<String> newConcatListPath() async =>
      '${(await getTemporaryDirectory()).path}/concat_${DateTime.now().millisecondsSinceEpoch}.txt';

  /// Temp framed clip produced before compile concat.
  static Future<String> newFramedClipPath() async =>
      '${(await getTemporaryDirectory()).path}/framed_${_uuid.v4()}.mp4';

  /// Transparent PNG date stamp for FFmpeg overlay during compile.
  static Future<String> newStampOverlayPath() async =>
      '${(await getTemporaryDirectory()).path}/stamp_${_uuid.v4()}.png';

  /// Best-effort cleanup of a clip + its thumbnail when a clip is discarded.
  static Future<void> deleteFiles(Iterable<String?> paths) async {
    for (final p in paths) {
      if (p == null) continue;
      final f = File(p);
      if (await f.exists()) {
        try {
          await f.delete();
        } catch (_) {
          /* file already gone / locked — ignore */
        }
      }
    }
  }

  /// Removes every clip, thumbnail, and compiled video file on disk.
  static Future<void> clearCapturedMedia() async {
    for (final name in [_clipsDir, _thumbsDir, _compiledDir]) {
      final dir = await _subDir(name);
      if (!await dir.exists()) continue;
      await for (final entity in dir.list()) {
        if (entity is File) {
          try {
            await entity.delete();
          } catch (_) {
            /* ignore locked / missing files */
          }
        }
      }
    }
  }

  static Future<Directory> _subDir(String name) async {
    final base = await getApplicationDocumentsDirectory();
    final sub = Directory('${base.path}/$name');
    if (!await sub.exists()) await sub.create(recursive: true);
    return sub;
  }
}
