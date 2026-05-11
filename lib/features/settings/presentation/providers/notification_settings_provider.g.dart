// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$morningReminderTimeHash() =>
    r'c75ffb8aab56cf8cbfb8e11d7690247456e5ed2b';

/// Morning reminder time (hour + minute).
///
/// Copied from [MorningReminderTime].
@ProviderFor(MorningReminderTime)
final morningReminderTimeProvider =
    NotifierProvider<MorningReminderTime, ({int hour, int minute})>.internal(
      MorningReminderTime.new,
      name: r'morningReminderTimeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$morningReminderTimeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MorningReminderTime = Notifier<({int hour, int minute})>;
String _$eveningReminderTimeHash() =>
    r'f69f9ea29614701edcff4200ea0777bcd049ed23';

/// Evening reminder time (hour + minute).
///
/// Copied from [EveningReminderTime].
@ProviderFor(EveningReminderTime)
final eveningReminderTimeProvider =
    NotifierProvider<EveningReminderTime, ({int hour, int minute})>.internal(
      EveningReminderTime.new,
      name: r'eveningReminderTimeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$eveningReminderTimeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EveningReminderTime = Notifier<({int hour, int minute})>;
String _$streakNotificationEnabledHash() =>
    r'f82d933d990ef94a777a63bf8f45140a0907e21c';

/// Whether streak milestone notifications are enabled.
///
/// Copied from [StreakNotificationEnabled].
@ProviderFor(StreakNotificationEnabled)
final streakNotificationEnabledProvider =
    NotifierProvider<StreakNotificationEnabled, bool>.internal(
      StreakNotificationEnabled.new,
      name: r'streakNotificationEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$streakNotificationEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StreakNotificationEnabled = Notifier<bool>;
String _$motivationalNotificationEnabledHash() =>
    r'1a370f468c5fb845d38501e750d744a9dbb2a8da';

/// Whether motivational notification messages are enabled.
///
/// Copied from [MotivationalNotificationEnabled].
@ProviderFor(MotivationalNotificationEnabled)
final motivationalNotificationEnabledProvider =
    NotifierProvider<MotivationalNotificationEnabled, bool>.internal(
      MotivationalNotificationEnabled.new,
      name: r'motivationalNotificationEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$motivationalNotificationEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MotivationalNotificationEnabled = Notifier<bool>;
String _$weeklyReminderDayHash() => r'6877232bc803d4b0280e96120ffde5857807d705';

/// Day of week for the weekly analysis reminder (1=Monday, 7=Sunday).
///
/// Copied from [WeeklyReminderDay].
@ProviderFor(WeeklyReminderDay)
final weeklyReminderDayProvider =
    NotifierProvider<WeeklyReminderDay, int>.internal(
      WeeklyReminderDay.new,
      name: r'weeklyReminderDayProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$weeklyReminderDayHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WeeklyReminderDay = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
