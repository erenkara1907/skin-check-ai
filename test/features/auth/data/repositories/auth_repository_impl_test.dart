import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skincheck_ai/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:skincheck_ai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:skincheck_ai/features/auth/domain/entities/user_entity.dart';

class MockSupabaseAuthDataSource extends Mock
    implements SupabaseAuthDataSource {}

void main() {
  late MockSupabaseAuthDataSource mockDataSource;
  late AuthRepositoryImpl repository;

  const testUser = UserEntity(
    id: 'test-uid',
    email: 'test@example.com',
    name: 'Test User',
  );

  setUp(() {
    mockDataSource = MockSupabaseAuthDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('signInWithEmail', () {
    test('returns user on success', () async {
      when(() => mockDataSource.signInWithEmail(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => testUser);

      final result = await repository.signInWithEmail(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(result, testUser);
      verify(() => mockDataSource.signInWithEmail(
            email: 'test@example.com',
            password: 'password123',
          )).called(1);
    });

    test('rethrows exception on failure', () async {
      when(() => mockDataSource.signInWithEmail(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception('Invalid credentials'));

      expect(
        () => repository.signInWithEmail(
          email: 'test@example.com',
          password: 'wrong',
        ),
        throwsException,
      );
    });
  });

  group('signUp', () {
    test('returns user on success', () async {
      when(() => mockDataSource.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            name: any(named: 'name'),
          )).thenAnswer((_) async => testUser);

      final result = await repository.signUp(
        email: 'test@example.com',
        password: 'password123',
        name: 'Test User',
      );

      expect(result, testUser);
    });

    test('rethrows exception on failure', () async {
      when(() => mockDataSource.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            name: any(named: 'name'),
          )).thenThrow(Exception('Email taken'));

      expect(
        () => repository.signUp(
          email: 'test@example.com',
          password: 'password123',
        ),
        throwsException,
      );
    });
  });

  group('signOut', () {
    test('calls datasource signOut', () async {
      when(() => mockDataSource.signOut()).thenAnswer((_) async {});

      await repository.signOut();

      verify(() => mockDataSource.signOut()).called(1);
    });

    test('rethrows exception on failure', () async {
      when(() => mockDataSource.signOut()).thenThrow(Exception('Network'));

      expect(() => repository.signOut(), throwsException);
    });
  });

  group('currentUser', () {
    test('returns user from datasource', () {
      when(() => mockDataSource.currentUser).thenReturn(testUser);

      expect(repository.currentUser, testUser);
    });

    test('returns null when not authenticated', () {
      when(() => mockDataSource.currentUser).thenReturn(null);

      expect(repository.currentUser, isNull);
    });
  });

  group('authStateChanges', () {
    test('emits user changes from datasource', () {
      when(() => mockDataSource.authStateChanges())
          .thenAnswer((_) => Stream.fromIterable([testUser, null]));

      expect(
        repository.authStateChanges(),
        emitsInOrder([testUser, null]),
      );
    });
  });
}
