/// Application-wide constants.
abstract final class AppConstants {
  // Storage buckets
  static const photoBucket = 'skin-photos';

  // API
  static const analysisEndpoint = '/functions/v1/analyze-skin';
  static const maxPhotoSizeMb = 10;

  // UI
  static const animationDuration = Duration(milliseconds: 300);
  static const longAnimationDuration = Duration(milliseconds: 600);
  static const pageTransitionDuration = Duration(milliseconds: 250);

  // Limits
  static const maxFileNameLength = 100;
  static const scoreMin = 0.0;
  static const scoreMax = 100.0;

  // Subscription
  static const freeWeeklyAnalysisLimit = 1;
  static const proEntitlementId = 'pro';
  static const monthlyPlanId = 'skincheck_pro_monthly';
  static const yearlyPlanId = 'skincheck_pro_yearly';
  static const monthlyPrice = '\$5.99';
  static const yearlyPrice = '\$49.99';
}
