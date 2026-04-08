import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/pro_badge.dart';
import '../../../auth/domain/entities/user_entity.dart';

/// Profile header with avatar, name, email, skin type, and plan badge.
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key, required this.user});

  /// The user to display.
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final subtextColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final isPro = user.subscriptionTier == 'pro';

    return AppCard(
      child: Column(
        children: [
          _buildAvatar(isDark),
          const SizedBox(height: 16),
          // Name + badge row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  user.name ?? 'Kullanici',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isPro) ...[
                const SizedBox(width: 8),
                const ProBadge(size: ProBadgeSize.small),
              ],
            ],
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            user.email,
            style: AppTextStyles.bodyMedium.copyWith(color: subtextColor),
          ),
          // Skin type badge
          if (user.skinType != null) ...[
            const SizedBox(height: 12),
            _buildSkinTypeBadge(isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isDark) {
    final initials = _getInitials();
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTextStyles.displaySmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildSkinTypeBadge(bool isDark) {
    final label = _skinTypeLabel(user.skinType!);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getInitials() {
    final name = user.name ?? user.email;
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  String _skinTypeLabel(String type) {
    return switch (type.toLowerCase()) {
      'normal' => 'Normal Cilt',
      'oily' => 'Yagli Cilt',
      'dry' => 'Kuru Cilt',
      'combination' => 'Karma Cilt',
      _ => type,
    };
  }
}
