# Full Feature Pipeline
# Usage: /feature <description>

Execute a full feature pipeline. Follow ALL phases IN ORDER.
NEVER skip a phase. ONLY pause at Phase 1 for approval.

## INPUT
$ARGUMENTS

---

## PHASE 1: PLANNING

Think step by step. Create a detailed plan:
1. Files to create/modify (full paths)
2. Domain → Data → Presentation layers
3. Database changes (Supabase MCP)
4. Test cases needed
5. Security concerns

Save to: docs/plans/PLAN.md

**STOP. Ask: "Plan hazır. Onaylıyor musun?" Wait for approval.**

---

## PHASE 2: GIT BRANCH

```bash
git checkout develop 2>/dev/null || git checkout -b develop
git pull origin develop 2>/dev/null || true
git checkout -b feature/<kebab-case-name>
```

---

## PHASE 3: IMPLEMENTATION

1. Database (Supabase MCP)
2. Domain (Freezed entities, repo interfaces)
3. Data (DTOs, data sources, repo impl)
4. Presentation (providers, screens, widgets — FULL DESIGN per CLAUDE.md)
5. After each layer: build_runner + flutter analyze

---

## PHASE 4: TESTING

1. Unit tests (repositories, providers — mocktail)
2. Widget tests (main screen, critical widgets)
3. flutter test — fix until all pass

---

## PHASE 5: CODE REVIEW

Checklist:
- flutter analyze: 0 issues
- No files > 250 lines
- No business logic in widgets
- No hardcoded API keys
- Dark mode works
- Loading/error/empty states

Save to: docs/reviews/REVIEW.md

---

## PHASE 6: COMMIT + PUSH + PR

```bash
git add -A
git commit -m "feat: <description>"
git push -u origin feature/<branch-name>
```

Create PR using GitHub MCP:
- Title: "feat: <description>"
- Body: summary from review
- Base: develop
- Head: feature/<branch-name>

Present:
✅ FEATURE COMPLETE
🌿 Branch: feature/<name>
🔗 PR: <url>
🧪 Tests: X/X passing
📝 Review: docs/reviews/REVIEW.md
