// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SkinCheck AI';

  @override
  String get appTagline => 'AI-powered skin analysis';

  @override
  String get loginTitle => 'Log In';

  @override
  String get loginButton => 'Log In';

  @override
  String get loginError => 'Login failed. Please try again.';

  @override
  String get signupTitle => 'Create Account';

  @override
  String get signupSubtitle => 'Start your skincare journey';

  @override
  String get signupFormTitle => 'Sign Up';

  @override
  String get signupButton => 'Sign Up';

  @override
  String get signupError => 'Sign up failed. Please try again.';

  @override
  String get signupPrompt => 'Don\'t have an account? ';

  @override
  String get loginPrompt => 'Already have an account? ';

  @override
  String get signupLink => 'Sign Up';

  @override
  String get loginLink => 'Log In';

  @override
  String get orDivider => 'or';

  @override
  String get nameLabel => 'Full Name';

  @override
  String get nameHint => 'Your Full Name';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'example@email.com';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => '••••••••';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'At least 6 characters';

  @override
  String get onboardingWelcomeTitle => 'Know your skin,\ndiscover your beauty';

  @override
  String get onboardingWelcomeSubtitle => 'AI-powered skin analysis';

  @override
  String get startButton => 'Start';

  @override
  String get continueButton => 'Continue';

  @override
  String get skinTypeTitle => 'What\'s your skin type?';

  @override
  String get skinTypeSubtitle =>
      'Select your skin type for personalized analysis';

  @override
  String get skinConcernsTitle => 'What do you want\nto improve the most?';

  @override
  String get skinConcernsSubtitle => 'You can select multiple';

  @override
  String get cameraPermissionTitle =>
      'We need camera access\nfor your skin analysis';

  @override
  String get cameraSecurityMessage => 'Your photos are stored securely';

  @override
  String get startAnalysisButton => 'Start My Analysis';

  @override
  String greetingMessage(String name) {
    return 'Hello, $name!';
  }

  @override
  String get defaultUserName => 'User';

  @override
  String get morningRoutineLabel => 'Morning Routine';

  @override
  String get eveningRoutineLabel => 'Evening Routine';

  @override
  String moreSteps(int count) {
    return '+$count more steps';
  }

  @override
  String get weeklyTipTitle => 'Tip of the Week';

  @override
  String get tip1 =>
      'Sunscreen isn\'t just for summer! Don\'t forget to use SPF 30+ during winter too.';

  @override
  String get tip2 =>
      'Apply moisturizer within 60 seconds after cleansing your skin.';

  @override
  String get tip3 =>
      'A gentle exfoliation 2-3 times a week helps your skin renew.';

  @override
  String get tip4 =>
      'Drinking at least 2 liters of water a day keeps your skin hydrated and glowing.';

  @override
  String get tip5 =>
      'Changing your pillowcase weekly positively affects your skin health.';

  @override
  String get tip6 => 'Use retinol products only in your evening routine.';

  @override
  String get tip7 =>
      'Add vitamin C serum to your morning routine for brighter skin.';

  @override
  String get lastAnalysisTitle => 'Last Analysis';

  @override
  String get viewDetailsCta => 'View details';

  @override
  String get todayLabel => 'Today';

  @override
  String get yesterdayLabel => '1 day ago';

  @override
  String daysAgoLabel(int count) {
    return '$count days ago';
  }

  @override
  String get scoreLabel => 'Score';

  @override
  String get skinAgeLabel => 'Skin Age';

  @override
  String skinAgeDisplay(int age) {
    return 'Your Skin Age: $age';
  }

  @override
  String get reanalyzeButton => 'Reanalyze';

  @override
  String get firstAnalysisTitle => 'Take Your First Analysis!';

  @override
  String get firstAnalysisDescription =>
      'Take a selfie, let AI analyze your skin in 7 zones and get personalized skincare advice.';

  @override
  String get openCameraButton => 'Open Camera';

  @override
  String get analyzeSubtitle => 'Analyze your skin with AI';

  @override
  String get newAnalysisTitle => 'Start New Analysis';

  @override
  String get analysisDescription =>
      'Take a selfie, let AI analyze your skin in 7 zones';

  @override
  String get analysisResultsTitle => 'Analysis Results';

  @override
  String get overallScoreLabel => 'Overall Score';

  @override
  String get zoneMapLabel => 'Zone Map';

  @override
  String get createRoutineButton => 'Create Routine';

  @override
  String get shareButton => 'Share';

  @override
  String get analysisFailedTitle => 'Analysis Failed';

  @override
  String get backButton => 'Go Back';

  @override
  String get analysisErrorSnackbar => 'An error occurred. Please try again.';

  @override
  String get recommendedProductsTitle => 'Recommended Products';

  @override
  String get viewAllButton => 'View All';

  @override
  String get cameraInitError => 'Camera could not be initialized';

  @override
  String get captureError => 'Photo could not be captured';

  @override
  String get routineTitle => 'Skincare Routine';

  @override
  String get morningTab => 'Morning';

  @override
  String get eveningTab => 'Evening';

  @override
  String get emptyRoutineMessage => 'This routine hasn\'t been created yet.';

  @override
  String get addStepButton => 'Add Step';

  @override
  String get noAnalysisSnackbar => 'You need to do a skin analysis first!';

  @override
  String get noRoutineTitle => 'No Routine Yet';

  @override
  String get noRoutineDescription =>
      'Create your personal morning and evening skincare routine based on your skin analysis.';

  @override
  String get addStepDialogTitle => 'Add Step';

  @override
  String get productTypeLabel => 'Product Type';

  @override
  String get stepNameLabel => 'Step Name';

  @override
  String get stepNameHint => 'e.g. Face wash';

  @override
  String get stepReasonLabel => 'Why Is It Needed?';

  @override
  String get stepReasonHint => 'e.g. Cleans pores';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get addButton => 'Add';

  @override
  String get addStepSheetTitle => 'A New Step for Your Routine';

  @override
  String get addStepSheetSubtitle =>
      'Discover what this product does, how to apply it, and the results to expect.';

  @override
  String get whatIsItLabel => 'What is it?';

  @override
  String get howToApplyLabel => 'How to apply';

  @override
  String get expectedResultsLabel => 'What to expect';

  @override
  String get bestTimeLabel => 'Best time';

  @override
  String get durationLabel => 'Duration';

  @override
  String get addToRoutineButton => 'Add to Routine';

  @override
  String get notesOptionalLabel => 'Personal note (optional)';

  @override
  String get notesOptionalHint => 'e.g. CeraVe — I use it at night';

  @override
  String get stepNameOptionalHelper =>
      'Customize the step name — leave blank to use the product type';

  @override
  String defaultReasonTemplate(String type) {
    return '$type is recommended for your skin.';
  }

  @override
  String get cleanserType => 'Cleanser';

  @override
  String get tonerType => 'Toner';

  @override
  String get serumType => 'Serum';

  @override
  String get moisturizerType => 'Moisturizer';

  @override
  String get sunscreenType => 'Sunscreen';

  @override
  String get eyeCreamType => 'Eye Cream';

  @override
  String get maskType => 'Mask';

  @override
  String get exfoliantType => 'Exfoliant';

  @override
  String get oilType => 'Oil';

  @override
  String get retinolType => 'Retinol';

  @override
  String get progressTitle => 'Progress';

  @override
  String get noProgressTitle => 'No progress data yet';

  @override
  String get noProgressDescription =>
      'Start tracking your progress by\ntaking your first skin analysis!';

  @override
  String get analyzeButton => 'Analyze';

  @override
  String get analysisCountLabel => 'Analyses';

  @override
  String get comparisonTitle => 'Before & After Comparison';

  @override
  String get beforeLabel => 'Before';

  @override
  String get afterLabel => 'After';

  @override
  String scoreDisplay(String score) {
    return 'Score: $score';
  }

  @override
  String get weeklyProgress => 'Weekly Progress';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileLoadError => 'Could not load profile';

  @override
  String get userNotFound => 'User not found';

  @override
  String get editProfileMenu => 'Edit Profile';

  @override
  String get settingsMenu => 'Settings';

  @override
  String get logoutMenu => 'Log Out';

  @override
  String get logoutDialogTitle => 'Log Out';

  @override
  String get logoutConfirmation => 'Are you sure you want to log out?';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get emailReadOnlyHelper => 'Contact support to change your email';

  @override
  String get changePasswordButton => 'Change Password';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get currentPasswordLabel => 'Current Password';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get confirmPasswordLabel => 'Confirm New Password';

  @override
  String get passwordMismatchError => 'Passwords don\'t match';

  @override
  String get passwordWeakError =>
      'Password must be at least 8 characters and include an uppercase letter, a lowercase letter, and a number';

  @override
  String get passwordChangedSnackbar => 'Password updated';

  @override
  String get currentPasswordIncorrectError => 'Current password is incorrect';

  @override
  String get passwordUpdateError => 'Could not update password. Try again.';

  @override
  String get updateButton => 'Update';

  @override
  String get nameEmptyError => 'Name cannot be empty';

  @override
  String get emailInvalidEdit => 'Enter a valid email';

  @override
  String get saveButton => 'Save';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get profileUpdateError => 'Could not update profile';

  @override
  String get totalAnalysesLabel => 'Total Analyses';

  @override
  String get membershipDateLabel => 'Member Since';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeSectionTitle => 'Theme';

  @override
  String get notificationsSectionTitle => 'Notifications';

  @override
  String get routineReminderLabel => 'Routine Reminder';

  @override
  String get reminderTimeLabel => 'Reminder Time';

  @override
  String get subscriptionSectionTitle => 'Subscription';

  @override
  String get currentPlanLabel => 'Current Plan';

  @override
  String get proPlanLabel => 'Pro';

  @override
  String get freePlanLabel => 'Free';

  @override
  String get manageSubscriptionLabel => 'Manage Subscription';

  @override
  String get accountSectionTitle => 'Account';

  @override
  String get exportDataLabel => 'Export My Data';

  @override
  String get deleteAccountLabel => 'Delete My Account';

  @override
  String get aboutSectionTitle => 'About';

  @override
  String get versionLabel => 'Version';

  @override
  String get privacyPolicyLabel => 'Privacy Policy';

  @override
  String get termsOfUseLabel => 'Terms of Use';

  @override
  String get licensesLabel => 'Licenses';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get preparingData => 'Preparing data...';

  @override
  String get dataExportFailed => 'Could not export data';

  @override
  String get deletingAccount => 'Deleting account...';

  @override
  String get accountDeletionFailed =>
      'Could not delete account. Please try again.';

  @override
  String get deleteAccountTitle => 'Delete Account';

  @override
  String get deleteAccountWarning =>
      'This action cannot be undone. All your data, analyses, and photos will be permanently deleted.';

  @override
  String get deleteAccountConfirm => 'Yes, Delete My Account';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get proUpgradeTitle => 'Go Pro';

  @override
  String get proUpgradeSubtitle =>
      'Take your skincare journey to the next level';

  @override
  String get yearlyPlan => 'Yearly';

  @override
  String get yearlyPeriod => '/year';

  @override
  String get yearlyDiscount => 'Save 30%';

  @override
  String get monthlyPlan => 'Monthly';

  @override
  String get monthlyPeriod => '/month';

  @override
  String get freeTrialButton => 'Try 7 Days Free';

  @override
  String get restorePurchase => 'Restore purchase';

  @override
  String get privacyLink => 'Privacy';

  @override
  String get termsLink => 'Terms of Use';

  @override
  String get proFeature => 'Pro feature';

  @override
  String get productCatalogTitle => 'Product Catalog';

  @override
  String get productsLoadError => 'Error loading products';

  @override
  String get retryButton => 'Retry';

  @override
  String get noMatchingProducts => 'No products matching your concerns';

  @override
  String get noProductsAdded => 'No products added yet';

  @override
  String get buyButton => 'Buy';

  @override
  String whyProductTitle(String name) {
    return 'Why $name?';
  }

  @override
  String get matchingConcerns => 'Matching Concerns';

  @override
  String get closeButton => 'Close';

  @override
  String get acneConcern => 'Acne';

  @override
  String get wrinklesConcern => 'Wrinkles';

  @override
  String get spotsConcern => 'Spots';

  @override
  String get poresConcern => 'Pores';

  @override
  String get drynessConcern => 'Dryness';

  @override
  String get oilinessConcern => 'Oiliness';

  @override
  String get darkCirclesConcern => 'Dark Circles';

  @override
  String get rednessConcern => 'Redness';

  @override
  String get shareTitle => 'Share';

  @override
  String get instagramOption => 'Instagram';

  @override
  String get whatsappOption => 'WhatsApp';

  @override
  String get otherOption => 'Other';

  @override
  String get homeNavLabel => 'Home';

  @override
  String get analyzeNavLabel => 'Analyze';

  @override
  String get progressNavLabel => 'Progress';

  @override
  String get routineNavLabel => 'Routine';

  @override
  String get profileNavLabel => 'Profile';

  @override
  String get morningNotificationTitle => 'Morning Routine Ready ☀️';

  @override
  String get morningNotificationBody =>
      'Start your day with care! Check your morning routine.';

  @override
  String get eveningNotificationTitle => 'Evening Routine Time 🌙';

  @override
  String get eveningNotificationBody =>
      'End the day fresh! Start your evening skincare routine.';

  @override
  String get weeklyAnalysisTitle => 'Did you do your analysis this week?';

  @override
  String get weeklyAnalysisBody =>
      'Do your weekly analysis and track your progress!';

  @override
  String get routineRemindersChannel => 'Routine Reminders';

  @override
  String get routineRemindersChannelDesc => 'Daily skincare routine reminders';

  @override
  String get weeklyAnalysisChannel => 'Weekly Analysis Reminder';

  @override
  String get weeklyAnalysisChannelDesc => 'Weekly skin analysis reminder';

  @override
  String errorDisplay(String error) {
    return 'Error: $error';
  }

  @override
  String get zoneAnalysisTitle => 'Zone Analysis';

  @override
  String get tapZonesForDetails => 'Tap zones for details';

  @override
  String get detectedConcerns => 'Detected Concerns';

  @override
  String get recommendationsTitle => 'Recommendations';

  @override
  String get severityLabel => 'Severity';

  @override
  String get zoneForehead => 'Forehead';

  @override
  String get zoneLeftCheek => 'Left Cheek';

  @override
  String get zoneRightCheek => 'Right Cheek';

  @override
  String get zoneNose => 'Nose';

  @override
  String get zoneChin => 'Chin';

  @override
  String get zoneUnderEyes => 'Under Eyes';

  @override
  String get zoneJawline => 'Jawline';

  @override
  String get concernDryness => 'Dryness';

  @override
  String get concernOiliness => 'Oiliness';

  @override
  String get concernAcne => 'Acne';

  @override
  String get concernWrinkles => 'Wrinkles';

  @override
  String get concernFinelines => 'Fine Lines';

  @override
  String get concernSpots => 'Spots';

  @override
  String get concernPores => 'Pores';

  @override
  String get concernRedness => 'Redness';

  @override
  String get concernDarkCircles => 'Dark Circles';

  @override
  String get concernUnevenTone => 'Uneven Tone';

  @override
  String get concernSagging => 'Sagging';

  @override
  String get concernSensitivity => 'Sensitivity';

  @override
  String get concernDehydration => 'Dehydration';

  @override
  String get concernHyperpigmentation => 'Hyperpigmentation';

  @override
  String get concernTexture => 'Texture';

  @override
  String get deleteStepTitle => 'Delete Step';

  @override
  String get deleteStepConfirmation =>
      'Are you sure you want to delete this step?';

  @override
  String get deleteButton => 'Delete';

  @override
  String get productsComingSoon => 'Product recommendations coming soon';

  @override
  String get scoreTrendTitle => 'Score Trend';

  @override
  String get secondAnalysisInfoTitle => 'Take Your 2nd Analysis!';

  @override
  String get secondAnalysisInfoDescription =>
      'Comparison, trend chart, and most improved zone features activate after your 2nd analysis.';

  @override
  String get startSecondAnalysisButton => 'Analyze';

  @override
  String get pastAnalysesTitle => 'Past Analyses';

  @override
  String get analysisDetailTitle => 'Analysis Detail';

  @override
  String get landingHeroTitle => 'Analyze Your Skin\nwith AI';

  @override
  String get landingHeroDescription =>
      'Get detailed insights about your skin with AI-powered analysis and create your personal skincare routine.';

  @override
  String get getStartedButton => 'Get Started';

  @override
  String get appStoreBadge => 'App Store';

  @override
  String get googlePlayBadge => 'Google Play';

  @override
  String get featuredFeaturesTitle => 'Featured';

  @override
  String get featuredFeaturesSubtitle =>
      'Discover the AI revolution in skincare';

  @override
  String get aiAnalysisFeatureTitle => 'AI Skin Analysis';

  @override
  String get aiAnalysisFeatureDesc =>
      'AI analyzes your face in 7 zones and provides a detailed score.';

  @override
  String get personalRoutineFeatureTitle => 'Personal Routine';

  @override
  String get personalRoutineFeatureDesc =>
      'Creates morning/evening skincare routines tailored to your skin type and concerns.';

  @override
  String get progressTrackingFeatureTitle => 'Progress Tracking';

  @override
  String get progressTrackingFeatureDesc =>
      'Track your skin changes over time with charts.';

  @override
  String get productRecsFeatureTitle => 'Product Recommendations';

  @override
  String get productRecsFeatureDesc =>
      'Get product recommendations for your skin concerns and buy instantly.';

  @override
  String get howItWorksTitle => 'How It Works';

  @override
  String get howItWorksSubtitle =>
      'Complete your skin analysis in 3 simple steps';

  @override
  String get step1Title => 'Take a Selfie';

  @override
  String get step1Desc => 'Quickly take a selfie using your front camera.';

  @override
  String get step2Title => 'AI Analysis';

  @override
  String get step2Desc => 'AI analyzes your skin in 7 different zones.';

  @override
  String get step3Title => 'Get Routine';

  @override
  String get step3Desc =>
      'Apply your personalized skincare routine right away.';

  @override
  String get relatedRoutineSteps => 'Related Routine Steps';

  @override
  String get morningReminderLabel => 'Morning Reminder Time';

  @override
  String get eveningReminderLabel => 'Evening Reminder Time';

  @override
  String get streakNotificationLabel => 'Streak Notifications';

  @override
  String get motivationalNotificationLabel => 'Motivational Messages';

  @override
  String get weeklyReminderDayLabel => 'Weekly Analysis Day';

  @override
  String get guidedModeTitle => 'Guided Mode';

  @override
  String get nextStepButton => 'Next Step';

  @override
  String get completeRoutineButton => 'Complete Routine';

  @override
  String get whyThisStep => 'Why this step?';

  @override
  String get howToApply => 'How to Apply?';

  @override
  String get guidedModeComplete =>
      'Congratulations! You completed your routine!';

  @override
  String get updateRoutineTitle => 'Update Your Routine';

  @override
  String get updateRoutinePrompt =>
      'Your routine has changes based on the new analysis';

  @override
  String get updateRoutineButton => 'Update Routine';

  @override
  String get applyUpdateButton => 'Update';

  @override
  String get skipUpdateButton => 'Not Now';

  @override
  String get noChangesMessage => 'No changes in your routine';

  @override
  String get concernTimelineTitle => 'Concern Tracking';

  @override
  String get concernTimelineSubtitle => 'How skin concerns evolve over time';

  @override
  String get concernTimelineEmpty =>
      'Tracking cards will appear here after at least 2 analyses';

  @override
  String concernTrendImproved(int percent) {
    return '$percent% improved';
  }

  @override
  String concernTrendWorsened(int percent) {
    return '$percent% worsened';
  }

  @override
  String get concernTrendStable => 'No change';

  @override
  String get concernTrendFirstMeasurement => 'First measurement';

  @override
  String get concernTrendBefore => 'Before';

  @override
  String get concernTrendNow => 'Now';

  @override
  String get concernTrendImprovedLabel => 'Improved';

  @override
  String get concernTrendStableLabel => 'Stable';

  @override
  String get concernTrendWorsenedLabel => 'Watch';

  @override
  String concernTrendSummary(int improved, int stable, int worsened) {
    return '$improved improved · $stable stable · $worsened need attention';
  }

  @override
  String get severityNone => 'None';

  @override
  String get severityMild => 'Mild';

  @override
  String get severityModerate => 'Moderate';

  @override
  String get severitySevere => 'Severe';

  @override
  String get badgesTitle => 'My Badges';

  @override
  String get viewAllBadges => 'View All';

  @override
  String get weeklySummaryTitle => 'Weekly Summary';

  @override
  String get badgeFirstAnalysis => 'First Analysis';

  @override
  String get badgeFirstAnalysisDesc => 'Completed your first skin analysis!';

  @override
  String get badgeFirstRoutine => 'First Routine';

  @override
  String get badgeFirstRoutineDesc => 'Created your first skincare routine!';

  @override
  String get badgeStreak7 => '7-Day Streak';

  @override
  String get badgeStreak7Desc => 'Completed your routine 7 days in a row!';

  @override
  String get badgeStreak14 => '14-Day Streak';

  @override
  String get badgeStreak14Desc => 'Completed your routine 14 days in a row!';

  @override
  String get badgeStreak30 => '30-Day Master';

  @override
  String get badgeStreak30Desc => 'Never missed a day for 30 days!';

  @override
  String get badgeStreak60 => '60-Day Legend';

  @override
  String get badgeStreak60Desc => '60 days of consistent skincare!';

  @override
  String get badgeScore80 => 'Radiant Skin';

  @override
  String get badgeScore80Desc => 'Your skin score went above 80!';

  @override
  String get badgeScoreImproved10 => '10-Point Boost';

  @override
  String get badgeScoreImproved10Desc =>
      'Your skin score improved by more than 10 points!';

  @override
  String get badgeLocked => 'Locked';

  @override
  String badgeUnlockedOn(String date) {
    return 'Unlocked on $date';
  }

  @override
  String get onboardingFirstAnalysisTitle =>
      'Let\'s Take Your\nFirst Analysis!';

  @override
  String get onboardingFirstAnalysisSubtitle =>
      'Learn everything about your skin in 3 steps';

  @override
  String get onboardingStep1Label => 'Take a Selfie';

  @override
  String get onboardingStep1Desc => 'Quick selfie with front camera';

  @override
  String get onboardingStep2Label => 'AI Analyzes';

  @override
  String get onboardingStep2Desc => 'Detailed analysis in 7 zones';

  @override
  String get onboardingStep3Label => 'See Results';

  @override
  String get onboardingStep3Desc => 'Score, tips & personal routine';

  @override
  String get onboardingOpenCamera => 'Open Camera';

  @override
  String get onboardingAnalyzingTitle => 'Analyzing Your Skin';

  @override
  String get onboardingAnalyzingStage1 => 'Scanning your skin...';

  @override
  String get onboardingAnalyzingStage2 => 'Examining 7 zones...';

  @override
  String get onboardingAnalyzingStage3 => 'Preparing personalized tips...';

  @override
  String get onboardingAnalyzingStage4 => 'Results almost ready!';

  @override
  String get onboardingAnalyzingFooter =>
      'Our AI model is examining your skin in detail';

  @override
  String get onboardingResultTitle => 'Here Are Your Results!';

  @override
  String get onboardingResultScoreLabel => 'Your Skin Score';

  @override
  String onboardingResultSkinAge(int age) {
    return 'Skin Age: $age';
  }

  @override
  String get onboardingResultNext => 'What\'s Next?';

  @override
  String get onboardingTourTitle => 'Explore the App';

  @override
  String get onboardingTourRoutineTitle => 'Your Personal Routine';

  @override
  String get onboardingTourRoutineDesc =>
      'Morning and evening routines auto-created from your AI analysis. Follow step-by-step guided mode.';

  @override
  String get onboardingTourProgressTitle => 'Track Your Progress';

  @override
  String get onboardingTourProgressDesc =>
      'Analyze regularly to track skin changes with charts. Compare before and after results.';

  @override
  String get onboardingTourProductsTitle => 'Smart Product Picks';

  @override
  String get onboardingTourProductsDesc =>
      'Get product recommendations tailored to your skin concerns. Finding the right product made easy.';

  @override
  String get onboardingCompletionTitle => 'You\'re All Set!';

  @override
  String get onboardingCompletionSubtitle => 'Your skincare journey starts now';

  @override
  String get onboardingCompletionFeature1 => 'Daily routine reminders';

  @override
  String get onboardingCompletionFeature2 => 'Weekly analysis tracking';

  @override
  String get onboardingCompletionFeature3 => 'Personalized recommendations';

  @override
  String get onboardingStartExploring => 'Start Exploring';

  @override
  String get onboardingSkipAnalysis => 'Skip for Now';

  @override
  String get analysisErrorTransient =>
      'Our analysis service is busy. Please try again in a few seconds.';

  @override
  String get analysisErrorNetwork =>
      'Check your internet connection and try again.';

  @override
  String get analysisErrorQuota =>
      'Daily analysis limit reached. Please try again later.';

  @override
  String get analysisErrorUnknown =>
      'An unexpected error occurred. Please try again.';

  @override
  String get goHomeButton => 'Go to Home';
}
