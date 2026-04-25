import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/analysis/domain/entities/analysis_entity.dart';
import 'package:skincheck_ai/features/auth/domain/entities/user_entity.dart';
import 'package:skincheck_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:skincheck_ai/features/home/presentation/providers/home_provider.dart';
import 'package:skincheck_ai/features/home/presentation/screens/home_screen.dart';
import 'package:skincheck_ai/features/subscription/presentation/providers/subscription_provider.dart';

import '../../../../helpers/test_app.dart';

const _testUser = UserEntity(
  id: 'test-uid',
  email: 'test@example.com',
  name: 'Eren',
  skinType: 'normal',
  subscriptionTier: 'free',
);

final _testAnalysis = AnalysisEntity(
  id: 'a1',
  userId: 'test-uid',
  overallScore: 72,
  skinAge: 25,
  summary: 'Cildiniz genel olarak iyi durumda.',
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
);

class _TestAuthNotifier extends AuthNotifier {
  _TestAuthNotifier(this._user);
  final UserEntity? _user;

  @override
  FutureOr<UserEntity?> build() => _user;
}

class _TestUserProfile extends UserProfile {
  _TestUserProfile(this._user);
  final UserEntity? _user;

  @override
  FutureOr<UserEntity?> build() => _user;
}

void main() {
  Widget buildSubject({
    bool hasAnalysis = false,
    AnalysisEntity? latestAnalysis,
  }) {
    return pumpableTestApp(
      const HomeScreen(),
      overrides: [
        authNotifierProvider
            .overrideWith(() => _TestAuthNotifier(_testUser)),
        userProfileProvider
            .overrideWith(() => _TestUserProfile(_testUser)),
        canAnalyzeProvider.overrideWith((_) => Future.value(true)),
        hasAnalysisProvider('test-uid')
            .overrideWith((_) => Future.value(hasAnalysis)),
        latestAnalysisProvider('test-uid')
            .overrideWith((_) => Future.value(latestAnalysis)),
        homeRoutinesProvider('test-uid')
            .overrideWith((_) => Future.value([])),
        homeTrendProvider('test-uid')
            .overrideWith((_) => Future.value([])),
      ],
    );
  }

  group('HomeScreen', () {
    testWidgets('shows greeting with user name', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.textContaining('Merhaba, Eren!'), findsOneWidget);
    });

    testWidgets('shows FirstAnalysisCard when no analyses exist',
        (tester) async {
      await tester.pumpWidget(buildSubject(hasAnalysis: false));
      await tester.pumpAndSettle();

      expect(find.text('İlk Analizini Yap!'), findsOneWidget);
      expect(find.text('Kamerayı Aç'), findsOneWidget);
    });

    testWidgets('shows LastAnalysisCard when analysis exists',
        (tester) async {
      await tester.pumpWidget(buildSubject(
        hasAnalysis: true,
        latestAnalysis: _testAnalysis,
      ));
      await tester.pumpAndSettle();

      expect(find.text('Son Analiz'), findsOneWidget);
      expect(find.text('Tekrar Analiz Et'), findsOneWidget);
    });

    testWidgets('shows score in LastAnalysisCard', (tester) async {
      await tester.pumpWidget(buildSubject(
        hasAnalysis: true,
        latestAnalysis: _testAnalysis,
      ));
      await tester.pumpAndSettle();

      expect(find.textContaining('25'), findsWidgets);
    });

    testWidgets('shows weekly tip card', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Haftanın İpucu'), findsOneWidget);
    });

    testWidgets('shows loading indicator while data loads', (tester) async {
      await tester.pumpWidget(
        pumpableTestApp(
          const HomeScreen(),
          overrides: [
            authNotifierProvider
                .overrideWith(() => _TestAuthNotifier(_testUser)),
            userProfileProvider
                .overrideWith(() => _TestUserProfile(_testUser)),
            latestAnalysisProvider('test-uid')
                .overrideWith((_) => Completer<AnalysisEntity?>().future),
          ],
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
