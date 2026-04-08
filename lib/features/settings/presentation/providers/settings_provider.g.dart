// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationEnabledHash() =>
    r'daf7b70550535897bc965aa555327a84b01dc9ac';

/// Whether routine notifications are enabled.
///
/// Copied from [NotificationEnabled].
@ProviderFor(NotificationEnabled)
final notificationEnabledProvider =
    NotifierProvider<NotificationEnabled, bool>.internal(
      NotificationEnabled.new,
      name: r'notificationEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationEnabled = Notifier<bool>;
String _$reminderTimeHash() => r'8e287dbad5836eed7e35bc19f540d26ebaa00e40';

/// Reminder time (hour and minute).
///
/// Copied from [ReminderTime].
@ProviderFor(ReminderTime)
final reminderTimeProvider =
    NotifierProvider<ReminderTime, ({int hour, int minute})>.internal(
      ReminderTime.new,
      name: r'reminderTimeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$reminderTimeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReminderTime = Notifier<({int hour, int minute})>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
