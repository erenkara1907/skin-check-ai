import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../analysis/presentation/providers/analysis_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/first_analysis_page.dart';
import '../widgets/onboarding_camera_page.dart';
import '../widgets/onboarding_completion_page.dart';
import '../widgets/onboarding_dot_indicator.dart';
import '../widgets/onboarding_loading_page.dart';
import '../widgets/onboarding_result_page.dart';
import '../widgets/onboarding_tour_page.dart';
import '../widgets/skin_concerns_page.dart';
import '../widgets/skin_type_page.dart';

/// Interactive onboarding: first analysis → results → tour → profile.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  bool _showCamera = false;
  bool _analysisListenerActive = false;

  /// Pages: 0=FirstAnalysis, 1=Loading, 2=Results, 3=Tour,
  ///        4=SkinType, 5=Concerns, 6=Completion
  static const _pageCount = kOnboardingPageCount; // 7

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

  /// Open embedded camera.
  void _openCamera() {
    setState(() => _showCamera = true);
  }

  /// Handle photo capture → start analysis → advance to loading page.
  void _onPhotoCaptured(Uint8List bytes) {
    final notifier = ref.read(onboardingNotifierProvider.notifier);
    notifier.setCapturedPhoto(bytes);

    setState(() => _showCamera = false);

    // Wait for PageView rebuild before animating
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToPage(1); // Loading page

      final user = ref.read(authNotifierProvider).valueOrNull;
      if (user != null) {
        ref.read(analysisNotifierProvider.notifier).runAnalysis(
              userId: user.id,
              photoBytes: bytes,
            );
        _analysisListenerActive = true;
      }
    });
  }

  /// Close camera and return to intro page.
  void _closeCamera() {
    setState(() => _showCamera = false);
  }

  /// Skip analysis → jump to skin type selection.
  void _skipAnalysis() {
    _goToPage(4);
  }

  /// Complete onboarding at the final page.
  Future<void> _onComplete() async {
    final notifier = ref.read(onboardingNotifierProvider.notifier);
    final success = await notifier.finishOnboarding();
    if (success && mounted) {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(
      onboardingNotifierProvider.select((s) => s.currentPage),
    );

    // Auto-advance from loading (page 1) to results (page 2)
    if (_analysisListenerActive) {
      final analysisAsync = ref.watch(analysisNotifierProvider);
      analysisAsync.whenData((analysis) {
        if (analysis != null && currentPage == 1) {
          _analysisListenerActive = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _goToPage(2);
          });
        }
      });
    }

    // Camera mode — full screen
    if (_showCamera) {
      return OnboardingCameraPage(
        onCaptured: _onPhotoCaptured,
        onClose: _closeCamera,
      );
    }

    // Hide dots on loading page (index 1)
    final showDots = currentPage != 1;

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
                    FirstAnalysisPage(
                      onStartCamera: _openCamera,
                      onSkip: _skipAnalysis,
                    ),
                    const OnboardingLoadingPage(),
                    OnboardingResultPage(onNext: _nextPage),
                    OnboardingTourPage(onNext: _nextPage),
                    SkinTypePage(onNext: _nextPage),
                    SkinConcernsPage(onNext: _nextPage),
                    OnboardingCompletionPage(onComplete: _onComplete),
                  ],
                ),
              ),
              if (showDots)
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
