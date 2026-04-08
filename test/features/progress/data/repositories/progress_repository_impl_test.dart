import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skincheck_ai/features/progress/data/datasources/progress_datasource.dart';
import 'package:skincheck_ai/features/progress/data/repositories/progress_repository_impl.dart';

class MockProgressDataSource extends Mock implements ProgressDataSource {}

void main() {
  late MockProgressDataSource mockDataSource;
  late ProgressRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockProgressDataSource();
    repository = ProgressRepositoryImpl(mockDataSource);
  });

  Map<String, dynamic> makeAnalysis({
    required String id,
    required double score,
    required int skinAge,
    required String createdAt,
    String? photoUrl,
    List<Map<String, dynamic>> zoneScores = const [],
  }) {
    return {
      'id': id,
      'user_id': 'user1',
      'overall_score': score,
      'skin_age': skinAge,
      'created_at': createdAt,
      'photo_url': photoUrl,
      'zone_scores': zoneScores,
    };
  }

  List<Map<String, dynamic>> makeZoneScores(
    Map<String, double> scores,
  ) {
    return scores.entries
        .map((e) => {'zone': e.key, 'score': e.value})
        .toList();
  }

  group('getProgressSummary', () {
    test('returns empty summary when no analyses', () async {
      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => []);

      final result = await repository.getProgressSummary('user1');

      expect(result.totalAnalyses, 0);
      expect(result.currentScore, 0);
      expect(result.streak, 0);
    });

    test('returns correct summary with analyses', () async {
      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => [
                makeAnalysis(
                  id: '1',
                  score: 60,
                  skinAge: 28,
                  createdAt: '2026-03-01T10:00:00Z',
                  zoneScores: makeZoneScores({
                    'forehead': 50,
                    'nose': 40,
                  }),
                ),
                makeAnalysis(
                  id: '2',
                  score: 75,
                  skinAge: 25,
                  createdAt: '2026-04-01T10:00:00Z',
                  zoneScores: makeZoneScores({
                    'forehead': 70,
                    'nose': 60,
                  }),
                ),
              ]);

      final result = await repository.getProgressSummary('user1');

      expect(result.currentScore, 75);
      expect(result.skinAge, 25);
      expect(result.totalAnalyses, 2);
      expect(result.mostImprovedZone, isNotNull);
    });
  });

  group('getScoreTrend', () {
    test('returns trend data ordered by date', () async {
      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => [
                makeAnalysis(
                  id: '1',
                  score: 60,
                  skinAge: 28,
                  createdAt: '2026-03-01T10:00:00Z',
                ),
                makeAnalysis(
                  id: '2',
                  score: 75,
                  skinAge: 25,
                  createdAt: '2026-04-01T10:00:00Z',
                ),
              ]);

      final result = await repository.getScoreTrend('user1');

      expect(result.length, 2);
      expect(result.first.score, 60);
      expect(result.last.score, 75);
      expect(result.first.date.isBefore(result.last.date), isTrue);
    });

    test('returns empty list when no analyses', () async {
      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => []);

      final result = await repository.getScoreTrend('user1');

      expect(result, isEmpty);
    });
  });

  group('getZoneProgress', () {
    test('returns zone progress with correct change', () async {
      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => [
                makeAnalysis(
                  id: '1',
                  score: 60,
                  skinAge: 28,
                  createdAt: '2026-03-01T10:00:00Z',
                  zoneScores: makeZoneScores({
                    'forehead': 50,
                    'nose': 40,
                  }),
                ),
                makeAnalysis(
                  id: '2',
                  score: 75,
                  skinAge: 25,
                  createdAt: '2026-04-01T10:00:00Z',
                  zoneScores: makeZoneScores({
                    'forehead': 70,
                    'nose': 60,
                  }),
                ),
              ]);

      final result = await repository.getZoneProgress('user1');

      expect(result.isNotEmpty, isTrue);
      final forehead = result.firstWhere(
        (z) => z.zone == 'forehead',
      );
      expect(forehead.currentScore, 70);
      expect(forehead.previousScore, 50);
      expect(forehead.changePercent, 40.0);
    });

    test('returns empty list with single analysis', () async {
      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => [
                makeAnalysis(
                  id: '1',
                  score: 60,
                  skinAge: 28,
                  createdAt: '2026-03-01T10:00:00Z',
                ),
              ]);

      final result = await repository.getZoneProgress('user1');

      expect(result, isEmpty);
    });
  });

  group('getPhotoComparison', () {
    test('returns empty when less than 2 analyses', () async {
      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => []);

      final result = await repository.getPhotoComparison('user1');

      expect(result.firstPhotoUrl, isNull);
      expect(result.latestPhotoUrl, isNull);
    });

    test('returns signed URLs for photos', () async {
      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => [
                makeAnalysis(
                  id: '1',
                  score: 60,
                  skinAge: 28,
                  createdAt: '2026-03-01T10:00:00Z',
                  photoUrl: 'user1/photo1.jpg',
                ),
                makeAnalysis(
                  id: '2',
                  score: 75,
                  skinAge: 25,
                  createdAt: '2026-04-01T10:00:00Z',
                  photoUrl: 'user1/photo2.jpg',
                ),
              ]);

      when(() => mockDataSource.getSignedPhotoUrl('user1/photo1.jpg'))
          .thenAnswer((_) async => 'https://signed-url/photo1');
      when(() => mockDataSource.getSignedPhotoUrl('user1/photo2.jpg'))
          .thenAnswer((_) async => 'https://signed-url/photo2');

      final result = await repository.getPhotoComparison('user1');

      expect(result.firstPhotoUrl, 'https://signed-url/photo1');
      expect(result.latestPhotoUrl, 'https://signed-url/photo2');
      expect(result.firstScore, 60);
      expect(result.latestScore, 75);
    });
  });

  group('streak calculation', () {
    test('returns correct streak for consecutive weeks', () async {
      final now = DateTime.now();
      final thisWeek = now.subtract(
        Duration(days: now.weekday - 1),
      );

      when(() => mockDataSource.fetchAllAnalyses('user1'))
          .thenAnswer((_) async => [
                makeAnalysis(
                  id: '1',
                  score: 60,
                  skinAge: 28,
                  createdAt: thisWeek
                      .subtract(const Duration(days: 14))
                      .toIso8601String(),
                ),
                makeAnalysis(
                  id: '2',
                  score: 65,
                  skinAge: 27,
                  createdAt: thisWeek
                      .subtract(const Duration(days: 7))
                      .toIso8601String(),
                ),
                makeAnalysis(
                  id: '3',
                  score: 70,
                  skinAge: 26,
                  createdAt: thisWeek.toIso8601String(),
                ),
              ]);

      final result = await repository.getProgressSummary('user1');

      expect(result.streak, 3);
    });
  });
}
