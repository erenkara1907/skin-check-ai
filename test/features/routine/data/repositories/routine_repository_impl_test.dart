import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skincheck_ai/features/routine/data/datasources/routine_datasource.dart';
import 'package:skincheck_ai/features/routine/data/repositories/routine_repository_impl.dart';
import 'package:skincheck_ai/features/routine/domain/entities/routine_entity.dart';


class MockRoutineDataSource extends Mock implements RoutineDataSource {}

void main() {
  late MockRoutineDataSource mockDataSource;
  late RoutineRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockRoutineDataSource();
    repository = RoutineRepositoryImpl(mockDataSource);
  });

  group('getActiveRoutines', () {
    test('returns mapped entities from datasource', () async {
      when(() => mockDataSource.fetchActiveRoutines(any()))
          .thenAnswer((_) async => [
                {
                  'id': 'r1',
                  'user_id': 'u1',
                  'type': 'morning',
                  'steps': [
                    {
                      'step': 'Cleanse',
                      'product_type': 'cleanser',
                      'reason': 'Clean face',
                      'how_to_apply': 'Apply gently',
                      'icon_name': 'droplets',
                      'is_completed': false,
                    }
                  ],
                  'is_active': true,
                  'created_at': '2026-04-08T10:00:00Z',
                  'updated_at': '2026-04-08T10:00:00Z',
                },
              ]);

      final result = await repository.getActiveRoutines('u1');

      expect(result, hasLength(1));
      expect(result.first.id, 'r1');
      expect(result.first.type, 'morning');
      expect(result.first.steps, hasLength(1));
      expect(result.first.steps.first.step, 'Cleanse');
    });

    test('returns empty list when no routines', () async {
      when(() => mockDataSource.fetchActiveRoutines(any()))
          .thenAnswer((_) async => []);

      final result = await repository.getActiveRoutines('u1');
      expect(result, isEmpty);
    });

    test('rethrows on datasource error', () async {
      when(() => mockDataSource.fetchActiveRoutines(any()))
          .thenAnswer((_) async => throw Exception('Network error'));

      expect(
        () => repository.getActiveRoutines('u1'),
        throwsException,
      );
    });
  });

  group('saveRoutine', () {
    test('upserts and returns mapped entity', () async {
      when(() => mockDataSource.upsertRoutine(any()))
          .thenAnswer((_) async => {
                'id': 'r1',
                'user_id': 'u1',
                'type': 'evening',
                'steps': <dynamic>[],
                'is_active': true,
                'created_at': '2026-04-08T10:00:00Z',
                'updated_at': '2026-04-08T10:00:00Z',
              });

      final result = await repository.saveRoutine(
        const RoutineEntity(
          id: '',
          userId: 'u1',
          type: 'evening',
          steps: [],
        ),
      );

      expect(result.id, 'r1');
      expect(result.type, 'evening');
      verify(() => mockDataSource.upsertRoutine(any())).called(1);
    });
  });

  group('deleteRoutine', () {
    test('delegates to datasource', () async {
      when(() => mockDataSource.deleteRoutine(any()))
          .thenAnswer((_) async {});

      await repository.deleteRoutine('r1');

      verify(() => mockDataSource.deleteRoutine('r1')).called(1);
    });
  });

  group('completeRoutine', () {
    test('inserts completion and returns entity', () async {
      when(() => mockDataSource.insertCompletion(any()))
          .thenAnswer((_) async => {
                'id': 'c1',
                'user_id': 'u1',
                'routine_id': 'r1',
                'completed_at': '2026-04-08',
                'completed_steps': ['Cleanse', 'Moisturize'],
              });

      final result = await repository.completeRoutine(
        userId: 'u1',
        routineId: 'r1',
        completedSteps: ['Cleanse', 'Moisturize'],
      );

      expect(result.id, 'c1');
      expect(result.completedSteps, hasLength(2));
    });
  });

  group('getStreak', () {
    test('returns zero streak when no completions', () async {
      when(() => mockDataSource.fetchCompletions(
            userId: any(named: 'userId'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => []);

      final streak = await repository.getStreak('u1');

      expect(streak.currentStreak, 0);
      expect(streak.longestStreak, 0);
      expect(streak.lastCompletedDate, isNull);
    });

    test('calculates streak from consecutive days', () async {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      when(() => mockDataSource.fetchCompletions(
            userId: any(named: 'userId'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => [
                {
                  'id': 'c1',
                  'user_id': 'u1',
                  'routine_id': 'r1',
                  'completed_at': today.toIso8601String(),
                  'completed_steps': ['Cleanse'],
                },
                {
                  'id': 'c2',
                  'user_id': 'u1',
                  'routine_id': 'r1',
                  'completed_at': yesterday.toIso8601String(),
                  'completed_steps': ['Cleanse'],
                },
                {
                  'id': 'c3',
                  'user_id': 'u1',
                  'routine_id': 'r1',
                  'completed_at': twoDaysAgo.toIso8601String(),
                  'completed_steps': ['Cleanse'],
                },
              ]);

      final streak = await repository.getStreak('u1');

      expect(streak.currentStreak, 3);
      expect(streak.longestStreak, 3);
    });

    test('breaks streak on missed day', () async {
      final today = DateTime.now();
      final threeDaysAgo = today.subtract(const Duration(days: 3));

      when(() => mockDataSource.fetchCompletions(
            userId: any(named: 'userId'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => [
                {
                  'id': 'c1',
                  'user_id': 'u1',
                  'routine_id': 'r1',
                  'completed_at': today.toIso8601String(),
                  'completed_steps': ['Cleanse'],
                },
                {
                  'id': 'c2',
                  'user_id': 'u1',
                  'routine_id': 'r1',
                  'completed_at': threeDaysAgo.toIso8601String(),
                  'completed_steps': ['Cleanse'],
                },
              ]);

      final streak = await repository.getStreak('u1');

      expect(streak.currentStreak, 1);
    });
  });
}
