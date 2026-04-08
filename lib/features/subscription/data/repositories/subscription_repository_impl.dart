import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/revenuecat_datasource.dart';

/// RevenueCat + Supabase implementation of [SubscriptionRepository].
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  /// Creates the repository with required data sources.
  SubscriptionRepositoryImpl({
    required RevenueCatDatasource datasource,
    required SupabaseClient supabaseClient,
  })  : _datasource = datasource,
        _supabaseClient = supabaseClient;

  final RevenueCatDatasource _datasource;
  final SupabaseClient _supabaseClient;

  @override
  Future<SubscriptionEntity> getSubscription() =>
      _datasource.getSubscription();

  @override
  Future<SubscriptionEntity> purchase(String packageId) =>
      _datasource.purchase(packageId);

  @override
  Future<SubscriptionEntity> restorePurchases() =>
      _datasource.restorePurchases();

  @override
  Future<int> getWeeklyAnalysisCount(String userId) async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartDate = DateTime(
      weekStart.year,
      weekStart.month,
      weekStart.day,
    );

    final response = await _supabaseClient
        .from('analyses')
        .select()
        .eq('user_id', userId)
        .gte('created_at', weekStartDate.toIso8601String())
        .count(CountOption.exact);

    return response.count;
  }

  /// Checks if a free user can perform another analysis this week.
  Future<bool> canAnalyze(String userId, bool isPro) async {
    if (isPro) return true;
    final count = await getWeeklyAnalysisCount(userId);
    return count < AppConstants.freeWeeklyAnalysisLimit;
  }
}
