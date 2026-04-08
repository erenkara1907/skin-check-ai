import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../domain/entities/routine_entity.dart';
import '../../domain/entities/routine_step_detail_entity.dart';
import '../providers/routine_completion_provider.dart';
import '../providers/routine_provider.dart';
import 'add_step_dialog.dart';
import 'routine_step_card.dart';

/// Displays the list of steps for a single routine (morning or evening).
class RoutineStepList extends ConsumerWidget {
  const RoutineStepList({
    super.key,
    required this.routine,
    required this.userId,
    required this.isEditing,
    required this.onAllCompleted,
  });

  /// The routine to display.
  final RoutineEntity? routine;

  /// Current user ID.
  final String userId;

  /// Whether the user is in editing mode.
  final bool isEditing;

  /// Called when all steps are completed.
  final VoidCallback onAllCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (routine == null) {
      return const Center(child: Text('Bu rutin henüz oluşturulmamış.'));
    }

    final completionState = ref.watch(
      routineCompletionNotifierProvider(routine!.id),
    );
    final completionMap = completionState.valueOrNull ?? {};

    return Column(
      children: [
        Expanded(
          child: isEditing
              ? _buildReorderableList(ref)
              : _buildStepList(ref, completionMap),
        ),
        if (isEditing)
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _addStep(context, ref),
                icon: const Icon(LucideIcons.plus, size: 18),
                label: const Text('Adım Ekle'),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStepList(WidgetRef ref, Map<int, bool> completionMap) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      itemCount: routine!.steps.length,
      itemBuilder: (context, index) {
        return RoutineStepCard(
          step: routine!.steps[index],
          index: index,
          totalSteps: routine!.steps.length,
          isCompleted: completionMap[index] ?? false,
          onToggle: () => _toggleStep(ref, index),
        );
      },
    );
  }

  Widget _buildReorderableList(WidgetRef ref) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      itemCount: routine!.steps.length,
      onReorder: (old, next) => _reorderSteps(ref, old, next),
      itemBuilder: (context, index) {
        return RoutineStepCard(
          key: ValueKey('${routine!.id}_$index'),
          step: routine!.steps[index],
          index: index,
          totalSteps: routine!.steps.length,
          isCompleted: false,
          onToggle: () {},
          onDelete: () => _deleteStep(ref, index),
        );
      },
    );
  }

  void _toggleStep(WidgetRef ref, int index) {
    final notifier = ref.read(
      routineCompletionNotifierProvider(routine!.id).notifier,
    );
    notifier.toggleStep(index, totalSteps: routine!.steps.length);

    final map = ref.read(
      routineCompletionNotifierProvider(routine!.id),
    ).valueOrNull ?? {};

    final allDone = map.length == routine!.steps.length &&
        map.values.every((v) => v);

    if (allDone) onAllCompleted();
  }

  void _reorderSteps(WidgetRef ref, int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final steps = List<RoutineStepDetailEntity>.from(routine!.steps);
    final item = steps.removeAt(oldIndex);
    steps.insert(newIndex, item);

    ref.read(routineNotifierProvider(userId).notifier)
        .updateRoutine(routine!.copyWith(steps: steps));
  }

  void _deleteStep(WidgetRef ref, int index) {
    final steps = List<RoutineStepDetailEntity>.from(routine!.steps);
    steps.removeAt(index);

    ref.read(routineNotifierProvider(userId).notifier)
        .updateRoutine(routine!.copyWith(steps: steps));
  }

  Future<void> _addStep(BuildContext context, WidgetRef ref) async {
    final newStep = await AddStepDialog.show(context);
    if (newStep == null) return;

    final steps = [...routine!.steps, newStep];
    ref.read(routineNotifierProvider(userId).notifier)
        .updateRoutine(routine!.copyWith(steps: steps));
  }
}
