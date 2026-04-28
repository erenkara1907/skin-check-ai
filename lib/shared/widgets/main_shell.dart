import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/extensions/l10n_extension.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../features/analysis/presentation/helpers/start_analysis.dart';
import '../providers/bottom_nav_visibility_provider.dart';
import 'gradient_background.dart';

/// Animation duration for the bottom nav show/hide transition.
const _navAnimDuration = Duration(milliseconds: 280);
const _navAnimCurve = Curves.easeInOutCubic;

/// Bottom navigation shell with 5 tabs and a prominent center FAB.
///
/// The nav bar slides down and collapses when
/// [bottomNavVisibilityProvider] is `false`, freeing the full screen for
/// modal sheets, detail pages, and routine edit mode.
class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.navigationShell});

  /// GoRouter navigation shell.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(bottomNavVisibleProvider);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: navigationShell,
        bottomNavigationBar: ClipRect(
          child: AnimatedSlide(
            duration: _navAnimDuration,
            curve: _navAnimCurve,
            offset: isVisible ? Offset.zero : const Offset(0, 1.4),
            child: AnimatedSize(
              duration: _navAnimDuration,
              curve: _navAnimCurve,
              alignment: Alignment.topCenter,
              child: isVisible
                  ? _FloatingBottomNav(navigationShell: navigationShell)
                  : const SizedBox(width: double.infinity, height: 0),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingBottomNav extends ConsumerWidget {
  const _FloatingBottomNav({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withValues(alpha: 0.95)
            : AppColors.surfaceLight.withValues(alpha: 0.95),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border.all(
          color: isDark
              ? AppColors.glassBorderDark
              : AppColors.glassBorderLight,
          width: 0.5,
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            children: [
              _NavItem(
                icon: LucideIcons.home,
                label: context.l10n.homeNavLabel,
                isSelected: navigationShell.currentIndex == 0,
                onTap: () => navigationShell.goBranch(0),
              ),
              _NavItem(
                icon: LucideIcons.trendingUp,
                label: context.l10n.progressNavLabel,
                isSelected: navigationShell.currentIndex == 1,
                onTap: () => navigationShell.goBranch(1),
              ),
              // Center FAB — Analyze (opens camera directly)
              _CenterFab(
                onTap: () => startAnalysisFlow(context, ref),
              ),
              _NavItem(
                icon: LucideIcons.sparkles,
                label: context.l10n.routineNavLabel,
                isSelected: navigationShell.currentIndex == 2,
                onTap: () => navigationShell.goBranch(2),
              ),
              _NavItem(
                icon: LucideIcons.user,
                label: context.l10n.profileNavLabel,
                isSelected: navigationShell.currentIndex == 3,
                onTap: () => navigationShell.goBranch(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterFab extends StatelessWidget {
  const _CenterFab({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                LucideIcons.scan,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              context.l10n.analyzeNavLabel,
              style: AppTextStyles.labelSmall.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.45),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected
        ? AppColors.primary
        : theme.colorScheme.onSurface.withValues(alpha: 0.45);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: color),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
