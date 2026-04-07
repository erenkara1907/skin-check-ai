import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/features/onboarding/domain/entities/skin_type.dart';

void main() {
  group('SkinType', () {
    test('has 4 values', () {
      expect(SkinType.values.length, 4);
    });

    test('fromValue returns correct type', () {
      expect(SkinType.fromValue('normal'), SkinType.normal);
      expect(SkinType.fromValue('oily'), SkinType.oily);
      expect(SkinType.fromValue('dry'), SkinType.dry);
      expect(SkinType.fromValue('combination'), SkinType.combination);
    });

    test('fromValue returns null for invalid value', () {
      expect(SkinType.fromValue('unknown'), isNull);
      expect(SkinType.fromValue(null), isNull);
    });

    test('each type has label and description', () {
      for (final type in SkinType.values) {
        expect(type.label, isNotEmpty);
        expect(type.description, isNotEmpty);
        expect(type.value, isNotEmpty);
      }
    });
  });
}
