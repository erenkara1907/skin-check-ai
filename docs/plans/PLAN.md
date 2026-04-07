# Plan: Supabase Database Schema & Auth Feature

## BÖLÜM A — Veritabanı (Supabase MCP)

### 1. Enum Types
- `skin_type_enum`: normal, oily, dry, combination
- `zone_enum`: forehead, nose, cheek_left, cheek_right, chin, eye_area, lip_area
- `routine_type_enum`: morning, evening

### 2. Tablolar

| Tablo | Açıklama |
|-------|----------|
| `users` | id (uuid, FK → auth.users), email, name, skin_type, birth_date, subscription_tier, avatar_url, created_at, updated_at |
| `analyses` | id, user_id (FK → users), photo_url, overall_score, skin_age, ai_response_json, created_at |
| `zone_scores` | id, analysis_id (FK → analyses), zone (zone_enum), score, concerns (text[]), severity (int), recommendations (text[]) |
| `routines` | id, user_id (FK → users), type (routine_type_enum), steps_json (jsonb), is_active, created_at, updated_at |
| `products` | id, name, brand, description, image_url, affiliate_url, suitable_concerns (text[]), skin_types (skin_type_enum[]), rating, created_at |
| `progress_logs` | id, user_id (FK → users), analysis_id (FK → analyses), score_delta, photo_url, notes, created_at |
| `user_goals` | id, user_id (FK → users), goal_type, target_score, current_score, is_achieved, created_at, updated_at |

### 3. Indexes
- `analyses`: user_id, created_at DESC
- `zone_scores`: analysis_id
- `routines`: user_id, is_active
- `progress_logs`: user_id, created_at DESC
- `user_goals`: user_id, is_achieved
- `products`: suitable_concerns (GIN)

### 4. RLS Policies
- **users**: authenticated → own row only (SELECT, INSERT, UPDATE)
- **analyses**: authenticated → own rows only (SELECT, INSERT)
- **zone_scores**: authenticated → own analysis's rows (SELECT, INSERT)
- **routines**: authenticated → own rows (SELECT, INSERT, UPDATE, DELETE)
- **products**: authenticated → all rows (SELECT only)
- **progress_logs**: authenticated → own rows (SELECT, INSERT)
- **user_goals**: authenticated → own rows (SELECT, INSERT, UPDATE, DELETE)

### 5. Storage
- Bucket: `skin-photos` (private)
- Max file size: 5MB
- Allowed MIME: `image/*`
- RLS: users can upload/read only own folder (`{user_id}/*`)

---

## BÖLÜM B — Auth Feature

### 1. Domain Layer
| Dosya | İçerik |
|-------|--------|
| `lib/features/auth/domain/entities/user_entity.dart` | Freezed User entity (id, email, name, skinType, avatarUrl) |
| `lib/features/auth/domain/repositories/auth_repository.dart` | Abstract AuthRepository interface |

### 2. Data Layer
| Dosya | İçerik |
|-------|--------|
| `lib/features/auth/data/datasources/supabase_auth_datasource.dart` | Supabase auth ops (signIn, signUp, signInWithGoogle, signInWithApple, signOut, currentUser, authStateChanges) |
| `lib/features/auth/data/repositories/auth_repository_impl.dart` | AuthRepository implementation |

### 3. Presentation Layer
| Dosya | İçerik |
|-------|--------|
| `lib/features/auth/presentation/providers/auth_provider.dart` | Riverpod AsyncNotifier for auth state |
| `lib/features/auth/presentation/screens/login_screen.dart` | Login screen (glassmorphism card, gradient bg, social login) |
| `lib/features/auth/presentation/screens/sign_up_screen.dart` | Sign up screen (name, email, password) |
| `lib/features/auth/presentation/widgets/auth_text_field.dart` | Styled text field with focus animation |
| `lib/features/auth/presentation/widgets/social_login_button.dart` | Google/Apple login buttons |

### 4. Core Updates
| Dosya | Değişiklik |
|-------|------------|
| `lib/core/router/app_router.dart` | Add redirect (unauthenticated → /login), add /sign-up route, convert to Riverpod provider |
| `lib/main.dart` | Initialize Supabase before runApp |

### 5. Tasarım
- **Login Screen**: Glassmorphism card centered, diagonal gradient (#6C63FF → #00D9A6)
- **Logo**: App name animated at top
- **Social buttons**: Google (white bg) + Apple (black bg, iOS only) side by side
- **Input fields**: Rounded borders, subtle border, focus animation
- **Dark mode**: Darker gradient tones

---

## Test Plan
| Test | Tip |
|------|-----|
| `auth_repository_impl_test.dart` | Unit — sign in, sign up, sign out, error handling |
| `auth_provider_test.dart` | Unit — state transitions |
| `login_screen_test.dart` | Widget — renders fields, buttons, navigation |
| `sign_up_screen_test.dart` | Widget — renders fields, validates input |

## Security
- No API keys in client code
- RLS enforced on all tables
- Photos in private bucket with signed URLs
- Auth tokens managed by Supabase SDK
- Input validation on all forms
