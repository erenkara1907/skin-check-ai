# Feature Pipeline — /feature <description>

You received: $ARGUMENTS

This is the full feature pipeline. It uses ECC's planner / code-reviewer / security-reviewer / tdd-guide / build-error-resolver agent perspectives. ECC common rules live at `~/.claude/rules/common/` — consult them as needed.

---

## Hard rules
- **Phase 1**: NO code, NO file edits except the plan file. Plan as text only.
- **Phase 2–6**: write code, run commands, do not pause for permission between phases.
- Plan and review filenames carry the FEATURE_ID so multiple features can coexist.
- Generate a unique FEATURE_ID from the description (kebab-case, max 3 words).
  - Example: "auth system" → `auth-system`
  - Use this ID for branch name, plan file, and review file.

---

## PHASE 1 — PLAN (no code)

Use the **ECC planner agent** mindset. Produce a plan that covers:

1. **Goal & scope** — one paragraph; what's in, what's out.
2. **Files to create / modify** — full paths, grouped by layer (domain → data → presentation).
3. **Database changes** — Supabase migrations, RLS, storage policies, indexes.
4. **State management** — Riverpod providers, AsyncNotifier shape, dependency graph.
5. **Navigation** — GoRouter routes added/changed.
6. **Test plan** — unit (repos / services / providers — mocktail) + widget tests + integration if main flow.
7. **Security concerns** — API key surfaces, RLS, signed URLs, sensitive logging, OWASP Mobile Top 10 hits.
8. **Design system mapping** — colors (#6C63FF / #00D9A6), fonts (Outfit / Plus Jakarta Sans), glassmorphism cards, dark mode, touch targets ≥48×48, loading/error/empty states.
9. **Risk & rollback** — what breaks if this ships wrong, how we revert.
10. **Acceptance criteria** — user-visible bullets the reviewer can tick.

Save to: `docs/plans/<FEATURE_ID>-plan.md`

Then say EXACTLY:

> 📋 Plan hazır: `docs/plans/<FEATURE_ID>-plan.md`
>
> Onaylıyor musun? (evet / hayır / değişiklik istiyorum)

**STOP.** Do not continue until the user says `evet`.

---

## PHASE 2 — BRANCH

```bash
git stash 2>/dev/null || true
git fetch origin develop 2>/dev/null || true
git checkout develop 2>/dev/null || git checkout -b develop
git pull origin develop 2>/dev/null || true
git checkout -b feature/<FEATURE_ID>
```

---

## PHASE 3 — IMPLEMENT

Build everything from the plan in this strict order:

1. **Database / migrations** — apply via Supabase MCP if needed; verify RLS.
2. **Domain layer** — Freezed entities, repository interfaces, use cases.
3. **Data layer** — DTOs (Freezed + json_serializable), data sources, repository implementations.
4. **Presentation layer** — Riverpod providers (AsyncNotifier), screens, widgets.
5. **Design** — STRICT adherence to CLAUDE.md design system. Never use default Flutter styling.

After each layer:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

**Fix every analyzer issue before moving to the next layer.**

If a file exceeds 250 lines → split it (extract widgets, helpers, or move logic into providers/use cases).

Do NOT stop. Continue to Phase 4.

---

## PHASE 4 — TEST

ECC tdd-guide mindset. For each unit added in Phase 3:

1. **Unit tests** (repositories, services, providers) — mocktail; cover happy path + at least one error path.
2. **Widget tests** for the main screen of this feature — pump frames for Riverpod (no `Future.delayed`).
3. Run `flutter test`. If failures: read the failure → fix root cause → re-run. Loop until green.
4. Run `flutter test --coverage` and check `coverage/lcov.info`. If coverage < 70% → add tests until ≥70%.

If you hit a build error you cannot resolve, switch to **ECC build-error-resolver** mindset: read the error, identify root cause (not symptom), apply targeted fix, re-run.

Do NOT stop. Continue to Phase 5.

---

## PHASE 5 — REVIEW

Self-review using **ECC code-reviewer + security-reviewer** perspectives.

### Code review checklist
- [ ] `flutter analyze` — 0 issues
- [ ] No file > 250 lines
- [ ] No business logic in widgets (must live in providers / use cases / repos)
- [ ] No `print()` calls (Logger only)
- [ ] No hardcoded secrets / API keys / URLs
- [ ] All public methods have `///` doc comments
- [ ] Riverpod for all state (no stray `setState` outside animations)
- [ ] GoRouter for all navigation
- [ ] Freezed for all models
- [ ] AsyncValue for async UI (loading/error/data states)
- [ ] Conventional commit style ready

### Design review checklist
- [ ] Colors: #6C63FF primary, #00D9A6 secondary
- [ ] Fonts: Outfit (display) + Plus Jakarta Sans (body)
- [ ] Glassmorphism cards with 16px radius + subtle shadow
- [ ] Dark mode works on every new screen
- [ ] Touch targets ≥ 48×48
- [ ] Loading / error / empty states present everywhere
- [ ] No default Flutter styling slipped through

### Security review checklist
- [ ] API keys only in Edge Functions (never on client)
- [ ] RLS policies cover every new table / column
- [ ] Storage buckets private; signed URLs only
- [ ] Auth flow uses Supabase auth correctly; no token leakage in logs
- [ ] HTTPS-only network calls
- [ ] No skin photos or PII in `Logger` output
- [ ] OWASP Mobile Top 10 — quickly walk M1–M10 against this feature

Save to: `docs/reviews/<FEATURE_ID>-review.md`. Include checklist results, files touched, test count, coverage %, and any follow-ups.

Do NOT stop. Continue to Phase 6.

---

## PHASE 6 — SHIP

```bash
git add -A
git commit -m "feat(<FEATURE_ID>): <short description>

- <change 1>
- <change 2>
- Tests: <N> passing, coverage <X>%"
git push -u origin feature/<FEATURE_ID>
```

Create the PR via GitHub MCP (`mcp__github__create_pull_request`):
- **base**: `develop`
- **head**: `feature/<FEATURE_ID>`
- **title**: `feat(<FEATURE_ID>): <description>`
- **body**: paste the review summary from `docs/reviews/<FEATURE_ID>-review.md`

Final report:

> ✅ DONE
>
> 🌿 Branch: `feature/<FEATURE_ID>`
> 🔗 PR: `<url>`
> 🧪 Tests: `<N>/<N>` passing, coverage `<X>%`
> 📝 Plan: `docs/plans/<FEATURE_ID>-plan.md`
> 📝 Review: `docs/reviews/<FEATURE_ID>-review.md`
