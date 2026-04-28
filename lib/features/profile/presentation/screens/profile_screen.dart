import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../gamification/presentation/providers/badge_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_stats_row.dart';

/// Profile screen with user info, stats, and navigation.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.profileTitle,
          style: AppTextStyles.headlineMedium.copyWith(color: textColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: userAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (e, _) => Center(
            child: Text(
              context.l10n.profileLoadError,
              style: AppTextStyles.bodyMedium.copyWith(color: textColor),
            ),
          ),
          data: (user) {
            if (user == null) {
              return Center(
                child: Text(
                  context.l10n.userNotFound,
                  style:
                      AppTextStyles.bodyMedium.copyWith(color: textColor),
                ),
              );
            }
            return _buildContent(context, ref, isDark);
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
  ) {
    final user = ref.watch(userProfileProvider).valueOrNull!;
    final analysisAsync = ref.watch(analysisCountProvider);
    final joinDateAsync = ref.watch(joinDateProvider);
    final surface = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.white;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const SizedBox(height: 8),
        // Header card
        ProfileHeaderCard(user: user),
        const SizedBox(height: 16),
        // Stats row
        ProfileStatsRow(
          analysisCount: analysisAsync.valueOrNull ?? 0,
          joinDate: joinDateAsync.valueOrNull,
        ),
        const SizedBox(height: 16),
        // Badges
        _buildBadgesRow(context, ref),
        const SizedBox(height: 24),
        // Menu items
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border),
          ),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: LucideIcons.userCog,
                label: context.l10n.editProfileMenu,
                onTap: () => context.push('/profile/edit'),
              ),
              ProfileMenuItem(
                icon: LucideIcons.settings,
                label: context.l10n.settingsMenu,
                onTap: () => context.push('/profile/settings'),
              ),
              ProfileMenuItem(
                icon: LucideIcons.logOut,
                label: context.l10n.logoutMenu,
                iconColor: AppColors.error,
                textColor: AppColors.error,
                showDivider: false,
                onTap: () => _signOut(context, ref),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildBadgesRow(BuildContext context, WidgetRef ref) {
    final badgesAsync = ref.watch(badgeNotifierProvider);
    final earned = badgesAsync.valueOrNull
            ?.where((b) => b.unlockedAt != null)
            .toList() ??
        [];
    if (earned.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.badgesTitle,
              style: AppTextStyles.titleMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.badges),
              child: Text(
                context.l10n.viewAllBadges,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 56,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: earned.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final badge = earned[index];
              return Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _badgeIcon(badge.iconName),
                  color: AppColors.primary,
                  size: 24,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _badgeIcon(String name) {
    const map = {
      'scan': LucideIcons.scanLine,
      'sparkles': LucideIcons.sparkles,
      'flame': LucideIcons.flame,
      'trophy': LucideIcons.trophy,
      'star': LucideIcons.star,
      'sun': LucideIcons.sun,
      'trending-up': LucideIcons.trendingUp,
    };
    return map[name] ?? LucideIcons.award;
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.logoutDialogTitle),
        content: Text(context.l10n.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(context.l10n.cancelAction),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(context.l10n.logoutMenu),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authNotifierProvider.notifier).signOut();
    }
  }
}
