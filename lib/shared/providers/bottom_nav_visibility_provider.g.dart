// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_visibility_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bottomNavVisibleHash() => r'ef5e8d1157c14ee573c022adc70ed38a3f77d0de';

/// Whether the bottom nav should currently be visible.
///
/// Copied from [bottomNavVisible].
@ProviderFor(bottomNavVisible)
final bottomNavVisibleProvider = AutoDisposeProvider<bool>.internal(
  bottomNavVisible,
  name: r'bottomNavVisibleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bottomNavVisibleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BottomNavVisibleRef = AutoDisposeProviderRef<bool>;
String _$bottomNavVisibilityHash() =>
    r'3278cf46dbd3f710aacab8e5afdbe3ba8f050e2e';

/// Ref-counted hide state for the floating bottom navigation bar.
///
/// Multiple independent sources (modal sheets, routine edit mode, etc.)
/// can request the nav to hide. The nav stays hidden until every source
/// has released it — so a modal opened during edit mode won't pop the
/// nav back on when it closes.
///
/// Every [hide] call MUST be matched with exactly one [show] call.
///
/// Copied from [BottomNavVisibility].
@ProviderFor(BottomNavVisibility)
final bottomNavVisibilityProvider =
    NotifierProvider<BottomNavVisibility, int>.internal(
      BottomNavVisibility.new,
      name: r'bottomNavVisibilityProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bottomNavVisibilityHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BottomNavVisibility = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
