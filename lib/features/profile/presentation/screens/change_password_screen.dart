import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../providers/profile_provider.dart';

/// Screen for changing the user's password with re-auth.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  static final _strongPassword = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$',
  );

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final actions = ref.watch(profileActionsProvider);
    final isLoading = actions.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.changePasswordTitle),
      ),
      extendBodyBehindAppBar: true,
      body: GradientBackground(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                const SizedBox(height: 24),
                _buildField(
                  label: context.l10n.currentPasswordLabel,
                  controller: _currentController,
                  textColor: textColor,
                  obscure: _obscureCurrent,
                  onToggleObscure: () =>
                      setState(() => _obscureCurrent = !_obscureCurrent),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return context.l10n.currentPasswordLabel;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildField(
                  label: context.l10n.newPasswordLabel,
                  controller: _newController,
                  textColor: textColor,
                  obscure: _obscureNew,
                  onToggleObscure: () =>
                      setState(() => _obscureNew = !_obscureNew),
                  validator: (v) {
                    if (v == null || !_strongPassword.hasMatch(v)) {
                      return context.l10n.passwordWeakError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildField(
                  label: context.l10n.confirmPasswordLabel,
                  controller: _confirmController,
                  textColor: textColor,
                  obscure: _obscureConfirm,
                  onToggleObscure: () => setState(
                    () => _obscureConfirm = !_obscureConfirm,
                  ),
                  validator: (v) {
                    if (v != _newController.text) {
                      return context.l10n.passwordMismatchError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: context.l10n.updateButton,
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _submit,
                  icon: LucideIcons.check,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required Color textColor,
    required bool obscure,
    required VoidCallback onToggleObscure,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(color: textColor),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          autocorrect: false,
          enableSuggestions: false,
          validator: validator,
          style: AppTextStyles.bodyLarge.copyWith(color: textColor),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: onToggleObscure,
              icon: Icon(
                obscure ? LucideIcons.eye : LucideIcons.eyeOff,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(profileActionsProvider.notifier);
    try {
      final success = await notifier.changePassword(
        currentPassword: _currentController.text,
        newPassword: _newController.text,
      );
      if (!mounted) return;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.passwordChangedSnackbar)),
        );
        context.pop();
      } else {
        _showError(context.l10n.passwordUpdateError);
      }
    } on AuthException {
      if (!mounted) return;
      _showError(context.l10n.currentPasswordIncorrectError);
    } catch (_) {
      if (!mounted) return;
      _showError(context.l10n.passwordUpdateError);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
