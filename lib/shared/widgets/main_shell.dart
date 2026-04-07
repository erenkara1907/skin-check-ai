import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'gradient_background.dart';

/// Bottom navigation shell with 5 tabs.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  /// GoRouter navigation shell.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: navigationShell,
        bottomNavigationBar: _BottomNav(navigationShell: navigationShell),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              _NavItem(
                icon: LucideIcons.home,
                label: 'Home',
                isSelected: navigationShell.currentIndex == 0,
                onTap: () => navigationShell.goBranch(0),
              ),
              _NavItem(
                icon: LucideIcons.scan,
                label: 'Analyze',
                isSelected: navigationShell.currentIndex == 1,
                onTap: () => navigationShell.goBranch(1),
              ),
              _NavItem(
                icon: LucideIcons.trendingUp,
                label: 'Progress',
                isSelected: navigationShell.currentIndex == 2,
                onTap: () => navigationShell.goBranch(2),
              ),
              _NavItem(
                icon: LucideIcons.sparkles,
                label: 'Routine',
                isSelected: navigationShell.currentIndex == 3,
                onTap: () => navigationShell.goBranch(3),
              ),
              _NavItem(
                icon: LucideIcons.user,
                label: 'Profile',
                isSelected: navigationShell.currentIndex == 4,
                onTap: () => navigationShell.goBranch(4),
              ),
            ],
          ),
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
        ? theme.colorScheme.primary
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
                style: TextStyle(
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
