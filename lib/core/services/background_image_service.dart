import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

/// Persists custom background images under app documents.
class BackgroundImageService {
  const BackgroundImageService._();

  static const _folderName = 'backgrounds';

  static Future<Directory> _backgroundsDir() async {
    final root = await getApplicationDocumentsDirectory();
    final dir = Directory('${root.path}/$_folderName');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  static String _prefixFor(Brightness brightness) =>
      brightness == Brightness.dark ? 'dark' : 'light';

  static Future<void> delete(Brightness brightness) async {
    final dir = await _backgroundsDir();
    await _deleteMatching(dir, _prefixFor(brightness));
  }

  static Future<void> deleteAll() async {
    final dir = await _backgroundsDir();
    if (!await dir.exists()) return;
    await for (final entity in dir.list()) {
      if (entity is File) {
        await entity.delete();
      }
    }
  }

  /// Saves a new image under a unique filename so Flutter's image cache
  /// cannot reuse the previous file at the same path.
  static Future<String> save(Brightness brightness, String sourcePath) async {
    final dir = await _backgroundsDir();
    final prefix = _prefixFor(brightness);
    await _deleteMatching(dir, prefix);

    final dest = File(
      '${dir.path}/${prefix}_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await File(sourcePath).copy(dest.path);
    return dest.path;
  }

  static Future<void> _deleteMatching(Directory dir, String prefix) async {
    if (!await dir.exists()) return;
    await for (final entity in dir.list()) {
      if (entity is! File) continue;
      final name = entity.uri.pathSegments.last;
      if (name.startsWith(prefix)) {
        await entity.delete();
      }
    }
  }
}
