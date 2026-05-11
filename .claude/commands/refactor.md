# Refactor Pipeline — /refactor <description>

Target: $ARGUMENTS

Use the **ECC refactor-cleaner** mindset. Goal: improve internal structure without changing observable behavior. Tests must stay green.

---

## PHASE 1 — ANALYZE

Identify what should change. Produce a short report:

- **Dead code** — unreferenced symbols, files, providers, routes.
- **Duplication** — repeated logic across features (extract to `lib/shared/` or `lib/core/`).
- **Oversized files** — anything > 250 lines (CLAUDE.md hard limit).
- **Layer violations** — business logic in widgets, data types in domain, etc.
- **Naming / readability** — confusing names, unclear responsibilities.
- **Test gaps** — any refactor target without test coverage (add tests BEFORE refactoring).

Save to: `docs/refactors/<REFACTOR_ID>-plan.md`. Then say:

> 🔧 Refactor planı hazır: `docs/refactors/<REFACTOR_ID>-plan.md`
>
> Onaylıyor musun? (evet / hayır)

**STOP.** Wait for `evet`.

---

## PHASE 2 — BRANCH

```bash
git stash 2>/dev/null || true
git checkout develop && git pull origin develop 2>/dev/null || true
git checkout -b refactor/<REFACTOR_ID>
```

---

## PHASE 3 — TEST FIRST

Before changing any code:
- For each refactor target, ensure tests exist that pin its current behavior.
- If gaps exist → write tests first. Run them green.

This is the safety net for the refactor.

---

## PHASE 4 — REFACTOR

Apply changes in small, atomic steps. After EACH step:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

If any check fails → revert that step, narrow the change, retry.

Rules:
- No behavior changes. No new features. No bug fixes (those go through `/fix`).
- Preserve public API of repositories / providers unless the plan explicitly approved breaking it.
- Update call sites in the same commit as the rename / move.

---

## PHASE 5 — VERIFY

- `flutter analyze` → 0 issues
- `flutter test` → all green
- Coverage did not drop (compare before/after)
- App still runs (`flutter run` or build) — manual smoke if UI-touching

---

## PHASE 6 — SHIP

```bash
git add -A
git commit -m "refactor(<REFACTOR_ID>): <short description>

- Behavior unchanged
- Tests: <N> passing
- LOC: <before> → <after>"
git push -u origin refactor/<REFACTOR_ID>
```

Open PR via `mcp__github__create_pull_request` (base: `develop`).

Report: branch, PR URL, files changed, LOC delta, tests passing.
