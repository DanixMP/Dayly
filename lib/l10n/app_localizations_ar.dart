// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Dayly';

  @override
  String get appTagline => 'حياتك، ثانية واحدة في كل مرة.';

  @override
  String get onboardingSkip => 'تخطّي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingGetStarted => 'ابدأ';

  @override
  String get onboardingSwipe => 'اسحب للاستكشاف';

  @override
  String get onboardingWelcomeTitle => 'مرحبًا بك في Dayly';

  @override
  String get onboardingWelcomeBody =>
      'طقس دافئ لثانية واحدة يحوّل أيامك العادية إلى فيلم يمكنك مشاهدته.';

  @override
  String get onboardingRecordTitle => 'التقط ثانية صادقة';

  @override
  String get onboardingRecordBody =>
      'افتح اليوم، اضغط تسجيل، واحفظ لحظة حقيقية — بلا تحرير ولا ضغط.';

  @override
  String get onboardingCalendarTitle => 'تصفّح التقويم';

  @override
  String get onboardingCalendarBody =>
      'اضغط أي يوم لإعادة المقاطع وترك ملاحظة ومتابعة تتابعك.';

  @override
  String get onboardingRemindersTitle => 'حافظ على الإيقاع';

  @override
  String get onboardingRemindersBody =>
      'فعّل التذكيرات اليومية من الإعدادات حتى لا تنسى ثانيتك.';

  @override
  String get tabNavigationLabel => 'التنقل الرئيسي';

  @override
  String get tabCalendar => 'التقويم';

  @override
  String get tabStats => 'الإحصاءات';

  @override
  String get tabToday => 'اليوم';

  @override
  String get tabCompile => 'التجميع';

  @override
  String get tabSettings => 'الإعدادات';

  @override
  String get diaryTitle => 'Dayly';

  @override
  String get diaryRecentSection => 'الأحدث';

  @override
  String diaryStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أيام',
      one: 'يوم واحد',
      zero: 'لا أيام بعد',
    );
    return 'التتابع: $_temp0 🔥';
  }

  @override
  String get diaryTodayTile => 'اليوم';

  @override
  String get diaryEmpty => 'لا لحظات بعد. سجّل ثانيتك الأولى.';

  @override
  String get diaryDayRecorded => 'مُسجّل';

  @override
  String get diaryDayNotRecorded => 'لا تسجيل';

  @override
  String get diaryDayNotRecordedHint => 'لم تلتقط ثانية لهذا اليوم بعد.';

  @override
  String diaryDayClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تسجيلات',
      one: 'تسجيل واحد',
    );
    return '$_temp0';
  }

  @override
  String get diaryTapToPlay => 'اضغط للتشغيل';

  @override
  String diaryRecordedAt(String time, int seconds) {
    return 'سُجّل في $time · $secondsث';
  }

  @override
  String get todayTitle => 'اليوم';

  @override
  String get todayRecordedTitle => 'تم حفظ ثانية اليوم';

  @override
  String get todayRecordedBody =>
      'أنت جاهز لهذا اليوم. عُد غدًا للحفاظ على الإيقاع.';

  @override
  String get todayUnrecordedTitle => 'سجّل ثانية اليوم';

  @override
  String get todayUnrecordedBody => 'التقط ثانية صادقة قبل أن ينتهي اليوم.';

  @override
  String todayClipSummary(String time, int seconds) {
    return 'سُجّل في $time · $secondsث';
  }

  @override
  String get todayRecordCta => 'سجّل اليوم';

  @override
  String get todayRecordAgainCta => 'سجّل ثانية أخرى';

  @override
  String get dayNoteTitle => 'اترك ملاحظة عن اليوم';

  @override
  String get dayNoteHint => 'سطر قصير عن شعور اليوم — يظهر في التقويم.';

  @override
  String get dayNotePlaceholder => 'ما الذي جعل اليوم يستحق التذكّر؟';

  @override
  String get dayNoteLabel => 'ملاحظة اليوم';

  @override
  String get statsTitle => 'الإحصاءات والفيديوهات';

  @override
  String get statsClipsLabel => 'المقاطع';

  @override
  String get statsDurationLabel => 'المدة';

  @override
  String get statsStreakLabel => 'التتابع';

  @override
  String statsClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقاطع',
      one: 'مقطع واحد',
      zero: 'لا مقاطع',
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
  String get statsRecentVideos => 'الفيديوهات الأخيرة';

  @override
  String get statsEmpty => 'سجّل بضع ثوانٍ وستظهر فيديوهاتك هنا.';

  @override
  String get recordTitle => 'سجّل يومك';

  @override
  String get recordHold => 'اضغط مطولاً للتسجيل';

  @override
  String recordHint(int min, int max) {
    return '$minث كحد أدنى · $maxث كحد أقصى';
  }

  @override
  String get recordDeviceOnly =>
      'يستخدم التسجيل كاميرا الجهاز وهو متاح على أندرويد.';

  @override
  String get recordPermissionDenied =>
      'يلزم الوصول إلى الكاميرا والميكروفون للتسجيل.';

  @override
  String get recordGrantPermission => 'منح الإذن';

  @override
  String recordTooShort(int min) {
    return 'استمر بالضغط قليلاً — $minث كحد أدنى.';
  }

  @override
  String get recordCameraError => 'تعذّر تشغيل الكاميرا.';

  @override
  String get previewTitle => 'ثانيتك';

  @override
  String get previewSaved => 'حُفظت في مذكراتك.';

  @override
  String get compileFailed => 'فشل التجميع. حاول مرة أخرى.';

  @override
  String compilePercent(int percent) {
    return 'جارٍ الدمج… $percent%';
  }

  @override
  String get compileTitle => 'اجمع مذكراتك';

  @override
  String get compileDateRange => 'نطاق التاريخ';

  @override
  String compileClips(int count, int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقاطع',
      one: 'مقطع واحد',
      zero: 'لا مقاطع',
    );
    return '$_temp0 · ~$secondsث';
  }

  @override
  String get compileButton => 'تجميع الفيديو';

  @override
  String compileMerging(int current, int total) {
    return 'جارٍ دمج المقطع $current من $total…';
  }

  @override
  String get compileNoClips => 'لا مقاطع في النطاق';

  @override
  String get playerShare => 'مشاركة';

  @override
  String get playerSave => 'حفظ';

  @override
  String get playerSaved => 'حُفظ في المعرض.';

  @override
  String get playerSaveFailed => 'تعذّر الحفظ في المعرض.';

  @override
  String get playerShareUnavailable => 'المشاركة غير متاحة بعد.';

  @override
  String get playerEmpty => 'اجمع فيلمًا لمشاهدته هنا.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsSectionPersonal => 'التخصيص';

  @override
  String get settingsSectionNotifications => 'الإشعارات';

  @override
  String get settingsSectionRecording => 'التسجيل';

  @override
  String get settingsSectionAbout => 'حول';

  @override
  String settingsProfileStats(int clips, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      clips,
      locale: localeName,
      other: '$clips مقاطع',
      one: 'مقطع واحد',
      zero: 'لا مقاطع بعد',
    );
    String _temp1 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'تتابع $streak أيام',
      one: 'تتابع يوم واحد',
      zero: 'لا تتابع',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get settingsReminderOff => 'متوقف';

  @override
  String get settingsCustomColorsUnlocked => 'مفتوح';

  @override
  String get settingsFooter => 'Dayly — حياتك، ثانية واحدة في كل مرة.';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsTheme => 'السمة';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsNavigationBarStyle => 'نمط Crystal';

  @override
  String get settingsNavigationBarStyleHint =>
      'اضبط مظهر Crystal. ينطبق فقط عند اختيار Crystal.';

  @override
  String get settingsNavigationBarType => 'شريط التنقل';

  @override
  String get settingsNavigationBarTypeHint =>
      'اختر Crystal أو الشريط المنحني مع زر مركزي عائم.';

  @override
  String get settingsNavTypeCrystal => 'Crystal';

  @override
  String get settingsNavTypeCurved => 'منحني';

  @override
  String get settingsNavigationBarPreview => 'معاينة';

  @override
  String get settingsNavigationBarPreviewHint =>
      'اضغط الأيقونات لتجربة الشريط.';

  @override
  String get settingsNavStyleBlur => 'شريط تنقل بضبابية';

  @override
  String get settingsNavStyleFrosted => 'شريط تنقل زجاجي';

  @override
  String get settingsNavStyleFloating => 'شريط تنقل عائم';

  @override
  String get settingsNavStyleRounded => 'شريط تنقل مستدير';

  @override
  String get settingsNavStyleModern => 'شريط تنقل حديث';

  @override
  String get settingsUiLibrary => 'مكتبة الواجهة';

  @override
  String get settingsUiLibraryHint =>
      'بدّل مكتبة المكوّنات مباشرةً — لاختبار أنظمة التصميم.';

  @override
  String get settingsReminders => 'التذكيرات';

  @override
  String get settingsDailyReminder => 'تذكير يومي';

  @override
  String get settingsReminderTime => 'وقت التذكير';

  @override
  String get settingsReminderCustom => 'مخصص';

  @override
  String get settingsReminderPickTime => 'اختر وقت التذكير';

  @override
  String get settingsReminderHour => 'الساعة';

  @override
  String get settingsReminderMinute => 'الدقيقة';

  @override
  String get settingsCapture => 'التصوير';

  @override
  String get settingsDefaultDuration => 'مدة المقطع';

  @override
  String get settingsSaveToGallery => 'حفظ الفيديو المجمّع في المعرض';

  @override
  String settingsSeconds(int count) {
    return '$countث';
  }

  @override
  String get settingsAbout => 'حول';

  @override
  String get settingsConnectWithDev => 'تواصل مع المطور';

  @override
  String get settingsConnectWithDevHint =>
      'GitHub وInstagram وTelegram والبريد';

  @override
  String get settingsConnectWithDevIntro =>
      'مرحباً — الملاحظات والأفكار وتقارير الأخطاء مرحب بها دائماً.';

  @override
  String get settingsPrivacy => 'الخصوصية';

  @override
  String get settingsPrivacyHint =>
      'كيف يتعامل Dayly مع بياناتك على هذا الجهاز';

  @override
  String get settingsPrivacyIntroTitle => 'مذكراتك ملكك';

  @override
  String get settingsPrivacyIntroBody =>
      'Dayly مذكرات فيديو شخصية تُبنى على الخصوصية أولاً. لا حساب ولا مزامنة سحابية ولا إعلانات. كل ما تسجّله يبقى على هاتفك ما لم تختار تصديره.';

  @override
  String get settingsPrivacyDataTitle => 'ما نخزّنه';

  @override
  String get settingsPrivacyDataBody =>
      'مقاطعك وصورك المصغرة وأفلامك المجمّعة وملاحظات اليوم وإعدادات التطبيق تُحفظ محلياً في التخزين الخاص للتطبيق. صور الخلفية المخصصة تُنسخ إلى مجلد مستندات التطبيق. لا يُرفع شيء إلى خوادمنا.';

  @override
  String get settingsPrivacyPermissionsTitle => 'الأذونات';

  @override
  String get settingsPrivacyPermissionsBody =>
      'الكاميرا والميكروفون تُطلب فقط عند التسجيل. التخزين يُستخدم إذا فعّلت حفظ الفيديو في المعرض. الإشعارات اختيارية لتذكيرك اليومي فقط. المعرض يُستخدم فقط عند اختيار صورة خلفية.';

  @override
  String get settingsPrivacyThirdPartyTitle => 'مكتبات الطرف الثالث';

  @override
  String get settingsPrivacyThirdPartyBody =>
      'يستخدم Dayly حزماً مفتوحة المصدر (Flutter وffmpeg وغيرها) تعمل على جهازك فقط. لا تتلقى محتوى مذكراتك. راجع المصدر المفتوح والشكر في الإعدادات.';

  @override
  String get settingsPrivacyYourControlTitle => 'تحكّمك';

  @override
  String get settingsPrivacyYourControlBody =>
      'يمكنك حذف المقاطع أو كل التسجيلات أو إعادة ضبط الإعدادات في أي وقت. إزالة التطبيق تحذف كل بيانات المذكرات المحلية.';

  @override
  String get settingsPrivacyFooter => 'آخر تحديث: يوليو 2026 · Dayly v1.0';

  @override
  String get settingsAcknowledgements => 'المصدر المفتوح والشكر';

  @override
  String get settingsAcknowledgementsHint => 'المكدس والتبعيات والامتنان';

  @override
  String get settingsAcknowledgementsStackTitle => 'مبني بمصدر مفتوح';

  @override
  String get settingsAcknowledgementsIntro =>
      'صُنع Dayly بـ Flutter ونظام بيئي رائع من حزم المجتمع. شكراً لكل مؤلف ومس maintainer.';

  @override
  String settingsAcknowledgementsVersion(String version, String build) {
    return 'Dayly $version (بناء $build)';
  }

  @override
  String get settingsAcknowledgementsThanks =>
      'شكراً لمجتمع المصدر المفتوح — Dayly لما كان لوجودكم.';

  @override
  String get settingsAckCategoryFramework => 'الإطار';

  @override
  String get settingsAckCategoryUi => 'واجهة وخطوط';

  @override
  String get settingsAckCategoryState => 'الحالة والتنقل';

  @override
  String get settingsAckCategoryMedia => 'فيديو ووسائط';

  @override
  String get settingsAckCategoryStorage => 'تخزين وتصدير';

  @override
  String get settingsAckCategoryNotifications => 'إشعارات';

  @override
  String get settingsAckCategoryUtilities => 'أدوات';

  @override
  String get settingsCustomColors => 'ألوان مخصصة';

  @override
  String get settingsCustomColorsHint =>
      'بيضة عيد الفصح — اضبط التمييز والألوان وصورة الخلفية.';

  @override
  String get settingsCustomColorsLightHint =>
      'تعديل ألوان السمة الفاتحة. بدّل إلى السمة الداكنة لتخصيصها بشكل منفصل.';

  @override
  String get settingsCustomColorsDarkHint =>
      'تعديل ألوان السمة الداكنة. بدّل إلى السمة الفاتحة لتخصيصها بشكل منفصل.';

  @override
  String get settingsAccentColor => 'التمييز';

  @override
  String get settingsBackgroundColor => 'الخلفية';

  @override
  String get settingsBackgroundImage => 'صورة الخلفية';

  @override
  String get settingsBackgroundImageHint =>
      'اختر صورة لهذا المظهر. طبقة خفيفة تحافظ على وضوح النص.';

  @override
  String get settingsChooseBackgroundImage => 'اختر صورة';

  @override
  String get settingsRemoveBackgroundImage => 'إزالة الصورة';

  @override
  String get settingsAppFont => 'خط التطبيق';

  @override
  String get settingsAppFontHint =>
      'الفارسية تستخدم Vazirmatn تلقائياً. غيّر الخط لجميع اللغات من هنا.';

  @override
  String get settingsFontAuto => 'تلقائي';

  @override
  String get settingsFontClassic => 'كلاسيكي';

  @override
  String get settingsFontVazir => 'Vazirmatn (فارسي)';

  @override
  String get settingsFontPoppins => 'Poppins';

  @override
  String get settingsFontNunito => 'Nunito';

  @override
  String get settingsFontLora => 'Lora';

  @override
  String get settingsFontSpaceGrotesk => 'Space Grotesk';

  @override
  String get settingsBoxColor => 'الصندوق';

  @override
  String get settingsResetColors => 'إعادة الضبط';

  @override
  String get settingsSectionReset => 'إعادة الضبط';

  @override
  String get settingsResetAll => 'إعادة ضبط الكل';

  @override
  String get settingsResetAllHint =>
      'استعادة جميع التفضيلات إلى الإعدادات الافتراضية.';

  @override
  String get settingsResetAllDetails =>
      'يعيد ضبط السمة واللغة وشريط التنقل ومكتبة الواجهة والتذكيرات وخيارات التصوير والألوان المخصصة. لن تُحذف مقاطعك المسجّلة.';

  @override
  String get settingsResetAllButton => 'إعادة ضبط الكل';

  @override
  String get settingsResetClips => 'حذف جميع المقاطع';

  @override
  String get settingsResetClipsHint =>
      'إزالة كل ثانية مسجّلة من هذا الجهاز نهائيًا.';

  @override
  String settingsResetClipsDetails(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'لديك $count مقاطع على هذا الجهاز.',
      one: 'لديك مقطع واحد على هذا الجهاز.',
      zero: 'لا توجد مقاطع للحذف.',
    );
    return '$_temp0';
  }

  @override
  String get settingsResetClipsConfirmTitle => 'حذف جميع المقاطع؟';

  @override
  String get settingsResetClipsConfirmBody =>
      'لا يمكن التراجع عن هذا. سيتم حذف كل المقاطع والصور المصغّرة والفيديوهات المجمّعة نهائيًا.';

  @override
  String get settingsResetClipsButton => 'حذف جميع المقاطع';

  @override
  String get aboutDevTitle => 'عن المطوّر';

  @override
  String get aboutDevSubtitle => 'من بنى Dayly';

  @override
  String get aboutDevName => 'Danix';

  @override
  String get aboutDevRole => 'مطوّر ومصمم';

  @override
  String get aboutDevBio =>
      'بدأ Dayly كتجربة صغيرة: ماذا لو استطعت حفظ عام كامل في دقائق قليلة من الفيلم؟ بنيت هذا التطبيق ليجعل هذا الطقس دافئًا وسريعًا وسحريًا قليلًا.';

  @override
  String get aboutDevStackTitle => 'مبني بـ';

  @override
  String get aboutDevStackBody =>
      'Flutter · Riverpod · كاميرا وffmpeg على الجهاز · الكثير من القهوة.';

  @override
  String aboutDevVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String aboutDevVersionBuild(String version, String build) {
    return 'الإصدار $version ($build)';
  }

  @override
  String get aboutDevEasterEggUnlocked =>
      'لقد وجدتها! الألوان المخصصة وصور الخلفية أصبحت متاحة الآن.';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonRetake => 'إعادة';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonRecord => 'تسجيل';
}
