import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_glassmorphism_card.dart';
import '../widgets/auth_gradient_background.dart';
import '../widgets/auth_gradient_button.dart';
import '../widgets/auth_logo_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_login_button.dart';

/// Login screen with glassmorphism card and gradient background.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

enum _AuthAction { none, email, google, apple }

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  _AuthAction _activeAction = _AuthAction.none;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _activeAction = _AuthAction.email);
    await ref.read(authNotifierProvider.notifier).signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(authNotifierProvider, (prev, next) {
      if (!next.isLoading) {
        setState(() => _activeAction = _AuthAction.none);
      }
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Giriş başarısız. Lütfen tekrar deneyin.'),
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
                    icon: LucideIcons.scan,
                    title: 'SkinCheck AI',
                    subtitle: 'Cildin için AI destekli analiz',
                  ),
                  const SizedBox(height: 32),
                  _buildCard(isDark),
                  const SizedBox(height: 24),
                  _buildSignUpLink(isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(bool isDark) {
    return AuthGlassmorphismCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Giriş Yap',
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
              label: 'Giriş Yap',
              isLoading: _activeAction == _AuthAction.email,
              onPressed: _handleLogin,
              gradientColors: const [AppColors.primary, AppColors.primaryDark],
            ),
            const SizedBox(height: 20),
            _buildDivider(isDark),
            const SizedBox(height: 20),
            _buildSocialButtons(),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms).slideY(
          begin: 0.1,
          curve: Curves.easeOut,
        );
  }

  Widget _buildDivider(bool isDark) {
    final color = isDark
        ? AppColors.textSecondaryDark.withValues(alpha: 0.3)
        : AppColors.textSecondaryLight.withValues(alpha: 0.3);
    return Row(
      children: [
        Expanded(child: Divider(color: color)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'veya',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
        Expanded(child: Divider(color: color)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    final isIOS = _isIOSPlatform();
    final anyLoading = _activeAction != _AuthAction.none;
    return Row(
      children: [
        Expanded(
          child: SocialLoginButton(
            provider: SocialProvider.google,
            isLoading: _activeAction == _AuthAction.google,
            onPressed: anyLoading
                ? null
                : () {
                    setState(() => _activeAction = _AuthAction.google);
                    ref
                        .read(authNotifierProvider.notifier)
                        .signInWithGoogle();
                  },
          ),
        ),
        if (isIOS) ...[
          const SizedBox(width: 12),
          Expanded(
            child: SocialLoginButton(
              provider: SocialProvider.apple,
              isLoading: _activeAction == _AuthAction.apple,
              onPressed: anyLoading
                  ? null
                  : () {
                      setState(() => _activeAction = _AuthAction.apple);
                      ref
                          .read(authNotifierProvider.notifier)
                          .signInWithApple();
                    },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSignUpLink(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hesabın yok mu? ',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        GestureDetector(
          onTap: () => context.push(AppRoutes.signUp),
          child: Text(
            'Kayıt Ol',
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

  bool _isIOSPlatform() {
    try {
      return Platform.isIOS;
    } catch (_) {
      return false;
    }
  }
}
