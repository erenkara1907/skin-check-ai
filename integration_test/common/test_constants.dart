/// Test user credentials for Patrol integration tests.
///
/// These users must exist in the Supabase project before running tests.
/// - [newUser]: Fresh user with onboarding_completed = false
/// - [homeUser]: Onboarded user with at least one analysis
abstract final class TestUsers {
  /// Fresh user — has NOT completed onboarding.
  static const newUserEmail = 'patrol-new@skincheck.dev';
  static const newUserPassword = 'PatrolTest123!';

  /// Onboarded user — HAS completed onboarding and has analysis data.
  static const homeUserEmail = 'patrol-home@skincheck.dev';
  static const homeUserPassword = 'PatrolTest123!';
}

/// Timeouts for integration tests.
abstract final class TestTimeouts {
  /// How long to wait for navigation transitions.
  static const Duration navigation = Duration(seconds: 5);

  /// How long to wait for network operations (login, data fetch).
  static const Duration network = Duration(seconds: 15);

  /// How long to wait for native permission dialogs.
  static const Duration nativeDialog = Duration(seconds: 5);
}
