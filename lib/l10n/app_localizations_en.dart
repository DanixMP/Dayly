// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Dayly';

  @override
  String get appTagline => 'Your life, one second at a time.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Get started';

  @override
  String get onboardingSwipe => 'Swipe to explore';

  @override
  String get onboardingWelcomeTitle => 'Welcome to Dayly';

  @override
  String get onboardingWelcomeBody =>
      'A warm, one-second ritual that turns ordinary days into a film you can actually watch.';

  @override
  String get onboardingRecordTitle => 'Capture one honest second';

  @override
  String get onboardingRecordBody =>
      'Open Today, hit record, and save a single real moment — no editing, no pressure.';

  @override
  String get onboardingCalendarTitle => 'Browse your calendar';

  @override
  String get onboardingCalendarBody =>
      'Tap any day to replay clips, leave a note, and watch your streak grow.';

  @override
  String get onboardingRemindersTitle => 'Stay in rhythm';

  @override
  String get onboardingRemindersBody =>
      'Turn on daily reminders in Settings so you never forget your second.';

  @override
  String get tabNavigationLabel => 'Main navigation';

  @override
  String get tabCalendar => 'Calendar';

  @override
  String get tabStats => 'Stats';

  @override
  String get tabToday => 'Today';

  @override
  String get tabCompile => 'Compile';

  @override
  String get tabSettings => 'Settings';

  @override
  String get diaryTitle => 'Dayly';

  @override
  String get diaryRecentSection => 'Recent';

  @override
  String diaryStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
      zero: 'no days yet',
    );
    return 'Streak: $_temp0 🔥';
  }

  @override
  String get diaryTodayTile => 'today';

  @override
  String get diaryEmpty => 'No moments yet. Record your first second.';

  @override
  String get diaryDayRecorded => 'Recorded';

  @override
  String get diaryDayNotRecorded => 'No recording';

  @override
  String get diaryDayNotRecordedHint =>
      'You haven\'t captured a second for this day yet.';

  @override
  String diaryDayClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recordings',
      one: '1 recording',
    );
    return '$_temp0';
  }

  @override
  String get diaryTapToPlay => 'Tap to play';

  @override
  String diaryRecordedAt(String time, int seconds) {
    return 'Recorded at $time · ${seconds}s';
  }

  @override
  String get todayTitle => 'Today';

  @override
  String get todayRecordedTitle => 'Today\'s second is saved';

  @override
  String get todayRecordedBody =>
      'You\'re set for today. Come back tomorrow to keep the rhythm going.';

  @override
  String get todayUnrecordedTitle => 'Record today\'s second';

  @override
  String get todayUnrecordedBody =>
      'Capture one honest second before the day slips by.';

  @override
  String todayClipSummary(String time, int seconds) {
    return 'Recorded at $time · ${seconds}s';
  }

  @override
  String get todayRecordCta => 'Record today';

  @override
  String get todayRecordAgainCta => 'Record another second';

  @override
  String get dayNoteTitle => 'Leave a note for today';

  @override
  String get dayNoteHint =>
      'A short line about how the day felt — visible on your calendar.';

  @override
  String get dayNotePlaceholder => 'What made today worth remembering?';

  @override
  String get dayNoteLabel => 'Day note';

  @override
  String get statsTitle => 'Stats & videos';

  @override
  String get statsClipsLabel => 'Clips';

  @override
  String get statsDurationLabel => 'Footage';

  @override
  String get statsStreakLabel => 'Streak';

  @override
  String statsClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count clips',
      one: '1 clip',
      zero: 'No clips',
    );
    return '$_temp0';
  }

  @override
  String statsDuration(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '${seconds}s',
      one: '1s',
      zero: '0s',
    );
    return '$_temp0';
  }

  @override
  String get statsRecentVideos => 'Recent videos';

  @override
  String get statsEmpty =>
      'Record a few seconds and your videos will appear here.';

  @override
  String get recordTitle => 'Record your day';

  @override
  String get recordHold => 'hold to record';

  @override
  String recordHint(int min, int max) {
    return '${min}s min · ${max}s max';
  }

  @override
  String get recordDeviceOnly =>
      'Recording uses the device camera and is available on Android.';

  @override
  String get recordPermissionDenied =>
      'Camera and microphone access is needed to record.';

  @override
  String get recordGrantPermission => 'Grant access';

  @override
  String recordTooShort(int min) {
    return 'Hold a little longer — ${min}s minimum.';
  }

  @override
  String get recordCameraError => 'Couldn\'t start the camera.';

  @override
  String get previewTitle => 'Your second';

  @override
  String get previewSaved => 'Saved to your diary.';

  @override
  String get compileFailed => 'Compile failed. Please try again.';

  @override
  String compilePercent(int percent) {
    return 'Merging… $percent%';
  }

  @override
  String get compileTitle => 'Compile your diary';

  @override
  String get compileDateRange => 'Date range';

  @override
  String compileClips(int count, int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count clips',
      one: '1 clip',
      zero: 'No clips',
    );
    return '$_temp0 · ~${seconds}s';
  }

  @override
  String get compileButton => 'Compile video';

  @override
  String compileMerging(int current, int total) {
    return 'Merging clip $current of $total…';
  }

  @override
  String get compileNoClips => 'No clips in range';

  @override
  String get playerShare => 'Share';

  @override
  String get playerSave => 'Save';

  @override
  String get playerSaved => 'Saved to gallery.';

  @override
  String get playerSaveFailed => 'Couldn\'t save to gallery.';

  @override
  String get playerShareUnavailable => 'Sharing isn\'t available yet.';

  @override
  String get playerEmpty => 'Compile a film to watch it here.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionPersonal => 'Personalization';

  @override
  String get settingsSectionNotifications => 'Notifications';

  @override
  String get settingsSectionRecording => 'Recording';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String settingsProfileStats(int clips, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      clips,
      locale: localeName,
      other: '$clips clips',
      one: '1 clip',
      zero: 'No clips yet',
    );
    String _temp1 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak-day streak',
      one: '1-day streak',
      zero: 'no streak',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get settingsReminderOff => 'Off';

  @override
  String get settingsCustomColorsUnlocked => 'Unlocked';

  @override
  String get settingsFooter => 'Dayly — your life, one second at a time.';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsNavigationBarStyle => 'Crystal style';

  @override
  String get settingsNavigationBarStyleHint =>
      'Fine-tune the Crystal tab bar look. Only applies when Crystal is selected.';

  @override
  String get settingsNavigationBarType => 'Navigation bar';

  @override
  String get settingsNavigationBarTypeHint =>
      'Choose Crystal or the curved bar with a floating center button.';

  @override
  String get settingsNavTypeCrystal => 'Crystal';

  @override
  String get settingsNavTypeCurved => 'Curved';

  @override
  String get settingsNavigationBarPreview => 'Preview';

  @override
  String get settingsNavigationBarPreviewHint =>
      'Tap icons to try the bar before leaving settings.';

  @override
  String get settingsNavStyleBlur => 'Blur navigation bar';

  @override
  String get settingsNavStyleFrosted => 'Frosted navigation bar';

  @override
  String get settingsNavStyleFloating => 'Floating navigation bar';

  @override
  String get settingsNavStyleRounded => 'Rounded navigation bar';

  @override
  String get settingsNavStyleModern => 'Modern navigation bar';

  @override
  String get settingsUiLibrary => 'UI library';

  @override
  String get settingsUiLibraryHint =>
      'Swap the component library live — for testing design systems.';

  @override
  String get settingsReminders => 'Reminders';

  @override
  String get settingsDailyReminder => 'Daily reminder';

  @override
  String get settingsReminderTime => 'Reminder time';

  @override
  String get settingsReminderCustom => 'Custom';

  @override
  String get settingsReminderPickTime => 'Pick a reminder time';

  @override
  String get settingsReminderHour => 'Hour';

  @override
  String get settingsReminderMinute => 'Minute';

  @override
  String get settingsCapture => 'Capture';

  @override
  String get settingsDefaultDuration => 'Default clip length';

  @override
  String get settingsSaveToGallery => 'Save compiled video to gallery';

  @override
  String settingsSeconds(int count) {
    return '${count}s';
  }

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsConnectWithDev => 'Connect with Dev';

  @override
  String get settingsConnectWithDevHint =>
      'GitHub, Instagram, Telegram & email';

  @override
  String get settingsConnectWithDevIntro =>
      'Say hello — feedback, ideas, and bug reports are always welcome.';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacyHint =>
      'How Dayly handles your data on this device';

  @override
  String get settingsPrivacyIntroTitle => 'Your diary stays yours';

  @override
  String get settingsPrivacyIntroBody =>
      'Dayly is a personal video diary built for privacy first. There is no account, no cloud sync, and no advertising. Everything you record lives on your phone unless you choose to export it.';

  @override
  String get settingsPrivacyDataTitle => 'What we store';

  @override
  String get settingsPrivacyDataBody =>
      'Your video clips, thumbnails, compiled films, day notes, and app preferences are saved locally in the app’s private storage. Custom background photos you pick are copied into the app documents folder. Nothing is uploaded to our servers — we do not operate any.';

  @override
  String get settingsPrivacyPermissionsTitle => 'Permissions';

  @override
  String get settingsPrivacyPermissionsBody =>
      'Camera and microphone access are requested only when you record a clip. Storage permission is used if you enable saving compiled videos to your gallery. Notifications are optional and only used for your daily reminder. Photo library access is requested only when you choose a custom background image.';

  @override
  String get settingsPrivacyThirdPartyTitle => 'Third-party libraries';

  @override
  String get settingsPrivacyThirdPartyBody =>
      'Dayly uses open-source packages (Flutter, ffmpeg, and others) that run entirely on your device. They do not receive your diary content. See Open source & thanks in Settings for the full list.';

  @override
  String get settingsPrivacyYourControlTitle => 'Your control';

  @override
  String get settingsPrivacyYourControlBody =>
      'You can delete individual clips, wipe all recordings, or reset every setting from Settings at any time. Uninstalling the app removes all locally stored diary data from your device.';

  @override
  String get settingsPrivacyFooter => 'Last updated: July 2026 · Dayly v1.0';

  @override
  String get settingsAcknowledgements => 'Open source & thanks';

  @override
  String get settingsAcknowledgementsHint =>
      'Stack, dependencies, and gratitude';

  @override
  String get settingsAcknowledgementsStackTitle => 'Built with open source';

  @override
  String get settingsAcknowledgementsIntro =>
      'Dayly is made with Flutter and a wonderful ecosystem of community packages. We are grateful to every author and maintainer below.';

  @override
  String settingsAcknowledgementsVersion(String version, String build) {
    return 'Dayly $version (build $build)';
  }

  @override
  String get settingsAcknowledgementsThanks =>
      'Thank you to the open-source community — Dayly would not exist without you.';

  @override
  String get settingsAckCategoryFramework => 'Framework';

  @override
  String get settingsAckCategoryUi => 'UI & typography';

  @override
  String get settingsAckCategoryState => 'State & navigation';

  @override
  String get settingsAckCategoryMedia => 'Video & media';

  @override
  String get settingsAckCategoryStorage => 'Storage & export';

  @override
  String get settingsAckCategoryNotifications => 'Notifications';

  @override
  String get settingsAckCategoryUtilities => 'Utilities';

  @override
  String get settingsCustomColors => 'Custom colors';

  @override
  String get settingsCustomColorsHint =>
      'Unlocked easter egg — tune accent, colors, and a photo background.';

  @override
  String get settingsCustomColorsLightHint =>
      'Editing light theme colors. Switch to dark theme to customize dark colors separately.';

  @override
  String get settingsCustomColorsDarkHint =>
      'Editing dark theme colors. Switch to light theme to customize light colors separately.';

  @override
  String get settingsAccentColor => 'Accent';

  @override
  String get settingsBackgroundColor => 'Background';

  @override
  String get settingsBackgroundImage => 'Background photo';

  @override
  String get settingsBackgroundImageHint =>
      'Pick a photo for this theme. A soft tint keeps text readable.';

  @override
  String get settingsChooseBackgroundImage => 'Choose photo';

  @override
  String get settingsRemoveBackgroundImage => 'Remove photo';

  @override
  String get settingsAppFont => 'App font';

  @override
  String get settingsAppFontHint =>
      'Persian uses Vazirmatn automatically. Override the font for all languages here.';

  @override
  String get settingsFontAuto => 'Auto';

  @override
  String get settingsFontClassic => 'Classic';

  @override
  String get settingsFontVazir => 'Vazirmatn (Persian)';

  @override
  String get settingsFontPoppins => 'Poppins';

  @override
  String get settingsFontNunito => 'Nunito';

  @override
  String get settingsFontLora => 'Lora';

  @override
  String get settingsFontSpaceGrotesk => 'Space Grotesk';

  @override
  String get settingsBoxColor => 'Box';

  @override
  String get settingsResetColors => 'Reset to defaults';

  @override
  String get settingsSectionReset => 'Reset';

  @override
  String get settingsResetAll => 'Reset all settings';

  @override
  String get settingsResetAllHint =>
      'Restore every preference to its factory default.';

  @override
  String get settingsResetAllDetails =>
      'This resets theme, language, navigation bar style, UI library, reminders, capture options, and custom colors. Your recorded clips are not deleted.';

  @override
  String get settingsResetAllButton => 'Reset all settings';

  @override
  String get settingsResetClips => 'Delete all clips';

  @override
  String get settingsResetClipsHint =>
      'Permanently remove every recorded second from this device.';

  @override
  String settingsResetClipsDetails(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count clips stored on this device.',
      one: 'You have 1 clip stored on this device.',
      zero: 'No clips to delete.',
    );
    return '$_temp0';
  }

  @override
  String get settingsResetClipsConfirmTitle => 'Delete all clips?';

  @override
  String get settingsResetClipsConfirmBody =>
      'This cannot be undone. Every recorded clip, thumbnail, and compiled video will be permanently removed.';

  @override
  String get settingsResetClipsButton => 'Delete all clips';

  @override
  String get aboutDevTitle => 'About the developer';

  @override
  String get aboutDevSubtitle => 'Who built Dayly';

  @override
  String get aboutDevName => 'Danix';

  @override
  String get aboutDevRole => 'Developer & designer';

  @override
  String get aboutDevBio =>
      'Dayly started as a small experiment: what if you could hold an entire year in a few minutes of film? I built this app to make that ritual feel warm, fast, and a little bit magical.';

  @override
  String get aboutDevStackTitle => 'Built with';

  @override
  String get aboutDevStackBody =>
      'Flutter · Riverpod · on-device camera & ffmpeg pipeline · a lot of coffee.';

  @override
  String aboutDevVersion(String version) {
    return 'Version $version';
  }

  @override
  String aboutDevVersionBuild(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get aboutDevEasterEggUnlocked =>
      'You found it! Custom colors and photo backgrounds are now unlocked.';

  @override
  String get commonSave => 'Save';

  @override
  String get commonRetake => 'Retake';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonBack => 'Back';

  @override
  String get commonRecord => 'Record';
}
