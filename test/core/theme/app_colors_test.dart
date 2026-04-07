import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skincheck_ai/core/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    test('primary is correct hex', () {
      expect(AppColors.primary, const Color(0xFF6C63FF));
    });

    test('secondary is correct hex', () {
      expect(AppColors.secondary, const Color(0xFF00D9A6));
    });

    group('scoreColor', () {
      test('returns red for score < 40', () {
        expect(AppColors.scoreColor(0), AppColors.scoreLow);
        expect(AppColors.scoreColor(39), AppColors.scoreLow);
      });

      test('returns yellow for score 40-70', () {
        expect(AppColors.scoreColor(40), AppColors.scoreMedium);
        expect(AppColors.scoreColor(55), AppColors.scoreMedium);
        expect(AppColors.scoreColor(70), AppColors.scoreMedium);
      });

      test('returns green for score > 70', () {
        expect(AppColors.scoreColor(71), AppColors.scoreHigh);
        expect(AppColors.scoreColor(100), AppColors.scoreHigh);
      });
    });
  });
}
