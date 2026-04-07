import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Styled text field for auth screens with focus animation.
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.prefixIcon,
  });

  /// Text editing controller.
  final TextEditingController controller;

  /// Label text shown above the field.
  final String label;

  /// Hint text shown when empty.
  final String? hint;

  /// Whether to obscure input (for passwords).
  final bool obscureText;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// Text input action.
  final TextInputAction? textInputAction;

  /// Validation function.
  final String? Function(String?)? validator;

  /// Prefix icon.
  final IconData? prefixIcon;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscured = true;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = _focused
        ? AppColors.primary
        : (isDark ? AppColors.borderDark : AppColors.borderLight);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (focused) => setState(() => _focused = focused),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: borderColor,
                width: _focused ? 1.5 : 1.0,
              ),
              color: isDark
                  ? AppColors.surfaceDark.withValues(alpha: 0.5)
                  : AppColors.surfaceLight,
              boxShadow: _focused
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.obscureText && _obscured,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              validator: widget.validator,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: isDark
                      ? AppColors.textSecondaryDark.withValues(alpha: 0.5)
                      : AppColors.textSecondaryLight.withValues(alpha: 0.5),
                ),
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        size: 20,
                        color: _focused
                            ? AppColors.primary
                            : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                      )
                    : null,
                suffixIcon: widget.obscureText
                    ? IconButton(
                        icon: Icon(
                          _obscured
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          size: 20,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        onPressed: () =>
                            setState(() => _obscured = !_obscured),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
