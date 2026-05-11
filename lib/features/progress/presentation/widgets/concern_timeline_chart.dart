import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../providers/progress_provider.dart';
import 'concern_trend_card.dart';
import 'concern_trend_data.dart';

/// "Sorun Takibi" section.
///
/// Layout: section header → at-a-glance summary strip (counts of
/// improving / stable / needs-attention) → one card per concern,
/// grouped by status. The summary strip is the headline number;
/// users see it first, then drill into individual cards. Cards are
/// pre-sorted upstream by [ConcernTrendData.fromTimeline] so wins
/// land first.
class ConcernTimelineChart extends ConsumerWidget {
  const ConcernTimelineChart({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineAsync =
        ref.watch(concernTimelineNotifierProvider(userId));

    return timelineAsync.when(
      loading: () => const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const _EmptyState(),
      data: (data) {
        final cards = ConcernTrendData.fromTimeline(data);
        if (cards.isEmpty) return const _EmptyState();
        return _Section(cards: cards);
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.cards});

  final List<ConcernTrendData> cards;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final muted = onSurface.withValues(alpha: 0.6);

    final improved = cards
        .where((c) => c.direction == TrendDirection.improving)
        .length;
    final worsened = cards
        .where((c) => c.direction == TrendDirection.worsening)
        .length;
    final stable = cards.length - improved - worsened;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.18),
                    AppColors.secondary.withValues(alpha: 0.18),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                LucideIcons.activity,
                size: 16,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.concernTimelineTitle,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: onSurface,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    context.l10n.concernTimelineSubtitle,
                    style: AppTextStyles.bodySmall.copyWith(color: muted),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SummaryStrip(
          improved: improved,
          stable: stable,
          worsened: worsened,
        ),
        const SizedBox(height: 14),
        ...cards.map((c) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ConcernTrendCard(data: c),
            )),
      ],
    );
  }
}

/// One-line summary chip strip. Users read it left-to-right: wins,
/// holding steady, then what needs attention. Each chip suppresses
/// itself when its count is zero so the strip never shows empty noise.
class _SummaryStrip extends StatelessWidget {
  const _SummaryStrip({
    required this.improved,
    required this.stable,
    required this.worsened,
  });

  final int improved;
  final int stable;
  final int worsened;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      if (improved > 0)
        _SummaryChip(
          icon: LucideIcons.arrowDownRight,
          color: AppColors.success,
          count: improved,
          label: context.l10n.concernTrendImprovedLabel,
        ),
      if (stable > 0)
        _SummaryChip(
          icon: LucideIcons.minus,
          color: AppColors.textSecondaryLight,
          count: stable,
          label: context.l10n.concernTrendStableLabel,
        ),
      if (worsened > 0)
        _SummaryChip(
          icon: LucideIcons.arrowUpRight,
          color: AppColors.error,
          count: worsened,
          label: context.l10n.concernTrendWorsenedLabel,
        ),
    ];

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          for (var i = 0; i < chips.length; i++) ...[
            if (i > 0)
              Container(
                width: 1,
                height: 28,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.08),
              ),
            Expanded(child: chips[i]),
          ],
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.icon,
    required this.color,
    required this.count,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$count',
              style: AppTextStyles.titleLarge.copyWith(
                color: onSurface,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: onSurface.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              LucideIcons.lineChart,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            context.l10n.concernTimelineTitle,
            style: AppTextStyles.titleMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.concernTimelineEmpty,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
