import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/revenuecat_datasource.dart';
import '../../data/repositories/subscription_repository_impl.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/repositories/subscription_repository.dart';

part 'subscription_provider.g.dart';

/// Provides the [SubscriptionRepository] instance.
@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(Ref ref) {
  return SubscriptionRepositoryImpl(
    datasource: RevenueCatDatasource(),
    supabaseClient: SupabaseService.client,
  );
}

/// Manages subscription state across the app.
@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  late final SubscriptionRepository _repo;

  @override
  FutureOr<SubscriptionEntity> build() {
    _repo = ref.read(subscriptionRepositoryProvider);
    return _repo.getSubscription();
  }

  /// Purchases a subscription package.
  Future<void> purchase(String packageId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.purchase(packageId));
  }

  /// Restores previous purchases.
  Future<void> restore() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.restorePurchases());
  }

  /// Refreshes subscription state from RevenueCat.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.getSubscription());
  }
}

/// Whether the current user has an active Pro subscription.
@riverpod
bool isPro(Ref ref) {
  // Bypass paywall in debug builds
  if (const bool.fromEnvironment('dart.vm.product') == false) {
    return true;
  }
  final sub = ref.watch(subscriptionNotifierProvider);
  return sub.valueOrNull?.hasProEntitlement ?? false;
}

/// Number of analyses the user has performed this week.
@riverpod
Future<int> weeklyAnalysisCount(Ref ref) async {
  final auth = ref.watch(authNotifierProvider);
  final user = auth.valueOrNull;
  if (user == null) return 0;

  final repo = ref.read(subscriptionRepositoryProvider);
  return repo.getWeeklyAnalysisCount(user.id);
}

/// Whether the user can perform a new analysis.
@riverpod
Future<bool> canAnalyze(Ref ref) async {
  final isPro = ref.watch(isProProvider);
  if (isPro) return true;

  final count = await ref.watch(weeklyAnalysisCountProvider.future);
  return count < AppConstants.freeWeeklyAnalysisLimit;
}
