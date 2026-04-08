import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
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
          'Profil',
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
              'Profil yuklenemedi',
              style: AppTextStyles.bodyMedium.copyWith(color: textColor),
            ),
          ),
          data: (user) {
            if (user == null) {
              return Center(
                child: Text(
                  'Kullanici bulunamadi',
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
                label: 'Profili Duzenle',
                onTap: () => context.push('/profile/edit'),
              ),
              ProfileMenuItem(
                icon: LucideIcons.settings,
                label: 'Ayarlar',
                onTap: () => context.push('/profile/settings'),
              ),
              ProfileMenuItem(
                icon: LucideIcons.logOut,
                label: 'Cikis Yap',
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

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cikis Yap'),
        content: const Text('Cikis yapmak istediginize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vazgec'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Cikis Yap'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authNotifierProvider.notifier).signOut();
    }
  }
}
