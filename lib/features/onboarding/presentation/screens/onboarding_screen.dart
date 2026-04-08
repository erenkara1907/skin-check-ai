import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/camera_permission_page.dart';
import '../widgets/onboarding_dot_indicator.dart';
import '../widgets/skin_concerns_page.dart';
import '../widgets/skin_type_page.dart';
import '../widgets/welcome_page.dart';

/// Main onboarding screen with PageView navigation.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;

  static const _pageCount = 4;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    ref.read(onboardingNotifierProvider.notifier).goToPage(page);
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextPage() {
    final current = ref.read(onboardingNotifierProvider).currentPage;
    if (current < _pageCount - 1) {
      _goToPage(current + 1);
    }
  }

  void _onComplete() {
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(
      onboardingNotifierProvider.select((s) => s.currentPage),
    );

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) => ref
                      .read(onboardingNotifierProvider.notifier)
                      .goToPage(page),
                  children: [
                    WelcomePage(onStart: _nextPage),
                    SkinTypePage(onNext: _nextPage),
                    SkinConcernsPage(onNext: _nextPage),
                    CameraPermissionPage(onComplete: _onComplete),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: OnboardingDotIndicator(
                  currentPage: currentPage,
                  pageCount: _pageCount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
