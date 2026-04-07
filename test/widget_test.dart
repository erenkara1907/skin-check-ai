import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skincheck_ai/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  testWidgets('App renders without crashing', (tester) async {
    await tester.pumpWidget(const SkinCheckApp());
    await tester.pumpAndSettle();
    expect(find.text('SkinCheck AI'), findsNothing); // smoke test
  });
}
