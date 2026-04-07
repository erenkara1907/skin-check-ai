# Full Feature Pipeline
# Usage: /feature <description>
 
Execute a full feature pipeline. Follow ALL phases IN ORDER.
NEVER skip a phase. ONLY pause at Phase 1 for approval.
 
## INPUT
$ARGUMENTS
 
---
 
## PHASE 1: PLANNING
 
Think step by step. Create a detailed plan:
1. Which files to create/modify (full paths)
2. Domain layer: entities, repo interfaces, use cases
3. Data layer: DTOs, data sources, repo implementations
4. Presentation: screens, widgets, providers
5. Database changes (Supabase tables/RLS/Edge Functions)
6. Dependencies to add to pubspec.yaml
7. Test cases needed
8. Security concerns
 
Save plan to: docs/plans/PLAN.md (overwrite if exists)
 
**STOP. Show the plan. Ask: "Plan hazır. Onaylıyor musun?"**
Wait for user to say "evet" before continuing.
 
---
 
## PHASE 2: IMPLEMENTATION
 
After approval, implement everything:
 
1. Database first (use Supabase MCP if needed)
2. Domain layer (entities with Freezed, repo interfaces)
3. Data layer (DTOs, data sources, repo impl)
4. Presentation (providers, screens, widgets — FULL DESIGN per CLAUDE.md)
5. Run after each layer:
   - dart run build_runner build --delete-conflicting-outputs
   - flutter analyze (fix all issues)
 
Proceed to Phase 3 WITHOUT stopping.
 
---
 
## PHASE 3: TESTING
 
1. Write unit tests (repositories, providers) using mocktail
2. Write widget tests (main screen, critical widgets)
3. Run: flutter test
4. If any fail: fix code, re-run until all pass
5. Run: flutter test --coverage
 
Proceed to Phase 4 WITHOUT stopping.
 
---
 
## PHASE 4: CODE REVIEW & QA
 
Self-review checklist:
- flutter analyze: 0 issues
- No files > 250 lines
- No business logic in widgets
- No hardcoded API keys
- RLS policies correct
- Dark mode works
- Loading/error/empty states handled
- All public methods documented
 
Save report to: docs/reviews/REVIEW.md (overwrite if exists)
 
Proceed to Phase 5 WITHOUT stopping.
 
---
 
## PHASE 5: COMMIT
 
1. git add -A
2. git commit with conventional commit message
3. Present summary:
 
✅ FEATURE COMPLETE
📋 Plan: docs/plans/PLAN.md
🧪 Tests: X/X passing
📝 Review: docs/reviews/REVIEW.md
📦 Committed
