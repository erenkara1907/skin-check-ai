// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cameraNotifierHash() => r'b5929371e5a745c66a153839ab24afd6024c260a';

/// Manages camera lifecycle, face detection, and capture flow.
///
/// Copied from [CameraNotifier].
@ProviderFor(CameraNotifier)
final cameraNotifierProvider =
    AutoDisposeNotifierProvider<CameraNotifier, CameraState>.internal(
      CameraNotifier.new,
      name: r'cameraNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cameraNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CameraNotifier = AutoDisposeNotifier<CameraState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
