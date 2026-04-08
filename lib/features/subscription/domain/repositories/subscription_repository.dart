import '../entities/subscription_entity.dart';

/// Contract for subscription operations.
abstract class SubscriptionRepository {
  /// Gets the current subscription state.
  Future<SubscriptionEntity> getSubscription();

  /// Purchases the given package by its identifier.
  Future<SubscriptionEntity> purchase(String packageId);

  /// Restores previously purchased subscriptions.
  Future<SubscriptionEntity> restorePurchases();

  /// Returns the number of analyses this week for the user.
  Future<int> getWeeklyAnalysisCount(String userId);
}
