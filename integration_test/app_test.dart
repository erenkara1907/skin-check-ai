import 'auth/login_test.dart' as auth;
import 'onboarding/onboarding_flow_test.dart' as onboarding;
import 'navigation/bottom_nav_test.dart' as navigation;
import 'home/home_dashboard_test.dart' as home;
import 'routine/routine_flow_test.dart' as routine;
import 'profile/profile_settings_test.dart' as profile;
import 'analysis/camera_flow_test.dart' as camera;

void main() {
  auth.main();
  onboarding.main();
  navigation.main();
  home.main();
  routine.main();
  profile.main();
  camera.main();
}
