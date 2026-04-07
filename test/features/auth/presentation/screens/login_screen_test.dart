import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/auth/domain/entities/user_entity.dart';
import 'package:skincheck_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:skincheck_ai/features/auth/presentation/screens/login_screen.dart';
import 'package:skincheck_ai/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:skincheck_ai/features/auth/presentation/widgets/social_login_button.dart';

Widget _buildTestApp() {
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(() => _FakeAuthNotifier()),
    ],
    child: const MaterialApp(
      home: LoginScreen(),
    ),
  );
}

class _FakeAuthNotifier extends AuthNotifier {
  @override
  FutureOr<UserEntity?> build() => null;
}

void main() {
  group('LoginScreen', () {
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(AuthTextField), findsNWidgets(2));
    });

    testWidgets('renders login button', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Giriş Yap'), findsWidgets);
    });

    testWidgets('renders Google sign-in button', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(SocialLoginButton), findsWidgets);
      expect(find.text('Google ile Giriş'), findsOneWidget);
    });

    testWidgets('renders sign up link', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Hesabın yok mu? '), findsOneWidget);
      expect(find.text('Kayıt Ol'), findsOneWidget);
    });

    testWidgets('renders app name', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('SkinCheck AI'), findsOneWidget);
    });

    testWidgets('shows validation errors on empty submit', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      // Find the login button container and tap it
      final loginButtons = find.text('Giriş Yap');
      await tester.tap(loginButtons.last);
      await tester.pumpAndSettle();

      expect(find.text('E-posta gerekli'), findsOneWidget);
      expect(find.text('Şifre gerekli'), findsOneWidget);
    });
  });
}
