import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/landing_faq_section.dart';
import '../widgets/landing_features_section.dart';
import '../widgets/landing_footer.dart';
import '../widgets/landing_hero_section.dart';
import '../widgets/landing_how_it_works.dart';
import '../widgets/landing_pricing_section.dart';

/// Web-only landing page with all marketing sections.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          _LandingAppBar(isDark: isDark),
          SliverList(
            delegate: SliverChildListDelegate([
              const LandingHeroSection(),
              const LandingHowItWorks(),
              const LandingFeaturesSection(),
              const LandingPricingSection(),
              const LandingFaqSection(),
              const LandingFooter(),
            ]),
          ),
        ],
      ),
    );
  }
}

/// Transparent floating app bar for the landing page.
class _LandingAppBar extends StatelessWidget {
  const _LandingAppBar({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: isDark
          ? AppColors.backgroundDark.withValues(alpha: 0.9)
          : AppColors.backgroundLight.withValues(alpha: 0.9),
      elevation: 0,
      toolbarHeight: 64,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.face_retouching_natural,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'SkinCheck AI',
            style: AppTextStyles.headlineSmall.copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.go(AppRoutes.login),
          child: Text(
            'Giriş Yap',
            style: AppTextStyles.titleMedium.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ElevatedButton(
            onPressed: () => context.go(AppRoutes.signUp),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Kayıt Ol',
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
