import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skincheck_ai/features/auth/domain/entities/user_entity.dart';
import 'package:skincheck_ai/features/profile/data/datasources/profile_datasource.dart';
import 'package:skincheck_ai/features/profile/data/repositories/profile_repository_impl.dart';

class MockProfileDatasource extends Mock implements ProfileDatasource {}

void main() {
  late MockProfileDatasource mockDatasource;
  late ProfileRepositoryImpl repository;

  const testUser = UserEntity(
    id: 'test-uid',
    email: 'test@example.com',
    name: 'Test User',
  );

  const testUserId = 'test-uid';

  setUp(() {
    mockDatasource = MockProfileDatasource();
    repository = ProfileRepositoryImpl(mockDatasource);
  });

  group('updateProfile', () {
    test('returns updated user on success', () async {
      when(() => mockDatasource.updateProfile(
            userId: any(named: 'userId'),
            name: any(named: 'name'),
            email: any(named: 'email'),
          )).thenAnswer((_) async => testUser);

      final result = await repository.updateProfile(
        userId: testUserId,
        name: 'New Name',
        email: 'new@example.com',
      );

      expect(result, testUser);
      verify(() => mockDatasource.updateProfile(
            userId: testUserId,
            name: 'New Name',
            email: 'new@example.com',
          )).called(1);
    });

    test('rethrows exception on failure', () async {
      when(() => mockDatasource.updateProfile(
            userId: any(named: 'userId'),
            name: any(named: 'name'),
            email: any(named: 'email'),
          )).thenThrow(Exception('Update failed'));

      expect(
        () => repository.updateProfile(
          userId: testUserId,
          name: 'New Name',
        ),
        throwsException,
      );
    });
  });

  group('getAnalysisCount', () {
    test('returns count on success', () async {
      when(() => mockDatasource.getAnalysisCount(any()))
          .thenAnswer((_) async => 5);

      final result = await repository.getAnalysisCount(testUserId);

      expect(result, 5);
    });

    test('rethrows exception on failure', () async {
      when(() => mockDatasource.getAnalysisCount(any()))
          .thenThrow(Exception('DB error'));

      expect(
        () => repository.getAnalysisCount(testUserId),
        throwsException,
      );
    });
  });

  group('getJoinDate', () {
    test('returns date on success', () async {
      final date = DateTime(2026, 1, 15);
      when(() => mockDatasource.getJoinDate(any()))
          .thenAnswer((_) async => date);

      final result = await repository.getJoinDate(testUserId);

      expect(result, date);
    });

    test('returns null when no date found', () async {
      when(() => mockDatasource.getJoinDate(any()))
          .thenAnswer((_) async => null);

      final result = await repository.getJoinDate(testUserId);

      expect(result, isNull);
    });
  });

  group('exportUserData', () {
    test('returns data map on success', () async {
      final exportData = {
        'exported_at': '2026-04-08T12:00:00.000',
        'user': {'id': testUserId, 'email': 'test@example.com'},
        'analyses': <dynamic>[],
        'routines': <dynamic>[],
        'progress_logs': <dynamic>[],
      };
      when(() => mockDatasource.exportUserData(any()))
          .thenAnswer((_) async => exportData);

      final result = await repository.exportUserData(testUserId);

      expect(result, exportData);
      expect(result.containsKey('user'), isTrue);
      expect(result.containsKey('analyses'), isTrue);
    });

    test('rethrows exception on failure', () async {
      when(() => mockDatasource.exportUserData(any()))
          .thenThrow(Exception('Export failed'));

      expect(
        () => repository.exportUserData(testUserId),
        throwsException,
      );
    });
  });

  group('deleteAccount', () {
    test('calls datasource deleteAccount', () async {
      when(() => mockDatasource.deleteAccount(any()))
          .thenAnswer((_) async {});

      await repository.deleteAccount(testUserId);

      verify(() => mockDatasource.deleteAccount(testUserId)).called(1);
    });

    test('rethrows exception on failure', () async {
      when(() => mockDatasource.deleteAccount(any()))
          .thenThrow(Exception('Delete failed'));

      expect(
        () => repository.deleteAccount(testUserId),
        throwsException,
      );
    });
  });
}
