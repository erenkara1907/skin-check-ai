# Deployment Checklist — /deploy

Run every gate below in order. Do NOT skip. If a gate fails → stop, fix, restart from that gate.

---

## 1. Static analysis
```bash
flutter analyze
```
Must report **0 issues**. Otherwise fix and re-run.

## 2. Tests + coverage
```bash
flutter test --coverage
```
- All tests pass
- Coverage ≥ 70% (parse `coverage/lcov.info`)

## 3. Security scan
- Hardcoded secrets:
  ```bash
  grep -rEn "(sk_|pk_|sb_secret|SUPABASE_SERVICE_ROLE|sk-[a-zA-Z0-9]{20,})" lib/ || echo "clean"
  ```
- API keys/URLs only in `lib/core/config/env_config.dart` and `.env*` (verify).
- RLS active on every table (Supabase MCP `list_tables`, check `rls_enabled = true`).
- Storage buckets are private + signed URLs.
- No `print()` of skin photos / PII.

## 4. Responsive smoke
For each major screen, verify in the running app at:
- 375 × 812 (iPhone)
- 768 × 1024 (iPad)
- 1440 × 900 (Web)

No overflow, no clipped touch targets.

## 5. Dark mode
Every screen must render correctly in dark mode. Toggle via system theme + verify.

## 6. Performance
- Build size: `flutter build apk --release --analyze-size` (note delta vs previous release).
- Unused imports: `dart fix --dry-run` reports.
- Unused assets: scan `pubspec.yaml` assets vs `git grep`.

## 7. Assets
- App icon present for all platforms (`flutter_launcher_icons` config valid).
- Splash screen present (`flutter_native_splash.yaml`).

## 8. Builds
```bash
flutter build apk --release
flutter build web --release
flutter build ios --release --no-codesign
```
All three must complete.

## 9. Store listing
Generate / update `docs/store-listing.md` with TR + EN copy:
- App name, short description, full description
- Keywords, screenshots checklist
- Category, content rating, privacy policy URL
- What's new (this release)

## 10. Final report
Write `docs/deployment-report.md` with:
- Date, version, build numbers (Android / iOS / web)
- Result of each gate above (pass / fail + notes)
- Test count + coverage %
- Build sizes
- Open issues / risks for this release
- Rollback plan

Final chat output: a single bullet list of gate results + path to report.
