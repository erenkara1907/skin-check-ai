import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincheck_ai/l10n/generated/app_localizations.dart';

/// Wraps a child in MaterialApp + Riverpod + L10n delegates so widget tests
/// can call `context.l10n` and find localized strings without a router.
Widget pumpableTestApp(
  Widget child, {
  List<Override> overrides = const [],
  Locale locale = const Locale('tr'),
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: child,
    ),
  );
}
