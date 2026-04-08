import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/logger.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../analysis/presentation/providers/analysis_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/routine_entity.dart';
import '../providers/routine_completion_provider.dart';
import '../providers/routine_provider.dart';
import '../widgets/empty_routine_view.dart';
import '../widgets/routine_step_list.dart';
import '../widgets/routine_tab_bar.dart';
import '../widgets/streak_banner.dart';

/// Main routine screen with morning/evening tabs.
class RoutineScreen extends ConsumerStatefulWidget {
  const RoutineScreen({super.key});

  @override
  ConsumerState<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends ConsumerState<RoutineScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ConfettiController _confettiController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    _scheduleNotifications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _scheduleNotifications() async {
    final granted =
        await NotificationService.instance.requestPermission();
    if (granted) {
      await NotificationService.instance.scheduleDailyReminders();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authNotifierProvider).valueOrNull?.id;
    if (userId == null) return const SizedBox.shrink();

    final routinesAsync = ref.watch(routineNotifierProvider(userId));

    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 8),
                  RoutineTabBar(controller: _tabController),
                  const SizedBox(height: 8),
                  _buildStreak(userId),
                  Expanded(
                    child: routinesAsync.when(
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (e, _) =>
                          Center(child: Text('Hata: $e')),
                      data: (routines) =>
                          _buildContent(routines, userId),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  AppColors.primary,
                  AppColors.secondary,
                  Color(0xFFFF8C00),
                  Color(0xFFFFD700),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: [
          Text('Bakım Rutini', style: AppTextStyles.headlineMedium),
          const Spacer(),
          IconButton(
            onPressed: () =>
                setState(() => _isEditing = !_isEditing),
            icon: Icon(
              _isEditing ? LucideIcons.check : LucideIcons.pencil,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreak(String userId) {
    final streakAsync = ref.watch(streakNotifierProvider(userId));
    return streakAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (streak) => StreakBanner(streak: streak),
    );
  }

  Widget _buildContent(
    List<RoutineEntity> routines,
    String userId,
  ) {
    if (routines.isEmpty) {
      return EmptyRoutineView(
        onCreateFromAnalysis: () => _createFromAnalysis(userId),
      );
    }

    final morning =
        routines.where((r) => r.type == 'morning').toList();
    final evening =
        routines.where((r) => r.type == 'evening').toList();

    return TabBarView(
      controller: _tabController,
      children: [
        RoutineStepList(
          routine: morning.isNotEmpty ? morning.first : null,
          userId: userId,
          isEditing: _isEditing,
          onAllCompleted: () =>
              _onAllCompleted(morning.first, userId),
        ),
        RoutineStepList(
          routine: evening.isNotEmpty ? evening.first : null,
          userId: userId,
          isEditing: _isEditing,
          onAllCompleted: () =>
              _onAllCompleted(evening.first, userId),
        ),
      ],
    );
  }

  void _onAllCompleted(RoutineEntity routine, String userId) {
    _confettiController.play();
    final completedSteps =
        routine.steps.map((s) => s.step).toList();
    ref
        .read(streakNotifierProvider(userId).notifier)
        .recordCompletion(
          userId: userId,
          routineId: routine.id,
          completedSteps: completedSteps,
        );
    log.i('Routine completed! Confetti time!');
  }

  Future<void> _createFromAnalysis(String userId) async {
    final historyAsync =
        ref.read(analysisHistoryProvider(userId));
    final history = historyAsync.valueOrNull;

    if (history == null || history.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Önce bir cilt analizi yapmalısın!'),
          ),
        );
        context.go('/analyze');
      }
      return;
    }

    final latest = history.first;
    await ref
        .read(routineNotifierProvider(userId).notifier)
        .createFromAnalysis(latest);
  }
}
