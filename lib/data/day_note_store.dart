import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Persists one free-text note per calendar day (`yyyy-MM-dd`).
class DayNoteStore {
  const DayNoteStore._();

  static const _kNotes = 'day_notes_json';

  static Map<String, String> fromPrefs(SharedPreferences prefs) {
    final raw = prefs.getString(_kNotes);
    if (raw == null || raw.isEmpty) return const {};
    final decoded = jsonDecode(raw);
    if (decoded is! Map) return const {};
    return decoded.map(
      (key, value) => MapEntry(key.toString(), value.toString()),
    );
  }

  static Future<void> persist(
    SharedPreferences prefs,
    Map<String, String> notes,
  ) async {
    if (notes.isEmpty) {
      await prefs.remove(_kNotes);
      return;
    }
    await prefs.setString(_kNotes, jsonEncode(notes));
  }
}
