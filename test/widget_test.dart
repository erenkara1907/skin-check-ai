import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincheck_ai/features/auth/domain/entities/user_entity.dart';
import 'package:skincheck_ai/features/auth/presentation/providers/auth_provider.dart';
import 'package:skincheck_ai/main.dart';

class _FakeAuthNotifier extends AuthNotifier {
  @override
  FutureOr<UserEntity?> build() => null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('App renders without crashing', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authNotifierProvider.overrideWith(() => _FakeAuthNotifier()),
        ],
        child: const SkinCheckApp(),
      ),
    );
    await tester.pumpAndSettle();
    // Smoke test: when not authenticated, should redirect to login
    expect(find.text('SkinCheck AI'), findsOneWidget);
  });
}
