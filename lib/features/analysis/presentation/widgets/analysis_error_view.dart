import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/analysis_failure.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

/// Error view displayed when skin analysis fails.
///
/// Shows a localized, user-friendly message based on [failure] type,
/// plus two actions:
///   • **Retry** — re-runs the analysis step (no re-upload).
///   • **Home**  — navigates back to the analyze hub safely, even when
///                 the GoRouter stack is empty.
///
/// In debug builds, the raw cause is collapsible at the bottom for
/// troubleshooting.
class AnalysisErrorView extends StatelessWidget {
  const AnalysisErrorView({
    super.key,
    required this.failure,
    required this.onRetry,
    required this.onHome,
  });

  final AnalysisFailure failure;
  final VoidCallback onRetry;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.analysisFailedTitle,
              style: AppTextStyles.headlineSmall.copyWith(color: onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              failure.userMessage(context.l10n),
              style: AppTextStyles.bodyMedium.copyWith(
                color: onSurface.withValues(alpha: 0.7),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: context.l10n.retryButton,
              onPressed: onRetry,
              variant: AppButtonVariant.primary,
              fullWidth: true,
            ),
            const SizedBox(height: 10),
            AppButton(
              label: context.l10n.goHomeButton,
              onPressed: onHome,
              variant: AppButtonVariant.outline,
              fullWidth: true,
            ),
            if (kDebugMode && failure.cause != null) ...[
              const SizedBox(height: 16),
              _DebugCause(cause: failure.cause!),
            ],
          ],
        ),
      ),
    );
  }
}

class _DebugCause extends StatelessWidget {
  const _DebugCause({required this.cause});

  final Object cause;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          'debug: cause',
          style: AppTextStyles.labelSmall.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
            letterSpacing: 0.8,
          ),
        ),
        childrenPadding: const EdgeInsets.only(top: 4, bottom: 8),
        children: [
          SelectableText(
            cause.toString(),
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55),
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
