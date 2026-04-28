import 'dart:async';

import 'package:camera/camera.dart';
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

/// Manages camera lifecycle, face detection, and capture flow.
@riverpod
class CameraNotifier extends _$CameraNotifier {
  CameraDataSource? _dataSource;
  bool _isDetecting = false;
  bool _disposed = false;

  @override
  CameraState build() {
    _disposed = false;
    ref.onDispose(() {
      _disposed = true;
      _dataSource?.dispose();
      _dataSource = null;
    });
    return const CameraState();
  }

  /// Initialize the front camera and start face detection.
  Future<void> initCamera() async {
    try {
      log.d('Initializing camera...');
      _dataSource = CameraDataSource();
      final controller = await _dataSource!.initialize();
      if (_disposed) return;
      state = state.copyWith(
        controller: controller,
        isInitialized: true,
      );
      log.d('Camera ready, delaying face detection...');
      // Let the preview render before starting heavy ML processing
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (_disposed) return;
      if (state.isInitialized && !state.isCapturing) {
        _startFaceDetection(controller);
      }
    } catch (e, st) {
      if (_disposed) return;
      log.e('Camera init failed', e, st);
      state = state.copyWith(error: 'Kamera başlatılamadı');
    }
  }

  void _startFaceDetection(CameraController controller) {
    int frameSkip = 0;
    try {
      controller.startImageStream((image) async {
        // Process every 3rd frame to reduce CPU load
        frameSkip++;
        if (frameSkip % 3 != 0) return;
        if (_isDetecting || _disposed) return;
        _isDetecting = true;
        try {
          final count = await _dataSource?.detectFaces(image) ?? 0;
          if (_disposed) return;
          if (state.faceDetected != (count > 0)) {
            state = state.copyWith(faceDetected: count > 0);
          }
        } catch (e) {
          log.w('Face detection frame error: $e');
        } finally {
          _isDetecting = false;
        }
      });
      log.d('Face detection stream started');
    } catch (e, st) {
      log.e('Failed to start image stream', e, st);
    }
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
      final bytes = await _dataSource!.capturePhoto();
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
}
