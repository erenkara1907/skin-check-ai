import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/logger.dart';
import '../../data/datasources/camera_datasource.dart';

part 'camera_provider.g.dart';

/// Camera state exposed to the UI.
class CameraState {
  const CameraState({
    this.controller,
    this.isInitialized = false,
    this.faceDetected = false,
    this.isCapturing = false,
    this.countdown = 0,
    this.showFlash = false,
    this.error,
  });

  final CameraController? controller;
  final bool isInitialized;
  final bool faceDetected;
  final bool isCapturing;
  final int countdown;
  final bool showFlash;
  final String? error;

  CameraState copyWith({
    CameraController? controller,
    bool? isInitialized,
    bool? faceDetected,
    bool? isCapturing,
    int? countdown,
    bool? showFlash,
    String? error,
  }) {
    return CameraState(
      controller: controller ?? this.controller,
      isInitialized: isInitialized ?? this.isInitialized,
      faceDetected: faceDetected ?? this.faceDetected,
      isCapturing: isCapturing ?? this.isCapturing,
      countdown: countdown ?? this.countdown,
      showFlash: showFlash ?? this.showFlash,
      error: error,
    );
  }
}

/// Provides the [CameraDataSource] singleton.
@riverpod
CameraDataSource cameraDataSource(Ref ref) {
  final ds = CameraDataSource();
  ref.onDispose(() => ds.dispose());
  return ds;
}

/// Manages camera lifecycle, face detection, and capture flow.
@riverpod
class CameraNotifier extends _$CameraNotifier {
  late CameraDataSource _dataSource;
  bool _isDetecting = false;

  @override
  CameraState build() {
    _dataSource = ref.read(cameraDataSourceProvider);
    ref.onDispose(_cleanup);
    return const CameraState();
  }

  /// Initialize the front camera and start face detection.
  Future<void> initCamera() async {
    try {
      final controller = await _dataSource.initialize();
      state = state.copyWith(
        controller: controller,
        isInitialized: true,
      );
      _startFaceDetection(controller);
    } catch (e, st) {
      log.e('Camera init failed', e, st);
      state = state.copyWith(error: 'Kamera başlatılamadı');
    }
  }

  void _startFaceDetection(CameraController controller) {
    controller.startImageStream((image) async {
      if (_isDetecting) return;
      _isDetecting = true;
      try {
        final count = await _dataSource.detectFaces(image);
        if (state.faceDetected != (count > 0)) {
          state = state.copyWith(faceDetected: count > 0);
        }
      } catch (_) {
        // Silently skip detection errors
      } finally {
        _isDetecting = false;
      }
    });
  }

  /// Start the 3-2-1 countdown, then capture.
  Future<void> startCountdownAndCapture() async {
    if (state.isCapturing) return;
    state = state.copyWith(isCapturing: true);

    // Stop image stream before capture
    await state.controller?.stopImageStream();

    // 3-2-1 countdown
    for (int i = 3; i >= 1; i--) {
      state = state.copyWith(countdown: i);
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    state = state.copyWith(countdown: 0);

    // Flash effect
    state = state.copyWith(showFlash: true);
    await Future<void>.delayed(const Duration(milliseconds: 150));
    state = state.copyWith(showFlash: false);
  }

  /// Capture the photo and return bytes.
  Future<List<int>> capturePhoto() async {
    try {
      final bytes = await _dataSource.capturePhoto();
      return bytes;
    } catch (e, st) {
      log.e('Capture failed', e, st);
      state = state.copyWith(
        error: 'Fotoğraf çekilemedi',
        isCapturing: false,
      );
      rethrow;
    }
  }

  /// Reset capture state for a new attempt.
  void resetCapture() {
    state = state.copyWith(
      isCapturing: false,
      countdown: 0,
      showFlash: false,
      error: null,
    );
    if (state.controller != null && state.isInitialized) {
      _startFaceDetection(state.controller!);
    }
  }

  void _cleanup() {
    _dataSource.dispose();
  }
}
