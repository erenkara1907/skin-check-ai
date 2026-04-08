import 'dart:typed_data';
import 'dart:ui' show Size;

import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../../core/utils/logger.dart';

/// Manages camera access, face detection, and photo capture.
class CameraDataSource {
  CameraController? _controller;
  FaceDetector? _faceDetector;

  /// Whether the camera is initialized and ready.
  bool get isReady => _controller?.value.isInitialized ?? false;

  /// The active camera controller.
  CameraController? get controller => _controller;

  /// Initialize the front camera.
  Future<CameraController> initialize() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      front,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _controller!.initialize();
    log.i('Camera initialized: ${front.name}');

    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.fast,
        enableLandmarks: false,
        enableClassification: false,
      ),
    );

    return _controller!;
  }

  /// Detect faces in the current camera image.
  /// Returns the number of faces found.
  Future<int> detectFaces(CameraImage image) async {
    if (_faceDetector == null) return 0;

    final format = _inputImageFormat(image.format.group);
    if (format == null) return 0;

    final inputImage = InputImage.fromBytes(
      bytes: _concatenatePlanes(image.planes),
      metadata: InputImageMetadata(
        size: Size(
          image.width.toDouble(),
          image.height.toDouble(),
        ),
        rotation: InputImageRotation.rotation0deg,
        format: format,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );

    final faces = await _faceDetector!.processImage(inputImage);
    return faces.length;
  }

  /// Capture a photo and return the bytes.
  Future<Uint8List> capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      throw StateError('Camera not initialized');
    }

    final file = await _controller!.takePicture();
    final bytes = await file.readAsBytes();
    log.i('Photo captured: ${bytes.length} bytes');
    return bytes;
  }

  /// Release camera and face detector resources.
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
    _faceDetector?.close();
    _faceDetector = null;
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    int totalLength = 0;
    for (final plane in planes) {
      totalLength += plane.bytes.length;
    }
    final result = Uint8List(totalLength);
    int offset = 0;
    for (final plane in planes) {
      result.setRange(offset, offset + plane.bytes.length, plane.bytes);
      offset += plane.bytes.length;
    }
    return result;
  }

  InputImageFormat? _inputImageFormat(ImageFormatGroup group) {
    switch (group) {
      case ImageFormatGroup.nv21:
        return InputImageFormat.nv21;
      case ImageFormatGroup.yuv420:
        return InputImageFormat.yuv420;
      case ImageFormatGroup.bgra8888:
        return InputImageFormat.bgra8888;
      default:
        return null;
    }
  }
}
