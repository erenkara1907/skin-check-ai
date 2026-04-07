# Plan: Project Scaffold & Core Layer

## 1. Files to Create/Modify

### Modified Files
- `pubspec.yaml` — add all dependencies
- `lib/main.dart` — ProviderScope + MaterialApp.router

### Core Layer (New Files)
- `lib/core/theme/app_colors.dart`
- `lib/core/theme/app_text_styles.dart`
- `lib/core/theme/app_theme.dart`
- `lib/core/router/app_router.dart`
- `lib/core/services/supabase_service.dart`
- `lib/core/constants/app_constants.dart`
- `lib/core/utils/logger.dart`

### Shared Widgets (New Files)
- `lib/shared/widgets/app_button.dart`
- `lib/shared/widgets/app_card.dart`
- `lib/shared/widgets/app_loading.dart`
- `lib/shared/widgets/score_circle.dart`
- `lib/shared/widgets/gradient_background.dart`

### Feature Directories (Empty — placeholder .gitkeep)
Each feature gets `domain/`, `data/`, `presentation/` subdirs:
- `lib/features/auth/{domain,data,presentation}/`
- `lib/features/onboarding/{domain,data,presentation}/`
- `lib/features/analysis/{domain,data,presentation}/`
- `lib/features/routine/{domain,data,presentation}/`
- `lib/features/progress/{domain,data,presentation}/`
- `lib/features/products/{domain,data,presentation}/`
- `lib/features/sharing/{domain,data,presentation}/`
- `lib/features/profile/{domain,data,presentation}/`
- `lib/features/settings/{domain,data,presentation}/`

### Placeholder Screens (for GoRouter)
- `lib/features/auth/presentation/screens/login_screen.dart`
- `lib/features/onboarding/presentation/screens/onboarding_screen.dart`
- `lib/features/analysis/presentation/screens/analysis_screen.dart`
- `lib/features/routine/presentation/screens/routine_screen.dart`
- `lib/features/progress/presentation/screens/progress_screen.dart`
- `lib/features/products/presentation/screens/products_screen.dart`
- `lib/features/sharing/presentation/screens/sharing_screen.dart`
- `lib/features/profile/presentation/screens/profile_screen.dart`
- `lib/features/settings/presentation/screens/settings_screen.dart`
- `lib/shared/widgets/main_shell.dart` — Bottom nav shell

## 2. Domain Layer
N/A for this scaffold task — no entities, repos, or use cases yet.

## 3. Data Layer
N/A for this scaffold task — no DTOs or data sources yet.

## 4. Presentation Layer
- Placeholder screens for each feature (minimal scaffold with GradientBackground)
- MainShell with bottom navigation (5 tabs: Home, Analyze, Progress, Routine, Profile)
- GoRouter with ShellRoute for bottom nav

## 5. Database Changes
None — Supabase service is init-only, no table creation in this task.

## 6. Dependencies (pubspec.yaml)

### dependencies:
- flutter_riverpod, riverpod_annotation
- go_router
- supabase_flutter
- camera, image_picker, google_mlkit_face_detection
- dio
- freezed_annotation, json_annotation
- flutter_secure_storage
- share_plus, fl_chart
- cached_network_image, flutter_animate
- logger, lucide_icons
- permission_handler, url_launcher, path_provider
- google_fonts

### dev_dependencies:
- riverpod_generator, build_runner
- freezed, json_serializable
- riverpod_lint
- mocktail

## 7. Test Cases
- `test/core/theme/app_colors_test.dart` — color constants validation
- `test/core/theme/app_theme_test.dart` — light/dark theme verification
- `test/shared/widgets/app_button_test.dart` — button variants & states
- `test/shared/widgets/app_card_test.dart` — card renders correctly
- `test/shared/widgets/score_circle_test.dart` — score colors by range
- `test/shared/widgets/gradient_background_test.dart` — renders child

## 8. Security Concerns
- Supabase URL/anon key loaded from env (not hardcoded)
- No API keys in source code
- flutter_secure_storage for sensitive data
