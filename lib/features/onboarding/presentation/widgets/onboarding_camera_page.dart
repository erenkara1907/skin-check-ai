import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../analysis/presentation/providers/camera_provider.dart';
import '../../../analysis/presentation/widgets/camera_guidance_bar.dart';
import '../../../analysis/presentation/widgets/capture_button.dart';
import '../../../analysis/presentation/widgets/face_oval_overlay.dart';
import '../../../analysis/presentation/widgets/scan_line_effect.dart';

/// Embedded camera page for onboarding first analysis.
class OnboardingCameraPage extends ConsumerStatefulWidget {
  const OnboardingCameraPage({
    super.key,
    required this.onCaptured,
    required this.onClose,
  });

  /// Called with photo bytes after successful capture.
  final ValueChanged<Uint8List> onCaptured;

  /// Called when user closes camera.
  final VoidCallback onClose;

  @override
  ConsumerState<OnboardingCameraPage> createState() =>
      _OnboardingCameraPageState();
}

class _OnboardingCameraPageState extends ConsumerState<OnboardingCameraPage> {
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

    ref.invalidate(cameraNotifierProvider);
    widget.onCaptured(Uint8List.fromList(bytes));
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
            Center(
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width:
                        cameraState.controller!.value.previewSize!.height,
                    height:
                        cameraState.controller!.value.previewSize!.width,
                    child: CameraPreview(cameraState.controller!),
                  ),
                ),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          // Face oval overlay
          FaceOvalOverlay(faceDetected: cameraState.faceDetected),

          // Scan line effect
          ScanLineEffect(faceDetected: cameraState.faceDetected),

          // Flash overlay
          if (cameraState.showFlash)
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.9),
                    Colors.white.withValues(alpha: 0.0),
                  ],
                  radius: 0.8,
                ),
              ),
            ),

          // Close button
          Positioned(
            top: padding.top + 8,
            left: 8,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: 44,
                  height: 44,
                  color: Colors.black.withValues(alpha: 0.3),
                  child: IconButton(
                    onPressed: widget.onClose,
                    icon: const Icon(
                      LucideIcons.x,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Guidance bar
          Positioned(
            top: padding.top + 60,
            left: 0,
            right: 0,
            child: CameraGuidanceBar(
              faceDetected: cameraState.faceDetected,
            ),
          ),

          // Countdown
          if (cameraState.countdown > 0)
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  '${cameraState.countdown}',
                  key: ValueKey(cameraState.countdown),
                  style: AppTextStyles.displayLarge.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 72,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

          // Error
          if (cameraState.error != null)
            Positioned(
              bottom: 160,
              left: 32,
              right: 32,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.6),
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
              ),
            ),

          // Capture button
          Positioned(
            bottom: padding.bottom + 40,
            left: 0,
            right: 0,
            child: Center(
              child: CaptureButton(
                onPressed: _onCapture,
                enabled:
                    cameraState.faceDetected && !cameraState.isCapturing,
                countdown: cameraState.countdown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
