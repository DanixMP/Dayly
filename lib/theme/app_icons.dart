import 'package:flutter/material.dart' show Icons, IconData;

/// Library-agnostic icon set.
///
/// Screens reference [AppIcons] rather than any UI library's icon pack, so the
/// active [UiKit] can be swapped without touching feature code. Backed by
/// Flutter's bundled Material icon glyphs (part of the SDK, not a component
/// library).
class AppIcons {
  const AppIcons._();

  static const IconData settings = Icons.settings_outlined;
  static const IconData calendar = Icons.calendar_month_outlined;
  static const IconData stats = Icons.query_stats_rounded;
  static const IconData today = Icons.today_outlined;
  static const IconData play = Icons.play_arrow_rounded;
  static const IconData record = Icons.fiber_manual_record;
  static const IconData flipCamera = Icons.cameraswitch_outlined;
  static const IconData gallery = Icons.photo_library_outlined;
  static const IconData share = Icons.ios_share;
  static const IconData save = Icons.download_rounded;
  static const IconData language = Icons.translate_rounded;
  static const IconData palette = Icons.brush_outlined;
  static const IconData reminder = Icons.notifications_outlined;
  static const IconData clock = Icons.schedule_outlined;
  static const IconData film = Icons.movie_outlined;
  static const IconData chevronRight = Icons.chevron_right_rounded;
  static const IconData back = Icons.arrow_back_rounded;
  static const IconData add = Icons.add_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData sun = Icons.light_mode_outlined;
  static const IconData moon = Icons.dark_mode_outlined;
  static const IconData auto = Icons.brightness_auto_outlined;
  static const IconData note = Icons.sticky_note_2_outlined;
  static const IconData delete = Icons.delete_outline_rounded;
  static const IconData reset = Icons.restart_alt_outlined;
  static const IconData info = Icons.info_outline_rounded;
  static const IconData person = Icons.person_outline_rounded;
  static const IconData code = Icons.code_rounded;
  static const IconData privacy = Icons.shield_outlined;
  static const IconData heart = Icons.favorite_border_rounded;
  static const IconData openSource = Icons.auto_awesome_outlined;
  static const IconData connect = Icons.chat_bubble_outline_rounded;
  static const IconData github = Icons.code_rounded;
  static const IconData instagram = Icons.camera_alt_outlined;
  static const IconData telegram = Icons.send_rounded;
  static const IconData email = Icons.mail_outline_rounded;
}
