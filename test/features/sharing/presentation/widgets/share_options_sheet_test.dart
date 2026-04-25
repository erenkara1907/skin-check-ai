import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skincheck_ai/features/sharing/presentation/widgets/share_options_sheet.dart';

import '../../../../helpers/test_app.dart';

void main() {
  group('ShareOptionsSheet', () {
    Widget buildApp({required ValueChanged<ShareDestination> onSelected}) {
      return pumpableTestApp(
        Scaffold(body: ShareOptionsSheet(onSelected: onSelected)),
      );
    }

    testWidgets('renders three share options', (tester) async {
      await tester.pumpWidget(
        buildApp(onSelected: (_) {}),
      );

      expect(find.text('Instagram'), findsOneWidget);
      expect(find.text('WhatsApp'), findsOneWidget);
      expect(find.text('Diğer'), findsOneWidget);
    });

    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        buildApp(onSelected: (_) {}),
      );

      expect(find.text('Paylaş'), findsOneWidget);
    });

    testWidgets('tapping Instagram calls onSelected', (tester) async {
      ShareDestination? selected;
      await tester.pumpWidget(
        buildApp(onSelected: (d) => selected = d),
      );

      await tester.tap(find.text('Instagram'));
      expect(selected, ShareDestination.instagram);
    });

    testWidgets('tapping WhatsApp calls onSelected', (tester) async {
      ShareDestination? selected;
      await tester.pumpWidget(
        buildApp(onSelected: (d) => selected = d),
      );

      await tester.tap(find.text('WhatsApp'));
      expect(selected, ShareDestination.whatsapp);
    });

    testWidgets('tapping Diğer calls onSelected', (tester) async {
      ShareDestination? selected;
      await tester.pumpWidget(
        buildApp(onSelected: (d) => selected = d),
      );

      await tester.tap(find.text('Diğer'));
      expect(selected, ShareDestination.other);
    });
  });
}
