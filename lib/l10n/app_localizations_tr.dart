// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Dayly';

  @override
  String get appTagline => 'Hayatın, her seferinde bir saniye.';

  @override
  String get onboardingSkip => 'Atla';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingGetStarted => 'Başla';

  @override
  String get onboardingSwipe => 'Keşfetmek için kaydır';

  @override
  String get onboardingWelcomeTitle => 'Dayly\'ye Hoş Geldin';

  @override
  String get onboardingWelcomeBody =>
      'Sıradan günleri gerçekten izleyebileceğin bir filme dönüştüren sıcak, bir saniyelik bir ritüel.';

  @override
  String get onboardingRecordTitle => 'Bir dürüst saniye yakala';

  @override
  String get onboardingRecordBody =>
      'Bugün\'ü aç, kayda bas ve tek bir gerçek an kaydet — düzenleme yok, baskı yok.';

  @override
  String get onboardingCalendarTitle => 'Takvimine göz at';

  @override
  String get onboardingCalendarBody =>
      'Klipleri oynatmak, not bırakmak ve serini büyütmek için bir güne dokun.';

  @override
  String get onboardingRemindersTitle => 'Ritimde kal';

  @override
  String get onboardingRemindersBody =>
      'Saniyeni unutmamak için Ayarlar\'dan günlük hatırlatıcıları aç.';

  @override
  String get tabNavigationLabel => 'Ana gezinme';

  @override
  String get tabCalendar => 'Takvim';

  @override
  String get tabStats => 'İstatistikler';

  @override
  String get tabToday => 'Bugün';

  @override
  String get tabCompile => 'Birleştir';

  @override
  String get tabSettings => 'Ayarlar';

  @override
  String get diaryTitle => 'Dayly';

  @override
  String get diaryRecentSection => 'Son';

  @override
  String diaryStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün',
      one: '1 gün',
      zero: 'henüz gün yok',
    );
    return 'Seri: $_temp0 🔥';
  }

  @override
  String get diaryTodayTile => 'bugün';

  @override
  String get diaryEmpty => 'Henüz an yok. İlk saniyeni kaydet.';

  @override
  String get diaryDayRecorded => 'Kaydedildi';

  @override
  String get diaryDayNotRecorded => 'Kayıt yok';

  @override
  String get diaryDayNotRecordedHint =>
      'Bu gün için henüz bir saniye kaydetmedin.';

  @override
  String diaryDayClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kayıt',
      one: '1 kayıt',
    );
    return '$_temp0';
  }

  @override
  String get diaryTapToPlay => 'Oynatmak için dokun';

  @override
  String diaryRecordedAt(String time, int seconds) {
    return '$time · ${seconds}sn\'de kaydedildi';
  }

  @override
  String get todayTitle => 'Bugün';

  @override
  String get todayRecordedTitle => 'Bugünün saniyesi kaydedildi';

  @override
  String get todayRecordedBody =>
      'Bugün için hazırsın. Ritmi sürdürmek için yarın tekrar gel.';

  @override
  String get todayUnrecordedTitle => 'Bugünün saniyesini kaydet';

  @override
  String get todayUnrecordedBody => 'Gün geçmeden bir dürüst saniye yakala.';

  @override
  String todayClipSummary(String time, int seconds) {
    return '$time · ${seconds}sn\'de kaydedildi';
  }

  @override
  String get todayRecordCta => 'Bugünü kaydet';

  @override
  String get todayRecordAgainCta => 'Bir saniye daha kaydet';

  @override
  String get dayNoteTitle => 'Bugün için bir not bırak';

  @override
  String get dayNoteHint =>
      'Günün nasıl geçtiğine dair kısa bir satır — takviminde görünür.';

  @override
  String get dayNotePlaceholder => 'Bugünü hatırlamaya değer kılan ne?';

  @override
  String get dayNoteLabel => 'Gün notu';

  @override
  String get statsTitle => 'İstatistikler ve videolar';

  @override
  String get statsClipsLabel => 'Klipler';

  @override
  String get statsDurationLabel => 'Süre';

  @override
  String get statsStreakLabel => 'Seri';

  @override
  String statsClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count klip',
      one: '1 klip',
      zero: 'Klips yok',
    );
    return '$_temp0';
  }

  @override
  String statsDuration(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: '${seconds}sn',
      one: '1sn',
      zero: '0sn',
    );
    return '$_temp0';
  }

  @override
  String get statsRecentVideos => 'Son videolar';

  @override
  String get statsEmpty => 'Birkaç saniye kaydet, videoların burada görünecek.';

  @override
  String get recordTitle => 'Gününü kaydet';

  @override
  String get recordHold => 'kaydetmek için basılı tut';

  @override
  String recordHint(int min, int max) {
    return 'en az ${min}sn · en çok ${max}sn';
  }

  @override
  String get recordDeviceOnly =>
      'Kayıt cihaz kamerasını kullanır ve Android\'de kullanılabilir.';

  @override
  String get recordPermissionDenied =>
      'Kayıt için kamera ve mikrofon erişimi gerekli.';

  @override
  String get recordGrantPermission => 'Erişim ver';

  @override
  String recordTooShort(int min) {
    return 'Biraz daha basılı tut — en az ${min}sn.';
  }

  @override
  String get recordCameraError => 'Kamera başlatılamadı.';

  @override
  String get previewTitle => 'Saniyen';

  @override
  String get previewSaved => 'Günlüğüne kaydedildi.';

  @override
  String get compileFailed => 'Birleştirme başarısız. Lütfen tekrar dene.';

  @override
  String compilePercent(int percent) {
    return 'Birleştiriliyor… %$percent';
  }

  @override
  String get compileTitle => 'Günlüğünü birleştir';

  @override
  String get compileDateRange => 'Tarih aralığı';

  @override
  String compileClips(int count, int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count klip',
      one: '1 klip',
      zero: 'Klips yok',
    );
    return '$_temp0 · ~${seconds}sn';
  }

  @override
  String get compileButton => 'Video birleştir';

  @override
  String compileMerging(int current, int total) {
    return 'Klip $current/$total birleştiriliyor…';
  }

  @override
  String get compileNoClips => 'Aralıkta klip yok';

  @override
  String get playerShare => 'Paylaş';

  @override
  String get playerSave => 'Kaydet';

  @override
  String get playerSaved => 'Galeriye kaydedildi.';

  @override
  String get playerSaveFailed => 'Galeriye kaydedilemedi.';

  @override
  String get playerShareUnavailable => 'Paylaşım henüz kullanılamıyor.';

  @override
  String get playerEmpty => 'İzlemek için bir film birleştir.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsSectionPersonal => 'Kişiselleştirme';

  @override
  String get settingsSectionNotifications => 'Bildirimler';

  @override
  String get settingsSectionRecording => 'Kayıt';

  @override
  String get settingsSectionAbout => 'Hakkında';

  @override
  String settingsProfileStats(int clips, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      clips,
      locale: localeName,
      other: '$clips klip',
      one: '1 klip',
      zero: 'Henüz klip yok',
    );
    String _temp1 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak günlük seri',
      one: '1 günlük seri',
      zero: 'seri yok',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get settingsReminderOff => 'Kapalı';

  @override
  String get settingsCustomColorsUnlocked => 'Açıldı';

  @override
  String get settingsFooter => 'Dayly — hayatın, her seferinde bir saniye.';

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistem';

  @override
  String get settingsThemeLight => 'Açık';

  @override
  String get settingsThemeDark => 'Koyu';

  @override
  String get settingsNavigationBarStyle => 'Crystal stili';

  @override
  String get settingsNavigationBarStyleHint =>
      'Crystal görünümünü ince ayarla. Yalnızca Crystal seçiliyken geçerlidir.';

  @override
  String get settingsNavigationBarType => 'Gezinme çubuğu';

  @override
  String get settingsNavigationBarTypeHint =>
      'Crystal veya ortada yüzen düğmeli kavisli çubuğu seç.';

  @override
  String get settingsNavTypeCrystal => 'Crystal';

  @override
  String get settingsNavTypeCurved => 'Kavisli';

  @override
  String get settingsNavigationBarPreview => 'Önizleme';

  @override
  String get settingsNavigationBarPreviewHint =>
      'Çubuğu denemek için simgelere dokun.';

  @override
  String get settingsNavStyleBlur => 'Bulanık gezinme çubuğu';

  @override
  String get settingsNavStyleFrosted => 'Buzlu gezinme çubuğu';

  @override
  String get settingsNavStyleFloating => 'Yüzen gezinme çubuğu';

  @override
  String get settingsNavStyleRounded => 'Yuvarlak gezinme çubuğu';

  @override
  String get settingsNavStyleModern => 'Modern gezinme çubuğu';

  @override
  String get settingsUiLibrary => 'UI kütüphanesi';

  @override
  String get settingsUiLibraryHint =>
      'Bileşen kütüphanesini canlı değiştir — tasarım sistemlerini test etmek için.';

  @override
  String get settingsReminders => 'Hatırlatıcılar';

  @override
  String get settingsDailyReminder => 'Günlük hatırlatıcı';

  @override
  String get settingsReminderTime => 'Hatırlatıcı saati';

  @override
  String get settingsReminderCustom => 'Özel';

  @override
  String get settingsReminderPickTime => 'Hatırlatıcı saati seç';

  @override
  String get settingsReminderHour => 'Saat';

  @override
  String get settingsReminderMinute => 'Dakika';

  @override
  String get settingsCapture => 'Kayıt';

  @override
  String get settingsDefaultDuration => 'Varsayılan klip süresi';

  @override
  String get settingsSaveToGallery => 'Birleştirilmiş videoyu galeriye kaydet';

  @override
  String settingsSeconds(int count) {
    return '${count}sn';
  }

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String get settingsConnectWithDev => 'Geliştiriciyle iletişim';

  @override
  String get settingsConnectWithDevHint =>
      'GitHub, Instagram, Telegram ve e-posta';

  @override
  String get settingsConnectWithDevIntro =>
      'Merhaba deyin — geri bildirim, fikirler ve hata raporları her zaman hoş karşılanır.';

  @override
  String get settingsPrivacy => 'Gizlilik';

  @override
  String get settingsPrivacyHint =>
      'Dayly bu cihazdaki verilerinizi nasıl işler';

  @override
  String get settingsPrivacyIntroTitle => 'Günlüğünüz size ait';

  @override
  String get settingsPrivacyIntroBody =>
      'Dayly gizlilik odaklı kişisel bir video günlüğüdür. Hesap, bulut senkronizasyonu veya reklam yoktur. Kaydettiğiniz her şey, dışa aktarmadıkça telefonunuzda kalır.';

  @override
  String get settingsPrivacyDataTitle => 'Ne saklıyoruz';

  @override
  String get settingsPrivacyDataBody =>
      'Klipleriniz, küçük resimler, derlenmiş filmler, gün notları ve tercihler uygulamanın özel depolamasında yerel olarak saklanır. Özel arka plan fotoğrafları uygulama belgelerine kopyalanır. Hiçbir şey sunucularımıza yüklenmez.';

  @override
  String get settingsPrivacyPermissionsTitle => 'İzinler';

  @override
  String get settingsPrivacyPermissionsBody =>
      'Kamera ve mikrofon yalnızca kayıt sırasında istenir. Galeriye kaydetme açıksa depolama kullanılır. Bildirimler isteğe bağlıdır ve yalnızca günlük hatırlatıcı içindir. Galeri yalnızca özel arka plan seçerken kullanılır.';

  @override
  String get settingsPrivacyThirdPartyTitle => 'Üçüncü taraf kütüphaneler';

  @override
  String get settingsPrivacyThirdPartyBody =>
      'Dayly yalnızca cihazınızda çalışan açık kaynak paketler (Flutter, ffmpeg vb.) kullanır. Günlük içeriğinizi almazlar. Tam liste için Ayarlar\'daki Açık kaynak ve teşekkürler bölümüne bakın.';

  @override
  String get settingsPrivacyYourControlTitle => 'Kontrolünüz';

  @override
  String get settingsPrivacyYourControlBody =>
      'Klipleri silebilir, tüm kayıtları temizleyebilir veya ayarları sıfırlayabilirsiniz. Uygulamayı kaldırmak tüm yerel günlük verilerini siler.';

  @override
  String get settingsPrivacyFooter =>
      'Son güncelleme: Temmuz 2026 · Dayly v1.0';

  @override
  String get settingsAcknowledgements => 'Açık kaynak ve teşekkürler';

  @override
  String get settingsAcknowledgementsHint =>
      'Yığın, bağımlılıklar ve minnettarlık';

  @override
  String get settingsAcknowledgementsStackTitle => 'Açık kaynakla yapıldı';

  @override
  String get settingsAcknowledgementsIntro =>
      'Dayly, Flutter ve harika topluluk paketleri ekosistemiyle yapıldı. Aşağıdaki her yazara ve maintainer\'a teşekkür ederiz.';

  @override
  String settingsAcknowledgementsVersion(String version, String build) {
    return 'Dayly $version (derleme $build)';
  }

  @override
  String get settingsAcknowledgementsThanks =>
      'Açık kaynak topluluğuna teşekkürler — Dayly siz olmasaydınız var olamazdı.';

  @override
  String get settingsAckCategoryFramework => 'Çatı';

  @override
  String get settingsAckCategoryUi => 'Arayüz ve tipografi';

  @override
  String get settingsAckCategoryState => 'Durum ve gezinme';

  @override
  String get settingsAckCategoryMedia => 'Video ve medya';

  @override
  String get settingsAckCategoryStorage => 'Depolama ve dışa aktarma';

  @override
  String get settingsAckCategoryNotifications => 'Bildirimler';

  @override
  String get settingsAckCategoryUtilities => 'Yardımcılar';

  @override
  String get settingsCustomColors => 'Özel renkler';

  @override
  String get settingsCustomColorsHint =>
      'Açılan gizli özellik — vurgu, renkler ve arka plan fotoğrafı.';

  @override
  String get settingsCustomColorsLightHint =>
      'Açık tema renkleri düzenleniyor. Koyu renkleri ayrı özelleştirmek için koyu temaya geç.';

  @override
  String get settingsCustomColorsDarkHint =>
      'Koyu tema renkleri düzenleniyor. Açık renkleri ayrı özelleştirmek için açık temaya geç.';

  @override
  String get settingsAccentColor => 'Vurgu';

  @override
  String get settingsBackgroundColor => 'Arka plan';

  @override
  String get settingsBackgroundImage => 'Arka plan fotoğrafı';

  @override
  String get settingsBackgroundImageHint =>
      'Bu tema için bir fotoğraf seçin. Hafif bir ton metni okunaklı tutar.';

  @override
  String get settingsChooseBackgroundImage => 'Fotoğraf seç';

  @override
  String get settingsRemoveBackgroundImage => 'Fotoğrafı kaldır';

  @override
  String get settingsAppFont => 'Uygulama yazı tipi';

  @override
  String get settingsAppFontHint =>
      'Farsça otomatik olarak Vazirmatn kullanır. Tüm diller için yazı tipini buradan değiştirin.';

  @override
  String get settingsFontAuto => 'Otomatik';

  @override
  String get settingsFontClassic => 'Klasik';

  @override
  String get settingsFontVazir => 'Vazirmatn (Farsça)';

  @override
  String get settingsFontPoppins => 'Poppins';

  @override
  String get settingsFontNunito => 'Nunito';

  @override
  String get settingsFontLora => 'Lora';

  @override
  String get settingsFontSpaceGrotesk => 'Space Grotesk';

  @override
  String get settingsBoxColor => 'Kutu';

  @override
  String get settingsResetColors => 'Varsayılanlara sıfırla';

  @override
  String get settingsSectionReset => 'Sıfırlama';

  @override
  String get settingsResetAll => 'Tüm ayarları sıfırla';

  @override
  String get settingsResetAllHint =>
      'Tüm tercihleri fabrika varsayılanlarına döndür.';

  @override
  String get settingsResetAllDetails =>
      'Tema, dil, gezinme çubuğu stili, UI kütüphanesi, hatırlatıcılar, kayıt seçenekleri ve özel renkler sıfırlanır. Kaydedilen klipler silinmez.';

  @override
  String get settingsResetAllButton => 'Tüm ayarları sıfırla';

  @override
  String get settingsResetClips => 'Tüm klipleri sil';

  @override
  String get settingsResetClipsHint =>
      'Bu cihazdaki kaydedilen her saniyeyi kalıcı olarak kaldır.';

  @override
  String settingsResetClipsDetails(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bu cihazda $count klip kayıtlı.',
      one: 'Bu cihazda 1 klip kayıtlı.',
      zero: 'Silinecek klip yok.',
    );
    return '$_temp0';
  }

  @override
  String get settingsResetClipsConfirmTitle => 'Tüm klipler silinsin mi?';

  @override
  String get settingsResetClipsConfirmBody =>
      'Bu geri alınamaz. Kaydedilen her klip, küçük resim ve birleştirilmiş video kalıcı olarak kaldırılacak.';

  @override
  String get settingsResetClipsButton => 'Tüm klipleri sil';

  @override
  String get aboutDevTitle => 'Geliştirici hakkında';

  @override
  String get aboutDevSubtitle => 'Dayly\'yi kim yaptı';

  @override
  String get aboutDevName => 'Danix';

  @override
  String get aboutDevRole => 'Geliştirici ve tasarımcı';

  @override
  String get aboutDevBio =>
      'Dayly küçük bir deney olarak başladı: Bir yılın tamamını birkaç dakikalık filmde tutabilir miydin? Bu uygulamayı o ritüeli sıcak, hızlı ve biraz sihirli hissettirmek için yaptım.';

  @override
  String get aboutDevStackTitle => 'Kullanılan teknolojiler';

  @override
  String get aboutDevStackBody =>
      'Flutter · Riverpod · cihaz içi kamera ve ffmpeg pipeline · bolca kahve.';

  @override
  String aboutDevVersion(String version) {
    return 'Sürüm $version';
  }

  @override
  String aboutDevVersionBuild(String version, String build) {
    return 'Sürüm $version ($build)';
  }

  @override
  String get aboutDevEasterEggUnlocked =>
      'Buldun! Özel renkler ve arka plan fotoğrafları artık açık.';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonRetake => 'Yeniden çek';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonBack => 'Geri';

  @override
  String get commonRecord => 'Kaydet';
}
