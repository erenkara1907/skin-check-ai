import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../analysis/domain/entities/analysis_entity.dart';
import '../../../analysis/domain/entities/routine_step_entity.dart';
import '../../data/datasources/routine_datasource.dart';
import '../../data/repositories/routine_repository_impl.dart';
import '../../domain/entities/routine_entity.dart';
import '../../domain/entities/routine_step_detail_entity.dart';
import '../../domain/repositories/routine_repository.dart';

part 'routine_provider.g.dart';

/// Provides the [RoutineRepository] singleton.
@Riverpod(keepAlive: true)
RoutineRepository routineRepository(Ref ref) {
  return RoutineRepositoryImpl(
    RoutineDataSource(SupabaseService.client),
  );
}

/// Manages the user's active routines (morning + evening).
@riverpod
class RoutineNotifier extends _$RoutineNotifier {
  @override
  FutureOr<List<RoutineEntity>> build(String userId) async {
    final repo = ref.read(routineRepositoryProvider);
    return repo.getActiveRoutines(userId);
  }

  /// Creates routines from the latest analysis result.
  Future<void> createFromAnalysis(AnalysisEntity analysis) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(routineRepositoryProvider);

      final morning = RoutineEntity(
        id: '',
        userId: analysis.userId,
        type: 'morning',
        steps: _mapSteps(analysis.morningRoutine),
      );
      final evening = RoutineEntity(
        id: '',
        userId: analysis.userId,
        type: 'evening',
        steps: _mapSteps(analysis.eveningRoutine),
      );

      final savedMorning = await repo.saveRoutine(morning);
      final savedEvening = await repo.saveRoutine(evening);
      log.i('Routines created from analysis');

      return [savedMorning, savedEvening];
    });
  }

  /// Saves an updated routine (reorder, add/remove steps).
  Future<void> updateRoutine(RoutineEntity routine) async {
    final current = state.valueOrNull ?? [];
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(routineRepositoryProvider);
      final saved = await repo.saveRoutine(routine);

      return current
          .map((r) => r.id == saved.id ? saved : r)
          .toList();
    });
  }

  /// Deletes a routine and refreshes the list.
  Future<void> deleteRoutine(String routineId) async {
    final current = state.valueOrNull ?? [];
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(routineRepositoryProvider);
      await repo.deleteRoutine(routineId);
      return current.where((r) => r.id != routineId).toList();
    });
  }

  /// Refreshes routines from the server.
  Future<void> refresh(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(routineRepositoryProvider);
      return repo.getActiveRoutines(userId);
    });
  }

  List<RoutineStepDetailEntity> _mapSteps(
    List<RoutineStepEntity> steps,
  ) {
    return steps
        .map(
          (s) => RoutineStepDetailEntity(
            step: s.step,
            productType: s.productType,
            reason: s.reason,
            howToApply: _defaultHowTo(s.productType),
            iconName: _iconForProductType(s.productType),
          ),
        )
        .toList();
  }

  String _defaultHowTo(String productType) {
    const instructions = {
      'cleanser': 'Islak yüze dairesel hareketlerle uygulayın.',
      'toner': 'Pamuk yardımıyla yüze hafifçe sürün.',
      'serum': 'Birkaç damla avuç içine alıp yüze bastırarak uygulayın.',
      'moisturizer': 'Yüze ve boyuna yukarı doğru masaj yaparak yayın.',
      'sunscreen': 'Son adım olarak bol miktarda uygulayın.',
      'eye_cream': 'Göz çevresine yüzük parmağıyla hafifçe vurun.',
      'mask': '10-15 dakika bekletip ılık suyla durulayın.',
      'exfoliant': 'Haftada 2-3 kez, nazikçe dairesel hareketlerle.',
      'oil': 'Birkaç damla avuç içinde ısıtıp yüze bastırın.',
    };
    return instructions[productType.toLowerCase()] ??
        'Ürün talimatlarına göre uygulayın.';
  }

  String _iconForProductType(String productType) {
    const icons = {
      'cleanser': 'droplets',
      'toner': 'spray-can',
      'serum': 'flask-round',
      'moisturizer': 'cloud',
      'sunscreen': 'sun',
      'eye_cream': 'eye',
      'mask': 'smile',
      'exfoliant': 'sparkles',
      'oil': 'droplet',
      'retinol': 'moon',
    };
    return icons[productType.toLowerCase()] ?? 'pill';
  }
}
