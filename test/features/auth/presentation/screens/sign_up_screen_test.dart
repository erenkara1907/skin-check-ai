import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/auth/domain/entities/user_entity.dart';
import 'package:skincheck_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:skincheck_ai/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:skincheck_ai/features/auth/presentation/widgets/auth_text_field.dart';

Widget _buildTestApp() {
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(() => _FakeAuthNotifier()),
    ],
    child: const MaterialApp(
      home: SignUpScreen(),
    ),
  );
}

class _FakeAuthNotifier extends AuthNotifier {
  @override
  FutureOr<UserEntity?> build() => null;
}

void main() {
  group('SignUpScreen', () {
    testWidgets('renders name, email and password fields', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(AuthTextField), findsNWidgets(3));
    });

    testWidgets('renders sign up button', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Kayıt Ol'), findsWidgets);
    });

    testWidgets('renders header text', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Hesap Oluştur'), findsOneWidget);
      expect(find.text('Cilt bakım yolculuğuna başla'), findsOneWidget);
    });

    testWidgets('renders login link', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Zaten hesabın var mı? '), findsOneWidget);
      expect(find.text('Giriş Yap'), findsOneWidget);
    });

    testWidgets('shows validation errors on empty submit', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      final signUpButtons = find.text('Kayıt Ol');
      await tester.tap(signUpButtons.last);
      await tester.pumpAndSettle();

      expect(find.text('İsim gerekli'), findsOneWidget);
      expect(find.text('E-posta gerekli'), findsOneWidget);
      expect(find.text('Şifre gerekli'), findsOneWidget);
    });
  });
}
