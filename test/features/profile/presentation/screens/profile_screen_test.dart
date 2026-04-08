import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/auth/domain/entities/user_entity.dart';
import 'package:skincheck_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:skincheck_ai/features/profile/presentation/providers/profile_provider.dart';
import 'package:skincheck_ai/features/profile/presentation/screens/profile_screen.dart';

const _testUser = UserEntity(
  id: 'test-uid',
  email: 'test@example.com',
  name: 'Test User',
  skinType: 'normal',
  subscriptionTier: 'free',
);

class _TestUserProfile extends UserProfile {
  _TestUserProfile(this._user);
  final UserEntity? _user;

  @override
  FutureOr<UserEntity?> build() => _user;
}

class _LoadingUserProfile extends UserProfile {
  final _completer = Completer<UserEntity?>();

  @override
  FutureOr<UserEntity?> build() => _completer.future;
}

void main() {
  Widget buildSubject({UserEntity? user = _testUser}) {
    return ProviderScope(
      overrides: [
        userProfileProvider.overrideWith(() => _TestUserProfile(user)),
        analysisCountProvider.overrideWith((_) => Future.value(3)),
        joinDateProvider
            .overrideWith((_) => Future.value(DateTime(2026, 1, 1))),
      ],
      child: const MaterialApp(home: ProfileScreen()),
    );
  }

  group('ProfileScreen', () {
    testWidgets('renders profile header with user name', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('renders email', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('renders skin type badge', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Normal Cilt'), findsOneWidget);
    });

    testWidgets('renders stats row', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);
      expect(find.text('Toplam Analiz'), findsOneWidget);
      expect(find.text('Uyelik Tarihi'), findsOneWidget);
    });

    testWidgets('renders menu items', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Profili Duzenle'), findsOneWidget);
      expect(find.text('Ayarlar'), findsOneWidget);
      expect(find.text('Cikis Yap'), findsOneWidget);
    });

    testWidgets('shows loading when user is loading', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProfileProvider
                .overrideWith(() => _LoadingUserProfile()),
          ],
          child: const MaterialApp(home: ProfileScreen()),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
