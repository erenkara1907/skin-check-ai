import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../providers/badge_provider.dart';
import '../widgets/badge_grid.dart';

/// Full badge gallery screen.
class BadgesScreen extends ConsumerWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgesAsync = ref.watch(badgeNotifierProvider);
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.badgesTitle,
          style: AppTextStyles.headlineSmall.copyWith(color: textColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: badgesAsync.when(
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
          data: (badges) => SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BadgeGrid(badges: badges),
          ),
        ),
      ),
    );
  }
}
