import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/analysis_provider.dart';
import '../providers/camera_provider.dart';
import '../widgets/camera_guidance_bar.dart';
import '../widgets/capture_button.dart';
import '../widgets/face_oval_overlay.dart';
import '../widgets/scan_line_effect.dart';

/// Quiet, focused selfie capture screen.
///
/// Three things only:
///   • The oval (where your face goes)
///   • One line of guidance
///   • One button to capture
///
/// Everything else — quality chips, brand marks, help drawers — has been
/// removed. The screen should feel like an empty room, not a cockpit.
class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cameraNotifierProvider.notifier).initCamera();
    });
  }

  Future<void> _onCapture() async {
    final notifier = ref.read(cameraNotifierProvider.notifier);
    await notifier.startCountdownAndCapture();
    final bytes = await notifier.capturePhoto();
    if (!mounted) return;

    final user = ref.read(authNotifierProvider).valueOrNull;
    if (user == null) return;

    ref.read(analysisNotifierProvider.notifier).runAnalysis(
          userId: user.id,
          photoBytes: Uint8List.fromList(bytes),
        );

    ref.invalidate(cameraNotifierProvider);
    if (!mounted) return;
    context.go(AppRoutes.analysisResult);
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraNotifierProvider);
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Camera preview
          if (cameraState.isInitialized && cameraState.controller != null)
            _CameraPreview(controller: cameraState.controller!)
          else
            const _PreviewLoading(),

          // Viewfinder (oval cutout + vignette + corner arcs + aura)
          FaceOvalOverlay(faceDetected: cameraState.faceDetected),

          // Soft scan line
          ScanLineEffect(faceDetected: cameraState.faceDetected),

          // Subtle edge vignette for cinematic framing
          const _EdgeVignette(),

          // Soft flash burst
          if (cameraState.showFlash) const _SoftFlash(),

          // Close button (top-left only — nothing else up top)
          Positioned(
            top: padding.top + 10,
            left: 14,
            child: _CloseButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutes.analyze);
                }
              },
            ),
          ),

          // Guidance whisper — just above the bottom third
          Positioned(
            left: 0,
            right: 0,
            bottom: padding.bottom + 168,
            child: CameraGuidanceBar(
              faceDetected: cameraState.faceDetected,
            ),
          ),

          // Centered countdown numeral
          if (cameraState.countdown > 0)
            _Countdown(value: cameraState.countdown),

          // Error toast
          if (cameraState.error != null)
            Positioned(
              bottom: padding.bottom + 220,
              left: 32,
              right: 32,
              child: _ErrorToast(message: cameraState.error!),
            ),

          // Capture button
          Positioned(
            bottom: padding.bottom + 48,
            left: 0,
            right: 0,
            child: Center(
              child: CaptureButton(
                onPressed: _onCapture,
                enabled: cameraState.faceDetected &&
                    !cameraState.isCapturing,
                countdown: cameraState.countdown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _CameraPreview extends StatelessWidget {
  const _CameraPreview({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller.value.previewSize!.height,
            height: controller.value.previewSize!.width,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );
  }
}

class _PreviewLoading extends StatelessWidget {
  const _PreviewLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0B10),
      alignment: Alignment.center,
      child: SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(
          strokeWidth: 1.6,
          valueColor: AlwaysStoppedAnimation(
            Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}

/// Very subtle gradient at top and bottom — just enough to anchor the chrome.
class _EdgeVignette extends StatelessWidget {
  const _EdgeVignette();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x99000000), Color(0x00000000)],
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xB3000000), Color(0x00000000)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftFlash extends StatelessWidget {
  const _SoftFlash();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        color: Colors.white.withValues(alpha: 0.75),
      ).animate().fadeIn(duration: 70.ms).then().fadeOut(duration: 220.ms),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Material(
          color: Colors.black.withValues(alpha: 0.25),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(LucideIcons.x, color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}

/// Just a large numeral with a soft glow — no orb, no halo, no aurora.
class _Countdown extends StatelessWidget {
  const _Countdown({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Text(
          '$value',
          key: ValueKey(value),
          style: AppTextStyles.displayLarge.copyWith(
            color: Colors.white,
            fontSize: 96,
            fontWeight: FontWeight.w300,
            height: 1,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 24,
              ),
            ],
          ),
        )
            .animate(key: ValueKey(value))
            .fadeIn(duration: 220.ms)
            .scale(
              begin: const Offset(0.9, 0.9),
              end: const Offset(1.0, 1.0),
              curve: Curves.easeOutCubic,
              duration: 320.ms,
            ),
      ),
    );
  }
}

class _ErrorToast extends StatelessWidget {
  const _ErrorToast({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
