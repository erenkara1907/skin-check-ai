import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Button variant.
enum AppButtonVariant { primary, secondary, outline, text }

/// Premium button with animated press effect and loading state.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
  });

  /// Button label text.
  final String label;

  /// Press callback. Disabled when null or [isLoading].
  final VoidCallback? onPressed;

  /// Visual variant.
  final AppButtonVariant variant;

  /// Shows a loading spinner and disables interaction.
  final bool isLoading;

  /// Optional leading icon.
  final IconData? icon;

  /// Expand to full width.
  final bool fullWidth;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _enabled ? (_) => _controller.forward() : null,
      onTapUp: _enabled ? (_) => _controller.reverse() : null,
      onTapCancel: _enabled ? () => _controller.reverse() : null,
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: widget.fullWidth ? double.infinity : null,
          height: 52,
          child: _buildButton(),
        ),
      ),
    );
  }

  Widget _buildButton() {
    final child = _buildChild();
    return switch (widget.variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: _enabled ? widget.onPressed : null,
          child: child,
        ),
      AppButtonVariant.secondary => ElevatedButton(
          onPressed: _enabled ? widget.onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: Colors.white,
          ),
          child: child,
        ),
      AppButtonVariant.outline => OutlinedButton(
          onPressed: _enabled ? widget.onPressed : null,
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: _enabled ? widget.onPressed : null,
          child: child,
        ),
    };
  }

  Widget _buildChild() {
    if (widget.isLoading) {
      return const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: Colors.white,
        ),
      );
    }
    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 20),
          const SizedBox(width: 8),
          Text(widget.label, style: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w700,
          )),
        ],
      );
    }
    return Text(widget.label, style: AppTextStyles.labelLarge.copyWith(
      fontWeight: FontWeight.w700,
    ));
  }
}
