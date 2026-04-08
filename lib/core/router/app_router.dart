import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/analysis/presentation/screens/analysis_result_screen.dart';
import '../../features/analysis/presentation/screens/analysis_screen.dart';
import '../../features/analysis/presentation/screens/camera_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/products/presentation/screens/products_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/routine/presentation/screens/routine_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/subscription/presentation/screens/paywall_screen.dart';
import '../../shared/widgets/main_shell.dart';

/// Route path constants.
abstract final class AppRoutes {
  static const login = '/login';
  static const signUp = '/sign-up';
  static const onboarding = '/onboarding';
  static const home = '/';
  static const analyze = '/analyze';
  static const progress = '/progress';
  static const routine = '/routine';
  static const profile = '/profile';
  static const settings = '/settings';
  static const products = '/products';
  static const paywall = '/paywall';
}

/// Application router provider with auth + onboarding redirect.
final appRouterProvider = Provider<GoRouter>((ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  final onboardingDone = ref.watch(isOnboardingCompletedProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final onAuthPage =
          loc == AppRoutes.login || loc == AppRoutes.signUp;
      final onOnboarding = loc == AppRoutes.onboarding;

      // Not authenticated → login (unless already on auth page)
      if (!isAuth && !onAuthPage) return AppRoutes.login;
      // Authenticated on auth page → check onboarding
      if (isAuth && onAuthPage) {
        return onboardingDone ? AppRoutes.home : AppRoutes.onboarding;
      }
      // Authenticated but onboarding not done → onboarding
      if (isAuth && !onboardingDone && !onOnboarding) {
        return AppRoutes.onboarding;
      }
      // Onboarding done but still on onboarding page → home
      if (isAuth && onboardingDone && onOnboarding) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      // Auth (outside shell)
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
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
                routes: [
                  GoRoute(
                    path: 'camera',
                    builder: (context, state) => const CameraScreen(),
                  ),
                  GoRoute(
                    path: 'result',
                    builder: (context, state) =>
                        const AnalysisResultScreen(),
                  ),
                ],
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
                    path: 'edit',
                    builder: (context, state) =>
                        const EditProfileScreen(),
                  ),
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
        path: AppRoutes.paywall,
        builder: (context, state) => const PaywallScreen(),
      ),
      GoRoute(
        path: AppRoutes.products,
        builder: (context, state) {
          final concernsParam =
              state.uri.queryParameters['concerns'] ?? '';
          final concerns = concernsParam.isEmpty
              ? <String>[]
              : concernsParam.split(',');
          return ProductsScreen(concerns: concerns);
        },
      ),
    ],
  );
});
