import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/logger.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';

/// Starts the analysis flow: runs the subscription gate then pushes the
/// camera screen, or the paywall if the user is over quota.
///
/// Shared helper used by the bottom-nav analyze FAB, the home screen
/// first-analysis CTA, and the "re-analyze" button on the last-analysis
/// card — ensures the subscription check lives in one place.
Future<void> startAnalysisFlow(
  BuildContext context,
  WidgetRef ref,
) async {
  try {
    final canAnalyze = await ref.read(canAnalyzeProvider.future);
    if (!context.mounted) return;
    if (canAnalyze) {
      context.push(AppRoutes.camera);
    } else {
      context.push(AppRoutes.paywall);
    }
  } catch (e, st) {
    log.e('Start analysis failed', e, st);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.analysisErrorSnackbar)),
    );
  }
}
