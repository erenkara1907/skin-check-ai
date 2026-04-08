import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

import '../config/env_config.dart';
import '../utils/logger.dart';

/// Singleton wrapper for RevenueCat SDK initialization.
abstract final class RevenueCatService {
  static bool _initialized = false;

  /// Initializes the RevenueCat SDK with platform-specific API key.
  static Future<void> initialize() async {
    if (_initialized) return;

    final apiKey = Platform.isIOS
        ? EnvConfig.revenueCatApiKeyIos
        : EnvConfig.revenueCatApiKeyAndroid;

    final configuration = PurchasesConfiguration(apiKey);
    await Purchases.configure(configuration);

    _initialized = true;
    log.i('RevenueCat initialized');
  }

  /// Identifies the user in RevenueCat after auth.
  static Future<void> login(String userId) async {
    await Purchases.logIn(userId);
    log.i('RevenueCat user logged in: $userId');
  }

  /// Logs out the current RevenueCat user.
  static Future<void> logout() async {
    await Purchases.logOut();
    log.i('RevenueCat user logged out');
  }
}
