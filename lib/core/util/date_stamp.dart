import 'package:intl/intl.dart';

/// Super-8 style date stamp shared by the record overlay, film frame UI, and
/// FFmpeg burn-in during compile.
String formatFilmDateStamp(DateTime date, [String? locale]) {
  final loc = locale ?? 'en';
  final day = DateFormat('EEE d', loc).format(date).toUpperCase();
  final monthYear = DateFormat('MMM yyyy', loc).format(date).toUpperCase();
  return '$day · $monthYear';
}

/// Escapes user-facing text for FFmpeg `drawtext` (single-quoted value).
String escapeFfmpegDrawText(String text) {
  return text
      .replaceAll('\\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(':', r'\:')
      .replaceAll('%', r'\%');
}
