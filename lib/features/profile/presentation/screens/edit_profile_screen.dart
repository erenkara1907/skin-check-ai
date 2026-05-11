import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

/// Screen for editing user name (email is read-only) and changing
/// password.
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProfileProvider).valueOrNull;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final actions = ref.watch(profileActionsProvider);
    final isLoading = actions.isLoading;
    final authProvider = ref.watch(currentAuthProviderProvider);
    final isEmailUser = authProvider == null || authProvider == 'email';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.editProfileTitle),
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
                  label: context.l10n.nameLabel,
                  controller: _nameController,
                  textColor: textColor,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return context.l10n.nameEmptyError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildReadOnlyEmail(textColor: textColor, isDark: isDark),
                const SizedBox(height: 32),
                AppButton(
                  label: context.l10n.saveButton,
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _save,
                ),
                if (isEmailUser) ...[
                  const SizedBox(height: 24),
                  Divider(
                    color: (isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight)
                        .withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    label: context.l10n.changePasswordButton,
                    variant: AppButtonVariant.outline,
                    icon: LucideIcons.lock,
                    onPressed: () =>
                        context.push(AppRoutes.changePassword),
                  ),
                ],
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
    TextInputType? keyboardType,
    String? Function(String?)? validator,
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
          keyboardType: keyboardType,
          validator: validator,
          style: AppTextStyles.bodyLarge.copyWith(color: textColor),
        ),
      ],
    );
  }

  Widget _buildReadOnlyEmail({
    required Color textColor,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.emailLabel,
          style: AppTextStyles.labelMedium.copyWith(color: textColor),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          enabled: false,
          style: AppTextStyles.bodyLarge.copyWith(
            color: textColor.withValues(alpha: 0.55),
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              LucideIcons.lock,
              size: 18,
              color: textColor.withValues(alpha: 0.4),
            ),
            helperText: context.l10n.emailReadOnlyHelper,
            helperStyle: AppTextStyles.labelSmall.copyWith(
              color: textColor.withValues(alpha: 0.55),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final actions = ref.read(profileActionsProvider.notifier);
    final success = await actions.updateProfile(
      name: _nameController.text.trim(),
    );

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.profileUpdated)),
      );
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.profileUpdateError)),
      );
    }
  }
}
