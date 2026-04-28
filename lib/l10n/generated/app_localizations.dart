import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
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
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

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
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appName.
  ///
  /// In tr, this message translates to:
  /// **'SkinCheck AI'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In tr, this message translates to:
  /// **'Cildin için AI destekli analiz'**
  String get appTagline;

  /// No description provided for @loginTitle.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get loginTitle;

  /// No description provided for @loginButton.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get loginButton;

  /// No description provided for @loginError.
  ///
  /// In tr, this message translates to:
  /// **'Giriş başarısız. Lütfen tekrar deneyin.'**
  String get loginError;

  /// No description provided for @signupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesap Oluştur'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Cilt bakım yolculuğuna başla'**
  String get signupSubtitle;

  /// No description provided for @signupFormTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get signupFormTitle;

  /// No description provided for @signupButton.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get signupButton;

  /// No description provided for @signupError.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt başarısız. Lütfen tekrar deneyin.'**
  String get signupError;

  /// No description provided for @signupPrompt.
  ///
  /// In tr, this message translates to:
  /// **'Hesabın yok mu? '**
  String get signupPrompt;

  /// No description provided for @loginPrompt.
  ///
  /// In tr, this message translates to:
  /// **'Zaten hesabın var mı? '**
  String get loginPrompt;

  /// No description provided for @signupLink.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get signupLink;

  /// No description provided for @loginLink.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get loginLink;

  /// No description provided for @orDivider.
  ///
  /// In tr, this message translates to:
  /// **'veya'**
  String get orDivider;

  /// No description provided for @nameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ad Soyad'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In tr, this message translates to:
  /// **'Adınız Soyadınız'**
  String get nameHint;

  /// No description provided for @nameRequired.
  ///
  /// In tr, this message translates to:
  /// **'İsim gerekli'**
  String get nameRequired;

  /// No description provided for @emailLabel.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In tr, this message translates to:
  /// **'ornek@email.com'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In tr, this message translates to:
  /// **'E-posta gerekli'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta girin'**
  String get emailInvalid;

  /// No description provided for @passwordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Şifre'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In tr, this message translates to:
  /// **'••••••••'**
  String get passwordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In tr, this message translates to:
  /// **'Şifre gerekli'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In tr, this message translates to:
  /// **'En az 6 karakter'**
  String get passwordMinLength;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Cildini tanı,\ngüzelliğini keşfet'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Yapay zeka destekli cilt analizi'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @startButton.
  ///
  /// In tr, this message translates to:
  /// **'Başla'**
  String get startButton;

  /// No description provided for @continueButton.
  ///
  /// In tr, this message translates to:
  /// **'Devam'**
  String get continueButton;

  /// No description provided for @skinTypeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Cilt tipin hangisi?'**
  String get skinTypeTitle;

  /// No description provided for @skinTypeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Sana özel analiz için cilt tipini seç'**
  String get skinTypeSubtitle;

  /// No description provided for @skinConcernsTitle.
  ///
  /// In tr, this message translates to:
  /// **'En çok neyi\niyileştirmek istiyorsun?'**
  String get skinConcernsTitle;

  /// No description provided for @skinConcernsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Birden fazla seçebilirsin'**
  String get skinConcernsSubtitle;

  /// No description provided for @cameraPermissionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Cilt analizin için\nkameraya ihtiyacımız var'**
  String get cameraPermissionTitle;

  /// No description provided for @cameraSecurityMessage.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğrafların güvenle saklanır'**
  String get cameraSecurityMessage;

  /// No description provided for @startAnalysisButton.
  ///
  /// In tr, this message translates to:
  /// **'Analizimi Başlat'**
  String get startAnalysisButton;

  /// No description provided for @greetingMessage.
  ///
  /// In tr, this message translates to:
  /// **'Merhaba, {name}!'**
  String greetingMessage(String name);

  /// No description provided for @defaultUserName.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı'**
  String get defaultUserName;

  /// No description provided for @morningRoutineLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sabah Rutini'**
  String get morningRoutineLabel;

  /// No description provided for @eveningRoutineLabel.
  ///
  /// In tr, this message translates to:
  /// **'Akşam Rutini'**
  String get eveningRoutineLabel;

  /// No description provided for @moreSteps.
  ///
  /// In tr, this message translates to:
  /// **'+{count} adım daha'**
  String moreSteps(int count);

  /// No description provided for @weeklyTipTitle.
  ///
  /// In tr, this message translates to:
  /// **'Haftanın İpucu'**
  String get weeklyTipTitle;

  /// No description provided for @tip1.
  ///
  /// In tr, this message translates to:
  /// **'Güneş kremi sadece yaz için değil! Kış aylarında da SPF 30+ kullanmayı ihmal etmeyin.'**
  String get tip1;

  /// No description provided for @tip2.
  ///
  /// In tr, this message translates to:
  /// **'Cildinizi temizledikten sonra 60 saniye içinde nemlendirici sürmeye özen gösterin.'**
  String get tip2;

  /// No description provided for @tip3.
  ///
  /// In tr, this message translates to:
  /// **'Haftada 2-3 kez hafif bir peeling cildinizin yenilenmesine yardımcı olur.'**
  String get tip3;

  /// No description provided for @tip4.
  ///
  /// In tr, this message translates to:
  /// **'Günde en az 2 litre su içmek cildinizin nemli ve parlak kalmasını sağlar.'**
  String get tip4;

  /// No description provided for @tip5.
  ///
  /// In tr, this message translates to:
  /// **'Yastık kılıfı haftada bir değiştirmek cilt sağlığınızı olumlu etkiler.'**
  String get tip5;

  /// No description provided for @tip6.
  ///
  /// In tr, this message translates to:
  /// **'Retinol içeren ürünleri sadece akşam rutininizde kullanın.'**
  String get tip6;

  /// No description provided for @tip7.
  ///
  /// In tr, this message translates to:
  /// **'C vitamini serumu sabah rutininize ekleyerek cildinize parlaklık kazandırın.'**
  String get tip7;

  /// No description provided for @lastAnalysisTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son Analiz'**
  String get lastAnalysisTitle;

  /// No description provided for @viewDetailsCta.
  ///
  /// In tr, this message translates to:
  /// **'Detayları gör'**
  String get viewDetailsCta;

  /// No description provided for @todayLabel.
  ///
  /// In tr, this message translates to:
  /// **'Bugün'**
  String get todayLabel;

  /// No description provided for @yesterdayLabel.
  ///
  /// In tr, this message translates to:
  /// **'1 gün önce'**
  String get yesterdayLabel;

  /// No description provided for @daysAgoLabel.
  ///
  /// In tr, this message translates to:
  /// **'{count} gün önce'**
  String daysAgoLabel(int count);

  /// No description provided for @scoreLabel.
  ///
  /// In tr, this message translates to:
  /// **'Skor'**
  String get scoreLabel;

  /// No description provided for @skinAgeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Cilt Yaşı'**
  String get skinAgeLabel;

  /// No description provided for @skinAgeDisplay.
  ///
  /// In tr, this message translates to:
  /// **'Cilt Yaşın: {age}'**
  String skinAgeDisplay(int age);

  /// No description provided for @reanalyzeButton.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Analiz Et'**
  String get reanalyzeButton;

  /// No description provided for @firstAnalysisTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlk Analizini Yap!'**
  String get firstAnalysisTitle;

  /// No description provided for @firstAnalysisDescription.
  ///
  /// In tr, this message translates to:
  /// **'Selfie çek, yapay zeka cildinizi 7 bölgede analiz etsin ve size özel bakım önerisi alsın.'**
  String get firstAnalysisDescription;

  /// No description provided for @openCameraButton.
  ///
  /// In tr, this message translates to:
  /// **'Kamerayı Aç'**
  String get openCameraButton;

  /// No description provided for @analyzeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Cildinizi yapay zeka ile analiz edin'**
  String get analyzeSubtitle;

  /// No description provided for @newAnalysisTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Analiz Başlat'**
  String get newAnalysisTitle;

  /// No description provided for @analysisDescription.
  ///
  /// In tr, this message translates to:
  /// **'Selfie çekin, AI cildinizi 7 bölgede analiz etsin'**
  String get analysisDescription;

  /// No description provided for @analysisResultsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Analiz Sonuçları'**
  String get analysisResultsTitle;

  /// No description provided for @overallScoreLabel.
  ///
  /// In tr, this message translates to:
  /// **'Genel Skor'**
  String get overallScoreLabel;

  /// No description provided for @zoneMapLabel.
  ///
  /// In tr, this message translates to:
  /// **'Bölge Haritası'**
  String get zoneMapLabel;

  /// No description provided for @createRoutineButton.
  ///
  /// In tr, this message translates to:
  /// **'Rutin Oluştur'**
  String get createRoutineButton;

  /// No description provided for @shareButton.
  ///
  /// In tr, this message translates to:
  /// **'Paylaş'**
  String get shareButton;

  /// No description provided for @analysisFailedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Analiz Başarısız'**
  String get analysisFailedTitle;

  /// No description provided for @backButton.
  ///
  /// In tr, this message translates to:
  /// **'Geri Dön'**
  String get backButton;

  /// No description provided for @analysisErrorSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Bir hata oluştu. Tekrar deneyin.'**
  String get analysisErrorSnackbar;

  /// No description provided for @recommendedProductsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Önerilen Ürünler'**
  String get recommendedProductsTitle;

  /// No description provided for @viewAllButton.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü Gör'**
  String get viewAllButton;

  /// No description provided for @cameraInitError.
  ///
  /// In tr, this message translates to:
  /// **'Kamera başlatılamadı'**
  String get cameraInitError;

  /// No description provided for @captureError.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf çekilemedi'**
  String get captureError;

  /// No description provided for @routineTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bakım Rutini'**
  String get routineTitle;

  /// No description provided for @morningTab.
  ///
  /// In tr, this message translates to:
  /// **'Sabah'**
  String get morningTab;

  /// No description provided for @eveningTab.
  ///
  /// In tr, this message translates to:
  /// **'Akşam'**
  String get eveningTab;

  /// No description provided for @emptyRoutineMessage.
  ///
  /// In tr, this message translates to:
  /// **'Bu rutin henüz oluşturulmamış.'**
  String get emptyRoutineMessage;

  /// No description provided for @addStepButton.
  ///
  /// In tr, this message translates to:
  /// **'Adım Ekle'**
  String get addStepButton;

  /// No description provided for @noAnalysisSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Önce bir cilt analizi yapmalısın!'**
  String get noAnalysisSnackbar;

  /// No description provided for @noRoutineTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz Rutin Yok'**
  String get noRoutineTitle;

  /// No description provided for @noRoutineDescription.
  ///
  /// In tr, this message translates to:
  /// **'Cilt analizine göre kişisel sabah ve akşam bakım rutinini oluştur.'**
  String get noRoutineDescription;

  /// No description provided for @addStepDialogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Adım Ekle'**
  String get addStepDialogTitle;

  /// No description provided for @productTypeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ürün Tipi'**
  String get productTypeLabel;

  /// No description provided for @stepNameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Adım Adı'**
  String get stepNameLabel;

  /// No description provided for @stepNameHint.
  ///
  /// In tr, this message translates to:
  /// **'Örn: Yüz yıkama'**
  String get stepNameHint;

  /// No description provided for @stepReasonLabel.
  ///
  /// In tr, this message translates to:
  /// **'Neden Gerekli?'**
  String get stepReasonLabel;

  /// No description provided for @stepReasonHint.
  ///
  /// In tr, this message translates to:
  /// **'Örn: Gözenekleri temizler'**
  String get stepReasonHint;

  /// No description provided for @cancelButton.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get cancelButton;

  /// No description provided for @addButton.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get addButton;

  /// No description provided for @addStepSheetTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rutinine Yeni Adım'**
  String get addStepSheetTitle;

  /// No description provided for @addStepSheetSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu ürünün ne işe yaradığını, nasıl uygulanacağını ve seni ne bekleyen sonuçları keşfet.'**
  String get addStepSheetSubtitle;

  /// No description provided for @whatIsItLabel.
  ///
  /// In tr, this message translates to:
  /// **'Nedir?'**
  String get whatIsItLabel;

  /// No description provided for @howToApplyLabel.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl uygulanır?'**
  String get howToApplyLabel;

  /// No description provided for @expectedResultsLabel.
  ///
  /// In tr, this message translates to:
  /// **'Seni bekleyen sonuçlar'**
  String get expectedResultsLabel;

  /// No description provided for @bestTimeLabel.
  ///
  /// In tr, this message translates to:
  /// **'En iyi zaman'**
  String get bestTimeLabel;

  /// No description provided for @durationLabel.
  ///
  /// In tr, this message translates to:
  /// **'Süre'**
  String get durationLabel;

  /// No description provided for @addToRoutineButton.
  ///
  /// In tr, this message translates to:
  /// **'Rutinime Ekle'**
  String get addToRoutineButton;

  /// No description provided for @notesOptionalLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kişisel not (opsiyonel)'**
  String get notesOptionalLabel;

  /// No description provided for @notesOptionalHint.
  ///
  /// In tr, this message translates to:
  /// **'Örn: Bi\'taraf marka, akşamları kullanıyorum'**
  String get notesOptionalHint;

  /// No description provided for @stepNameOptionalHelper.
  ///
  /// In tr, this message translates to:
  /// **'Adım adını özelleştir — boş bırakırsan ürün tipi kullanılır'**
  String get stepNameOptionalHelper;

  /// No description provided for @defaultReasonTemplate.
  ///
  /// In tr, this message translates to:
  /// **'{type} cildiniz için önerilir.'**
  String defaultReasonTemplate(String type);

  /// No description provided for @cleanserType.
  ///
  /// In tr, this message translates to:
  /// **'Temizleyici'**
  String get cleanserType;

  /// No description provided for @tonerType.
  ///
  /// In tr, this message translates to:
  /// **'Tonik'**
  String get tonerType;

  /// No description provided for @serumType.
  ///
  /// In tr, this message translates to:
  /// **'Serum'**
  String get serumType;

  /// No description provided for @moisturizerType.
  ///
  /// In tr, this message translates to:
  /// **'Nemlendirici'**
  String get moisturizerType;

  /// No description provided for @sunscreenType.
  ///
  /// In tr, this message translates to:
  /// **'Güneş Kremi'**
  String get sunscreenType;

  /// No description provided for @eyeCreamType.
  ///
  /// In tr, this message translates to:
  /// **'Göz Kremi'**
  String get eyeCreamType;

  /// No description provided for @maskType.
  ///
  /// In tr, this message translates to:
  /// **'Maske'**
  String get maskType;

  /// No description provided for @exfoliantType.
  ///
  /// In tr, this message translates to:
  /// **'Peeling'**
  String get exfoliantType;

  /// No description provided for @oilType.
  ///
  /// In tr, this message translates to:
  /// **'Yağ'**
  String get oilType;

  /// No description provided for @retinolType.
  ///
  /// In tr, this message translates to:
  /// **'Retinol'**
  String get retinolType;

  /// No description provided for @progressTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme'**
  String get progressTitle;

  /// No description provided for @noProgressTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz ilerleme verisi yok'**
  String get noProgressTitle;

  /// No description provided for @noProgressDescription.
  ///
  /// In tr, this message translates to:
  /// **'İlk cilt analizini yaparak ilerleme\ntakibine başla!'**
  String get noProgressDescription;

  /// No description provided for @analyzeButton.
  ///
  /// In tr, this message translates to:
  /// **'Analiz Yap'**
  String get analyzeButton;

  /// No description provided for @analysisCountLabel.
  ///
  /// In tr, this message translates to:
  /// **'Analiz'**
  String get analysisCountLabel;

  /// No description provided for @comparisonTitle.
  ///
  /// In tr, this message translates to:
  /// **'Değişim Karşılaştırması'**
  String get comparisonTitle;

  /// No description provided for @beforeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Önce'**
  String get beforeLabel;

  /// No description provided for @afterLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sonra'**
  String get afterLabel;

  /// No description provided for @scoreDisplay.
  ///
  /// In tr, this message translates to:
  /// **'Skor: {score}'**
  String scoreDisplay(String score);

  /// No description provided for @weeklyProgress.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık İlerleme'**
  String get weeklyProgress;

  /// No description provided for @profileTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @profileLoadError.
  ///
  /// In tr, this message translates to:
  /// **'Profil yüklenemedi'**
  String get profileLoadError;

  /// No description provided for @userNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı bulunamadı'**
  String get userNotFound;

  /// No description provided for @editProfileMenu.
  ///
  /// In tr, this message translates to:
  /// **'Profili Düzenle'**
  String get editProfileMenu;

  /// No description provided for @settingsMenu.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsMenu;

  /// No description provided for @logoutMenu.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış Yap'**
  String get logoutMenu;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış Yap'**
  String get logoutDialogTitle;

  /// No description provided for @logoutConfirmation.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış yapmak istediğinize emin misiniz?'**
  String get logoutConfirmation;

  /// No description provided for @editProfileTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profili Düzenle'**
  String get editProfileTitle;

  /// No description provided for @emailReadOnlyHelper.
  ///
  /// In tr, this message translates to:
  /// **'E-postayı değiştirmek için destekle iletişime geçin'**
  String get emailReadOnlyHelper;

  /// No description provided for @changePasswordButton.
  ///
  /// In tr, this message translates to:
  /// **'Şifre Değiştir'**
  String get changePasswordButton;

  /// No description provided for @changePasswordTitle.
  ///
  /// In tr, this message translates to:
  /// **'Şifre Değiştir'**
  String get changePasswordTitle;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Mevcut Şifre'**
  String get currentPasswordLabel;

  /// No description provided for @newPasswordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Şifre'**
  String get newPasswordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Şifre (Tekrar)'**
  String get confirmPasswordLabel;

  /// No description provided for @passwordMismatchError.
  ///
  /// In tr, this message translates to:
  /// **'Şifreler eşleşmiyor'**
  String get passwordMismatchError;

  /// No description provided for @passwordWeakError.
  ///
  /// In tr, this message translates to:
  /// **'Şifre en az 8 karakter, bir büyük harf, bir küçük harf ve bir rakam içermeli'**
  String get passwordWeakError;

  /// No description provided for @passwordChangedSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Şifreniz güncellendi'**
  String get passwordChangedSnackbar;

  /// No description provided for @currentPasswordIncorrectError.
  ///
  /// In tr, this message translates to:
  /// **'Mevcut şifre yanlış'**
  String get currentPasswordIncorrectError;

  /// No description provided for @passwordUpdateError.
  ///
  /// In tr, this message translates to:
  /// **'Şifre güncellenemedi. Tekrar deneyin.'**
  String get passwordUpdateError;

  /// No description provided for @updateButton.
  ///
  /// In tr, this message translates to:
  /// **'Güncelle'**
  String get updateButton;

  /// No description provided for @nameEmptyError.
  ///
  /// In tr, this message translates to:
  /// **'İsim boş olamaz'**
  String get nameEmptyError;

  /// No description provided for @emailInvalidEdit.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta giriniz'**
  String get emailInvalidEdit;

  /// No description provided for @saveButton.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get saveButton;

  /// No description provided for @profileUpdated.
  ///
  /// In tr, this message translates to:
  /// **'Profil güncellendi'**
  String get profileUpdated;

  /// No description provided for @profileUpdateError.
  ///
  /// In tr, this message translates to:
  /// **'Profil güncellenemedi'**
  String get profileUpdateError;

  /// No description provided for @totalAnalysesLabel.
  ///
  /// In tr, this message translates to:
  /// **'Toplam Analiz'**
  String get totalAnalysesLabel;

  /// No description provided for @membershipDateLabel.
  ///
  /// In tr, this message translates to:
  /// **'Üyelik Tarihi'**
  String get membershipDateLabel;

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @themeSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tema'**
  String get themeSectionTitle;

  /// No description provided for @notificationsSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get notificationsSectionTitle;

  /// No description provided for @routineReminderLabel.
  ///
  /// In tr, this message translates to:
  /// **'Rutin Hatırlatma'**
  String get routineReminderLabel;

  /// No description provided for @reminderTimeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Hatırlatma Saati'**
  String get reminderTimeLabel;

  /// No description provided for @subscriptionSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Abonelik'**
  String get subscriptionSectionTitle;

  /// No description provided for @currentPlanLabel.
  ///
  /// In tr, this message translates to:
  /// **'Mevcut Plan'**
  String get currentPlanLabel;

  /// No description provided for @proPlanLabel.
  ///
  /// In tr, this message translates to:
  /// **'Pro'**
  String get proPlanLabel;

  /// No description provided for @freePlanLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsiz'**
  String get freePlanLabel;

  /// No description provided for @manageSubscriptionLabel.
  ///
  /// In tr, this message translates to:
  /// **'Aboneliği Yönet'**
  String get manageSubscriptionLabel;

  /// No description provided for @accountSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesap'**
  String get accountSectionTitle;

  /// No description provided for @exportDataLabel.
  ///
  /// In tr, this message translates to:
  /// **'Verilerimi Dışa Aktar'**
  String get exportDataLabel;

  /// No description provided for @deleteAccountLabel.
  ///
  /// In tr, this message translates to:
  /// **'Hesabımı Sil'**
  String get deleteAccountLabel;

  /// No description provided for @aboutSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hakkında'**
  String get aboutSectionTitle;

  /// No description provided for @versionLabel.
  ///
  /// In tr, this message translates to:
  /// **'Versiyon'**
  String get versionLabel;

  /// No description provided for @privacyPolicyLabel.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Politikası'**
  String get privacyPolicyLabel;

  /// No description provided for @termsOfUseLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım Koşulları'**
  String get termsOfUseLabel;

  /// No description provided for @licensesLabel.
  ///
  /// In tr, this message translates to:
  /// **'Lisanslar'**
  String get licensesLabel;

  /// No description provided for @systemTheme.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In tr, this message translates to:
  /// **'Açık'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In tr, this message translates to:
  /// **'Koyu'**
  String get darkTheme;

  /// No description provided for @preparingData.
  ///
  /// In tr, this message translates to:
  /// **'Veriler hazırlanıyor...'**
  String get preparingData;

  /// No description provided for @dataExportFailed.
  ///
  /// In tr, this message translates to:
  /// **'Veriler dışa aktarılamadı'**
  String get dataExportFailed;

  /// No description provided for @deletingAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesap siliniyor...'**
  String get deletingAccount;

  /// No description provided for @accountDeletionFailed.
  ///
  /// In tr, this message translates to:
  /// **'Hesap silinemedi. Tekrar deneyin.'**
  String get accountDeletionFailed;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesabını Sil'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem geri alınamaz. Tüm verilerin, analizlerin ve fotoğrafların kalıcı olarak silinecek.'**
  String get deleteAccountWarning;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Evet, Hesabımı Sil'**
  String get deleteAccountConfirm;

  /// No description provided for @cancelAction.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get cancelAction;

  /// No description provided for @proUpgradeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Pro\'ya Geç'**
  String get proUpgradeTitle;

  /// No description provided for @proUpgradeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Cilt bakım yolculuğunu bir üst seviyeye taşıyın'**
  String get proUpgradeSubtitle;

  /// No description provided for @yearlyPlan.
  ///
  /// In tr, this message translates to:
  /// **'Yıllık'**
  String get yearlyPlan;

  /// No description provided for @yearlyPeriod.
  ///
  /// In tr, this message translates to:
  /// **'/yıl'**
  String get yearlyPeriod;

  /// No description provided for @yearlyDiscount.
  ///
  /// In tr, this message translates to:
  /// **'%30 tasarruf'**
  String get yearlyDiscount;

  /// No description provided for @monthlyPlan.
  ///
  /// In tr, this message translates to:
  /// **'Aylık'**
  String get monthlyPlan;

  /// No description provided for @monthlyPeriod.
  ///
  /// In tr, this message translates to:
  /// **'/ay'**
  String get monthlyPeriod;

  /// No description provided for @freeTrialButton.
  ///
  /// In tr, this message translates to:
  /// **'7 Gün Ücretsiz Dene'**
  String get freeTrialButton;

  /// No description provided for @restorePurchase.
  ///
  /// In tr, this message translates to:
  /// **'Satın almayı geri yükle'**
  String get restorePurchase;

  /// No description provided for @privacyLink.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik'**
  String get privacyLink;

  /// No description provided for @termsLink.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım Koşulları'**
  String get termsLink;

  /// No description provided for @proFeature.
  ///
  /// In tr, this message translates to:
  /// **'Pro özelliği'**
  String get proFeature;

  /// No description provided for @productCatalogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ürün Kataloğu'**
  String get productCatalogTitle;

  /// No description provided for @productsLoadError.
  ///
  /// In tr, this message translates to:
  /// **'Ürünler yüklenirken hata oluştu'**
  String get productsLoadError;

  /// No description provided for @retryButton.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get retryButton;

  /// No description provided for @noMatchingProducts.
  ///
  /// In tr, this message translates to:
  /// **'Sorunlarınıza uygun ürün bulunamadı'**
  String get noMatchingProducts;

  /// No description provided for @noProductsAdded.
  ///
  /// In tr, this message translates to:
  /// **'Henüz ürün eklenmemiş'**
  String get noProductsAdded;

  /// No description provided for @buyButton.
  ///
  /// In tr, this message translates to:
  /// **'Satın Al'**
  String get buyButton;

  /// No description provided for @whyProductTitle.
  ///
  /// In tr, this message translates to:
  /// **'Neden {name}?'**
  String whyProductTitle(String name);

  /// No description provided for @matchingConcerns.
  ///
  /// In tr, this message translates to:
  /// **'Eşleşen Sorunlar'**
  String get matchingConcerns;

  /// No description provided for @closeButton.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get closeButton;

  /// No description provided for @acneConcern.
  ///
  /// In tr, this message translates to:
  /// **'Akne'**
  String get acneConcern;

  /// No description provided for @wrinklesConcern.
  ///
  /// In tr, this message translates to:
  /// **'Kırışıklık'**
  String get wrinklesConcern;

  /// No description provided for @spotsConcern.
  ///
  /// In tr, this message translates to:
  /// **'Leke'**
  String get spotsConcern;

  /// No description provided for @poresConcern.
  ///
  /// In tr, this message translates to:
  /// **'Gözenek'**
  String get poresConcern;

  /// No description provided for @drynessConcern.
  ///
  /// In tr, this message translates to:
  /// **'Kuruluk'**
  String get drynessConcern;

  /// No description provided for @oilinessConcern.
  ///
  /// In tr, this message translates to:
  /// **'Yağlanma'**
  String get oilinessConcern;

  /// No description provided for @darkCirclesConcern.
  ///
  /// In tr, this message translates to:
  /// **'Koyu Halka'**
  String get darkCirclesConcern;

  /// No description provided for @rednessConcern.
  ///
  /// In tr, this message translates to:
  /// **'Kızarıklık'**
  String get rednessConcern;

  /// No description provided for @shareTitle.
  ///
  /// In tr, this message translates to:
  /// **'Paylaş'**
  String get shareTitle;

  /// No description provided for @instagramOption.
  ///
  /// In tr, this message translates to:
  /// **'Instagram'**
  String get instagramOption;

  /// No description provided for @whatsappOption.
  ///
  /// In tr, this message translates to:
  /// **'WhatsApp'**
  String get whatsappOption;

  /// No description provided for @otherOption.
  ///
  /// In tr, this message translates to:
  /// **'Diğer'**
  String get otherOption;

  /// No description provided for @homeNavLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfa'**
  String get homeNavLabel;

  /// No description provided for @analyzeNavLabel.
  ///
  /// In tr, this message translates to:
  /// **'Analiz'**
  String get analyzeNavLabel;

  /// No description provided for @progressNavLabel.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme'**
  String get progressNavLabel;

  /// No description provided for @routineNavLabel.
  ///
  /// In tr, this message translates to:
  /// **'Rutin'**
  String get routineNavLabel;

  /// No description provided for @profileNavLabel.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get profileNavLabel;

  /// No description provided for @morningNotificationTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sabah Rutinin Hazır ☀️'**
  String get morningNotificationTitle;

  /// No description provided for @morningNotificationBody.
  ///
  /// In tr, this message translates to:
  /// **'Güne bakımlı başla! Sabah rutinine göz at.'**
  String get morningNotificationBody;

  /// No description provided for @eveningNotificationTitle.
  ///
  /// In tr, this message translates to:
  /// **'Akşam Rutini Zamanı 🌙'**
  String get eveningNotificationTitle;

  /// No description provided for @eveningNotificationBody.
  ///
  /// In tr, this message translates to:
  /// **'Günü temiz bitir! Akşam bakım rutinine başla.'**
  String get eveningNotificationBody;

  /// No description provided for @weeklyAnalysisTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta analizini yaptın mı?'**
  String get weeklyAnalysisTitle;

  /// No description provided for @weeklyAnalysisBody.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık analizini yap ve ilerlemeyi takip et!'**
  String get weeklyAnalysisBody;

  /// No description provided for @routineRemindersChannel.
  ///
  /// In tr, this message translates to:
  /// **'Rutin Hatırlatmaları'**
  String get routineRemindersChannel;

  /// No description provided for @routineRemindersChannelDesc.
  ///
  /// In tr, this message translates to:
  /// **'Günlük cilt bakım rutini hatırlatmaları'**
  String get routineRemindersChannelDesc;

  /// No description provided for @weeklyAnalysisChannel.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık Analiz Hatırlatması'**
  String get weeklyAnalysisChannel;

  /// No description provided for @weeklyAnalysisChannelDesc.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık cilt analizi hatırlatması'**
  String get weeklyAnalysisChannelDesc;

  /// No description provided for @errorDisplay.
  ///
  /// In tr, this message translates to:
  /// **'Hata: {error}'**
  String errorDisplay(String error);

  /// No description provided for @zoneAnalysisTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bölge Analizi'**
  String get zoneAnalysisTitle;

  /// No description provided for @tapZonesForDetails.
  ///
  /// In tr, this message translates to:
  /// **'Detaylar için bölgelere dokunun'**
  String get tapZonesForDetails;

  /// No description provided for @detectedConcerns.
  ///
  /// In tr, this message translates to:
  /// **'Tespit Edilen Sorunlar'**
  String get detectedConcerns;

  /// No description provided for @recommendationsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Öneriler'**
  String get recommendationsTitle;

  /// No description provided for @severityLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ciddiyet'**
  String get severityLabel;

  /// No description provided for @zoneForehead.
  ///
  /// In tr, this message translates to:
  /// **'Alın'**
  String get zoneForehead;

  /// No description provided for @zoneLeftCheek.
  ///
  /// In tr, this message translates to:
  /// **'Sol Yanak'**
  String get zoneLeftCheek;

  /// No description provided for @zoneRightCheek.
  ///
  /// In tr, this message translates to:
  /// **'Sağ Yanak'**
  String get zoneRightCheek;

  /// No description provided for @zoneNose.
  ///
  /// In tr, this message translates to:
  /// **'Burun'**
  String get zoneNose;

  /// No description provided for @zoneChin.
  ///
  /// In tr, this message translates to:
  /// **'Çene'**
  String get zoneChin;

  /// No description provided for @zoneUnderEyes.
  ///
  /// In tr, this message translates to:
  /// **'Göz Altı'**
  String get zoneUnderEyes;

  /// No description provided for @zoneJawline.
  ///
  /// In tr, this message translates to:
  /// **'Çene Hattı'**
  String get zoneJawline;

  /// No description provided for @concernDryness.
  ///
  /// In tr, this message translates to:
  /// **'Kuruluk'**
  String get concernDryness;

  /// No description provided for @concernOiliness.
  ///
  /// In tr, this message translates to:
  /// **'Yağlılık'**
  String get concernOiliness;

  /// No description provided for @concernAcne.
  ///
  /// In tr, this message translates to:
  /// **'Akne'**
  String get concernAcne;

  /// No description provided for @concernWrinkles.
  ///
  /// In tr, this message translates to:
  /// **'Kırışıklık'**
  String get concernWrinkles;

  /// No description provided for @concernFinelines.
  ///
  /// In tr, this message translates to:
  /// **'İnce Çizgiler'**
  String get concernFinelines;

  /// No description provided for @concernSpots.
  ///
  /// In tr, this message translates to:
  /// **'Lekeler'**
  String get concernSpots;

  /// No description provided for @concernPores.
  ///
  /// In tr, this message translates to:
  /// **'Gözenekler'**
  String get concernPores;

  /// No description provided for @concernRedness.
  ///
  /// In tr, this message translates to:
  /// **'Kızarıklık'**
  String get concernRedness;

  /// No description provided for @concernDarkCircles.
  ///
  /// In tr, this message translates to:
  /// **'Göz Altı Morluğu'**
  String get concernDarkCircles;

  /// No description provided for @concernUnevenTone.
  ///
  /// In tr, this message translates to:
  /// **'Dengesiz Ton'**
  String get concernUnevenTone;

  /// No description provided for @concernSagging.
  ///
  /// In tr, this message translates to:
  /// **'Sarkma'**
  String get concernSagging;

  /// No description provided for @concernSensitivity.
  ///
  /// In tr, this message translates to:
  /// **'Hassasiyet'**
  String get concernSensitivity;

  /// No description provided for @concernDehydration.
  ///
  /// In tr, this message translates to:
  /// **'Dehidrasyon'**
  String get concernDehydration;

  /// No description provided for @concernHyperpigmentation.
  ///
  /// In tr, this message translates to:
  /// **'Hiperpigmentasyon'**
  String get concernHyperpigmentation;

  /// No description provided for @concernTexture.
  ///
  /// In tr, this message translates to:
  /// **'Doku'**
  String get concernTexture;

  /// No description provided for @deleteStepTitle.
  ///
  /// In tr, this message translates to:
  /// **'Adımı Sil'**
  String get deleteStepTitle;

  /// No description provided for @deleteStepConfirmation.
  ///
  /// In tr, this message translates to:
  /// **'Bu adımı silmek istediğinize emin misiniz?'**
  String get deleteStepConfirmation;

  /// No description provided for @deleteButton.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get deleteButton;

  /// No description provided for @productsComingSoon.
  ///
  /// In tr, this message translates to:
  /// **'Yakında ürün önerileri eklenecek'**
  String get productsComingSoon;

  /// No description provided for @scoreTrendTitle.
  ///
  /// In tr, this message translates to:
  /// **'Skor Trendi'**
  String get scoreTrendTitle;

  /// No description provided for @secondAnalysisInfoTitle.
  ///
  /// In tr, this message translates to:
  /// **'2. Analizini Yap!'**
  String get secondAnalysisInfoTitle;

  /// No description provided for @secondAnalysisInfoDescription.
  ///
  /// In tr, this message translates to:
  /// **'Karşılaştırma, ilerleme grafiği ve en çok gelişen bölge gibi özellikler 2. analizden sonra aktif olur.'**
  String get secondAnalysisInfoDescription;

  /// No description provided for @startSecondAnalysisButton.
  ///
  /// In tr, this message translates to:
  /// **'Analiz Yap'**
  String get startSecondAnalysisButton;

  /// No description provided for @pastAnalysesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Geçmiş Analizler'**
  String get pastAnalysesTitle;

  /// No description provided for @analysisDetailTitle.
  ///
  /// In tr, this message translates to:
  /// **'Analiz Detayı'**
  String get analysisDetailTitle;

  /// No description provided for @landingHeroTitle.
  ///
  /// In tr, this message translates to:
  /// **'Cildini AI ile\nAnaliz Et'**
  String get landingHeroTitle;

  /// No description provided for @landingHeroDescription.
  ///
  /// In tr, this message translates to:
  /// **'Yapay zekâ destekli cilt analizi ile cildin hakkında detaylı bilgi al, kişisel bakım rutini oluştur.'**
  String get landingHeroDescription;

  /// No description provided for @getStartedButton.
  ///
  /// In tr, this message translates to:
  /// **'Hemen Başla'**
  String get getStartedButton;

  /// No description provided for @appStoreBadge.
  ///
  /// In tr, this message translates to:
  /// **'App Store'**
  String get appStoreBadge;

  /// No description provided for @googlePlayBadge.
  ///
  /// In tr, this message translates to:
  /// **'Google Play'**
  String get googlePlayBadge;

  /// No description provided for @featuredFeaturesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Öne Çıkan Özellikler'**
  String get featuredFeaturesTitle;

  /// No description provided for @featuredFeaturesSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Cilt bakımında yapay zekâ devrimini keşfet'**
  String get featuredFeaturesSubtitle;

  /// No description provided for @aiAnalysisFeatureTitle.
  ///
  /// In tr, this message translates to:
  /// **'AI Cilt Analizi'**
  String get aiAnalysisFeatureTitle;

  /// No description provided for @aiAnalysisFeatureDesc.
  ///
  /// In tr, this message translates to:
  /// **'Yapay zekâ yüzünü 7 bölgede analiz eder ve detaylı skor verir.'**
  String get aiAnalysisFeatureDesc;

  /// No description provided for @personalRoutineFeatureTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kişisel Rutin'**
  String get personalRoutineFeatureTitle;

  /// No description provided for @personalRoutineFeatureDesc.
  ///
  /// In tr, this message translates to:
  /// **'Cilt tipine ve sorunlarına özel sabah/akşam bakım rutini oluşturur.'**
  String get personalRoutineFeatureDesc;

  /// No description provided for @progressTrackingFeatureTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme Takibi'**
  String get progressTrackingFeatureTitle;

  /// No description provided for @progressTrackingFeatureDesc.
  ///
  /// In tr, this message translates to:
  /// **'Zaman içindeki cilt değişimini grafiklerle takip et.'**
  String get progressTrackingFeatureDesc;

  /// No description provided for @productRecsFeatureTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ürün Önerileri'**
  String get productRecsFeatureTitle;

  /// No description provided for @productRecsFeatureDesc.
  ///
  /// In tr, this message translates to:
  /// **'Cilt sorunlarına uygun ürün önerileri al, hemen satın al.'**
  String get productRecsFeatureDesc;

  /// No description provided for @howItWorksTitle.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl Çalışır?'**
  String get howItWorksTitle;

  /// No description provided for @howItWorksSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'3 basit adımda cilt analizini tamamla'**
  String get howItWorksSubtitle;

  /// No description provided for @step1Title.
  ///
  /// In tr, this message translates to:
  /// **'Selfie Çek'**
  String get step1Title;

  /// No description provided for @step1Desc.
  ///
  /// In tr, this message translates to:
  /// **'Ön kameranı kullanarak hızlıca bir selfie çek.'**
  String get step1Desc;

  /// No description provided for @step2Title.
  ///
  /// In tr, this message translates to:
  /// **'AI Analiz'**
  String get step2Title;

  /// No description provided for @step2Desc.
  ///
  /// In tr, this message translates to:
  /// **'Yapay zekâ cildini 7 farklı bölgede analiz eder.'**
  String get step2Desc;

  /// No description provided for @step3Title.
  ///
  /// In tr, this message translates to:
  /// **'Rutin Al'**
  String get step3Title;

  /// No description provided for @step3Desc.
  ///
  /// In tr, this message translates to:
  /// **'Kişiselleştirilmiş bakım rutinini hemen uygula.'**
  String get step3Desc;

  /// No description provided for @relatedRoutineSteps.
  ///
  /// In tr, this message translates to:
  /// **'İlgili Rutin Adımları'**
  String get relatedRoutineSteps;

  /// No description provided for @morningReminderLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sabah Hatırlatma Saati'**
  String get morningReminderLabel;

  /// No description provided for @eveningReminderLabel.
  ///
  /// In tr, this message translates to:
  /// **'Akşam Hatırlatma Saati'**
  String get eveningReminderLabel;

  /// No description provided for @streakNotificationLabel.
  ///
  /// In tr, this message translates to:
  /// **'Seri Bildirimleri'**
  String get streakNotificationLabel;

  /// No description provided for @motivationalNotificationLabel.
  ///
  /// In tr, this message translates to:
  /// **'Motivasyon Mesajları'**
  String get motivationalNotificationLabel;

  /// No description provided for @weeklyReminderDayLabel.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık Analiz Günü'**
  String get weeklyReminderDayLabel;

  /// No description provided for @guidedModeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rehberli Mod'**
  String get guidedModeTitle;

  /// No description provided for @nextStepButton.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki Adım'**
  String get nextStepButton;

  /// No description provided for @completeRoutineButton.
  ///
  /// In tr, this message translates to:
  /// **'Rutini Tamamla'**
  String get completeRoutineButton;

  /// No description provided for @whyThisStep.
  ///
  /// In tr, this message translates to:
  /// **'Neden bu adım?'**
  String get whyThisStep;

  /// No description provided for @howToApply.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl Uygulanır?'**
  String get howToApply;

  /// No description provided for @guidedModeComplete.
  ///
  /// In tr, this message translates to:
  /// **'Tebrikler! Rutinini tamamladın!'**
  String get guidedModeComplete;

  /// No description provided for @updateRoutineTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rutinini Güncelle'**
  String get updateRoutineTitle;

  /// No description provided for @updateRoutinePrompt.
  ///
  /// In tr, this message translates to:
  /// **'Yeni analiz sonucuna göre rutininde değişiklikler var'**
  String get updateRoutinePrompt;

  /// No description provided for @updateRoutineButton.
  ///
  /// In tr, this message translates to:
  /// **'Rutinini Güncelle'**
  String get updateRoutineButton;

  /// No description provided for @applyUpdateButton.
  ///
  /// In tr, this message translates to:
  /// **'Güncelle'**
  String get applyUpdateButton;

  /// No description provided for @skipUpdateButton.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi Değil'**
  String get skipUpdateButton;

  /// No description provided for @noChangesMessage.
  ///
  /// In tr, this message translates to:
  /// **'Rutininde değişiklik yok'**
  String get noChangesMessage;

  /// No description provided for @concernTimelineTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sorun Takibi'**
  String get concernTimelineTitle;

  /// No description provided for @concernTimelineSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Cilt sorunlarının zaman içindeki değişimi'**
  String get concernTimelineSubtitle;

  /// No description provided for @concernTimelineEmpty.
  ///
  /// In tr, this message translates to:
  /// **'En az 2 analiz tamamlandığında takip kartları burada görünecek'**
  String get concernTimelineEmpty;

  /// No description provided for @concernTrendImproved.
  ///
  /// In tr, this message translates to:
  /// **'%{percent} iyileşti'**
  String concernTrendImproved(int percent);

  /// No description provided for @concernTrendWorsened.
  ///
  /// In tr, this message translates to:
  /// **'%{percent} kötüleşti'**
  String concernTrendWorsened(int percent);

  /// No description provided for @concernTrendStable.
  ///
  /// In tr, this message translates to:
  /// **'Değişim yok'**
  String get concernTrendStable;

  /// No description provided for @concernTrendFirstMeasurement.
  ///
  /// In tr, this message translates to:
  /// **'İlk ölçüm'**
  String get concernTrendFirstMeasurement;

  /// No description provided for @concernTrendBefore.
  ///
  /// In tr, this message translates to:
  /// **'Önce'**
  String get concernTrendBefore;

  /// No description provided for @concernTrendNow.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi'**
  String get concernTrendNow;

  /// No description provided for @concernTrendImprovedLabel.
  ///
  /// In tr, this message translates to:
  /// **'İyileşen'**
  String get concernTrendImprovedLabel;

  /// No description provided for @concernTrendStableLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sabit'**
  String get concernTrendStableLabel;

  /// No description provided for @concernTrendWorsenedLabel.
  ///
  /// In tr, this message translates to:
  /// **'Dikkat'**
  String get concernTrendWorsenedLabel;

  /// No description provided for @concernTrendSummary.
  ///
  /// In tr, this message translates to:
  /// **'{improved} iyileşti · {stable} sabit · {worsened} dikkat'**
  String concernTrendSummary(int improved, int stable, int worsened);

  /// No description provided for @severityNone.
  ///
  /// In tr, this message translates to:
  /// **'Yok'**
  String get severityNone;

  /// No description provided for @severityMild.
  ///
  /// In tr, this message translates to:
  /// **'Hafif'**
  String get severityMild;

  /// No description provided for @severityModerate.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get severityModerate;

  /// No description provided for @severitySevere.
  ///
  /// In tr, this message translates to:
  /// **'Şiddetli'**
  String get severitySevere;

  /// No description provided for @badgesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rozetlerim'**
  String get badgesTitle;

  /// No description provided for @viewAllBadges.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü Gör'**
  String get viewAllBadges;

  /// No description provided for @weeklySummaryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık Özet'**
  String get weeklySummaryTitle;

  /// No description provided for @badgeFirstAnalysis.
  ///
  /// In tr, this message translates to:
  /// **'İlk Analiz'**
  String get badgeFirstAnalysis;

  /// No description provided for @badgeFirstAnalysisDesc.
  ///
  /// In tr, this message translates to:
  /// **'İlk cilt analizini yaptın!'**
  String get badgeFirstAnalysisDesc;

  /// No description provided for @badgeFirstRoutine.
  ///
  /// In tr, this message translates to:
  /// **'İlk Rutin'**
  String get badgeFirstRoutine;

  /// No description provided for @badgeFirstRoutineDesc.
  ///
  /// In tr, this message translates to:
  /// **'İlk bakım rutinini oluşturdun!'**
  String get badgeFirstRoutineDesc;

  /// No description provided for @badgeStreak7.
  ///
  /// In tr, this message translates to:
  /// **'7 Gün Seri'**
  String get badgeStreak7;

  /// No description provided for @badgeStreak7Desc.
  ///
  /// In tr, this message translates to:
  /// **'7 gün üst üste rutinini tamamladın!'**
  String get badgeStreak7Desc;

  /// No description provided for @badgeStreak14.
  ///
  /// In tr, this message translates to:
  /// **'14 Gün Seri'**
  String get badgeStreak14;

  /// No description provided for @badgeStreak14Desc.
  ///
  /// In tr, this message translates to:
  /// **'14 gün üst üste rutinini tamamladın!'**
  String get badgeStreak14Desc;

  /// No description provided for @badgeStreak30.
  ///
  /// In tr, this message translates to:
  /// **'30 Gün Ustası'**
  String get badgeStreak30;

  /// No description provided for @badgeStreak30Desc.
  ///
  /// In tr, this message translates to:
  /// **'30 gün boyunca hiç aksatmadın!'**
  String get badgeStreak30Desc;

  /// No description provided for @badgeStreak60.
  ///
  /// In tr, this message translates to:
  /// **'60 Gün Efsanesi'**
  String get badgeStreak60;

  /// No description provided for @badgeStreak60Desc.
  ///
  /// In tr, this message translates to:
  /// **'60 gün boyunca düzenli bakım yaptın!'**
  String get badgeStreak60Desc;

  /// No description provided for @badgeScore80.
  ///
  /// In tr, this message translates to:
  /// **'Işıltılı Cilt'**
  String get badgeScore80;

  /// No description provided for @badgeScore80Desc.
  ///
  /// In tr, this message translates to:
  /// **'Cilt skorun 80\'in üzerine çıktı!'**
  String get badgeScore80Desc;

  /// No description provided for @badgeScoreImproved10.
  ///
  /// In tr, this message translates to:
  /// **'10 Puan Artış'**
  String get badgeScoreImproved10;

  /// No description provided for @badgeScoreImproved10Desc.
  ///
  /// In tr, this message translates to:
  /// **'Cilt skorun 10 puandan fazla arttı!'**
  String get badgeScoreImproved10Desc;

  /// No description provided for @badgeLocked.
  ///
  /// In tr, this message translates to:
  /// **'Kilitli'**
  String get badgeLocked;

  /// No description provided for @badgeUnlockedOn.
  ///
  /// In tr, this message translates to:
  /// **'{date} tarihinde açıldı'**
  String badgeUnlockedOn(String date);

  /// No description provided for @onboardingFirstAnalysisTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hadi İlk Analizini\nYapalım!'**
  String get onboardingFirstAnalysisTitle;

  /// No description provided for @onboardingFirstAnalysisSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'3 adımda cildin hakkında her şeyi öğren'**
  String get onboardingFirstAnalysisSubtitle;

  /// No description provided for @onboardingStep1Label.
  ///
  /// In tr, this message translates to:
  /// **'Selfie Çek'**
  String get onboardingStep1Label;

  /// No description provided for @onboardingStep1Desc.
  ///
  /// In tr, this message translates to:
  /// **'Ön kameranla hızlı bir selfie'**
  String get onboardingStep1Desc;

  /// No description provided for @onboardingStep2Label.
  ///
  /// In tr, this message translates to:
  /// **'AI Analiz Etsin'**
  String get onboardingStep2Label;

  /// No description provided for @onboardingStep2Desc.
  ///
  /// In tr, this message translates to:
  /// **'7 bölgede detaylı cilt analizi'**
  String get onboardingStep2Desc;

  /// No description provided for @onboardingStep3Label.
  ///
  /// In tr, this message translates to:
  /// **'Sonuçları Gör'**
  String get onboardingStep3Label;

  /// No description provided for @onboardingStep3Desc.
  ///
  /// In tr, this message translates to:
  /// **'Skor, öneriler ve kişisel rutin'**
  String get onboardingStep3Desc;

  /// No description provided for @onboardingOpenCamera.
  ///
  /// In tr, this message translates to:
  /// **'Kamerayı Aç'**
  String get onboardingOpenCamera;

  /// No description provided for @onboardingAnalyzingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Cildin Analiz Ediliyor'**
  String get onboardingAnalyzingTitle;

  /// No description provided for @onboardingAnalyzingStage1.
  ///
  /// In tr, this message translates to:
  /// **'Cildiniz taranıyor...'**
  String get onboardingAnalyzingStage1;

  /// No description provided for @onboardingAnalyzingStage2.
  ///
  /// In tr, this message translates to:
  /// **'7 bölge inceleniyor...'**
  String get onboardingAnalyzingStage2;

  /// No description provided for @onboardingAnalyzingStage3.
  ///
  /// In tr, this message translates to:
  /// **'Kişisel öneriler hazırlanıyor...'**
  String get onboardingAnalyzingStage3;

  /// No description provided for @onboardingAnalyzingStage4.
  ///
  /// In tr, this message translates to:
  /// **'Sonuçlar neredeyse hazır!'**
  String get onboardingAnalyzingStage4;

  /// No description provided for @onboardingAnalyzingFooter.
  ///
  /// In tr, this message translates to:
  /// **'AI modelimiz cildinizi detaylıca inceliyor'**
  String get onboardingAnalyzingFooter;

  /// No description provided for @onboardingResultTitle.
  ///
  /// In tr, this message translates to:
  /// **'İşte Sonuçların!'**
  String get onboardingResultTitle;

  /// No description provided for @onboardingResultScoreLabel.
  ///
  /// In tr, this message translates to:
  /// **'Cilt Skorun'**
  String get onboardingResultScoreLabel;

  /// No description provided for @onboardingResultSkinAge.
  ///
  /// In tr, this message translates to:
  /// **'Cilt Yaşın: {age}'**
  String onboardingResultSkinAge(int age);

  /// No description provided for @onboardingResultNext.
  ///
  /// In tr, this message translates to:
  /// **'Sırada Ne Var?'**
  String get onboardingResultNext;

  /// No description provided for @onboardingTourTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uygulamayı Keşfet'**
  String get onboardingTourTitle;

  /// No description provided for @onboardingTourRoutineTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kişisel Bakım Rutinin'**
  String get onboardingTourRoutineTitle;

  /// No description provided for @onboardingTourRoutineDesc.
  ///
  /// In tr, this message translates to:
  /// **'AI analizine göre sabah ve akşam bakım rutinin otomatik oluşturulur. Adım adım rehberli mod ile uygula.'**
  String get onboardingTourRoutineDesc;

  /// No description provided for @onboardingTourProgressTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlerlemeyi Takip Et'**
  String get onboardingTourProgressTitle;

  /// No description provided for @onboardingTourProgressDesc.
  ///
  /// In tr, this message translates to:
  /// **'Düzenli analiz yaparak cildindeki değişimi grafiklerle takip et. Öncesi-sonrası karşılaştırması yap.'**
  String get onboardingTourProgressDesc;

  /// No description provided for @onboardingTourProductsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Akıllı Ürün Önerileri'**
  String get onboardingTourProductsTitle;

  /// No description provided for @onboardingTourProductsDesc.
  ///
  /// In tr, this message translates to:
  /// **'Cilt sorunlarına özel ürün tavsiyeleri al. Doğru ürünü bulmak artık çok kolay.'**
  String get onboardingTourProductsDesc;

  /// No description provided for @onboardingCompletionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hazırsın!'**
  String get onboardingCompletionTitle;

  /// No description provided for @onboardingCompletionSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Cilt bakım yolculuğun başlıyor'**
  String get onboardingCompletionSubtitle;

  /// No description provided for @onboardingCompletionFeature1.
  ///
  /// In tr, this message translates to:
  /// **'Günlük rutin hatırlatmaları'**
  String get onboardingCompletionFeature1;

  /// No description provided for @onboardingCompletionFeature2.
  ///
  /// In tr, this message translates to:
  /// **'Haftalık analiz takibi'**
  String get onboardingCompletionFeature2;

  /// No description provided for @onboardingCompletionFeature3.
  ///
  /// In tr, this message translates to:
  /// **'Kişiselleştirilmiş öneriler'**
  String get onboardingCompletionFeature3;

  /// No description provided for @onboardingStartExploring.
  ///
  /// In tr, this message translates to:
  /// **'Keşfetmeye Başla'**
  String get onboardingStartExploring;

  /// No description provided for @onboardingSkipAnalysis.
  ///
  /// In tr, this message translates to:
  /// **'Şimdilik Atla'**
  String get onboardingSkipAnalysis;

  /// No description provided for @analysisErrorTransient.
  ///
  /// In tr, this message translates to:
  /// **'Analiz servisimiz şu an yoğun. Birkaç saniye içinde tekrar deneyin.'**
  String get analysisErrorTransient;

  /// No description provided for @analysisErrorNetwork.
  ///
  /// In tr, this message translates to:
  /// **'İnternet bağlantınızı kontrol edin ve tekrar deneyin.'**
  String get analysisErrorNetwork;

  /// No description provided for @analysisErrorQuota.
  ///
  /// In tr, this message translates to:
  /// **'Günlük analiz limitine ulaşıldı. Lütfen daha sonra deneyin.'**
  String get analysisErrorQuota;

  /// No description provided for @analysisErrorUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.'**
  String get analysisErrorUnknown;

  /// No description provided for @goHomeButton.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfaya Dön'**
  String get goHomeButton;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'tr':
      return L10nTr();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
