import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/bottom_nav_visibility_provider.dart';

/// Shows a modal bottom sheet that hides the floating bottom nav while open.
///
/// Wraps [showModalBottomSheet] with two opinionated defaults:
/// - [useRootNavigator] is `true` so the sheet covers the bottom nav area.
/// - The nav is hidden on open and restored on dismiss.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetRef ref,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useSafeArea = false,
  Color? backgroundColor = Colors.transparent,
  Color? barrierColor,
  ShapeBorder? shape,
}) {
  ref.read(bottomNavVisibilityProvider.notifier).hide();
  final future = showModalBottomSheet<T>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useSafeArea: useSafeArea,
    backgroundColor: backgroundColor,
    barrierColor: barrierColor,
    shape: shape,
    builder: builder,
  );
  future.whenComplete(() {
    ref.read(bottomNavVisibilityProvider.notifier).show();
  });
  return future;
}
