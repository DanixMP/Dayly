import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/date_stamp.dart';

/// Renders the film date stamp to a transparent PNG for FFmpeg overlay.
class StampRenderer {
  const StampRenderer._();

  static Future<void> renderToFile(DateTime date, String outputPath) async {
    final stamp = formatFilmDateStamp(date, 'en');
    final style = GoogleFonts.dmSerifDisplay(
      fontSize: 28,
      color: const Color(0xFFEDEAE0),
    );

    final textPainter = TextPainter(
      text: TextSpan(text: stamp, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    final width = (textPainter.width + 48).ceil().clamp(240, 1080);
    const height = 72;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    );
    textPainter.paint(
      canvas,
      Offset((width - textPainter.width) / 2, (height - textPainter.height) / 2),
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(width, height);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    picture.dispose();
    image.dispose();

    if (bytes == null) {
      throw StateError('Failed to encode stamp PNG.');
    }
    await File(outputPath).writeAsBytes(bytes.buffer.asUint8List());
  }
}
