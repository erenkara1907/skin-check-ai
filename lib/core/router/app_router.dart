import 'package:go_router/go_router.dart';

import '../../features/analysis/presentation/screens/analysis_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/products/presentation/screens/products_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/routine/presentation/screens/routine_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/sharing/presentation/screens/sharing_screen.dart';
import '../../shared/widgets/main_shell.dart';

/// Route path constants.
abstract final class AppRoutes {
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const home = '/';
  static const analyze = '/analyze';
  static const progress = '/progress';
  static const routine = '/routine';
  static const profile = '/profile';
  static const settings = '/settings';
  static const products = '/products';
  static const sharing = '/sharing';
}

/// Application router configuration.
final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // Auth (outside shell)
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Main shell with bottom nav
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        // Home (index 0)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AnalysisScreen(), // Home = analysis overview
              ),
            ),
          ],
        ),
        // Analyze (index 1)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.analyze,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AnalysisScreen(),
              ),
            ),
          ],
        ),
        // Progress (index 2)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.progress,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProgressScreen(),
              ),
            ),
          ],
        ),
        // Routine (index 3)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.routine,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RoutineScreen(),
              ),
            ),
          ],
        ),
        // Profile (index 4)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // Standalone routes
    GoRoute(
      path: AppRoutes.products,
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: AppRoutes.sharing,
      builder: (context, state) => const SharingScreen(),
    ),
  ],
);
