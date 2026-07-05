import 'dart:async';
import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';

import '../../models/clip.dart';
import '../platform.dart';
import 'stamp_renderer.dart';
import 'storage_service.dart';

/// Clip merging + thumbnail extraction (Design.MD §5 / §10).
class FFmpegService {
  static bool get isSupported => isMobilePlatform;

  static const _outputWidth = 1080;
  static const _outputHeight = 1920;
  static const _videoHeight = 1840;

  static const _padChain =
      'scale=$_outputWidth:$_videoHeight:force_original_aspect_ratio=decrease,'
      'pad=$_outputWidth:$_videoHeight:(ow-iw)/2:(oh-ih)/2:color=black,'
      'pad=$_outputWidth:$_outputHeight:0:0:color=black';

  static Future<String?> generateThumbnail(String videoPath) async {
    if (!isSupported) return null;
    final out = await StorageService.newThumbPath();
    final cmd = '-y -ss 0 -i "$videoPath" -frames:v 1 -q:v 5 "$out"';
    final session = await FFmpegKit.execute(cmd);
    final rc = await session.getReturnCode();
    return ReturnCode.isSuccess(rc) ? out : null;
  }

  /// Burns a dark film border + PNG date stamp overlay into a clip.
  static Future<String> applyFilmFrame({
    required String videoPath,
    required DateTime recordedAt,
  }) async {
    if (!isSupported) return videoPath;

    final stampPath = await StorageService.newStampOverlayPath();
    final out = await StorageService.newFramedClipPath();

    try {
      await StampRenderer.renderToFile(recordedAt, stampPath);

      final withStamp =
          '[0:v]$_padChain[vid];'
          '[vid][1:v]overlay=x=(W-w)/2:y=H-h-28[vout]';

      if (await _transcodeWithOverlay(
        videoPath: videoPath,
        stampPath: stampPath,
        output: out,
        filterComplex: withStamp,
      )) {
        return out;
      }

      final padOnly = await StorageService.newFramedClipPath();
      if (await _transcodeVideoFilter(videoPath, padOnly, _padChain)) {
        return padOnly;
      }
    } catch (_) {
      // Fall through to original clip.
    } finally {
      await StorageService.deleteFiles([stampPath]);
    }

    return videoPath;
  }

  static Future<bool> _transcodeWithOverlay({
    required String videoPath,
    required String stampPath,
    required String output,
    required String filterComplex,
  }) async {
    final withAudio =
        '-y -i "$videoPath" -i "$stampPath" -filter_complex "$filterComplex" '
        '-map "[vout]" -map 0:a? '
        '-c:v libx264 -preset fast -crf 23 -pix_fmt yuv420p '
        '-c:a aac -b:a 128k -ar 44100 -ac 2 -movflags +faststart "$output"';
    if (await _execute(withAudio) && File(output).existsSync()) return true;

    final silentAudio =
        '-y -i "$videoPath" -i "$stampPath" -f lavfi -i anullsrc=r=44100:cl=stereo '
        '-filter_complex "$filterComplex" -map "[vout]" -map 2:a '
        '-shortest -c:v libx264 -preset fast -crf 23 -pix_fmt yuv420p '
        '-c:a aac -b:a 128k -ar 44100 -ac 2 -movflags +faststart "$output"';
    if (await _execute(silentAudio) && File(output).existsSync()) return true;

    final videoOnly =
        '-y -i "$videoPath" -i "$stampPath" -filter_complex "$filterComplex" '
        '-map "[vout]" -c:v libx264 -preset fast -crf 23 -pix_fmt yuv420p '
        '-an -movflags +faststart "$output"';
    return await _execute(videoOnly) && File(output).existsSync();
  }

  static Future<bool> _transcodeVideoFilter(
    String input,
    String output,
    String videoFilter,
  ) async {
    final withAudio =
        '-y -i "$input" -vf "$videoFilter" -map 0:v:0 -map 0:a? '
        '-c:v libx264 -preset fast -crf 23 -pix_fmt yuv420p '
        '-c:a aac -b:a 128k -ar 44100 -ac 2 -movflags +faststart "$output"';
    if (await _execute(withAudio) && File(output).existsSync()) return true;

    final videoOnly =
        '-y -i "$input" -vf "$videoFilter" -map 0:v:0 '
        '-c:v libx264 -preset fast -crf 23 -pix_fmt yuv420p '
        '-an -movflags +faststart "$output"';
    return await _execute(videoOnly) && File(output).existsSync();
  }

  static Future<bool> _execute(String command) async {
    final session = await FFmpegKit.execute(command);
    final rc = await session.getReturnCode();
    return ReturnCode.isSuccess(rc);
  }

  static Future<String> mergeClips({
    required List<Clip> clips,
    int totalDurationMs = 0,
    void Function(double progress)? onProgress,
  }) async {
    if (!isSupported) {
      throw StateError('FFmpeg merge is only available on Android/iOS.');
    }

    final output = await StorageService.newCompiledPath();
    final listPath = await StorageService.newConcatListPath();
    final tempFramed = <String>[];

    try {
      final paths = <String>[];
      for (final clip in clips) {
        final path = clip.videoPath;
        if (path == null || !File(path).existsSync()) continue;

        final framed = await applyFilmFrame(
          videoPath: path,
          recordedAt: clip.recordedAt,
        );
        if (framed != path) tempFramed.add(framed);
        paths.add(framed);
      }

      if (paths.isEmpty) {
        throw StateError('No clip paths to merge.');
      }

      final buffer = StringBuffer();
      for (final path in paths) {
        buffer.writeln("file '${path.replaceAll("'", r"'\''")}'");
      }
      await File(listPath).writeAsString(buffer.toString());

      await _run(
        '-y -f concat -safe 0 -i "$listPath" '
        '-c:v libx264 -preset fast -crf 23 -pix_fmt yuv420p '
        '-c:a aac -b:a 128k -ar 44100 -ac 2 -movflags +faststart "$output"',
        totalDurationMs,
        onProgress,
      );

      if (!File(output).existsSync()) {
        throw StateError('Compiled output was not created.');
      }
      return output;
    } finally {
      await StorageService.deleteFiles([listPath, ...tempFramed]);
    }
  }

  static Future<void> _run(
    String command,
    int totalMs,
    void Function(double)? onProgress,
  ) async {
    final completer = Completer<void>();
    await FFmpegKit.executeAsync(
      command,
      (session) async {
        final rc = await session.getReturnCode();
        if (ReturnCode.isSuccess(rc)) {
          if (!completer.isCompleted) completer.complete();
        } else {
          if (!completer.isCompleted) {
            completer.completeError(
              Exception('FFmpeg failed (rc=$rc): ${await session.getOutput()}'),
            );
          }
        }
      },
      (_) {},
      (stats) {
        if (totalMs > 0 && onProgress != null) {
          onProgress((stats.getTime() / totalMs).clamp(0.0, 1.0));
        }
      },
    );
    return completer.future;
  }
}
