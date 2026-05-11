# SkinCheck AI — Project Context
 
## Overview
AI-powered skin analysis app. Selfie → AI analyzes 7 facial zones →
scores, routines, product recommendations.
Flutter (iOS, Android, Web) + Supabase backend.
 
## Tech Stack
- Frontend: Flutter 3.x (single codebase — iOS, Android, Web)
- Backend: Supabase (Auth, PostgreSQL, Storage, Edge Functions)
- AI: GPT-4o Vision via Supabase Edge Functions (NEVER client-side)
- Face Detection: Google ML Kit (on-device)
- State: Riverpod 2.x (code generation)
- Navigation: GoRouter
- Payments: RevenueCat
- HTTP: Dio
- Models: Freezed + json_serializable
- Charts: fl_chart
- Sharing: share_plus
 
## Architecture: Feature-First Clean Architecture
lib/
├── core/
│   ├── theme/           # AppTheme, colors, text styles
│   ├── router/          # GoRouter config
│   ├── constants/       # API endpoints, app constants
│   ├── extensions/      # Dart extensions
│   ├── utils/           # Helpers, formatters
│   └── services/        # Supabase client, AI service
├── shared/
│   ├── widgets/         # Reusable widgets
│   ├── models/          # Shared models
│   └── providers/       # Global providers
└── features/
    ├── auth/
    ├── onboarding/
    ├── analysis/
    ├── routine/
    ├── progress/
    ├── products/
    ├── sharing/
    ├── profile/
    └── settings/
 
Each feature:
  feature/
  ├── domain/       # Entities, repo interfaces, use cases
  ├── data/         # DTOs, data sources, repo impl
  └── presentation/
      ├── providers/  # Riverpod (AsyncNotifier)
      ├── screens/
      └── widgets/
 
## Design System
- Style: Modern minimalist + glassmorphism accents
- Primary: #6C63FF (purple)
- Secondary: #00D9A6 (teal/mint)
- Cards: White, subtle shadow, 16px radius, glassmorphism
- Fonts: Outfit (display), Plus Jakarta Sans (body) — Google Fonts
- Dark mode: REQUIRED from day 1
- Animations: Smooth transitions, score reveal animations
- Icons: Lucide Icons
- Touch targets: min 48x48
- Bottom nav: 5 tabs (Home, Analyze, Progress, Routine, Profile)
- NEVER use generic Flutter default styling
 
## Database (Supabase PostgreSQL)
- users: id, email, name, skin_type, birth_date, subscription_tier
- analyses: id, user_id, photo_url, overall_score, skin_age, ai_response_json
- zone_scores: id, analysis_id, zone, concerns, severity, recommendations
- routines: id, user_id, type(morning/evening), steps_json, is_active
- products: id, name, brand, affiliate_url, suitable_concerns
- progress_logs: id, user_id, analysis_id, score_delta, photo_url
 
## Security (CRITICAL)
- RLS on ALL tables (user sees only own data)
- Photos: encrypted, private bucket, signed URLs only
- API keys: ONLY in Edge Functions
- GDPR: user can delete all data
- OWASP Mobile Top 10 compliance
 
## Coding Rules
1. Riverpod for ALL state (no setState except animations)
2. GoRouter for ALL navigation
3. Repository pattern everywhere
4. NO business logic in widgets
5. NO print() — use Logger
6. Freezed for all models
7. AsyncValue for async UI
8. Max 250 lines per file
9. Every public method has /// doc comment
10. Conventional commits: feat:, fix:, docs:, test:
 
## Testing
- Unit: repositories, services, providers (mocktail)
- Widget: critical screens
- Integration: main flows
- Target: 70%+ coverage

## Pipeline Commands
- `/feature <desc>` — Full feature pipeline (plan → branch → implement → test → review → PR)
- `/fix <desc>` — Quick bug fix on its own branch + PR
- `/refactor <desc>` — Refactor with safety net of pre-existing tests + PR
- `/deploy` — Deployment checklist (analyze, test, security, builds, store listing)
- `/design-review` — Audit code against this design system; auto-fix safe drifts
- `/status` — One-page project snapshot
- `/security-scan` — Full client + Supabase security audit (OWASP M1–M10)

## ECC Integration
This project uses the Everything Claude Code (ECC) plugin and its common rules.
- ECC common rules are loaded from `~/.claude/rules/common/` and cover code review, security review, testing, performance, git workflow, and patterns.
- Slash commands above reference ECC agent perspectives (planner, code-reviewer, security-reviewer, tdd-guide, build-error-resolver, refactor-cleaner) as their mental model.
- Other-language rules (`rust/`, `python/`, etc.) are intentionally NOT installed — only `common/`.

## Quality Gates (every PR before merge)
1. `flutter analyze` — 0 issues
2. `flutter test` — all green
3. Coverage ≥ 70%
4. No hardcoded secrets; RLS active on all tables
5. CLAUDE.md design system: colors / fonts / dark mode / touch targets / state coverage
6. Every file ≤ 250 lines

## Token Optimization
- Default model: `sonnet`. Use `opus` only for non-trivial architecture decisions.
- Run `/compact` after each completed feature.
- Run `/clear` between unrelated tasks.
