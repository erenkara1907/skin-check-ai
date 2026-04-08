import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skincheck_ai/features/subscription/data/datasources/revenuecat_datasource.dart';
import 'package:skincheck_ai/features/subscription/data/repositories/subscription_repository_impl.dart';
import 'package:skincheck_ai/features/subscription/domain/entities/subscription_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockRevenueCatDatasource extends Mock implements RevenueCatDatasource {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  late MockRevenueCatDatasource mockDatasource;
  late MockSupabaseClient mockSupabase;
  late SubscriptionRepositoryImpl repo;

  setUp(() {
    mockDatasource = MockRevenueCatDatasource();
    mockSupabase = MockSupabaseClient();
    repo = SubscriptionRepositoryImpl(
      datasource: mockDatasource,
      supabaseClient: mockSupabase,
    );
  });

  group('getSubscription', () {
    test('delegates to datasource', () async {
      const expected = SubscriptionEntity(
        tier: 'pro',
        isActive: true,
        hasProEntitlement: true,
      );
      when(() => mockDatasource.getSubscription())
          .thenAnswer((_) async => expected);

      final result = await repo.getSubscription();
      expect(result, expected);
      verify(() => mockDatasource.getSubscription()).called(1);
    });
  });

  group('purchase', () {
    test('delegates to datasource with package ID', () async {
      const expected = SubscriptionEntity(
        tier: 'pro',
        isActive: true,
        hasProEntitlement: true,
      );
      when(() => mockDatasource.purchase('monthly'))
          .thenAnswer((_) async => expected);

      final result = await repo.purchase('monthly');
      expect(result, expected);
      verify(() => mockDatasource.purchase('monthly')).called(1);
    });
  });

  group('restorePurchases', () {
    test('delegates to datasource', () async {
      const expected = SubscriptionEntity(hasProEntitlement: true);
      when(() => mockDatasource.restorePurchases())
          .thenAnswer((_) async => expected);

      final result = await repo.restorePurchases();
      expect(result, expected);
      verify(() => mockDatasource.restorePurchases()).called(1);
    });
  });
}
