// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cameraDataSourceHash() => r'4aeaf180d8010a42520236677e8eeb9d64788e4a';

/// Provides the [CameraDataSource] singleton.
///
/// Copied from [cameraDataSource].
@ProviderFor(cameraDataSource)
final cameraDataSourceProvider = AutoDisposeProvider<CameraDataSource>.internal(
  cameraDataSource,
  name: r'cameraDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cameraDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CameraDataSourceRef = AutoDisposeProviderRef<CameraDataSource>;
String _$cameraNotifierHash() => r'8bee28c132b58d6c6eefb490ea380ab714b6ce50';

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
