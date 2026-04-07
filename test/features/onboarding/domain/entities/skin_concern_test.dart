import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/onboarding/domain/entities/skin_concern.dart';

void main() {
  group('SkinConcern', () {
    test('has 8 values', () {
      expect(SkinConcern.values.length, 8);
    });

    test('fromValue returns correct concern', () {
      expect(SkinConcern.fromValue('acne'), SkinConcern.acne);
      expect(SkinConcern.fromValue('dark_circles'), SkinConcern.darkCircles);
    });

    test('fromValue returns null for invalid value', () {
      expect(SkinConcern.fromValue('unknown'), isNull);
      expect(SkinConcern.fromValue(null), isNull);
    });

    test('fromValues parses list correctly', () {
      final result = SkinConcern.fromValues(['acne', 'redness', 'invalid']);
      expect(result, [SkinConcern.acne, SkinConcern.redness]);
    });

    test('fromValues handles empty list', () {
      expect(SkinConcern.fromValues([]), isEmpty);
    });

    test('each concern has label and value', () {
      for (final concern in SkinConcern.values) {
        expect(concern.label, isNotEmpty);
        expect(concern.value, isNotEmpty);
      }
    });
  });
}
