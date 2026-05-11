import '../../features/analysis/domain/entities/routine_step_entity.dart';

/// Represents the difference between old and new routine steps.
class RoutineDiff {
  const RoutineDiff({
    required this.addedSteps,
    required this.removedSteps,
    required this.changedSteps,
    required this.unchangedSteps,
  });

  final List<RoutineStepEntity> addedSteps;
  final List<RoutineStepEntity> removedSteps;
  final List<({RoutineStepEntity old, RoutineStepEntity updated})>
      changedSteps;
  final List<RoutineStepEntity> unchangedSteps;

  /// True if there are any differences.
  bool get hasChanges =>
      addedSteps.isNotEmpty ||
      removedSteps.isNotEmpty ||
      changedSteps.isNotEmpty;
}

/// Computes the diff between old and new routine steps.
///
/// Steps are matched by [productType]. A step is "changed" if the
/// productType matches but the reason or step name differs.
RoutineDiff computeRoutineDiff({
  required List<RoutineStepEntity> oldSteps,
  required List<RoutineStepEntity> newSteps,
}) {
  final oldByType = {for (final s in oldSteps) s.productType: s};
  final newByType = {for (final s in newSteps) s.productType: s};

  final added = <RoutineStepEntity>[];
  final removed = <RoutineStepEntity>[];
  final changed =
      <({RoutineStepEntity old, RoutineStepEntity updated})>[];
  final unchanged = <RoutineStepEntity>[];

  // Find added and changed steps
  for (final entry in newByType.entries) {
    final oldStep = oldByType[entry.key];
    if (oldStep == null) {
      added.add(entry.value);
    } else if (oldStep.reason != entry.value.reason ||
        oldStep.step != entry.value.step) {
      changed.add((old: oldStep, updated: entry.value));
    } else {
      unchanged.add(entry.value);
    }
  }

  // Find removed steps
  for (final entry in oldByType.entries) {
    if (!newByType.containsKey(entry.key)) {
      removed.add(entry.value);
    }
  }

  return RoutineDiff(
    addedSteps: added,
    removedSteps: removed,
    changedSteps: changed,
    unchangedSteps: unchanged,
  );
}
