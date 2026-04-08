import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/analysis/domain/entities/analysis_entity.dart';
import 'package:skincheck_ai/features/analysis/domain/entities/zone_score_entity.dart';
import 'package:skincheck_ai/features/analysis/presentation/providers/analysis_provider.dart';
import 'package:skincheck_ai/features/analysis/presentation/screens/analysis_result_screen.dart';
import 'package:skincheck_ai/features/analysis/presentation/widgets/analysis_loading.dart';

final _mockAnalysis = AnalysisEntity(
  id: 'test-1',
  userId: 'user-1',
  overallScore: 78,
  skinAge: 26,
  summary: 'Genel olarak iyi bir cilt durumu.',
  zones: const [
    ZoneScoreEntity(
      zone: 'forehead',
      score: 85,
      concerns: ['hafif kuruluk'],
      severity: 2,
      recommendations: ['Nemlendirici kullanın'],
    ),
    ZoneScoreEntity(
      zone: 'nose',
      score: 65,
      concerns: ['gözenek'],
      severity: 4,
      recommendations: ['Gözenek küçültücü serum'],
    ),
  ],
);

/// Test notifier that returns a fixed state.
class _TestAnalysisNotifier extends AnalysisNotifier {
  _TestAnalysisNotifier(this._initialState);

  final AsyncValue<AnalysisEntity?> _initialState;

  @override
  FutureOr<AnalysisEntity?> build() {
    return _initialState.when(
      data: (data) => data,
      loading: () {
        state = const AsyncLoading();
        return null;
      },
      error: (e, st) => throw e,
    );
  }
}

Widget _buildTestWidget(AsyncValue<AnalysisEntity?> state) {
  return ProviderScope(
    overrides: [
      analysisNotifierProvider.overrideWith(
        () => _TestAnalysisNotifier(state),
      ),
    ],
    child: const MaterialApp(
      home: AnalysisResultScreen(),
    ),
  );
}

void main() {
  setUp(() {
    // Make all flutter_animate animations instant in tests.
    Animate.restartOnHotReload = false;
    Animate.defaultDuration = Duration.zero;
  });

  tearDown(() {
    Animate.defaultDuration = const Duration(milliseconds: 300);
  });

  group('AnalysisResultScreen', () {
    testWidgets('shows loading state', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const AsyncLoading()),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(AnalysisLoading), findsOneWidget);
      expect(find.text('Cildiniz analiz ediliyor...'), findsOneWidget);
    });

    testWidgets('shows error state', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          AsyncError(Exception('Test error'), StackTrace.current),
        ),
      );
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('Analiz Başarısız'), findsOneWidget);
      expect(find.text('Geri Dön'), findsOneWidget);
    });

    testWidgets('shows result with score and skin age', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(AsyncData(_mockAnalysis)),
      );
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('Analiz Sonuçları'), findsOneWidget);
      expect(find.text('Cilt Yaşın: 26'), findsOneWidget);
      expect(find.text('Bölge Analizi'), findsOneWidget);

      // Scroll down to find action buttons
      await tester.scrollUntilVisible(
        find.text('Rutin Oluştur'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Rutin Oluştur'), findsOneWidget);
      expect(find.text('Paylaş'), findsOneWidget);
    });

    testWidgets('shows summary text', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(AsyncData(_mockAnalysis)),
      );
      await tester.pump(const Duration(seconds: 2));

      expect(
        find.text('Genel olarak iyi bir cilt durumu.'),
        findsOneWidget,
      );
    });
  });
}
