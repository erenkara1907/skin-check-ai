import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skincheck_ai/features/analysis/data/datasources/analysis_datasource.dart';
import 'package:skincheck_ai/features/analysis/data/repositories/analysis_repository_impl.dart';

class MockAnalysisDataSource extends Mock implements AnalysisDataSource {}

void main() {
  late MockAnalysisDataSource mockDataSource;
  late AnalysisRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    mockDataSource = MockAnalysisDataSource();
    repository = AnalysisRepositoryImpl(mockDataSource);
  });

  group('uploadPhoto', () {
    test('delegates to datasource and returns path', () async {
      when(() => mockDataSource.uploadPhoto(
            userId: any(named: 'userId'),
            photoBytes: any(named: 'photoBytes'),
          )).thenAnswer((_) async => 'user-1/123.jpg');

      final result = await repository.uploadPhoto(
        userId: 'user-1',
        photoBytes: Uint8List.fromList([1, 2, 3]),
      );

      expect(result, 'user-1/123.jpg');
      verify(() => mockDataSource.uploadPhoto(
            userId: 'user-1',
            photoBytes: any(named: 'photoBytes'),
          )).called(1);
    });

    test('rethrows on datasource error', () async {
      when(() => mockDataSource.uploadPhoto(
            userId: any(named: 'userId'),
            photoBytes: any(named: 'photoBytes'),
          )).thenThrow(Exception('Upload failed'));

      expect(
        () => repository.uploadPhoto(
          userId: 'user-1',
          photoBytes: Uint8List.fromList([1, 2, 3]),
        ),
        throwsException,
      );
    });
  });

  group('analyzeSkin', () {
    test('calls datasource and maps response to entity', () async {
      when(() => mockDataSource.invokeSkinAnalysis(
            userId: any(named: 'userId'),
            photoPath: any(named: 'photoPath'),
          )).thenAnswer((_) async => {
            'id': 'analysis-1',
            'user_id': 'user-1',
            'photo_url': 'path.jpg',
            'overall_score': 72,
            'skin_age': 27,
            'ai_response_json': {
              'summary': 'Good skin',
              'suggested_routine': {
                'morning': [
                  {
                    'step': 'Cleanse',
                    'product_type': 'Cleanser',
                    'reason': 'Clean'
                  }
                ],
                'evening': <dynamic>[],
              },
            },
            'zone_scores': [
              {
                'zone': 'forehead',
                'score': 80.0,
                'concerns': ['acne'],
                'severity': 3,
                'recommendations': ['Moisturize'],
              }
            ],
          });

      final result = await repository.analyzeSkin(
        userId: 'user-1',
        photoPath: 'path.jpg',
      );

      expect(result.id, 'analysis-1');
      expect(result.overallScore, 72.0);
      expect(result.skinAge, 27);
      expect(result.summary, 'Good skin');
      expect(result.zones, hasLength(1));
      expect(result.zones.first.zone, 'forehead');
      expect(result.morningRoutine, hasLength(1));
      expect(result.morningRoutine.first.step, 'Cleanse');
    });
  });

  group('getAnalysis', () {
    test('returns null when datasource returns null', () async {
      when(() => mockDataSource.fetchAnalysis(any()))
          .thenAnswer((_) async => null);

      final result = await repository.getAnalysis('nonexistent');
      expect(result, isNull);
    });
  });

  group('getHistory', () {
    test('returns empty list when no history', () async {
      when(() => mockDataSource.fetchHistory(any()))
          .thenAnswer((_) async => []);

      final result = await repository.getHistory('user-1');
      expect(result, isEmpty);
    });

    test('maps multiple rows to entities', () async {
      when(() => mockDataSource.fetchHistory(any()))
          .thenAnswer((_) async => [
            {
              'id': 'a1',
              'user_id': 'user-1',
              'overall_score': 60,
              'skin_age': 30,
              'ai_response_json': null,
              'zone_scores': <dynamic>[],
            },
            {
              'id': 'a2',
              'user_id': 'user-1',
              'overall_score': 75,
              'skin_age': 28,
              'ai_response_json': null,
              'zone_scores': <dynamic>[],
            },
          ]);

      final result = await repository.getHistory('user-1');
      expect(result, hasLength(2));
      expect(result[0].id, 'a1');
      expect(result[1].id, 'a2');
    });
  });
}
