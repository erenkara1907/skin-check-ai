import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/subscription_entity.dart';

/// Data source wrapping RevenueCat SDK calls.
class RevenueCatDatasource {
  /// Fetches the current customer info and maps to [SubscriptionEntity].
  Future<SubscriptionEntity> getSubscription() async {
    final customerInfo = await Purchases.getCustomerInfo();
    return _mapCustomerInfo(customerInfo);
  }

  /// Purchases a package by [packageId] from the default offering.
  Future<SubscriptionEntity> purchase(String packageId) async {
    final offerings = await Purchases.getOfferings();
    final offering = offerings.current;

    if (offering == null) {
      throw Exception('No offerings available');
    }

    final package = offering.availablePackages.firstWhere(
      (p) => p.identifier == packageId,
      orElse: () => throw Exception('Package not found: $packageId'),
    );

    final customerInfo = await Purchases.purchasePackage(package);
    return _mapCustomerInfo(customerInfo);
  }

  /// Restores previously purchased subscriptions.
  Future<SubscriptionEntity> restorePurchases() async {
    final customerInfo = await Purchases.restorePurchases();
    return _mapCustomerInfo(customerInfo);
  }

  SubscriptionEntity _mapCustomerInfo(CustomerInfo info) {
    final entitlement =
        info.entitlements.all[AppConstants.proEntitlementId];
    final isActive = entitlement?.isActive ?? false;

    log.d('RevenueCat entitlement: pro=$isActive');

    return SubscriptionEntity(
      tier: isActive ? 'pro' : 'free',
      isActive: isActive,
      expiresAt: entitlement?.expirationDate != null
          ? DateTime.tryParse(entitlement!.expirationDate!)
          : null,
      hasProEntitlement: isActive,
    );
  }
}
