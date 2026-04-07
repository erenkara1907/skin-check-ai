import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_glassmorphism_card.dart';
import '../widgets/auth_gradient_background.dart';
import '../widgets/auth_gradient_button.dart';
import '../widgets/auth_logo_header.dart';
import '../widgets/auth_text_field.dart';

/// Sign up screen with name, email and password fields.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authNotifierProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLoading = authState.isLoading;

    ref.listen(authNotifierProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kayıt başarısız. Lütfen tekrar deneyin.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    return Scaffold(
      body: AuthGradientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthLogoHeader(
                    icon: LucideIcons.userPlus,
                    title: 'Hesap Oluştur',
                    subtitle: 'Cilt bakım yolculuğuna başla',
                    gradientColors: [AppColors.secondary, AppColors.primary],
                    glowColor: AppColors.secondary,
                  ),
                  const SizedBox(height: 32),
                  _buildCard(isDark, isLoading),
                  const SizedBox(height: 24),
                  _buildLoginLink(isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(bool isDark, bool isLoading) {
    return AuthGlassmorphismCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Kayıt Ol',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AuthTextField(
              controller: _nameController,
              label: 'Ad Soyad',
              hint: 'Adınız Soyadınız',
              textInputAction: TextInputAction.next,
              prefixIcon: LucideIcons.user,
              validator: (v) {
                if (v == null || v.isEmpty) return 'İsim gerekli';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _emailController,
              label: 'E-posta',
              hint: 'ornek@email.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: LucideIcons.mail,
              validator: (v) {
                if (v == null || v.isEmpty) return 'E-posta gerekli';
                if (!v.contains('@')) return 'Geçerli bir e-posta girin';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _passwordController,
              label: 'Şifre',
              hint: '••••••••',
              obscureText: true,
              textInputAction: TextInputAction.done,
              prefixIcon: LucideIcons.lock,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Şifre gerekli';
                if (v.length < 6) return 'En az 6 karakter';
                return null;
              },
            ),
            const SizedBox(height: 24),
            AuthGradientButton(
              label: 'Kayıt Ol',
              isLoading: isLoading,
              onPressed: _handleSignUp,
              gradientColors: const [
                AppColors.secondary,
                AppColors.secondaryDark,
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms).slideY(
          begin: 0.1,
          curve: Curves.easeOut,
        );
  }

  Widget _buildLoginLink(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Zaten hesabın var mı? ',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        GestureDetector(
          onTap: () => context.pop(),
          child: Text(
            'Giriş Yap',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms, duration: 500.ms);
  }
}
