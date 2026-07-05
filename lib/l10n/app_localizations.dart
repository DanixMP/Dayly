import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Dayly'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your life, one second at a time.'**
  String get appTagline;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingSwipe.
  ///
  /// In en, this message translates to:
  /// **'Swipe to explore'**
  String get onboardingSwipe;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Dayly'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'A warm, one-second ritual that turns ordinary days into a film you can actually watch.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture one honest second'**
  String get onboardingRecordTitle;

  /// No description provided for @onboardingRecordBody.
  ///
  /// In en, this message translates to:
  /// **'Open Today, hit record, and save a single real moment — no editing, no pressure.'**
  String get onboardingRecordBody;

  /// No description provided for @onboardingCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Browse your calendar'**
  String get onboardingCalendarTitle;

  /// No description provided for @onboardingCalendarBody.
  ///
  /// In en, this message translates to:
  /// **'Tap any day to replay clips, leave a note, and watch your streak grow.'**
  String get onboardingCalendarBody;

  /// No description provided for @onboardingRemindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay in rhythm'**
  String get onboardingRemindersTitle;

  /// No description provided for @onboardingRemindersBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on daily reminders in Settings so you never forget your second.'**
  String get onboardingRemindersBody;

  /// No description provided for @tabNavigationLabel.
  ///
  /// In en, this message translates to:
  /// **'Main navigation'**
  String get tabNavigationLabel;

  /// No description provided for @tabCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get tabCalendar;

  /// No description provided for @tabStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get tabStats;

  /// No description provided for @tabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tabToday;

  /// No description provided for @tabCompile.
  ///
  /// In en, this message translates to:
  /// **'Compile'**
  String get tabCompile;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @diaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Dayly'**
  String get diaryTitle;

  /// No description provided for @diaryRecentSection.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get diaryRecentSection;

  /// No description provided for @diaryStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak: {count, plural, =0{no days yet} =1{1 day} other{{count} days}} 🔥'**
  String diaryStreak(int count);

  /// No description provided for @diaryTodayTile.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get diaryTodayTile;

  /// No description provided for @diaryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No moments yet. Record your first second.'**
  String get diaryEmpty;

  /// No description provided for @diaryDayRecorded.
  ///
  /// In en, this message translates to:
  /// **'Recorded'**
  String get diaryDayRecorded;

  /// No description provided for @diaryDayNotRecorded.
  ///
  /// In en, this message translates to:
  /// **'No recording'**
  String get diaryDayNotRecorded;

  /// No description provided for @diaryDayNotRecordedHint.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t captured a second for this day yet.'**
  String get diaryDayNotRecordedHint;

  /// No description provided for @diaryDayClipCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 recording} other{{count} recordings}}'**
  String diaryDayClipCount(int count);

  /// No description provided for @diaryTapToPlay.
  ///
  /// In en, this message translates to:
  /// **'Tap to play'**
  String get diaryTapToPlay;

  /// No description provided for @diaryRecordedAt.
  ///
  /// In en, this message translates to:
  /// **'Recorded at {time} · {seconds}s'**
  String diaryRecordedAt(String time, int seconds);

  /// No description provided for @todayTitle.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayTitle;

  /// No description provided for @todayRecordedTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s second is saved'**
  String get todayRecordedTitle;

  /// No description provided for @todayRecordedBody.
  ///
  /// In en, this message translates to:
  /// **'You\'re set for today. Come back tomorrow to keep the rhythm going.'**
  String get todayRecordedBody;

  /// No description provided for @todayUnrecordedTitle.
  ///
  /// In en, this message translates to:
  /// **'Record today\'s second'**
  String get todayUnrecordedTitle;

  /// No description provided for @todayUnrecordedBody.
  ///
  /// In en, this message translates to:
  /// **'Capture one honest second before the day slips by.'**
  String get todayUnrecordedBody;

  /// No description provided for @todayClipSummary.
  ///
  /// In en, this message translates to:
  /// **'Recorded at {time} · {seconds}s'**
  String todayClipSummary(String time, int seconds);

  /// No description provided for @todayRecordCta.
  ///
  /// In en, this message translates to:
  /// **'Record today'**
  String get todayRecordCta;

  /// No description provided for @todayRecordAgainCta.
  ///
  /// In en, this message translates to:
  /// **'Record another second'**
  String get todayRecordAgainCta;

  /// No description provided for @dayNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave a note for today'**
  String get dayNoteTitle;

  /// No description provided for @dayNoteHint.
  ///
  /// In en, this message translates to:
  /// **'A short line about how the day felt — visible on your calendar.'**
  String get dayNoteHint;

  /// No description provided for @dayNotePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What made today worth remembering?'**
  String get dayNotePlaceholder;

  /// No description provided for @dayNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Day note'**
  String get dayNoteLabel;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stats & videos'**
  String get statsTitle;

  /// No description provided for @statsClipsLabel.
  ///
  /// In en, this message translates to:
  /// **'Clips'**
  String get statsClipsLabel;

  /// No description provided for @statsDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Footage'**
  String get statsDurationLabel;

  /// No description provided for @statsStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get statsStreakLabel;

  /// No description provided for @statsClipCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No clips} =1{1 clip} other{{count} clips}}'**
  String statsClipCount(int count);

  /// No description provided for @statsDuration.
  ///
  /// In en, this message translates to:
  /// **'{seconds, plural, =0{0s} =1{1s} other{{seconds}s}}'**
  String statsDuration(int seconds);

  /// No description provided for @statsRecentVideos.
  ///
  /// In en, this message translates to:
  /// **'Recent videos'**
  String get statsRecentVideos;

  /// No description provided for @statsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Record a few seconds and your videos will appear here.'**
  String get statsEmpty;

  /// No description provided for @recordTitle.
  ///
  /// In en, this message translates to:
  /// **'Record your day'**
  String get recordTitle;

  /// No description provided for @recordHold.
  ///
  /// In en, this message translates to:
  /// **'hold to record'**
  String get recordHold;

  /// No description provided for @recordHint.
  ///
  /// In en, this message translates to:
  /// **'{min}s min · {max}s max'**
  String recordHint(int min, int max);

  /// No description provided for @recordDeviceOnly.
  ///
  /// In en, this message translates to:
  /// **'Recording uses the device camera and is available on Android.'**
  String get recordDeviceOnly;

  /// No description provided for @recordPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera and microphone access is needed to record.'**
  String get recordPermissionDenied;

  /// No description provided for @recordGrantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant access'**
  String get recordGrantPermission;

  /// No description provided for @recordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Hold a little longer — {min}s minimum.'**
  String recordTooShort(int min);

  /// No description provided for @recordCameraError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t start the camera.'**
  String get recordCameraError;

  /// No description provided for @previewTitle.
  ///
  /// In en, this message translates to:
  /// **'Your second'**
  String get previewTitle;

  /// No description provided for @previewSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to your diary.'**
  String get previewSaved;

  /// No description provided for @compileFailed.
  ///
  /// In en, this message translates to:
  /// **'Compile failed. Please try again.'**
  String get compileFailed;

  /// No description provided for @compilePercent.
  ///
  /// In en, this message translates to:
  /// **'Merging… {percent}%'**
  String compilePercent(int percent);

  /// No description provided for @compileTitle.
  ///
  /// In en, this message translates to:
  /// **'Compile your diary'**
  String get compileTitle;

  /// No description provided for @compileDateRange.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get compileDateRange;

  /// No description provided for @compileClips.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No clips} =1{1 clip} other{{count} clips}} · ~{seconds}s'**
  String compileClips(int count, int seconds);

  /// No description provided for @compileButton.
  ///
  /// In en, this message translates to:
  /// **'Compile video'**
  String get compileButton;

  /// No description provided for @compileMerging.
  ///
  /// In en, this message translates to:
  /// **'Merging clip {current} of {total}…'**
  String compileMerging(int current, int total);

  /// No description provided for @compileNoClips.
  ///
  /// In en, this message translates to:
  /// **'No clips in range'**
  String get compileNoClips;

  /// No description provided for @playerShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get playerShare;

  /// No description provided for @playerSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get playerSave;

  /// No description provided for @playerSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to gallery.'**
  String get playerSaved;

  /// No description provided for @playerSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save to gallery.'**
  String get playerSaveFailed;

  /// No description provided for @playerShareUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sharing isn\'t available yet.'**
  String get playerShareUnavailable;

  /// No description provided for @playerEmpty.
  ///
  /// In en, this message translates to:
  /// **'Compile a film to watch it here.'**
  String get playerEmpty;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSectionPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personalization'**
  String get settingsSectionPersonal;

  /// No description provided for @settingsSectionNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsSectionNotifications;

  /// No description provided for @settingsSectionRecording.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get settingsSectionRecording;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsSectionAbout;

  /// No description provided for @settingsProfileStats.
  ///
  /// In en, this message translates to:
  /// **'{clips, plural, =0{No clips yet} =1{1 clip} other{{clips} clips}} · {streak, plural, =0{no streak} =1{1-day streak} other{{streak}-day streak}}'**
  String settingsProfileStats(int clips, int streak);

  /// No description provided for @settingsReminderOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingsReminderOff;

  /// No description provided for @settingsCustomColorsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get settingsCustomColorsUnlocked;

  /// No description provided for @settingsFooter.
  ///
  /// In en, this message translates to:
  /// **'Dayly — your life, one second at a time.'**
  String get settingsFooter;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsNavigationBarStyle.
  ///
  /// In en, this message translates to:
  /// **'Crystal style'**
  String get settingsNavigationBarStyle;

  /// No description provided for @settingsNavigationBarStyleHint.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune the Crystal tab bar look. Only applies when Crystal is selected.'**
  String get settingsNavigationBarStyleHint;

  /// No description provided for @settingsNavigationBarType.
  ///
  /// In en, this message translates to:
  /// **'Navigation bar'**
  String get settingsNavigationBarType;

  /// No description provided for @settingsNavigationBarTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Choose Crystal or the curved bar with a floating center button.'**
  String get settingsNavigationBarTypeHint;

  /// No description provided for @settingsNavTypeCrystal.
  ///
  /// In en, this message translates to:
  /// **'Crystal'**
  String get settingsNavTypeCrystal;

  /// No description provided for @settingsNavTypeCurved.
  ///
  /// In en, this message translates to:
  /// **'Curved'**
  String get settingsNavTypeCurved;

  /// No description provided for @settingsNavigationBarPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get settingsNavigationBarPreview;

  /// No description provided for @settingsNavigationBarPreviewHint.
  ///
  /// In en, this message translates to:
  /// **'Tap icons to try the bar before leaving settings.'**
  String get settingsNavigationBarPreviewHint;

  /// No description provided for @settingsNavStyleBlur.
  ///
  /// In en, this message translates to:
  /// **'Blur navigation bar'**
  String get settingsNavStyleBlur;

  /// No description provided for @settingsNavStyleFrosted.
  ///
  /// In en, this message translates to:
  /// **'Frosted navigation bar'**
  String get settingsNavStyleFrosted;

  /// No description provided for @settingsNavStyleFloating.
  ///
  /// In en, this message translates to:
  /// **'Floating navigation bar'**
  String get settingsNavStyleFloating;

  /// No description provided for @settingsNavStyleRounded.
  ///
  /// In en, this message translates to:
  /// **'Rounded navigation bar'**
  String get settingsNavStyleRounded;

  /// No description provided for @settingsNavStyleModern.
  ///
  /// In en, this message translates to:
  /// **'Modern navigation bar'**
  String get settingsNavStyleModern;

  /// No description provided for @settingsUiLibrary.
  ///
  /// In en, this message translates to:
  /// **'UI library'**
  String get settingsUiLibrary;

  /// No description provided for @settingsUiLibraryHint.
  ///
  /// In en, this message translates to:
  /// **'Swap the component library live — for testing design systems.'**
  String get settingsUiLibraryHint;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// No description provided for @settingsDailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get settingsDailyReminder;

  /// No description provided for @settingsReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get settingsReminderTime;

  /// No description provided for @settingsReminderCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get settingsReminderCustom;

  /// No description provided for @settingsReminderPickTime.
  ///
  /// In en, this message translates to:
  /// **'Pick a reminder time'**
  String get settingsReminderPickTime;

  /// No description provided for @settingsReminderHour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get settingsReminderHour;

  /// No description provided for @settingsReminderMinute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get settingsReminderMinute;

  /// No description provided for @settingsCapture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get settingsCapture;

  /// No description provided for @settingsDefaultDuration.
  ///
  /// In en, this message translates to:
  /// **'Default clip length'**
  String get settingsDefaultDuration;

  /// No description provided for @settingsSaveToGallery.
  ///
  /// In en, this message translates to:
  /// **'Save compiled video to gallery'**
  String get settingsSaveToGallery;

  /// No description provided for @settingsSeconds.
  ///
  /// In en, this message translates to:
  /// **'{count}s'**
  String settingsSeconds(int count);

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsConnectWithDev.
  ///
  /// In en, this message translates to:
  /// **'Connect with Dev'**
  String get settingsConnectWithDev;

  /// No description provided for @settingsConnectWithDevHint.
  ///
  /// In en, this message translates to:
  /// **'GitHub, Instagram, Telegram & email'**
  String get settingsConnectWithDevHint;

  /// No description provided for @settingsConnectWithDevIntro.
  ///
  /// In en, this message translates to:
  /// **'Say hello — feedback, ideas, and bug reports are always welcome.'**
  String get settingsConnectWithDevIntro;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyHint.
  ///
  /// In en, this message translates to:
  /// **'How Dayly handles your data on this device'**
  String get settingsPrivacyHint;

  /// No description provided for @settingsPrivacyIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Your diary stays yours'**
  String get settingsPrivacyIntroTitle;

  /// No description provided for @settingsPrivacyIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Dayly is a personal video diary built for privacy first. There is no account, no cloud sync, and no advertising. Everything you record lives on your phone unless you choose to export it.'**
  String get settingsPrivacyIntroBody;

  /// No description provided for @settingsPrivacyDataTitle.
  ///
  /// In en, this message translates to:
  /// **'What we store'**
  String get settingsPrivacyDataTitle;

  /// No description provided for @settingsPrivacyDataBody.
  ///
  /// In en, this message translates to:
  /// **'Your video clips, thumbnails, compiled films, day notes, and app preferences are saved locally in the app’s private storage. Custom background photos you pick are copied into the app documents folder. Nothing is uploaded to our servers — we do not operate any.'**
  String get settingsPrivacyDataBody;

  /// No description provided for @settingsPrivacyPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get settingsPrivacyPermissionsTitle;

  /// No description provided for @settingsPrivacyPermissionsBody.
  ///
  /// In en, this message translates to:
  /// **'Camera and microphone access are requested only when you record a clip. Storage permission is used if you enable saving compiled videos to your gallery. Notifications are optional and only used for your daily reminder. Photo library access is requested only when you choose a custom background image.'**
  String get settingsPrivacyPermissionsBody;

  /// No description provided for @settingsPrivacyThirdPartyTitle.
  ///
  /// In en, this message translates to:
  /// **'Third-party libraries'**
  String get settingsPrivacyThirdPartyTitle;

  /// No description provided for @settingsPrivacyThirdPartyBody.
  ///
  /// In en, this message translates to:
  /// **'Dayly uses open-source packages (Flutter, ffmpeg, and others) that run entirely on your device. They do not receive your diary content. See Open source & thanks in Settings for the full list.'**
  String get settingsPrivacyThirdPartyBody;

  /// No description provided for @settingsPrivacyYourControlTitle.
  ///
  /// In en, this message translates to:
  /// **'Your control'**
  String get settingsPrivacyYourControlTitle;

  /// No description provided for @settingsPrivacyYourControlBody.
  ///
  /// In en, this message translates to:
  /// **'You can delete individual clips, wipe all recordings, or reset every setting from Settings at any time. Uninstalling the app removes all locally stored diary data from your device.'**
  String get settingsPrivacyYourControlBody;

  /// No description provided for @settingsPrivacyFooter.
  ///
  /// In en, this message translates to:
  /// **'Last updated: July 2026 · Dayly v1.0'**
  String get settingsPrivacyFooter;

  /// No description provided for @settingsAcknowledgements.
  ///
  /// In en, this message translates to:
  /// **'Open source & thanks'**
  String get settingsAcknowledgements;

  /// No description provided for @settingsAcknowledgementsHint.
  ///
  /// In en, this message translates to:
  /// **'Stack, dependencies, and gratitude'**
  String get settingsAcknowledgementsHint;

  /// No description provided for @settingsAcknowledgementsStackTitle.
  ///
  /// In en, this message translates to:
  /// **'Built with open source'**
  String get settingsAcknowledgementsStackTitle;

  /// No description provided for @settingsAcknowledgementsIntro.
  ///
  /// In en, this message translates to:
  /// **'Dayly is made with Flutter and a wonderful ecosystem of community packages. We are grateful to every author and maintainer below.'**
  String get settingsAcknowledgementsIntro;

  /// No description provided for @settingsAcknowledgementsVersion.
  ///
  /// In en, this message translates to:
  /// **'Dayly {version} (build {build})'**
  String settingsAcknowledgementsVersion(String version, String build);

  /// No description provided for @settingsAcknowledgementsThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you to the open-source community — Dayly would not exist without you.'**
  String get settingsAcknowledgementsThanks;

  /// No description provided for @settingsAckCategoryFramework.
  ///
  /// In en, this message translates to:
  /// **'Framework'**
  String get settingsAckCategoryFramework;

  /// No description provided for @settingsAckCategoryUi.
  ///
  /// In en, this message translates to:
  /// **'UI & typography'**
  String get settingsAckCategoryUi;

  /// No description provided for @settingsAckCategoryState.
  ///
  /// In en, this message translates to:
  /// **'State & navigation'**
  String get settingsAckCategoryState;

  /// No description provided for @settingsAckCategoryMedia.
  ///
  /// In en, this message translates to:
  /// **'Video & media'**
  String get settingsAckCategoryMedia;

  /// No description provided for @settingsAckCategoryStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage & export'**
  String get settingsAckCategoryStorage;

  /// No description provided for @settingsAckCategoryNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsAckCategoryNotifications;

  /// No description provided for @settingsAckCategoryUtilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get settingsAckCategoryUtilities;

  /// No description provided for @settingsCustomColors.
  ///
  /// In en, this message translates to:
  /// **'Custom colors'**
  String get settingsCustomColors;

  /// No description provided for @settingsCustomColorsHint.
  ///
  /// In en, this message translates to:
  /// **'Unlocked easter egg — tune accent, colors, and a photo background.'**
  String get settingsCustomColorsHint;

  /// No description provided for @settingsCustomColorsLightHint.
  ///
  /// In en, this message translates to:
  /// **'Editing light theme colors. Switch to dark theme to customize dark colors separately.'**
  String get settingsCustomColorsLightHint;

  /// No description provided for @settingsCustomColorsDarkHint.
  ///
  /// In en, this message translates to:
  /// **'Editing dark theme colors. Switch to light theme to customize light colors separately.'**
  String get settingsCustomColorsDarkHint;

  /// No description provided for @settingsAccentColor.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get settingsAccentColor;

  /// No description provided for @settingsBackgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get settingsBackgroundColor;

  /// No description provided for @settingsBackgroundImage.
  ///
  /// In en, this message translates to:
  /// **'Background photo'**
  String get settingsBackgroundImage;

  /// No description provided for @settingsBackgroundImageHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a photo for this theme. A soft tint keeps text readable.'**
  String get settingsBackgroundImageHint;

  /// No description provided for @settingsChooseBackgroundImage.
  ///
  /// In en, this message translates to:
  /// **'Choose photo'**
  String get settingsChooseBackgroundImage;

  /// No description provided for @settingsRemoveBackgroundImage.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get settingsRemoveBackgroundImage;

  /// No description provided for @settingsAppFont.
  ///
  /// In en, this message translates to:
  /// **'App font'**
  String get settingsAppFont;

  /// No description provided for @settingsAppFontHint.
  ///
  /// In en, this message translates to:
  /// **'Persian uses Vazirmatn automatically. Override the font for all languages here.'**
  String get settingsAppFontHint;

  /// No description provided for @settingsFontAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settingsFontAuto;

  /// No description provided for @settingsFontClassic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get settingsFontClassic;

  /// No description provided for @settingsFontVazir.
  ///
  /// In en, this message translates to:
  /// **'Vazirmatn (Persian)'**
  String get settingsFontVazir;

  /// No description provided for @settingsFontPoppins.
  ///
  /// In en, this message translates to:
  /// **'Poppins'**
  String get settingsFontPoppins;

  /// No description provided for @settingsFontNunito.
  ///
  /// In en, this message translates to:
  /// **'Nunito'**
  String get settingsFontNunito;

  /// No description provided for @settingsFontLora.
  ///
  /// In en, this message translates to:
  /// **'Lora'**
  String get settingsFontLora;

  /// No description provided for @settingsFontSpaceGrotesk.
  ///
  /// In en, this message translates to:
  /// **'Space Grotesk'**
  String get settingsFontSpaceGrotesk;

  /// No description provided for @settingsBoxColor.
  ///
  /// In en, this message translates to:
  /// **'Box'**
  String get settingsBoxColor;

  /// No description provided for @settingsResetColors.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get settingsResetColors;

  /// No description provided for @settingsSectionReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get settingsSectionReset;

  /// No description provided for @settingsResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings'**
  String get settingsResetAll;

  /// No description provided for @settingsResetAllHint.
  ///
  /// In en, this message translates to:
  /// **'Restore every preference to its factory default.'**
  String get settingsResetAllHint;

  /// No description provided for @settingsResetAllDetails.
  ///
  /// In en, this message translates to:
  /// **'This resets theme, language, navigation bar style, UI library, reminders, capture options, and custom colors. Your recorded clips are not deleted.'**
  String get settingsResetAllDetails;

  /// No description provided for @settingsResetAllButton.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings'**
  String get settingsResetAllButton;

  /// No description provided for @settingsResetClips.
  ///
  /// In en, this message translates to:
  /// **'Delete all clips'**
  String get settingsResetClips;

  /// No description provided for @settingsResetClipsHint.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove every recorded second from this device.'**
  String get settingsResetClipsHint;

  /// No description provided for @settingsResetClipsDetails.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No clips to delete.} =1{You have 1 clip stored on this device.} other{You have {count} clips stored on this device.}}'**
  String settingsResetClipsDetails(int count);

  /// No description provided for @settingsResetClipsConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all clips?'**
  String get settingsResetClipsConfirmTitle;

  /// No description provided for @settingsResetClipsConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone. Every recorded clip, thumbnail, and compiled video will be permanently removed.'**
  String get settingsResetClipsConfirmBody;

  /// No description provided for @settingsResetClipsButton.
  ///
  /// In en, this message translates to:
  /// **'Delete all clips'**
  String get settingsResetClipsButton;

  /// No description provided for @aboutDevTitle.
  ///
  /// In en, this message translates to:
  /// **'About the developer'**
  String get aboutDevTitle;

  /// No description provided for @aboutDevSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Who built Dayly'**
  String get aboutDevSubtitle;

  /// No description provided for @aboutDevName.
  ///
  /// In en, this message translates to:
  /// **'Danix'**
  String get aboutDevName;

  /// No description provided for @aboutDevRole.
  ///
  /// In en, this message translates to:
  /// **'Developer & designer'**
  String get aboutDevRole;

  /// No description provided for @aboutDevBio.
  ///
  /// In en, this message translates to:
  /// **'Dayly started as a small experiment: what if you could hold an entire year in a few minutes of film? I built this app to make that ritual feel warm, fast, and a little bit magical.'**
  String get aboutDevBio;

  /// No description provided for @aboutDevStackTitle.
  ///
  /// In en, this message translates to:
  /// **'Built with'**
  String get aboutDevStackTitle;

  /// No description provided for @aboutDevStackBody.
  ///
  /// In en, this message translates to:
  /// **'Flutter · Riverpod · on-device camera & ffmpeg pipeline · a lot of coffee.'**
  String get aboutDevStackBody;

  /// No description provided for @aboutDevVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String aboutDevVersion(String version);

  /// No description provided for @aboutDevVersionBuild.
  ///
  /// In en, this message translates to:
  /// **'Version {version} ({build})'**
  String aboutDevVersionBuild(String version, String build);

  /// No description provided for @aboutDevEasterEggUnlocked.
  ///
  /// In en, this message translates to:
  /// **'You found it! Custom colors and photo backgrounds are now unlocked.'**
  String get aboutDevEasterEggUnlocked;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get commonRetake;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonRecord.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get commonRecord;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es', 'fa', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
