# Feature Pipeline — /feature <description>

You received: $ARGUMENTS

---

IMPORTANT RULES:
- Phase 1: DO NOT write any code. Only produce a plan as text.
- Phase 2-6: Write code, files, run commands freely. Do not ask permission.
- The plan file and review file include a timestamp in the name to avoid conflicts with previous features.

Generate a unique FEATURE_ID from the description (kebab-case, max 3 words).
Example: "auth system" → "auth-system"
Use this ID for branch name, plan file, and review file.

---

## PHASE 1: PLAN ONLY (no code, no files except the plan)

Analyze the request. Produce a plan covering:
- Files to create/modify (full paths)
- Domain → Data → Presentation layers
- Database changes (if any)
- Test cases
- Security concerns

Save ONLY this file: docs/plans/<FEATURE_ID>-plan.md

Then say EXACTLY:

"📋 Plan hazır: docs/plans/<FEATURE_ID>-plan.md

Onaylıyor musun? (evet / hayır / değişiklik istiyorum)"

STOP. Do not continue until user says "evet".

---

## PHASE 2: BRANCH

After user approves:

```bash
git stash 2>/dev/null || true
git checkout develop 2>/dev/null || git checkout -b develop
git pull origin develop 2>/dev/null || true
git checkout -b feature/<FEATURE_ID>
```

---

## PHASE 3: IMPLEMENT

Build everything from the plan:
1. Database (Supabase MCP if needed)
2. Domain layer (Freezed entities, repo interfaces)
3. Data layer (DTOs, data sources, repo implementations)
4. Presentation (Riverpod providers, screens, widgets)
5. Design everything per CLAUDE.md design system
6. After each layer run:
   - dart run build_runner build --delete-conflicting-outputs
   - flutter analyze — fix all issues before next layer

Do NOT stop. Continue to Phase 4.

---

## PHASE 4: TEST

1. Write unit tests (repositories, services, providers) — use mocktail
2. Write widget tests for main screen of this feature
3. Run: flutter test
4. If failures: fix and re-run until all pass

Do NOT stop. Continue to Phase 5.

---

## PHASE 5: REVIEW

Run checklist:
- flutter analyze: must be 0 issues
- No file > 250 lines
- No business logic in widgets
- No hardcoded secrets
- Dark mode checked
- Loading/error/empty states present

Save to: docs/reviews/<FEATURE_ID>-review.md

Do NOT stop. Continue to Phase 6.

---

## PHASE 6: SHIP

```bash
git add -A
git commit -m "feat(<FEATURE_ID>): <short description>

- <change 1>
- <change 2>
- Tests: X passing"

git push -u origin feature/<FEATURE_ID>
```

Create PR using GitHub MCP:
- Title: feat(<FEATURE_ID>): <description>
- Body: paste the review summary
- Base: develop
- Head: feature/<FEATURE_ID>

Then say:

"✅ DONE

🌿 Branch: feature/<FEATURE_ID>
🔗 PR: <url>
🧪 Tests: X/X passing
📝 Plan: docs/plans/<FEATURE_ID>-plan.md
📝 Review: docs/reviews/<FEATURE_ID>-review.md"
