import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/profile_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';

part 'profile_provider.g.dart';

/// Provides the [ProfileRepository] instance.
@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepositoryImpl(
    ProfileDatasource(SupabaseService.client),
  );
}

/// Total analysis count for the current user.
@riverpod
Future<int> analysisCount(Ref ref) async {
  final user = ref.watch(userProfileProvider).valueOrNull;
  if (user == null) return 0;
  final repo = ref.read(profileRepositoryProvider);
  return repo.getAnalysisCount(user.id);
}

/// Account creation date for the current user.
@riverpod
Future<DateTime?> joinDate(Ref ref) async {
  final user = ref.watch(userProfileProvider).valueOrNull;
  if (user == null) return null;
  final repo = ref.read(profileRepositoryProvider);
  return repo.getJoinDate(user.id);
}

/// Manages profile update operations.
@riverpod
class ProfileActions extends _$ProfileActions {
  @override
  FutureOr<void> build() {}

  /// Updates the user's name and/or email.
  Future<bool> updateProfile({String? name, String? email}) async {
    final user = ref.read(userProfileProvider).valueOrNull;
    if (user == null) return false;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      await repo.updateProfile(userId: user.id, name: name, email: email);
      ref.invalidate(userProfileProvider);
    });
    return !state.hasError;
  }

  /// Exports all user data as JSON.
  Future<Map<String, dynamic>?> exportData() async {
    final user = ref.read(userProfileProvider).valueOrNull;
    if (user == null) return null;

    try {
      final repo = ref.read(profileRepositoryProvider);
      return await repo.exportUserData(user.id);
    } catch (e, st) {
      log.e('Export data failed', e, st);
      return null;
    }
  }

  /// Deletes the user account and all data.
  Future<bool> deleteAccount() async {
    final user = ref.read(userProfileProvider).valueOrNull;
    if (user == null) return false;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      await repo.deleteAccount(user.id);
    });
    return !state.hasError;
  }
}
