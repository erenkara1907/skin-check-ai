import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
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
      return Center(child: Text(context.l10n.emptyRoutineMessage));
    }

    final completionState = ref.watch(
      routineCompletionNotifierProvider(routine!.id),
    );
    final completionMap = completionState.valueOrNull ?? {};

    return Stack(
      children: [
        Positioned.fill(
          child: isEditing
              ? _buildReorderableList(ref)
              : _buildStepList(ref, completionMap),
        ),
        if (isEditing)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: _AddStepScrim(
                isDark: Theme.of(context).brightness == Brightness.dark,
              ),
            ),
          ),
        if (isEditing)
          Positioned(
            left: 20,
            right: 20,
            bottom: 16,
            child: _AddStepButton(
              label: context.l10n.addStepButton,
              onPressed: () => _addStep(context, ref),
            ),
          ),
      ],
    );
  }

  Widget _buildStepList(WidgetRef ref, Map<int, bool> completionMap) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8, bottom: isEditing ? 120 : 100),
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
      padding: const EdgeInsets.only(top: 8, bottom: 120),
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
          onDelete: () => _confirmDeleteStep(context, ref, index),
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

  Future<void> _confirmDeleteStep(
    BuildContext context,
    WidgetRef ref,
    int index,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.deleteStepTitle),
        content: Text(context.l10n.deleteStepConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(context.l10n.cancelButton),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(context.l10n.deleteButton),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      _deleteStep(ref, index);
    }
  }

  void _deleteStep(WidgetRef ref, int index) {
    final steps = List<RoutineStepDetailEntity>.from(routine!.steps);
    steps.removeAt(index);

    ref.read(routineNotifierProvider(userId).notifier)
        .updateRoutine(routine!.copyWith(steps: steps));
  }

  Future<void> _addStep(BuildContext context, WidgetRef ref) async {
    final newStep = await AddStepDialog.show(context, ref);
    if (newStep == null) return;

    final steps = [...routine!.steps, newStep];
    ref.read(routineNotifierProvider(userId).notifier)
        .updateRoutine(routine!.copyWith(steps: steps));
  }
}

/// Soft fade behind the floating "Add step" button so the last step in the
/// list doesn't visually collide with it.
class _AddStepScrim extends StatelessWidget {
  const _AddStepScrim({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bg = (isDark ? AppColors.backgroundDark : AppColors.backgroundLight);
    return SizedBox(
      height: 140,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              bg.withValues(alpha: 0),
              bg.withValues(alpha: 0.7),
              bg,
            ],
            stops: const [0, 0.55, 1],
          ),
        ),
      ),
    );
  }
}

/// Floating primary action for adding a step — gradient, elevated, no footer.
class _AddStepButton extends StatefulWidget {
  const _AddStepButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<_AddStepButton> createState() => _AddStepButtonState();
}

class _AddStepButtonState extends State<_AddStepButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _controller.forward(),
      onPointerUp: (_) => _controller.reverse(),
      onPointerCancel: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.plus, size: 20, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
