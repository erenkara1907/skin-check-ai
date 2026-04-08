import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/analysis_provider.dart';
import '../providers/camera_provider.dart';
import '../widgets/camera_guidance_bar.dart';
import '../widgets/capture_button.dart';
import '../widgets/face_oval_overlay.dart';

/// Full-screen camera for selfie capture with face detection.
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

    // Start countdown
    await notifier.startCountdownAndCapture();

    // Capture photo
    final bytes = await notifier.capturePhoto();

    if (!mounted) return;

    // Get user ID
    final user = ref.read(authNotifierProvider).valueOrNull;
    if (user == null) return;

    // Run analysis pipeline
    ref.read(analysisNotifierProvider.notifier).runAnalysis(
      userId: user.id,
      photoBytes: Uint8List.fromList(bytes),
    );

    // Navigate to result screen
    context.go('${AppRoutes.analyze}/result');
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Camera preview
          if (cameraState.isInitialized && cameraState.controller != null)
            CameraPreview(cameraState.controller!)
          else
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          // Face oval overlay
          FaceOvalOverlay(faceDetected: cameraState.faceDetected),

          // Flash effect
          if (cameraState.showFlash)
            Container(color: Colors.white.withValues(alpha: 0.8)),

          // Top bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          // Guidance bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 0,
            right: 0,
            child: CameraGuidanceBar(
              faceDetected: cameraState.faceDetected,
            ),
          ),

          // Error message
          if (cameraState.error != null)
            Positioned(
              bottom: 160,
              left: 32,
              right: 32,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  cameraState.error!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          // Bottom: capture button
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 40,
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
