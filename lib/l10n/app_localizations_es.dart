// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Dayly';

  @override
  String get appTagline => 'Tu vida, un segundo a la vez.';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingGetStarted => 'Empezar';

  @override
  String get onboardingSwipe => 'Desliza para explorar';

  @override
  String get onboardingWelcomeTitle => 'Bienvenido a Dayly';

  @override
  String get onboardingWelcomeBody =>
      'Un ritual cálido de un segundo que convierte días ordinarios en una película que puedes ver.';

  @override
  String get onboardingRecordTitle => 'Captura un segundo honesto';

  @override
  String get onboardingRecordBody =>
      'Abre Hoy, pulsa grabar y guarda un momento real — sin editar, sin presión.';

  @override
  String get onboardingCalendarTitle => 'Explora tu calendario';

  @override
  String get onboardingCalendarBody =>
      'Toca cualquier día para ver clips, dejar una nota y seguir tu racha.';

  @override
  String get onboardingRemindersTitle => 'Mantén el ritmo';

  @override
  String get onboardingRemindersBody =>
      'Activa los recordatorios diarios en Ajustes para no olvidar tu segundo.';

  @override
  String get tabNavigationLabel => 'Navegación principal';

  @override
  String get tabCalendar => 'Calendario';

  @override
  String get tabStats => 'Estadísticas';

  @override
  String get tabToday => 'Hoy';

  @override
  String get tabCompile => 'Compilar';

  @override
  String get tabSettings => 'Ajustes';

  @override
  String get diaryTitle => 'Dayly';

  @override
  String get diaryRecentSection => 'Recientes';

  @override
  String diaryStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
      zero: 'aún sin días',
    );
    return 'Racha: $_temp0 🔥';
  }

  @override
  String get diaryTodayTile => 'hoy';

  @override
  String get diaryEmpty => 'Aún no hay momentos. Graba tu primer segundo.';

  @override
  String get diaryDayRecorded => 'Grabado';

  @override
  String get diaryDayNotRecorded => 'Sin grabación';

  @override
  String get diaryDayNotRecordedHint =>
      'Aún no has capturado un segundo para este día.';

  @override
  String diaryDayClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grabaciones',
      one: '1 grabación',
    );
    return '$_temp0';
  }

  @override
  String get diaryTapToPlay => 'Toca para reproducir';

  @override
  String diaryRecordedAt(String time, int seconds) {
    return 'Grabado a las $time · ${seconds}s';
  }

  @override
  String get todayTitle => 'Hoy';

  @override
  String get todayRecordedTitle => 'El segundo de hoy está guardado';

  @override
  String get todayRecordedBody =>
      'Ya está listo por hoy. Vuelve mañana para mantener el ritmo.';

  @override
  String get todayUnrecordedTitle => 'Graba el segundo de hoy';

  @override
  String get todayUnrecordedBody =>
      'Captura un segundo honesto antes de que termine el día.';

  @override
  String todayClipSummary(String time, int seconds) {
    return 'Grabado a las $time · ${seconds}s';
  }

  @override
  String get todayRecordCta => 'Grabar hoy';

  @override
  String get todayRecordAgainCta => 'Grabar otro segundo';

  @override
  String get dayNoteTitle => 'Deja una nota del día';

  @override
  String get dayNoteHint =>
      'Una línea sobre cómo se sintió el día — visible en el calendario.';

  @override
  String get dayNotePlaceholder => '¿Qué hizo memorable a hoy?';

  @override
  String get dayNoteLabel => 'Nota del día';

  @override
  String get statsTitle => 'Estadísticas y vídeos';

  @override
  String get statsClipsLabel => 'Clips';

  @override
  String get statsDurationLabel => 'Metraje';

  @override
  String get statsStreakLabel => 'Racha';

  @override
  String statsClipCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count clips',
      one: '1 clip',
      zero: 'Sin clips',
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
  String get statsRecentVideos => 'Vídeos recientes';

  @override
  String get statsEmpty =>
      'Graba algunos segundos y tus vídeos aparecerán aquí.';

  @override
  String get recordTitle => 'Graba tu día';

  @override
  String get recordHold => 'mantén para grabar';

  @override
  String recordHint(int min, int max) {
    return '${min}s mín · ${max}s máx';
  }

  @override
  String get recordDeviceOnly =>
      'La grabación usa la cámara del dispositivo y está disponible en Android.';

  @override
  String get recordPermissionDenied =>
      'Se necesita acceso a la cámara y al micrófono para grabar.';

  @override
  String get recordGrantPermission => 'Conceder acceso';

  @override
  String recordTooShort(int min) {
    return 'Mantén un poco más — ${min}s mínimo.';
  }

  @override
  String get recordCameraError => 'No se pudo iniciar la cámara.';

  @override
  String get previewTitle => 'Tu segundo';

  @override
  String get previewSaved => 'Guardado en tu diario.';

  @override
  String get compileFailed => 'Error al compilar. Inténtalo de nuevo.';

  @override
  String compilePercent(int percent) {
    return 'Uniendo… $percent%';
  }

  @override
  String get compileTitle => 'Compila tu diario';

  @override
  String get compileDateRange => 'Rango de fechas';

  @override
  String compileClips(int count, int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count clips',
      one: '1 clip',
      zero: 'Sin clips',
    );
    return '$_temp0 · ~${seconds}s';
  }

  @override
  String get compileButton => 'Compilar vídeo';

  @override
  String compileMerging(int current, int total) {
    return 'Uniendo clip $current de $total…';
  }

  @override
  String get compileNoClips => 'Sin clips en el rango';

  @override
  String get playerShare => 'Compartir';

  @override
  String get playerSave => 'Guardar';

  @override
  String get playerSaved => 'Guardado en la galería.';

  @override
  String get playerSaveFailed => 'No se pudo guardar en la galería.';

  @override
  String get playerShareUnavailable => 'Compartir aún no está disponible.';

  @override
  String get playerEmpty => 'Compila una película para verla aquí.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSectionPersonal => 'Personalización';

  @override
  String get settingsSectionNotifications => 'Notificaciones';

  @override
  String get settingsSectionRecording => 'Grabación';

  @override
  String get settingsSectionAbout => 'Acerca de';

  @override
  String settingsProfileStats(int clips, int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      clips,
      locale: localeName,
      other: '$clips clips',
      one: '1 clip',
      zero: 'Sin clips aún',
    );
    String _temp1 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'racha de $streak días',
      one: 'racha de 1 día',
      zero: 'sin racha',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get settingsReminderOff => 'Desactivado';

  @override
  String get settingsCustomColorsUnlocked => 'Desbloqueado';

  @override
  String get settingsFooter => 'Dayly — tu vida, un segundo a la vez.';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsNavigationBarStyle => 'Estilo Crystal';

  @override
  String get settingsNavigationBarStyleHint =>
      'Ajusta el aspecto de Crystal. Solo aplica cuando Crystal está seleccionado.';

  @override
  String get settingsNavigationBarType => 'Barra de navegación';

  @override
  String get settingsNavigationBarTypeHint =>
      'Elige Crystal o la barra curva con botón central flotante.';

  @override
  String get settingsNavTypeCrystal => 'Crystal';

  @override
  String get settingsNavTypeCurved => 'Curva';

  @override
  String get settingsNavigationBarPreview => 'Vista previa';

  @override
  String get settingsNavigationBarPreviewHint =>
      'Toca los iconos para probar la barra.';

  @override
  String get settingsNavStyleBlur => 'Barra de navegación con desenfoque';

  @override
  String get settingsNavStyleFrosted => 'Barra de navegación escarchada';

  @override
  String get settingsNavStyleFloating => 'Barra de navegación flotante';

  @override
  String get settingsNavStyleRounded => 'Barra de navegación redondeada';

  @override
  String get settingsNavStyleModern => 'Barra de navegación moderna';

  @override
  String get settingsUiLibrary => 'Librería de UI';

  @override
  String get settingsUiLibraryHint =>
      'Cambia la librería de componentes en vivo — para probar sistemas de diseño.';

  @override
  String get settingsReminders => 'Recordatorios';

  @override
  String get settingsDailyReminder => 'Recordatorio diario';

  @override
  String get settingsReminderTime => 'Hora del recordatorio';

  @override
  String get settingsReminderCustom => 'Personalizado';

  @override
  String get settingsReminderPickTime => 'Elige una hora';

  @override
  String get settingsReminderHour => 'Hora';

  @override
  String get settingsReminderMinute => 'Minuto';

  @override
  String get settingsCapture => 'Captura';

  @override
  String get settingsDefaultDuration => 'Duración del clip';

  @override
  String get settingsSaveToGallery => 'Guardar vídeo compilado en la galería';

  @override
  String settingsSeconds(int count) {
    return '${count}s';
  }

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsConnectWithDev => 'Contactar al desarrollador';

  @override
  String get settingsConnectWithDevHint =>
      'GitHub, Instagram, Telegram y correo';

  @override
  String get settingsConnectWithDevIntro =>
      'Saluda — comentarios, ideas e informes de errores siempre son bienvenidos.';

  @override
  String get settingsPrivacy => 'Privacidad';

  @override
  String get settingsPrivacyHint =>
      'Cómo Dayly trata tus datos en este dispositivo';

  @override
  String get settingsPrivacyIntroTitle => 'Tu diario es tuyo';

  @override
  String get settingsPrivacyIntroBody =>
      'Dayly es un diario de video personal con la privacidad primero. No hay cuenta, ni sincronización en la nube, ni publicidad. Todo lo que grabas permanece en tu teléfono salvo que elijas exportarlo.';

  @override
  String get settingsPrivacyDataTitle => 'Qué almacenamos';

  @override
  String get settingsPrivacyDataBody =>
      'Tus clips, miniaturas, películas compiladas, notas del día y preferencias se guardan localmente en el almacenamiento privado de la app. Las fotos de fondo personalizadas se copian a la carpeta de documentos de la app. Nada se sube a servidores nuestros.';

  @override
  String get settingsPrivacyPermissionsTitle => 'Permisos';

  @override
  String get settingsPrivacyPermissionsBody =>
      'La cámara y el micrófono solo se solicitan al grabar. El almacenamiento se usa si activas guardar videos en la galería. Las notificaciones son opcionales y solo para tu recordatorio diario. La galería solo se usa si eliges una foto de fondo.';

  @override
  String get settingsPrivacyThirdPartyTitle => 'Bibliotecas de terceros';

  @override
  String get settingsPrivacyThirdPartyBody =>
      'Dayly usa paquetes de código abierto (Flutter, ffmpeg y otros) que se ejecutan solo en tu dispositivo. No reciben el contenido de tu diario. Consulta Código abierto y agradecimientos en Ajustes.';

  @override
  String get settingsPrivacyYourControlTitle => 'Tu control';

  @override
  String get settingsPrivacyYourControlBody =>
      'Puedes borrar clips, eliminar todas las grabaciones o restablecer ajustes en cualquier momento. Desinstalar la app elimina todos los datos locales del diario.';

  @override
  String get settingsPrivacyFooter =>
      'Última actualización: julio de 2026 · Dayly v1.0';

  @override
  String get settingsAcknowledgements => 'Código abierto y agradecimientos';

  @override
  String get settingsAcknowledgementsHint => 'Stack, dependencias y gratitud';

  @override
  String get settingsAcknowledgementsStackTitle => 'Hecho con código abierto';

  @override
  String get settingsAcknowledgementsIntro =>
      'Dayly está hecho con Flutter y un ecosistema maravilloso de paquetes comunitarios. Agradecemos a cada autor y mantenedor.';

  @override
  String settingsAcknowledgementsVersion(String version, String build) {
    return 'Dayly $version (compilación $build)';
  }

  @override
  String get settingsAcknowledgementsThanks =>
      'Gracias a la comunidad open source — Dayly no existiría sin vosotros.';

  @override
  String get settingsAckCategoryFramework => 'Framework';

  @override
  String get settingsAckCategoryUi => 'UI y tipografía';

  @override
  String get settingsAckCategoryState => 'Estado y navegación';

  @override
  String get settingsAckCategoryMedia => 'Video y medios';

  @override
  String get settingsAckCategoryStorage => 'Almacenamiento y exportación';

  @override
  String get settingsAckCategoryNotifications => 'Notificaciones';

  @override
  String get settingsAckCategoryUtilities => 'Utilidades';

  @override
  String get settingsCustomColors => 'Colores personalizados';

  @override
  String get settingsCustomColorsHint =>
      'Huevo de pascua desbloqueado — ajusta acento, colores y una foto de fondo.';

  @override
  String get settingsCustomColorsLightHint =>
      'Editando colores del tema claro. Cambia al tema oscuro para personalizarlo por separado.';

  @override
  String get settingsCustomColorsDarkHint =>
      'Editando colores del tema oscuro. Cambia al tema claro para personalizarlo por separado.';

  @override
  String get settingsAccentColor => 'Acento';

  @override
  String get settingsBackgroundColor => 'Fondo';

  @override
  String get settingsBackgroundImage => 'Foto de fondo';

  @override
  String get settingsBackgroundImageHint =>
      'Elige una foto para este tema. Un tinte suave mantiene el texto legible.';

  @override
  String get settingsChooseBackgroundImage => 'Elegir foto';

  @override
  String get settingsRemoveBackgroundImage => 'Quitar foto';

  @override
  String get settingsAppFont => 'Fuente de la app';

  @override
  String get settingsAppFontHint =>
      'Persa usa Vazirmatn automáticamente. Cambia la fuente para todos los idiomas aquí.';

  @override
  String get settingsFontAuto => 'Automático';

  @override
  String get settingsFontClassic => 'Clásica';

  @override
  String get settingsFontVazir => 'Vazirmatn (persa)';

  @override
  String get settingsFontPoppins => 'Poppins';

  @override
  String get settingsFontNunito => 'Nunito';

  @override
  String get settingsFontLora => 'Lora';

  @override
  String get settingsFontSpaceGrotesk => 'Space Grotesk';

  @override
  String get settingsBoxColor => 'Caja';

  @override
  String get settingsResetColors => 'Restablecer valores';

  @override
  String get settingsSectionReset => 'Restablecer';

  @override
  String get settingsResetAll => 'Restablecer todo';

  @override
  String get settingsResetAllHint =>
      'Restaura todas las preferencias a sus valores predeterminados.';

  @override
  String get settingsResetAllDetails =>
      'Restablece tema, idioma, barra de navegación, librería de UI, recordatorios, captura y colores personalizados. Tus clips grabados no se eliminan.';

  @override
  String get settingsResetAllButton => 'Restablecer todo';

  @override
  String get settingsResetClips => 'Eliminar todos los clips';

  @override
  String get settingsResetClipsHint =>
      'Elimina permanentemente cada segundo grabado de este dispositivo.';

  @override
  String settingsResetClipsDetails(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tienes $count clips en este dispositivo.',
      one: 'Tienes 1 clip en este dispositivo.',
      zero: 'No hay clips para eliminar.',
    );
    return '$_temp0';
  }

  @override
  String get settingsResetClipsConfirmTitle => '¿Eliminar todos los clips?';

  @override
  String get settingsResetClipsConfirmBody =>
      'Esta acción no se puede deshacer. Se eliminarán permanentemente todos los clips, miniaturas y vídeos compilados.';

  @override
  String get settingsResetClipsButton => 'Eliminar todos los clips';

  @override
  String get aboutDevTitle => 'Sobre el desarrollador';

  @override
  String get aboutDevSubtitle => 'Quién creó Dayly';

  @override
  String get aboutDevName => 'Danix';

  @override
  String get aboutDevRole => 'Desarrollador y diseñador';

  @override
  String get aboutDevBio =>
      'Dayly empezó como un pequeño experimento: ¿y si pudieras guardar un año entero en unos minutos de película? Construí esta app para que ese ritual se sienta cálido, rápido y un poco mágico.';

  @override
  String get aboutDevStackTitle => 'Hecho con';

  @override
  String get aboutDevStackBody =>
      'Flutter · Riverpod · cámara y ffmpeg en el dispositivo · mucho café.';

  @override
  String aboutDevVersion(String version) {
    return 'Versión $version';
  }

  @override
  String aboutDevVersionBuild(String version, String build) {
    return 'Versión $version ($build)';
  }

  @override
  String get aboutDevEasterEggUnlocked =>
      '¡Lo encontraste! Colores personalizados y fotos de fondo desbloqueados.';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonRetake => 'Repetir';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonRecord => 'Grabar';
}
