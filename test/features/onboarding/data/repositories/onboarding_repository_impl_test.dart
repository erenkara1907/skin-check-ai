import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skincheck_ai/features/onboarding/data/datasources/onboarding_datasource.dart';
import 'package:skincheck_ai/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:skincheck_ai/features/onboarding/domain/entities/skin_concern.dart';
import 'package:skincheck_ai/features/onboarding/domain/entities/skin_type.dart';

class MockOnboardingDataSource extends Mock implements OnboardingDataSource {}

void main() {
  late MockOnboardingDataSource mockDataSource;
  late OnboardingRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(SkinType.normal);
    registerFallbackValue(<SkinConcern>[]);
  });

  setUp(() {
    mockDataSource = MockOnboardingDataSource();
    repository = OnboardingRepositoryImpl(mockDataSource);
  });

  group('completeOnboarding', () {
    test('delegates to datasource', () async {
      when(() => mockDataSource.completeOnboarding(
            userId: any(named: 'userId'),
            skinType: any(named: 'skinType'),
            concerns: any(named: 'concerns'),
          )).thenAnswer((_) async {});

      await repository.completeOnboarding(
        userId: 'test-uid',
        skinType: SkinType.oily,
        concerns: [SkinConcern.acne, SkinConcern.pores],
      );

      verify(() => mockDataSource.completeOnboarding(
            userId: 'test-uid',
            skinType: SkinType.oily,
            concerns: [SkinConcern.acne, SkinConcern.pores],
          )).called(1);
    });

    test('rethrows exception on failure', () async {
      when(() => mockDataSource.completeOnboarding(
            userId: any(named: 'userId'),
            skinType: any(named: 'skinType'),
            concerns: any(named: 'concerns'),
          )).thenThrow(Exception('Network error'));

      expect(
        () => repository.completeOnboarding(
          userId: 'test-uid',
          skinType: SkinType.normal,
          concerns: [SkinConcern.dryness],
        ),
        throwsException,
      );
    });
  });
}
