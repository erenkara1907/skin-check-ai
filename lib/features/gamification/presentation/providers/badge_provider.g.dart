// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$badgeNotifierHash() => r'eae0f22076625762bc5057988e3a674b167c496d';

/// Manages badge unlocking and persistence.
///
/// Copied from [BadgeNotifier].
@ProviderFor(BadgeNotifier)
final badgeNotifierProvider =
    AsyncNotifierProvider<BadgeNotifier, List<BadgeEntity>>.internal(
      BadgeNotifier.new,
      name: r'badgeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$badgeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BadgeNotifier = AsyncNotifier<List<BadgeEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
