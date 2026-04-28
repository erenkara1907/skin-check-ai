import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../utils/concern_localizer.dart';
import 'concern_trend_data.dart';

/// Per-concern tracking card built around a dual severity-bar
/// comparison ("Önce" vs. "Şimdi"). The two bars share the same 0–10
/// track, are colored by severity zone (green/amber/red), and the
/// status pill at the top spells the verdict in plain language —
/// users no longer need to interpret a sparkline shape to know whether
/// a concern improved.
class ConcernTrendCard extends StatelessWidget {
  const ConcernTrendCard({super.key, required this.data});

  final ConcernTrendData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final hasComparison =
        data.direction != TrendDirection.firstMeasurement;

    return AppCard(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(data: data, onSurface: onSurface),
          const SizedBox(height: 14),
          if (hasComparison) ...[
            _SeverityBarRow(
              label: context.l10n.concernTrendBefore,
              value: data.firstSeverity,
              isCurrent: false,
              context: context,
            ),
            const SizedBox(height: 8),
            _SeverityBarRow(
              label: context.l10n.concernTrendNow,
              value: data.currentSeverity,
              isCurrent: true,
              context: context,
            ),
          ] else
            _SeverityBarRow(
              label: context.l10n.concernTrendNow,
              value: data.currentSeverity,
              isCurrent: true,
              context: context,
            ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.data, required this.onSurface});

  final ConcernTrendData data;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: data.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: data.color.withValues(alpha: 0.4),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            localizeConcern(context, data.concern),
            style: AppTextStyles.titleLarge.copyWith(
              color: onSurface,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        _StatusPill(direction: data.direction, percent: data.changePercent),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.direction, required this.percent});

  final TrendDirection direction;
  final int percent;

  @override
  Widget build(BuildContext context) {
    final color = _color(direction);
    final icon = _icon(direction);
    final label = _label(context, direction, percent);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  static Color _color(TrendDirection d) {
    switch (d) {
      case TrendDirection.improving:
        return AppColors.success;
      case TrendDirection.worsening:
        return AppColors.error;
      case TrendDirection.stable:
      case TrendDirection.firstMeasurement:
        return AppColors.textSecondaryLight;
    }
  }

  static IconData _icon(TrendDirection d) {
    switch (d) {
      case TrendDirection.improving:
        return LucideIcons.arrowDownRight;
      case TrendDirection.worsening:
        return LucideIcons.arrowUpRight;
      case TrendDirection.stable:
        return LucideIcons.minus;
      case TrendDirection.firstMeasurement:
        return LucideIcons.sparkles;
    }
  }

  static String _label(BuildContext c, TrendDirection d, int p) {
    switch (d) {
      case TrendDirection.improving:
        return c.l10n.concernTrendImproved(p.abs());
      case TrendDirection.worsening:
        return c.l10n.concernTrendWorsened(p);
      case TrendDirection.stable:
        return c.l10n.concernTrendStable;
      case TrendDirection.firstMeasurement:
        return c.l10n.concernTrendFirstMeasurement;
    }
  }
}

class _SeverityBarRow extends StatelessWidget {
  const _SeverityBarRow({
    required this.label,
    required this.value,
    required this.isCurrent,
    required this.context,
  });

  final String label;
  final double value;
  final bool isCurrent;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    final theme = Theme.of(context);
    final mutedText = theme.colorScheme.onSurface.withValues(alpha: 0.55);
    final strongText = theme.colorScheme.onSurface;
    final barColor = severityZoneColor(value);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 48,
          child: Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: mutedText,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SeverityBar(
            value: value,
            color: barColor,
            emphasized: isCurrent,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value.toStringAsFixed(1),
                style: AppTextStyles.titleMedium.copyWith(
                  color: isCurrent ? strongText : mutedText,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  severityLabel(context, value),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: barColor,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SeverityBar extends StatelessWidget {
  const _SeverityBar({
    required this.value,
    required this.color,
    required this.emphasized,
  });

  final double value;
  final Color color;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor = (isDark ? Colors.white : Colors.black)
        .withValues(alpha: 0.06);
    final fraction = (value / 10).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              width: constraints.maxWidth * fraction,
              height: 10,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: emphasized ? 0.95 : 0.7),
                    color,
                  ],
                ),
                borderRadius: BorderRadius.circular(999),
                boxShadow: emphasized
                    ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
