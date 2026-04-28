import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_visibility_provider.g.dart';

/// Ref-counted hide state for the floating bottom navigation bar.
///
/// Multiple independent sources (modal sheets, routine edit mode, etc.)
/// can request the nav to hide. The nav stays hidden until every source
/// has released it — so a modal opened during edit mode won't pop the
/// nav back on when it closes.
///
/// Every [hide] call MUST be matched with exactly one [show] call.
@Riverpod(keepAlive: true)
class BottomNavVisibility extends _$BottomNavVisibility {
  @override
  int build() => 0;

  /// Request the nav to hide. Pair with exactly one [show] call.
  void hide() {
    state = state + 1;
  }

  /// Release a previous [hide] request.
  void show() {
    state = state > 0 ? state - 1 : 0;
  }

  /// Reset all hide requests (use only for defensive cleanup).
  void reset() {
    state = 0;
  }
}

/// Whether the bottom nav should currently be visible.
@riverpod
bool bottomNavVisible(Ref ref) {
  return ref.watch(bottomNavVisibilityProvider) == 0;
}
