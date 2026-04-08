import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/routine/domain/entities/routine_entity.dart';
import 'package:skincheck_ai/features/routine/domain/entities/routine_step_detail_entity.dart';
import 'package:skincheck_ai/features/routine/domain/entities/streak_entity.dart';

void main() {
  group('RoutineEntity', () {
    test('creates with defaults', () {
      const entity = RoutineEntity(
        id: 'r1',
        userId: 'u1',
        type: 'morning',
      );

      expect(entity.steps, isEmpty);
      expect(entity.isActive, isTrue);
      expect(entity.createdAt, isNull);
    });

    test('serializes to/from JSON', () {
      final entity = RoutineEntity(
        id: 'r1',
        userId: 'u1',
        type: 'evening',
        steps: const [
          RoutineStepDetailEntity(
            step: 'Cleanse',
            productType: 'cleanser',
            reason: 'Clean face',
          ),
        ],
        createdAt: DateTime(2026, 4, 8),
      );

      // Round-trip through JSON string to simulate real serialization
      final jsonString = jsonEncode(entity.toJson());
      final restored = RoutineEntity.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );

      expect(restored.id, 'r1');
      expect(restored.type, 'evening');
      expect(restored.steps, hasLength(1));
      expect(restored.steps.first.step, 'Cleanse');
    });

    test('copyWith updates fields', () {
      const entity = RoutineEntity(
        id: 'r1',
        userId: 'u1',
        type: 'morning',
      );

      final updated = entity.copyWith(type: 'evening');
      expect(updated.type, 'evening');
      expect(updated.id, 'r1');
    });
  });

  group('RoutineStepDetailEntity', () {
    test('creates with defaults', () {
      const step = RoutineStepDetailEntity(
        step: 'Test',
        productType: 'serum',
        reason: 'Because',
      );

      expect(step.howToApply, '');
      expect(step.iconName, 'droplets');
      expect(step.isCompleted, isFalse);
    });

    test('serializes to/from JSON', () {
      const step = RoutineStepDetailEntity(
        step: 'Moisturize',
        productType: 'moisturizer',
        reason: 'Hydrate skin',
        howToApply: 'Apply gently',
        iconName: 'cloud',
      );

      final json = step.toJson();
      final restored = RoutineStepDetailEntity.fromJson(json);

      expect(restored.step, 'Moisturize');
      expect(restored.productType, 'moisturizer');
      expect(restored.iconName, 'cloud');
    });
  });

  group('StreakEntity', () {
    test('creates with zero defaults', () {
      const streak = StreakEntity();

      expect(streak.currentStreak, 0);
      expect(streak.longestStreak, 0);
      expect(streak.lastCompletedDate, isNull);
    });

    test('serializes to/from JSON', () {
      final streak = StreakEntity(
        currentStreak: 5,
        longestStreak: 10,
        lastCompletedDate: DateTime(2026, 4, 8),
      );

      final json = streak.toJson();
      final restored = StreakEntity.fromJson(json);

      expect(restored.currentStreak, 5);
      expect(restored.longestStreak, 10);
    });
  });
}
