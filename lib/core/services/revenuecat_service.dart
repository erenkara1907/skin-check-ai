import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

import '../config/env_config.dart';
import '../utils/logger.dart';

/// Singleton wrapper for RevenueCat SDK initialization.
abstract final class RevenueCatService {
  static bool _initialized = false;

  /// Whether RevenueCat was successfully configured.
  static bool get isConfigured => _initialized;

  /// Initializes the RevenueCat SDK with platform-specific API key.
  static Future<void> initialize() async {
    if (_initialized) return;

    final apiKey = Platform.isIOS
        ? EnvConfig.revenueCatApiKeyIos
        : EnvConfig.revenueCatApiKeyAndroid;

    if (apiKey.isEmpty) {
      log.w('RevenueCat API key not set — skipping initialization');
      return;
    }

    try {
      final configuration = PurchasesConfiguration(apiKey);
      await Purchases.configure(configuration);
      _initialized = true;
      log.i('RevenueCat initialized');
    } catch (e, st) {
      log.e('RevenueCat init failed', e, st);
    }
  }

  /// Identifies the user in RevenueCat after auth.
  static Future<void> login(String userId) async {
    if (!_initialized) return;
    try {
      await Purchases.logIn(userId);
      log.i('RevenueCat user logged in: $userId');
    } catch (e, st) {
      log.e('RevenueCat login failed', e, st);
    }
  }

  /// Logs out the current RevenueCat user.
  static Future<void> logout() async {
    if (!_initialized) return;
    try {
      await Purchases.logOut();
      log.i('RevenueCat user logged out');
    } catch (e, st) {
      log.e('RevenueCat logout failed', e, st);
    }
  }
}
