import 'package:flutter/foundation.dart' show ChangeNotifier, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/analysis/presentation/screens/analysis_result_screen.dart';
import '../../features/analysis/presentation/screens/analysis_detail_screen.dart';
import '../../features/analysis/presentation/screens/camera_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/landing/presentation/screens/landing_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/products/presentation/screens/products_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/gamification/presentation/screens/badges_screen.dart';
import '../../features/routine/domain/entities/routine_step_detail_entity.dart';
import '../../features/routine/presentation/screens/guided_routine_screen.dart';
import '../../features/routine/presentation/screens/routine_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/subscription/presentation/screens/paywall_screen.dart';
import '../../shared/widgets/main_shell.dart';

/// Route path constants.
abstract final class AppRoutes {
  /// Global navigator key for notification deep links.
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static const landing = '/landing';
  static const login = '/login';
  static const signUp = '/sign-up';
  static const onboarding = '/onboarding';
  static const home = '/';
  static const analyze = '/analyze';
  static const progress = '/progress';
  static const routine = '/routine';
  static const profile = '/profile';
  static const camera = '/analyze/camera';
  static const analysisResult = '/analyze/result';
  static const analysisDetail = '/progress/detail';
  static const editProfile = '/profile/edit';
  static const changePassword = '/profile/change-password';
  static const settings = '/profile/settings';
  static const products = '/products';
  static const paywall = '/paywall';
  static const guidedRoutine = '/routine/guided';
  static const badges = '/badges';
}

/// Notifier that triggers GoRouter redirect re-evaluation.
class _RouterNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

/// Application router provider with auth + onboarding redirect.
final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier();

  // Listen (not watch!) — triggers redirect re-evaluation without
  // recreating the GoRouter instance.
  ref.listen(isAuthenticatedProvider, (_, __) => notifier.notify());
  ref.listen(isOnboardingCompletedProvider, (_, __) => notifier.notify());
  ref.onDispose(notifier.dispose);

  return GoRouter(
    navigatorKey: AppRoutes.rootNavigatorKey,
    initialLocation: AppRoutes.home,
    refreshListenable: notifier,
    redirect: (context, state) {
      final isAuth = ref.read(isAuthenticatedProvider);
      final onboardingDone = ref.read(isOnboardingCompletedProvider);

      final loc = state.matchedLocation;
      final onAuthPage =
          loc == AppRoutes.login || loc == AppRoutes.signUp;
      final onOnboarding = loc == AppRoutes.onboarding;
      final onLanding = loc == AppRoutes.landing;

      // Landing page is always accessible (web only)
      if (onLanding) return null;

      // Not authenticated on web → landing page
      if (kIsWeb && !isAuth && !onAuthPage) return AppRoutes.landing;
      // Not authenticated on mobile → login
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
      // /analyze hub no longer exists — deep links go straight to camera
      if (loc == AppRoutes.analyze) return AppRoutes.camera;
      return null;
    },
    routes: [
      // Landing (web only)
      GoRoute(
        path: AppRoutes.landing,
        builder: (context, state) => const LandingScreen(),
      ),

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
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          // Progress (index 1)
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
          // Routine (index 2)
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
          // Profile (index 3)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),

      // Detail routes (outside shell — no bottom nav)
      GoRoute(
        path: AppRoutes.camera,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const CameraScreen(),
          transitionsBuilder: (context, animation, _, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 1.05, end: 1.0)
                    .animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.analysisResult,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const AnalysisResultScreen(),
          transitionsBuilder: (context, animation, _, child) {
            final slide = Tween<Offset>(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slide, child: child),
            );
          },
        ),
      ),
      GoRoute(
        path: '${AppRoutes.analysisDetail}/:analysisId',
        builder: (context, state) => AnalysisDetailScreen(
          analysisId: state.pathParameters['analysisId']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Standalone routes
      GoRoute(
        path: AppRoutes.paywall,
        builder: (context, state) => const PaywallScreen(),
      ),
      GoRoute(
        path: AppRoutes.guidedRoutine,
        builder: (context, state) => GuidedRoutineScreen(
          steps: state.extra! as List<RoutineStepDetailEntity>,
        ),
      ),
      GoRoute(
        path: AppRoutes.badges,
        builder: (context, state) => const BadgesScreen(),
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
