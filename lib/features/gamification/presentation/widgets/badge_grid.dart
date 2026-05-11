import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/badge_entity.dart';

/// Grid display of achievement badges.
class BadgeGrid extends StatelessWidget {
  const BadgeGrid({super.key, required this.badges});

  final List<BadgeEntity> badges;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) => _BadgeCard(badge: badges[index]),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge});

  final BadgeEntity badge;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUnlocked = badge.unlockedAt != null;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final onSurface = Theme.of(context).colorScheme.onSurface;

    final title = _resolveTitle(l10n, badge.titleKey);
    final description = _resolveDescription(l10n, badge.descriptionKey);
    final footerText = isUnlocked
        ? l10n.badgeUnlockedOn(
            DateFormat('d MMM yyyy', locale).format(badge.unlockedAt!),
          )
        : l10n.badgeLocked;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.glassDark : AppColors.glassLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked
              ? AppColors.primary.withValues(alpha: 0.3)
              : isDark
                  ? AppColors.glassBorderDark
                  : AppColors.glassBorderLight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isUnlocked ? _resolveIcon(badge.iconName) : LucideIcons.lock,
              size: 22,
              color: isUnlocked
                  ? AppColors.primary
                  : onSurface.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTextStyles.labelLarge.copyWith(
              color: isUnlocked
                  ? onSurface
                  : onSurface.withValues(alpha: 0.45),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: onSurface.withValues(alpha: isUnlocked ? 0.65 : 0.4),
                height: 1.25,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            footerText,
            style: AppTextStyles.labelSmall.copyWith(
              color: isUnlocked
                  ? AppColors.primary
                  : onSurface.withValues(alpha: 0.5),
              fontWeight: isUnlocked ? FontWeight.w600 : FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _resolveIcon(String name) {
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

  String _resolveTitle(L10n l10n, String key) {
    switch (key) {
      case 'badgeFirstAnalysis':
        return l10n.badgeFirstAnalysis;
      case 'badgeFirstRoutine':
        return l10n.badgeFirstRoutine;
      case 'badgeStreak7':
        return l10n.badgeStreak7;
      case 'badgeStreak14':
        return l10n.badgeStreak14;
      case 'badgeStreak30':
        return l10n.badgeStreak30;
      case 'badgeStreak60':
        return l10n.badgeStreak60;
      case 'badgeScore80':
        return l10n.badgeScore80;
      case 'badgeScoreImproved10':
        return l10n.badgeScoreImproved10;
      default:
        return key;
    }
  }

  String _resolveDescription(L10n l10n, String key) {
    switch (key) {
      case 'badgeFirstAnalysisDesc':
        return l10n.badgeFirstAnalysisDesc;
      case 'badgeFirstRoutineDesc':
        return l10n.badgeFirstRoutineDesc;
      case 'badgeStreak7Desc':
        return l10n.badgeStreak7Desc;
      case 'badgeStreak14Desc':
        return l10n.badgeStreak14Desc;
      case 'badgeStreak30Desc':
        return l10n.badgeStreak30Desc;
      case 'badgeStreak60Desc':
        return l10n.badgeStreak60Desc;
      case 'badgeScore80Desc':
        return l10n.badgeScore80Desc;
      case 'badgeScoreImproved10Desc':
        return l10n.badgeScoreImproved10Desc;
      default:
        return '';
    }
  }
}
