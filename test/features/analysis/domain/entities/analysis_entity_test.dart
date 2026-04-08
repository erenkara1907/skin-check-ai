import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/analysis/domain/entities/analysis_entity.dart';
import 'package:skincheck_ai/features/analysis/domain/entities/routine_step_entity.dart';
import 'package:skincheck_ai/features/analysis/domain/entities/skin_zone.dart';
import 'package:skincheck_ai/features/analysis/domain/entities/zone_score_entity.dart';

void main() {
  group('AnalysisEntity', () {
    test('fromJson parses snake_case fields correctly', () {
      final json = {
        'id': 'abc-123',
        'user_id': 'user-1',
        'photo_url': 'photos/user-1/123.jpg',
        'overall_score': 75.0,
        'skin_age': 28,
        'summary': 'Good skin condition',
        'zones': <dynamic>[],
        'morning_routine': <dynamic>[],
        'evening_routine': <dynamic>[],
        'created_at': '2026-04-08T10:00:00.000Z',
      };

      final entity = AnalysisEntity.fromJson(json);

      expect(entity.id, 'abc-123');
      expect(entity.userId, 'user-1');
      expect(entity.photoUrl, 'photos/user-1/123.jpg');
      expect(entity.overallScore, 75.0);
      expect(entity.skinAge, 28);
      expect(entity.summary, 'Good skin condition');
      expect(entity.createdAt, isA<DateTime>());
    });

    test('fromJson uses defaults for missing optional fields', () {
      final json = {
        'id': 'abc-123',
        'user_id': 'user-1',
        'overall_score': 50.0,
        'skin_age': 30,
      };

      final entity = AnalysisEntity.fromJson(json);

      expect(entity.photoUrl, isNull);
      expect(entity.summary, '');
      expect(entity.zones, isEmpty);
      expect(entity.morningRoutine, isEmpty);
      expect(entity.eveningRoutine, isEmpty);
      expect(entity.createdAt, isNull);
    });

    test('equality works with Freezed', () {
      final a = AnalysisEntity(
        id: '1',
        userId: 'u1',
        overallScore: 80,
        skinAge: 25,
      );
      final b = AnalysisEntity(
        id: '1',
        userId: 'u1',
        overallScore: 80,
        skinAge: 25,
      );

      expect(a, equals(b));
    });

    test('copyWith creates modified copy', () {
      final original = AnalysisEntity(
        id: '1',
        userId: 'u1',
        overallScore: 80,
        skinAge: 25,
      );

      final modified = original.copyWith(overallScore: 90);

      expect(modified.overallScore, 90);
      expect(modified.id, '1');
    });
  });

  group('ZoneScoreEntity', () {
    test('fromJson parses correctly', () {
      final json = {
        'zone': 'forehead',
        'score': 85.0,
        'concerns': ['acne', 'dryness'],
        'severity': 3,
        'recommendations': ['Use moisturizer'],
      };

      final entity = ZoneScoreEntity.fromJson(json);

      expect(entity.zone, 'forehead');
      expect(entity.score, 85.0);
      expect(entity.concerns, ['acne', 'dryness']);
      expect(entity.severity, 3);
      expect(entity.recommendations, ['Use moisturizer']);
    });

    test('uses defaults for missing fields', () {
      final json = {
        'zone': 'nose',
        'score': 60.0,
      };

      final entity = ZoneScoreEntity.fromJson(json);

      expect(entity.concerns, isEmpty);
      expect(entity.severity, 5);
      expect(entity.recommendations, isEmpty);
    });
  });

  group('RoutineStepEntity', () {
    test('fromJson parses snake_case product_type', () {
      final json = {
        'step': 'Cleanse',
        'product_type': 'Gentle Cleanser',
        'reason': 'Remove impurities',
      };

      final entity = RoutineStepEntity.fromJson(json);

      expect(entity.step, 'Cleanse');
      expect(entity.productType, 'Gentle Cleanser');
      expect(entity.reason, 'Remove impurities');
    });
  });

  group('SkinZone', () {
    test('fromValue returns correct zone', () {
      expect(
        SkinZone.fromValue('forehead'),
        SkinZone.forehead,
      );
      expect(
        SkinZone.fromValue('left_cheek'),
        SkinZone.leftCheek,
      );
    });

    test('fromValue returns forehead for unknown value', () {
      expect(
        SkinZone.fromValue('unknown'),
        SkinZone.forehead,
      );
    });

    test('all zones have Turkish labels', () {
      for (final zone in SkinZone.values) {
        expect(zone.label, isNotEmpty);
      }
    });
  });
}
