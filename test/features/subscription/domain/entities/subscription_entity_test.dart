import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/subscription/domain/entities/subscription_entity.dart';

void main() {
  group('SubscriptionEntity', () {
    test('creates with default values', () {
      const entity = SubscriptionEntity();
      expect(entity.tier, 'free');
      expect(entity.isActive, false);
      expect(entity.expiresAt, isNull);
      expect(entity.hasProEntitlement, false);
    });

    test('creates pro subscription', () {
      final expires = DateTime(2027, 1, 1);
      final entity = SubscriptionEntity(
        tier: 'pro',
        isActive: true,
        expiresAt: expires,
        hasProEntitlement: true,
      );
      expect(entity.tier, 'pro');
      expect(entity.isActive, true);
      expect(entity.expiresAt, expires);
      expect(entity.hasProEntitlement, true);
    });

    test('JSON roundtrip', () {
      final original = SubscriptionEntity(
        tier: 'pro',
        isActive: true,
        expiresAt: DateTime.utc(2027, 1, 1),
        hasProEntitlement: true,
      );
      final json = original.toJson();
      final decoded = SubscriptionEntity.fromJson(json);
      expect(decoded, original);
    });

    test('copyWith preserves other fields', () {
      const original = SubscriptionEntity(tier: 'pro', isActive: true);
      final updated = original.copyWith(isActive: false);
      expect(updated.tier, 'pro');
      expect(updated.isActive, false);
    });
  });
}
