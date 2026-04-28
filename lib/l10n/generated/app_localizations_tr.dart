// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'SkinCheck AI';

  @override
  String get appTagline => 'Cildin için AI destekli analiz';

  @override
  String get loginTitle => 'Giriş Yap';

  @override
  String get loginButton => 'Giriş Yap';

  @override
  String get loginError => 'Giriş başarısız. Lütfen tekrar deneyin.';

  @override
  String get signupTitle => 'Hesap Oluştur';

  @override
  String get signupSubtitle => 'Cilt bakım yolculuğuna başla';

  @override
  String get signupFormTitle => 'Kayıt Ol';

  @override
  String get signupButton => 'Kayıt Ol';

  @override
  String get signupError => 'Kayıt başarısız. Lütfen tekrar deneyin.';

  @override
  String get signupPrompt => 'Hesabın yok mu? ';

  @override
  String get loginPrompt => 'Zaten hesabın var mı? ';

  @override
  String get signupLink => 'Kayıt Ol';

  @override
  String get loginLink => 'Giriş Yap';

  @override
  String get orDivider => 'veya';

  @override
  String get nameLabel => 'Ad Soyad';

  @override
  String get nameHint => 'Adınız Soyadınız';

  @override
  String get nameRequired => 'İsim gerekli';

  @override
  String get emailLabel => 'E-posta';

  @override
  String get emailHint => 'ornek@email.com';

  @override
  String get emailRequired => 'E-posta gerekli';

  @override
  String get emailInvalid => 'Geçerli bir e-posta girin';

  @override
  String get passwordLabel => 'Şifre';

  @override
  String get passwordHint => '••••••••';

  @override
  String get passwordRequired => 'Şifre gerekli';

  @override
  String get passwordMinLength => 'En az 6 karakter';

  @override
  String get onboardingWelcomeTitle => 'Cildini tanı,\ngüzelliğini keşfet';

  @override
  String get onboardingWelcomeSubtitle => 'Yapay zeka destekli cilt analizi';

  @override
  String get startButton => 'Başla';

  @override
  String get continueButton => 'Devam';

  @override
  String get skinTypeTitle => 'Cilt tipin hangisi?';

  @override
  String get skinTypeSubtitle => 'Sana özel analiz için cilt tipini seç';

  @override
  String get skinConcernsTitle => 'En çok neyi\niyileştirmek istiyorsun?';

  @override
  String get skinConcernsSubtitle => 'Birden fazla seçebilirsin';

  @override
  String get cameraPermissionTitle =>
      'Cilt analizin için\nkameraya ihtiyacımız var';

  @override
  String get cameraSecurityMessage => 'Fotoğrafların güvenle saklanır';

  @override
  String get startAnalysisButton => 'Analizimi Başlat';

  @override
  String greetingMessage(String name) {
    return 'Merhaba, $name!';
  }

  @override
  String get defaultUserName => 'Kullanıcı';

  @override
  String get morningRoutineLabel => 'Sabah Rutini';

  @override
  String get eveningRoutineLabel => 'Akşam Rutini';

  @override
  String moreSteps(int count) {
    return '+$count adım daha';
  }

  @override
  String get weeklyTipTitle => 'Haftanın İpucu';

  @override
  String get tip1 =>
      'Güneş kremi sadece yaz için değil! Kış aylarında da SPF 30+ kullanmayı ihmal etmeyin.';

  @override
  String get tip2 =>
      'Cildinizi temizledikten sonra 60 saniye içinde nemlendirici sürmeye özen gösterin.';

  @override
  String get tip3 =>
      'Haftada 2-3 kez hafif bir peeling cildinizin yenilenmesine yardımcı olur.';

  @override
  String get tip4 =>
      'Günde en az 2 litre su içmek cildinizin nemli ve parlak kalmasını sağlar.';

  @override
  String get tip5 =>
      'Yastık kılıfı haftada bir değiştirmek cilt sağlığınızı olumlu etkiler.';

  @override
  String get tip6 =>
      'Retinol içeren ürünleri sadece akşam rutininizde kullanın.';

  @override
  String get tip7 =>
      'C vitamini serumu sabah rutininize ekleyerek cildinize parlaklık kazandırın.';

  @override
  String get lastAnalysisTitle => 'Son Analiz';

  @override
  String get viewDetailsCta => 'Detayları gör';

  @override
  String get todayLabel => 'Bugün';

  @override
  String get yesterdayLabel => '1 gün önce';

  @override
  String daysAgoLabel(int count) {
    return '$count gün önce';
  }

  @override
  String get scoreLabel => 'Skor';

  @override
  String get skinAgeLabel => 'Cilt Yaşı';

  @override
  String skinAgeDisplay(int age) {
    return 'Cilt Yaşın: $age';
  }

  @override
  String get reanalyzeButton => 'Tekrar Analiz Et';

  @override
  String get firstAnalysisTitle => 'İlk Analizini Yap!';

  @override
  String get firstAnalysisDescription =>
      'Selfie çek, yapay zeka cildinizi 7 bölgede analiz etsin ve size özel bakım önerisi alsın.';

  @override
  String get openCameraButton => 'Kamerayı Aç';

  @override
  String get analyzeSubtitle => 'Cildinizi yapay zeka ile analiz edin';

  @override
  String get newAnalysisTitle => 'Yeni Analiz Başlat';

  @override
  String get analysisDescription =>
      'Selfie çekin, AI cildinizi 7 bölgede analiz etsin';

  @override
  String get analysisResultsTitle => 'Analiz Sonuçları';

  @override
  String get overallScoreLabel => 'Genel Skor';

  @override
  String get zoneMapLabel => 'Bölge Haritası';

  @override
  String get createRoutineButton => 'Rutin Oluştur';

  @override
  String get shareButton => 'Paylaş';

  @override
  String get analysisFailedTitle => 'Analiz Başarısız';

  @override
  String get backButton => 'Geri Dön';

  @override
  String get analysisErrorSnackbar => 'Bir hata oluştu. Tekrar deneyin.';

  @override
  String get recommendedProductsTitle => 'Önerilen Ürünler';

  @override
  String get viewAllButton => 'Tümünü Gör';

  @override
  String get cameraInitError => 'Kamera başlatılamadı';

  @override
  String get captureError => 'Fotoğraf çekilemedi';

  @override
  String get routineTitle => 'Bakım Rutini';

  @override
  String get morningTab => 'Sabah';

  @override
  String get eveningTab => 'Akşam';

  @override
  String get emptyRoutineMessage => 'Bu rutin henüz oluşturulmamış.';

  @override
  String get addStepButton => 'Adım Ekle';

  @override
  String get noAnalysisSnackbar => 'Önce bir cilt analizi yapmalısın!';

  @override
  String get noRoutineTitle => 'Henüz Rutin Yok';

  @override
  String get noRoutineDescription =>
      'Cilt analizine göre kişisel sabah ve akşam bakım rutinini oluştur.';

  @override
  String get addStepDialogTitle => 'Adım Ekle';

  @override
  String get productTypeLabel => 'Ürün Tipi';

  @override
  String get stepNameLabel => 'Adım Adı';

  @override
  String get stepNameHint => 'Örn: Yüz yıkama';

  @override
  String get stepReasonLabel => 'Neden Gerekli?';

  @override
  String get stepReasonHint => 'Örn: Gözenekleri temizler';

  @override
  String get cancelButton => 'İptal';

  @override
  String get addButton => 'Ekle';

  @override
  String get addStepSheetTitle => 'Rutinine Yeni Adım';

  @override
  String get addStepSheetSubtitle =>
      'Bu ürünün ne işe yaradığını, nasıl uygulanacağını ve seni ne bekleyen sonuçları keşfet.';

  @override
  String get whatIsItLabel => 'Nedir?';

  @override
  String get howToApplyLabel => 'Nasıl uygulanır?';

  @override
  String get expectedResultsLabel => 'Seni bekleyen sonuçlar';

  @override
  String get bestTimeLabel => 'En iyi zaman';

  @override
  String get durationLabel => 'Süre';

  @override
  String get addToRoutineButton => 'Rutinime Ekle';

  @override
  String get notesOptionalLabel => 'Kişisel not (opsiyonel)';

  @override
  String get notesOptionalHint =>
      'Örn: Bi\'taraf marka, akşamları kullanıyorum';

  @override
  String get stepNameOptionalHelper =>
      'Adım adını özelleştir — boş bırakırsan ürün tipi kullanılır';

  @override
  String defaultReasonTemplate(String type) {
    return '$type cildiniz için önerilir.';
  }

  @override
  String get cleanserType => 'Temizleyici';

  @override
  String get tonerType => 'Tonik';

  @override
  String get serumType => 'Serum';

  @override
  String get moisturizerType => 'Nemlendirici';

  @override
  String get sunscreenType => 'Güneş Kremi';

  @override
  String get eyeCreamType => 'Göz Kremi';

  @override
  String get maskType => 'Maske';

  @override
  String get exfoliantType => 'Peeling';

  @override
  String get oilType => 'Yağ';

  @override
  String get retinolType => 'Retinol';

  @override
  String get progressTitle => 'İlerleme';

  @override
  String get noProgressTitle => 'Henüz ilerleme verisi yok';

  @override
  String get noProgressDescription =>
      'İlk cilt analizini yaparak ilerleme\ntakibine başla!';

  @override
  String get analyzeButton => 'Analiz Yap';

  @override
  String get analysisCountLabel => 'Analiz';

  @override
  String get comparisonTitle => 'Değişim Karşılaştırması';

  @override
  String get beforeLabel => 'Önce';

  @override
  String get afterLabel => 'Sonra';

  @override
  String scoreDisplay(String score) {
    return 'Skor: $score';
  }

  @override
  String get weeklyProgress => 'Haftalık İlerleme';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileLoadError => 'Profil yüklenemedi';

  @override
  String get userNotFound => 'Kullanıcı bulunamadı';

  @override
  String get editProfileMenu => 'Profili Düzenle';

  @override
  String get settingsMenu => 'Ayarlar';

  @override
  String get logoutMenu => 'Çıkış Yap';

  @override
  String get logoutDialogTitle => 'Çıkış Yap';

  @override
  String get logoutConfirmation => 'Çıkış yapmak istediğinize emin misiniz?';

  @override
  String get editProfileTitle => 'Profili Düzenle';

  @override
  String get emailReadOnlyHelper =>
      'E-postayı değiştirmek için destekle iletişime geçin';

  @override
  String get changePasswordButton => 'Şifre Değiştir';

  @override
  String get changePasswordTitle => 'Şifre Değiştir';

  @override
  String get currentPasswordLabel => 'Mevcut Şifre';

  @override
  String get newPasswordLabel => 'Yeni Şifre';

  @override
  String get confirmPasswordLabel => 'Yeni Şifre (Tekrar)';

  @override
  String get passwordMismatchError => 'Şifreler eşleşmiyor';

  @override
  String get passwordWeakError =>
      'Şifre en az 8 karakter, bir büyük harf, bir küçük harf ve bir rakam içermeli';

  @override
  String get passwordChangedSnackbar => 'Şifreniz güncellendi';

  @override
  String get currentPasswordIncorrectError => 'Mevcut şifre yanlış';

  @override
  String get passwordUpdateError => 'Şifre güncellenemedi. Tekrar deneyin.';

  @override
  String get updateButton => 'Güncelle';

  @override
  String get nameEmptyError => 'İsim boş olamaz';

  @override
  String get emailInvalidEdit => 'Geçerli bir e-posta giriniz';

  @override
  String get saveButton => 'Kaydet';

  @override
  String get profileUpdated => 'Profil güncellendi';

  @override
  String get profileUpdateError => 'Profil güncellenemedi';

  @override
  String get totalAnalysesLabel => 'Toplam Analiz';

  @override
  String get membershipDateLabel => 'Üyelik Tarihi';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get themeSectionTitle => 'Tema';

  @override
  String get notificationsSectionTitle => 'Bildirimler';

  @override
  String get routineReminderLabel => 'Rutin Hatırlatma';

  @override
  String get reminderTimeLabel => 'Hatırlatma Saati';

  @override
  String get subscriptionSectionTitle => 'Abonelik';

  @override
  String get currentPlanLabel => 'Mevcut Plan';

  @override
  String get proPlanLabel => 'Pro';

  @override
  String get freePlanLabel => 'Ücretsiz';

  @override
  String get manageSubscriptionLabel => 'Aboneliği Yönet';

  @override
  String get accountSectionTitle => 'Hesap';

  @override
  String get exportDataLabel => 'Verilerimi Dışa Aktar';

  @override
  String get deleteAccountLabel => 'Hesabımı Sil';

  @override
  String get aboutSectionTitle => 'Hakkında';

  @override
  String get versionLabel => 'Versiyon';

  @override
  String get privacyPolicyLabel => 'Gizlilik Politikası';

  @override
  String get termsOfUseLabel => 'Kullanım Koşulları';

  @override
  String get licensesLabel => 'Lisanslar';

  @override
  String get systemTheme => 'Sistem';

  @override
  String get lightTheme => 'Açık';

  @override
  String get darkTheme => 'Koyu';

  @override
  String get preparingData => 'Veriler hazırlanıyor...';

  @override
  String get dataExportFailed => 'Veriler dışa aktarılamadı';

  @override
  String get deletingAccount => 'Hesap siliniyor...';

  @override
  String get accountDeletionFailed => 'Hesap silinemedi. Tekrar deneyin.';

  @override
  String get deleteAccountTitle => 'Hesabını Sil';

  @override
  String get deleteAccountWarning =>
      'Bu işlem geri alınamaz. Tüm verilerin, analizlerin ve fotoğrafların kalıcı olarak silinecek.';

  @override
  String get deleteAccountConfirm => 'Evet, Hesabımı Sil';

  @override
  String get cancelAction => 'Vazgeç';

  @override
  String get proUpgradeTitle => 'Pro\'ya Geç';

  @override
  String get proUpgradeSubtitle =>
      'Cilt bakım yolculuğunu bir üst seviyeye taşıyın';

  @override
  String get yearlyPlan => 'Yıllık';

  @override
  String get yearlyPeriod => '/yıl';

  @override
  String get yearlyDiscount => '%30 tasarruf';

  @override
  String get monthlyPlan => 'Aylık';

  @override
  String get monthlyPeriod => '/ay';

  @override
  String get freeTrialButton => '7 Gün Ücretsiz Dene';

  @override
  String get restorePurchase => 'Satın almayı geri yükle';

  @override
  String get privacyLink => 'Gizlilik';

  @override
  String get termsLink => 'Kullanım Koşulları';

  @override
  String get proFeature => 'Pro özelliği';

  @override
  String get productCatalogTitle => 'Ürün Kataloğu';

  @override
  String get productsLoadError => 'Ürünler yüklenirken hata oluştu';

  @override
  String get retryButton => 'Tekrar Dene';

  @override
  String get noMatchingProducts => 'Sorunlarınıza uygun ürün bulunamadı';

  @override
  String get noProductsAdded => 'Henüz ürün eklenmemiş';

  @override
  String get buyButton => 'Satın Al';

  @override
  String whyProductTitle(String name) {
    return 'Neden $name?';
  }

  @override
  String get matchingConcerns => 'Eşleşen Sorunlar';

  @override
  String get closeButton => 'Kapat';

  @override
  String get acneConcern => 'Akne';

  @override
  String get wrinklesConcern => 'Kırışıklık';

  @override
  String get spotsConcern => 'Leke';

  @override
  String get poresConcern => 'Gözenek';

  @override
  String get drynessConcern => 'Kuruluk';

  @override
  String get oilinessConcern => 'Yağlanma';

  @override
  String get darkCirclesConcern => 'Koyu Halka';

  @override
  String get rednessConcern => 'Kızarıklık';

  @override
  String get shareTitle => 'Paylaş';

  @override
  String get instagramOption => 'Instagram';

  @override
  String get whatsappOption => 'WhatsApp';

  @override
  String get otherOption => 'Diğer';

  @override
  String get homeNavLabel => 'Ana Sayfa';

  @override
  String get analyzeNavLabel => 'Analiz';

  @override
  String get progressNavLabel => 'İlerleme';

  @override
  String get routineNavLabel => 'Rutin';

  @override
  String get profileNavLabel => 'Profil';

  @override
  String get morningNotificationTitle => 'Sabah Rutinin Hazır ☀️';

  @override
  String get morningNotificationBody =>
      'Güne bakımlı başla! Sabah rutinine göz at.';

  @override
  String get eveningNotificationTitle => 'Akşam Rutini Zamanı 🌙';

  @override
  String get eveningNotificationBody =>
      'Günü temiz bitir! Akşam bakım rutinine başla.';

  @override
  String get weeklyAnalysisTitle => 'Bu hafta analizini yaptın mı?';

  @override
  String get weeklyAnalysisBody =>
      'Haftalık analizini yap ve ilerlemeyi takip et!';

  @override
  String get routineRemindersChannel => 'Rutin Hatırlatmaları';

  @override
  String get routineRemindersChannelDesc =>
      'Günlük cilt bakım rutini hatırlatmaları';

  @override
  String get weeklyAnalysisChannel => 'Haftalık Analiz Hatırlatması';

  @override
  String get weeklyAnalysisChannelDesc => 'Haftalık cilt analizi hatırlatması';

  @override
  String errorDisplay(String error) {
    return 'Hata: $error';
  }

  @override
  String get zoneAnalysisTitle => 'Bölge Analizi';

  @override
  String get tapZonesForDetails => 'Detaylar için bölgelere dokunun';

  @override
  String get detectedConcerns => 'Tespit Edilen Sorunlar';

  @override
  String get recommendationsTitle => 'Öneriler';

  @override
  String get severityLabel => 'Ciddiyet';

  @override
  String get zoneForehead => 'Alın';

  @override
  String get zoneLeftCheek => 'Sol Yanak';

  @override
  String get zoneRightCheek => 'Sağ Yanak';

  @override
  String get zoneNose => 'Burun';

  @override
  String get zoneChin => 'Çene';

  @override
  String get zoneUnderEyes => 'Göz Altı';

  @override
  String get zoneJawline => 'Çene Hattı';

  @override
  String get concernDryness => 'Kuruluk';

  @override
  String get concernOiliness => 'Yağlılık';

  @override
  String get concernAcne => 'Akne';

  @override
  String get concernWrinkles => 'Kırışıklık';

  @override
  String get concernFinelines => 'İnce Çizgiler';

  @override
  String get concernSpots => 'Lekeler';

  @override
  String get concernPores => 'Gözenekler';

  @override
  String get concernRedness => 'Kızarıklık';

  @override
  String get concernDarkCircles => 'Göz Altı Morluğu';

  @override
  String get concernUnevenTone => 'Dengesiz Ton';

  @override
  String get concernSagging => 'Sarkma';

  @override
  String get concernSensitivity => 'Hassasiyet';

  @override
  String get concernDehydration => 'Dehidrasyon';

  @override
  String get concernHyperpigmentation => 'Hiperpigmentasyon';

  @override
  String get concernTexture => 'Doku';

  @override
  String get deleteStepTitle => 'Adımı Sil';

  @override
  String get deleteStepConfirmation =>
      'Bu adımı silmek istediğinize emin misiniz?';

  @override
  String get deleteButton => 'Sil';

  @override
  String get productsComingSoon => 'Yakında ürün önerileri eklenecek';

  @override
  String get scoreTrendTitle => 'Skor Trendi';

  @override
  String get secondAnalysisInfoTitle => '2. Analizini Yap!';

  @override
  String get secondAnalysisInfoDescription =>
      'Karşılaştırma, ilerleme grafiği ve en çok gelişen bölge gibi özellikler 2. analizden sonra aktif olur.';

  @override
  String get startSecondAnalysisButton => 'Analiz Yap';

  @override
  String get pastAnalysesTitle => 'Geçmiş Analizler';

  @override
  String get analysisDetailTitle => 'Analiz Detayı';

  @override
  String get landingHeroTitle => 'Cildini AI ile\nAnaliz Et';

  @override
  String get landingHeroDescription =>
      'Yapay zekâ destekli cilt analizi ile cildin hakkında detaylı bilgi al, kişisel bakım rutini oluştur.';

  @override
  String get getStartedButton => 'Hemen Başla';

  @override
  String get appStoreBadge => 'App Store';

  @override
  String get googlePlayBadge => 'Google Play';

  @override
  String get featuredFeaturesTitle => 'Öne Çıkan Özellikler';

  @override
  String get featuredFeaturesSubtitle =>
      'Cilt bakımında yapay zekâ devrimini keşfet';

  @override
  String get aiAnalysisFeatureTitle => 'AI Cilt Analizi';

  @override
  String get aiAnalysisFeatureDesc =>
      'Yapay zekâ yüzünü 7 bölgede analiz eder ve detaylı skor verir.';

  @override
  String get personalRoutineFeatureTitle => 'Kişisel Rutin';

  @override
  String get personalRoutineFeatureDesc =>
      'Cilt tipine ve sorunlarına özel sabah/akşam bakım rutini oluşturur.';

  @override
  String get progressTrackingFeatureTitle => 'İlerleme Takibi';

  @override
  String get progressTrackingFeatureDesc =>
      'Zaman içindeki cilt değişimini grafiklerle takip et.';

  @override
  String get productRecsFeatureTitle => 'Ürün Önerileri';

  @override
  String get productRecsFeatureDesc =>
      'Cilt sorunlarına uygun ürün önerileri al, hemen satın al.';

  @override
  String get howItWorksTitle => 'Nasıl Çalışır?';

  @override
  String get howItWorksSubtitle => '3 basit adımda cilt analizini tamamla';

  @override
  String get step1Title => 'Selfie Çek';

  @override
  String get step1Desc => 'Ön kameranı kullanarak hızlıca bir selfie çek.';

  @override
  String get step2Title => 'AI Analiz';

  @override
  String get step2Desc => 'Yapay zekâ cildini 7 farklı bölgede analiz eder.';

  @override
  String get step3Title => 'Rutin Al';

  @override
  String get step3Desc => 'Kişiselleştirilmiş bakım rutinini hemen uygula.';

  @override
  String get relatedRoutineSteps => 'İlgili Rutin Adımları';

  @override
  String get morningReminderLabel => 'Sabah Hatırlatma Saati';

  @override
  String get eveningReminderLabel => 'Akşam Hatırlatma Saati';

  @override
  String get streakNotificationLabel => 'Seri Bildirimleri';

  @override
  String get motivationalNotificationLabel => 'Motivasyon Mesajları';

  @override
  String get weeklyReminderDayLabel => 'Haftalık Analiz Günü';

  @override
  String get guidedModeTitle => 'Rehberli Mod';

  @override
  String get nextStepButton => 'Sonraki Adım';

  @override
  String get completeRoutineButton => 'Rutini Tamamla';

  @override
  String get whyThisStep => 'Neden bu adım?';

  @override
  String get howToApply => 'Nasıl Uygulanır?';

  @override
  String get guidedModeComplete => 'Tebrikler! Rutinini tamamladın!';

  @override
  String get updateRoutineTitle => 'Rutinini Güncelle';

  @override
  String get updateRoutinePrompt =>
      'Yeni analiz sonucuna göre rutininde değişiklikler var';

  @override
  String get updateRoutineButton => 'Rutinini Güncelle';

  @override
  String get applyUpdateButton => 'Güncelle';

  @override
  String get skipUpdateButton => 'Şimdi Değil';

  @override
  String get noChangesMessage => 'Rutininde değişiklik yok';

  @override
  String get concernTimelineTitle => 'Sorun Takibi';

  @override
  String get concernTimelineSubtitle =>
      'Cilt sorunlarının zaman içindeki değişimi';

  @override
  String get concernTimelineEmpty =>
      'En az 2 analiz tamamlandığında takip kartları burada görünecek';

  @override
  String concernTrendImproved(int percent) {
    return '%$percent iyileşti';
  }

  @override
  String concernTrendWorsened(int percent) {
    return '%$percent kötüleşti';
  }

  @override
  String get concernTrendStable => 'Değişim yok';

  @override
  String get concernTrendFirstMeasurement => 'İlk ölçüm';

  @override
  String get concernTrendBefore => 'Önce';

  @override
  String get concernTrendNow => 'Şimdi';

  @override
  String get concernTrendImprovedLabel => 'İyileşen';

  @override
  String get concernTrendStableLabel => 'Sabit';

  @override
  String get concernTrendWorsenedLabel => 'Dikkat';

  @override
  String concernTrendSummary(int improved, int stable, int worsened) {
    return '$improved iyileşti · $stable sabit · $worsened dikkat';
  }

  @override
  String get severityNone => 'Yok';

  @override
  String get severityMild => 'Hafif';

  @override
  String get severityModerate => 'Orta';

  @override
  String get severitySevere => 'Şiddetli';

  @override
  String get badgesTitle => 'Rozetlerim';

  @override
  String get viewAllBadges => 'Tümünü Gör';

  @override
  String get weeklySummaryTitle => 'Haftalık Özet';

  @override
  String get badgeFirstAnalysis => 'İlk Analiz';

  @override
  String get badgeFirstAnalysisDesc => 'İlk cilt analizini yaptın!';

  @override
  String get badgeFirstRoutine => 'İlk Rutin';

  @override
  String get badgeFirstRoutineDesc => 'İlk bakım rutinini oluşturdun!';

  @override
  String get badgeStreak7 => '7 Gün Seri';

  @override
  String get badgeStreak7Desc => '7 gün üst üste rutinini tamamladın!';

  @override
  String get badgeStreak14 => '14 Gün Seri';

  @override
  String get badgeStreak14Desc => '14 gün üst üste rutinini tamamladın!';

  @override
  String get badgeStreak30 => '30 Gün Ustası';

  @override
  String get badgeStreak30Desc => '30 gün boyunca hiç aksatmadın!';

  @override
  String get badgeStreak60 => '60 Gün Efsanesi';

  @override
  String get badgeStreak60Desc => '60 gün boyunca düzenli bakım yaptın!';

  @override
  String get badgeScore80 => 'Işıltılı Cilt';

  @override
  String get badgeScore80Desc => 'Cilt skorun 80\'in üzerine çıktı!';

  @override
  String get badgeScoreImproved10 => '10 Puan Artış';

  @override
  String get badgeScoreImproved10Desc => 'Cilt skorun 10 puandan fazla arttı!';

  @override
  String get badgeLocked => 'Kilitli';

  @override
  String badgeUnlockedOn(String date) {
    return '$date tarihinde açıldı';
  }

  @override
  String get onboardingFirstAnalysisTitle => 'Hadi İlk Analizini\nYapalım!';

  @override
  String get onboardingFirstAnalysisSubtitle =>
      '3 adımda cildin hakkında her şeyi öğren';

  @override
  String get onboardingStep1Label => 'Selfie Çek';

  @override
  String get onboardingStep1Desc => 'Ön kameranla hızlı bir selfie';

  @override
  String get onboardingStep2Label => 'AI Analiz Etsin';

  @override
  String get onboardingStep2Desc => '7 bölgede detaylı cilt analizi';

  @override
  String get onboardingStep3Label => 'Sonuçları Gör';

  @override
  String get onboardingStep3Desc => 'Skor, öneriler ve kişisel rutin';

  @override
  String get onboardingOpenCamera => 'Kamerayı Aç';

  @override
  String get onboardingAnalyzingTitle => 'Cildin Analiz Ediliyor';

  @override
  String get onboardingAnalyzingStage1 => 'Cildiniz taranıyor...';

  @override
  String get onboardingAnalyzingStage2 => '7 bölge inceleniyor...';

  @override
  String get onboardingAnalyzingStage3 => 'Kişisel öneriler hazırlanıyor...';

  @override
  String get onboardingAnalyzingStage4 => 'Sonuçlar neredeyse hazır!';

  @override
  String get onboardingAnalyzingFooter =>
      'AI modelimiz cildinizi detaylıca inceliyor';

  @override
  String get onboardingResultTitle => 'İşte Sonuçların!';

  @override
  String get onboardingResultScoreLabel => 'Cilt Skorun';

  @override
  String onboardingResultSkinAge(int age) {
    return 'Cilt Yaşın: $age';
  }

  @override
  String get onboardingResultNext => 'Sırada Ne Var?';

  @override
  String get onboardingTourTitle => 'Uygulamayı Keşfet';

  @override
  String get onboardingTourRoutineTitle => 'Kişisel Bakım Rutinin';

  @override
  String get onboardingTourRoutineDesc =>
      'AI analizine göre sabah ve akşam bakım rutinin otomatik oluşturulur. Adım adım rehberli mod ile uygula.';

  @override
  String get onboardingTourProgressTitle => 'İlerlemeyi Takip Et';

  @override
  String get onboardingTourProgressDesc =>
      'Düzenli analiz yaparak cildindeki değişimi grafiklerle takip et. Öncesi-sonrası karşılaştırması yap.';

  @override
  String get onboardingTourProductsTitle => 'Akıllı Ürün Önerileri';

  @override
  String get onboardingTourProductsDesc =>
      'Cilt sorunlarına özel ürün tavsiyeleri al. Doğru ürünü bulmak artık çok kolay.';

  @override
  String get onboardingCompletionTitle => 'Hazırsın!';

  @override
  String get onboardingCompletionSubtitle => 'Cilt bakım yolculuğun başlıyor';

  @override
  String get onboardingCompletionFeature1 => 'Günlük rutin hatırlatmaları';

  @override
  String get onboardingCompletionFeature2 => 'Haftalık analiz takibi';

  @override
  String get onboardingCompletionFeature3 => 'Kişiselleştirilmiş öneriler';

  @override
  String get onboardingStartExploring => 'Keşfetmeye Başla';

  @override
  String get onboardingSkipAnalysis => 'Şimdilik Atla';

  @override
  String get analysisErrorTransient =>
      'Analiz servisimiz şu an yoğun. Birkaç saniye içinde tekrar deneyin.';

  @override
  String get analysisErrorNetwork =>
      'İnternet bağlantınızı kontrol edin ve tekrar deneyin.';

  @override
  String get analysisErrorQuota =>
      'Günlük analiz limitine ulaşıldı. Lütfen daha sonra deneyin.';

  @override
  String get analysisErrorUnknown =>
      'Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get goHomeButton => 'Ana Sayfaya Dön';
}
