import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/subscription_provider.dart';
import '../widgets/feature_comparison_table.dart';
import '../widgets/paywall_cta_button.dart';
import '../widgets/plan_card.dart';

/// Full-screen paywall for upgrading to Pro.
class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  bool _isYearly = true;

  String get _selectedPlanId => _isYearly
      ? AppConstants.yearlyPlanId
      : AppConstants.monthlyPlanId;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subState = ref.watch(subscriptionNotifierProvider);
    final isLoading = subState.isLoading;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color(0xFF1A1040),
                    AppColors.backgroundDark,
                  ]
                : [
                    const Color(0xFFF0ECFF),
                    AppColors.backgroundLight,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      _buildHeader(isDark),
                      const SizedBox(height: 28),
                      const FeatureComparisonTable(),
                      const SizedBox(height: 28),
                      _buildPlanCards(),
                      const SizedBox(height: 24),
                      PaywallCtaButton(
                        label: '7 Gun Ucretsiz Dene',
                        isLoading: isLoading,
                        onPressed: _handlePurchase,
                      ),
                      const SizedBox(height: 12),
                      _buildRestoreButton(isLoading),
                      const SizedBox(height: 20),
                      _buildLegalLinks(isDark),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(LucideIcons.x),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        // Crown icon
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            LucideIcons.crown,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Pro'ya Gec",
          style: AppTextStyles.displayMedium.copyWith(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Cilt bakim yolculugunu bir ust seviyeye tasiyin',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCards() {
    return Column(
      children: [
        PlanCard(
          title: 'Yillik',
          price: AppConstants.yearlyPrice,
          period: '/yil',
          badge: '%30 tasarruf',
          isSelected: _isYearly,
          onTap: () => setState(() => _isYearly = true),
        ),
        const SizedBox(height: 12),
        PlanCard(
          title: 'Aylik',
          price: AppConstants.monthlyPrice,
          period: '/ay',
          isSelected: !_isYearly,
          onTap: () => setState(() => _isYearly = false),
        ),
      ],
    );
  }

  Widget _buildRestoreButton(bool isLoading) {
    return TextButton(
      onPressed: isLoading ? null : _handleRestore,
      child: Text(
        'Satin almayi geri yukle',
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildLegalLinks(bool isDark) {
    final color = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => _openUrl('https://skincheck.ai/privacy'),
          child: Text(
            'Gizlilik',
            style: AppTextStyles.labelSmall.copyWith(color: color),
          ),
        ),
        Text(' · ', style: TextStyle(color: color)),
        TextButton(
          onPressed: () => _openUrl('https://skincheck.ai/terms'),
          child: Text(
            'Kullanim Kosullari',
            style: AppTextStyles.labelSmall.copyWith(color: color),
          ),
        ),
      ],
    );
  }

  Future<void> _handlePurchase() async {
    await ref
        .read(subscriptionNotifierProvider.notifier)
        .purchase(_selectedPlanId);

    if (!mounted) return;
    final sub = ref.read(subscriptionNotifierProvider);
    if (sub.valueOrNull?.hasProEntitlement ?? false) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handleRestore() async {
    await ref
        .read(subscriptionNotifierProvider.notifier)
        .restore();

    if (!mounted) return;
    final sub = ref.read(subscriptionNotifierProvider);
    if (sub.valueOrNull?.hasProEntitlement ?? false) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
