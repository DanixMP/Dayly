// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'Dayly';

  @override
  String get appTagline => 'زندگی‌ات، یک ثانیه یک بار.';

  @override
  String get onboardingSkip => 'رد کردن';

  @override
  String get onboardingNext => 'بعدی';

  @override
  String get onboardingGetStarted => 'شروع کنید';

  @override
  String get onboardingSwipe => 'برای کشف بکشید';

  @override
  String get onboardingWelcomeTitle => 'به Dayly خوش آمدید';

  @override
  String get onboardingWelcomeBody =>
      'یک مراسم گرمِ یک‌ثانیه‌ای که روزهای عادی را به فیلمی تبدیل می‌کند که واقعاً می‌توانی تماشا کنی.';

  @override
  String get onboardingRecordTitle => 'یک ثانیهٔ صادقانه ثبت کن';

  @override
  String get onboardingRecordBody =>
      'امروز را باز کن، ضبط را بزن و یک لحظهٔ واقعی ذخیره کن — بدون ویرایش، بدون فشار.';

  @override
  String get onboardingCalendarTitle => 'تقویمت را مرور کن';

  @override
  String get onboardingCalendarBody =>
      'روی هر روز بزن تا کلیپ‌ها را پخش کنی، یادداشت بگذاری و پیوستگی‌ات را ببینی.';

  @override
  String get onboardingRemindersTitle => 'در ریتم بمان';

  @override
  String get onboardingRemindersBody =>
      'یادآورهای روزانه را در تنظیمات فعال کن تا ثانیه‌ات را فراموش نکنی.';

  @override
  String get tabNavigationLabel => 'ناوبری اصلی';

  @override
  String get tabCalendar => 'تقویم';

  @override
  String get tabStats => 'آمار';

  @override
  String get tabToday => 'امروز';

  @override
  String get tabCompile => 'ترکیب';

  @override
  String get tabSettings => 'تنظیمات';

  @override
  String get diaryTitle => 'Dayly';

  @override
  String get diaryRecentSection => 'اخیر';

  @override
  String diaryStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count روز',
      one: '1 روز',
      zero: 'هنوز روزی نیست',
    );
    return 'پیوستگی: $_temp0 🔥';
  }

  @override
  String get diaryTodayTile => 'امروز';

  @override
  String get diaryEmpty => 'هنوز لحظه‌ای نداری. اولین ثانیه‌ات را ضبط کن.';

  @override
  String get diaryDayRecorded => 'ضبط شده';

  @override
  String get diaryDayNotRecorded => 'ضبط نشده';

  @override
  String get diaryDayNotRecordedHint =>
      'هنوز ثانیه‌ای برای این روز ثبت نکرده‌ای.';

  @override
  String diaryDayClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ضبط',
      one: '1 ضبط',
    );
    return '$_temp0';
  }

  @override
  String get diaryTapToPlay => 'برای پخش بزن';

  @override
  String diaryRecordedAt(String time, int seconds) {
    return 'ضبط شده در $time · $secondsث';
  }

  @override
  String get todayTitle => 'امروز';

  @override
  String get todayRecordedTitle => 'ثانیهٔ امروز ذخیره شد';

  @override
  String get todayRecordedBody =>
      'برای امروز آماده‌ای. فردا برگرد تا ریتم را ادامه دهی.';

  @override
  String get todayUnrecordedTitle => 'ثانیهٔ امروز را ضبط کن';

  @override
  String get todayUnrecordedBody =>
      'یک ثانیهٔ صادقانه ثبت کن قبل از اینکه روز بگذرد.';

  @override
  String todayClipSummary(String time, int seconds) {
    return 'ضبط شده در $time · $secondsث';
  }

  @override
  String get todayRecordCta => 'امروز را ضبط کن';

  @override
  String get todayRecordAgainCta => 'ثانیهٔ دیگری ضبط کن';

  @override
  String get dayNoteTitle => 'یادداشتی برای امروز بگذار';

  @override
  String get dayNoteHint =>
      'یک خط کوتاه دربارهٔ احساس روز — در تقویمت دیده می‌شود.';

  @override
  String get dayNotePlaceholder => 'چه چیزی امروز را ارزش به‌یادماندن کرد؟';

  @override
  String get dayNoteLabel => 'یادداشت روز';

  @override
  String get statsTitle => 'آمار و ویدیوها';

  @override
  String get statsClipsLabel => 'کلیپ‌ها';

  @override
  String get statsDurationLabel => 'مدت';

  @override
  String get statsStreakLabel => 'پیوستگی';

  @override
  String statsClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count کلیپ',
      one: '1 کلیپ',
      zero: 'کلیپی نیست',
    );
    return '$_temp0';
  }

  @override
  String statsDuration(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '$secondsث',
      one: '1ث',
      zero: '0ث',
    );
    return '$_temp0';
  }

  @override
  String get statsRecentVideos => 'ویدیوهای اخیر';

  @override
  String get statsEmpty => 'چند ثانیه ضبط کن و ویدیوهایت اینجا ظاهر می‌شوند.';

  @override
  String get recordTitle => 'روزت را ضبط کن';

  @override
  String get recordHold => 'نگه دار تا ضبط شود';

  @override
  String recordHint(int min, int max) {
    return 'حداقل $minث · حداکثر $maxث';
  }

  @override
  String get recordDeviceOnly =>
      'ضبط از دوربین دستگاه استفاده می‌کند و روی اندروید در دسترس است.';

  @override
  String get recordPermissionDenied =>
      'برای ضبط به دسترسی دوربین و میکروفون نیاز است.';

  @override
  String get recordGrantPermission => 'دسترسی بده';

  @override
  String recordTooShort(int min) {
    return 'کمی بیشتر نگه دار — حداقل $minث.';
  }

  @override
  String get recordCameraError => 'دوربین راه‌اندازی نشد.';

  @override
  String get previewTitle => 'ثانیهٔ تو';

  @override
  String get previewSaved => 'در دفترچه ذخیره شد.';

  @override
  String get compileFailed => 'ترکیب ناموفق بود. لطفاً دوباره تلاش کن.';

  @override
  String compilePercent(int percent) {
    return 'در حال ادغام… $percent%';
  }

  @override
  String get compileTitle => 'دفترچه‌ات را ترکیب کن';

  @override
  String get compileDateRange => 'بازهٔ تاریخ';

  @override
  String compileClips(int count, int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count کلیپ',
      one: '1 کلیپ',
      zero: 'کلیپی نیست',
    );
    return '$_temp0 · ~$secondsث';
  }

  @override
  String get compileButton => 'ترکیب ویدیو';

  @override
  String compileMerging(int current, int total) {
    return 'در حال ادغام کلیپ $current از $total…';
  }

  @override
  String get compileNoClips => 'کلیپی در این بازه نیست';

  @override
  String get playerShare => 'اشتراک‌گذاری';

  @override
  String get playerSave => 'ذخیره';

  @override
  String get playerSaved => 'در گالری ذخیره شد.';

  @override
  String get playerSaveFailed => 'در گالری ذخیره نشد.';

  @override
  String get playerShareUnavailable => 'اشتراک‌گذاری هنوز در دسترس نیست.';

  @override
  String get playerEmpty => 'فیلمی ترکیب کن تا اینجا تماشا کنی.';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get settingsSectionPersonal => 'شخصی‌سازی';

  @override
  String get settingsSectionNotifications => 'اعلان‌ها';

  @override
  String get settingsSectionRecording => 'ضبط';

  @override
  String get settingsSectionAbout => 'درباره';

  @override
  String settingsProfileStats(int clips, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      clips,
      locale: localeName,
      other: '$clips کلیپ',
      one: '1 کلیپ',
      zero: 'هنوز کلیپی نیست',
    );
    String _temp1 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'پیوستگی $streak روزه',
      one: 'پیوستگی 1 روزه',
      zero: 'پیوستگی نیست',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get settingsReminderOff => 'خاموش';

  @override
  String get settingsCustomColorsUnlocked => 'باز شده';

  @override
  String get settingsFooter => 'Dayly — زندگی‌ات، یک ثانیه یک بار.';

  @override
  String get settingsAppearance => 'ظاهر';

  @override
  String get settingsLanguage => 'زبان';

  @override
  String get settingsTheme => 'تم';

  @override
  String get settingsThemeSystem => 'سیستم';

  @override
  String get settingsThemeLight => 'روشن';

  @override
  String get settingsThemeDark => 'تاریک';

  @override
  String get settingsNavigationBarStyle => 'سبک Crystal';

  @override
  String get settingsNavigationBarStyleHint =>
      'ظاهر Crystal را تنظیم کن. فقط وقتی Crystal انتخاب شده اعمال می‌شود.';

  @override
  String get settingsNavigationBarType => 'نوار پیمایش';

  @override
  String get settingsNavigationBarTypeHint =>
      'Crystal یا نوار منحنی با دکمهٔ شناور وسط را انتخاب کن.';

  @override
  String get settingsNavTypeCrystal => 'Crystal';

  @override
  String get settingsNavTypeCurved => 'منحنی';

  @override
  String get settingsNavigationBarPreview => 'پیش‌نمایش';

  @override
  String get settingsNavigationBarPreviewHint =>
      'برای امتحان نوار، روی آیکون‌ها بزن.';

  @override
  String get settingsNavStyleBlur => 'نوار پیمایش مات';

  @override
  String get settingsNavStyleFrosted => 'نوار پیمایش یخی';

  @override
  String get settingsNavStyleFloating => 'نوار پیمایش شناور';

  @override
  String get settingsNavStyleRounded => 'نوار پیمایش گرد';

  @override
  String get settingsNavStyleModern => 'نوار پیمایش مدرن';

  @override
  String get settingsUiLibrary => 'کتابخانه UI';

  @override
  String get settingsUiLibraryHint =>
      'کتابخانه کامپوننت را زنده عوض کن — برای تست سیستم‌های طراحی.';

  @override
  String get settingsReminders => 'یادآورها';

  @override
  String get settingsDailyReminder => 'یادآور روزانه';

  @override
  String get settingsReminderTime => 'زمان یادآور';

  @override
  String get settingsReminderCustom => 'سفارشی';

  @override
  String get settingsReminderPickTime => 'زمان یادآور را انتخاب کنید';

  @override
  String get settingsReminderHour => 'ساعت';

  @override
  String get settingsReminderMinute => 'دقیقه';

  @override
  String get settingsCapture => 'ضبط';

  @override
  String get settingsDefaultDuration => 'مدت پیش‌فرض کلیپ';

  @override
  String get settingsSaveToGallery => 'ذخیره ویدیوی ترکیب‌شده در گالری';

  @override
  String settingsSeconds(int count) {
    return '$countث';
  }

  @override
  String get settingsAbout => 'درباره';

  @override
  String get settingsConnectWithDev => 'ارتباط با توسعه‌دهنده';

  @override
  String get settingsConnectWithDevHint =>
      'گیت‌هاب، اینستاگرام، تلگرام و ایمیل';

  @override
  String get settingsConnectWithDevIntro =>
      'سلام بگویید — بازخورد، ایده و گزارش باگ همیشه خوش‌آمد است.';

  @override
  String get settingsPrivacy => 'حریم خصوصی';

  @override
  String get settingsPrivacyHint =>
      'Dayly چگونه داده‌های شما را روی این دستگاه نگه می‌دارد';

  @override
  String get settingsPrivacyIntroTitle => 'دفترچه مال شماست';

  @override
  String get settingsPrivacyIntroBody =>
      'Dayly یک دفترچه ویدیویی شخصی با اولویت حریم خصوصی است. حساب کاربری، همگام‌سازی ابری و تبلیغات ندارد. هر چه ضبط می‌کنید روی گوشی شما می‌ماند مگر اینکه صادر کنید.';

  @override
  String get settingsPrivacyDataTitle => 'چه چیزی ذخیره می‌شود';

  @override
  String get settingsPrivacyDataBody =>
      'کلیپ‌ها، بندانگشتی‌ها، فیلم‌های جمع‌شده، یادداشت روزانه و تنظیمات به‌صورت محلی در حافظه خصوصی برنامه ذخیره می‌شوند. عکس‌های پس‌زمینه سفارشی در پوشه اسناد برنامه کپی می‌شوند. چیزی به سرور ما ارسال نمی‌شود.';

  @override
  String get settingsPrivacyPermissionsTitle => 'مجوزها';

  @override
  String get settingsPrivacyPermissionsBody =>
      'دوربین و میکروفون فقط هنگام ضبط درخواست می‌شوند. حافظه اگر ذخیره در گالری را فعال کنید استفاده می‌شود. اعلان‌ها اختیاری و فقط برای یادآور روزانه است. گالری فقط برای انتخاب عکس پس‌زمینه.';

  @override
  String get settingsPrivacyThirdPartyTitle => 'کتابخانه‌های شخص ثالث';

  @override
  String get settingsPrivacyThirdPartyBody =>
      'Dayly از بسته‌های متن‌باز (Flutter، ffmpeg و دیگران) استفاده می‌کند که فقط روی دستگاه شما اجرا می‌شوند. محتوای دفترچه را دریافت نمی‌کنند. فهرست کامل در «متن‌باز و سپاس» در تنظیمات.';

  @override
  String get settingsPrivacyYourControlTitle => 'کنترل شما';

  @override
  String get settingsPrivacyYourControlBody =>
      'می‌توانید کلیپ‌ها را حذف کنید، همه ضبط‌ها را پاک کنید یا تنظیمات را بازنشانی کنید. حذف برنامه همه داده‌های محلی را از دستگاه برمی‌دارد.';

  @override
  String get settingsPrivacyFooter =>
      'آخرین به‌روزرسانی: ژوئیه ۲۰۲۶ · Dayly v1.0';

  @override
  String get settingsAcknowledgements => 'متن‌باز و سپاس';

  @override
  String get settingsAcknowledgementsHint => 'پشته، وابستگی‌ها و قدردانی';

  @override
  String get settingsAcknowledgementsStackTitle => 'ساخته‌شده با متن‌باز';

  @override
  String get settingsAcknowledgementsIntro =>
      'Dayly با Flutter و اکوسیستم شگفت‌انگیز بسته‌های جامعه ساخته شده. از همه نویسندگان و نگهدارندگان سپاسگزاریم.';

  @override
  String settingsAcknowledgementsVersion(String version, String build) {
    return 'Dayly $version (ساخت $build)';
  }

  @override
  String get settingsAcknowledgementsThanks =>
      'از جامعه متن‌باز سپاسگزاریم — Dayly بدون شما وجود نداشت.';

  @override
  String get settingsAckCategoryFramework => 'فریم‌ورک';

  @override
  String get settingsAckCategoryUi => 'رابط و تایپوگرافی';

  @override
  String get settingsAckCategoryState => 'وضعیت و مسیریابی';

  @override
  String get settingsAckCategoryMedia => 'ویدیو و رسانه';

  @override
  String get settingsAckCategoryStorage => 'ذخیره‌سازی و صادرات';

  @override
  String get settingsAckCategoryNotifications => 'اعلان‌ها';

  @override
  String get settingsAckCategoryUtilities => 'ابزارها';

  @override
  String get settingsCustomColors => 'رنگ‌های سفارشی';

  @override
  String get settingsCustomColorsHint =>
      'جایزهٔ مخفی — رنگ تأکید، رنگ‌ها و عکس پس‌زمینه را تنظیم کن.';

  @override
  String get settingsCustomColorsLightHint =>
      'در حال ویرایش رنگ‌های تم روشن. برای سفارشی‌سازی رنگ‌های تاریک به تم تاریک برو.';

  @override
  String get settingsCustomColorsDarkHint =>
      'در حال ویرایش رنگ‌های تم تاریک. برای سفارشی‌سازی رنگ‌های روشن به تم روشن برو.';

  @override
  String get settingsAccentColor => 'تأکید';

  @override
  String get settingsBackgroundColor => 'پس‌زمینه';

  @override
  String get settingsBackgroundImage => 'عکس پس‌زمینه';

  @override
  String get settingsBackgroundImageHint =>
      'برای این تم یک عکس انتخاب کنید. یک لایه ملایم خوانایی متن را حفظ می‌کند.';

  @override
  String get settingsChooseBackgroundImage => 'انتخاب عکس';

  @override
  String get settingsRemoveBackgroundImage => 'حذف عکس';

  @override
  String get settingsAppFont => 'فونت برنامه';

  @override
  String get settingsAppFontHint =>
      'فارسی به‌صورت خودکار از Vazirmatn استفاده می‌کند. فونت همه زبان‌ها را اینجا تغییر دهید.';

  @override
  String get settingsFontAuto => 'خودکار';

  @override
  String get settingsFontClassic => 'کلاسیک';

  @override
  String get settingsFontVazir => 'Vazirmatn (فارسی)';

  @override
  String get settingsFontPoppins => 'Poppins';

  @override
  String get settingsFontNunito => 'Nunito';

  @override
  String get settingsFontLora => 'Lora';

  @override
  String get settingsFontSpaceGrotesk => 'Space Grotesk';

  @override
  String get settingsBoxColor => 'جعبه';

  @override
  String get settingsResetColors => 'بازنشانی به پیش‌فرض';

  @override
  String get settingsSectionReset => 'بازنشانی';

  @override
  String get settingsResetAll => 'بازنشانی همه تنظیمات';

  @override
  String get settingsResetAllHint =>
      'همه ترجیحات را به پیش‌فرض کارخانه برگردان.';

  @override
  String get settingsResetAllDetails =>
      'تم، زبان، سبک نوار پیمایش، کتابخانه UI، یادآورها، گزینه‌های ضبط و رنگ‌های سفارشی بازنشانی می‌شوند. کلیپ‌های ضبط‌شده حذف نمی‌شوند.';

  @override
  String get settingsResetAllButton => 'بازنشانی همه تنظیمات';

  @override
  String get settingsResetClips => 'حذف همه کلیپ‌ها';

  @override
  String get settingsResetClipsHint =>
      'هر ثانیه ضبط‌شده را برای همیشه از این دستگاه حذف کن.';

  @override
  String settingsResetClipsDetails(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count کلیپ روی این دستگاه ذخیره داری.',
      one: '1 کلیپ روی این دستگاه ذخیره داری.',
      zero: 'کلیپی برای حذف نیست.',
    );
    return '$_temp0';
  }

  @override
  String get settingsResetClipsConfirmTitle => 'همه کلیپ‌ها حذف شوند؟';

  @override
  String get settingsResetClipsConfirmBody =>
      'این کار قابل بازگشت نیست. هر کلیپ، تصویر بندانگشتی و ویدیوی ترکیب‌شده برای همیشه حذف می‌شود.';

  @override
  String get settingsResetClipsButton => 'حذف همه کلیپ‌ها';

  @override
  String get aboutDevTitle => 'درباره توسعه‌دهنده';

  @override
  String get aboutDevSubtitle => 'چه کسی Dayly را ساخت';

  @override
  String get aboutDevName => 'Danix';

  @override
  String get aboutDevRole => 'توسعه‌دهنده و طراح';

  @override
  String get aboutDevBio =>
      'Dayly به‌عنوان یک آزمایش کوچک شروع شد: اگر بتوانی کل یک سال را در چند دقیقه فیلم نگه داری چه؟ این اپ را ساختم تا آن مراسم گرم، سریع و کمی جادویی باشد.';

  @override
  String get aboutDevStackTitle => 'ساخته‌شده با';

  @override
  String get aboutDevStackBody =>
      'Flutter · Riverpod · دوربین دستگاه و خط لوله ffmpeg · مقدار زیادی قهوه.';

  @override
  String aboutDevVersion(String version) {
    return 'نسخه $version';
  }

  @override
  String aboutDevVersionBuild(String version, String build) {
    return 'نسخه $version ($build)';
  }

  @override
  String get aboutDevEasterEggUnlocked =>
      'پیداش کردی! رنگ‌های سفارشی و عکس پس‌زمینه الان باز شده‌اند.';

  @override
  String get commonSave => 'ذخیره';

  @override
  String get commonRetake => 'ضبط مجدد';

  @override
  String get commonCancel => 'لغو';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonBack => 'بازگشت';

  @override
  String get commonRecord => 'ضبط';
}
