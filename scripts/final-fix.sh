#!/bin/bash
# ============================================================
# SkinCheck AI — FINAL DÜZELTME
# ============================================================
# cd ~/Desktop/skincheck_ai && bash final-fix.sh
# ============================================================

echo "🔧 Komutları ve hook'ları güncelliyorum..."

# ─── 1. /feature komutunu güncelle ───
cat > .claude/commands/feature.md << 'CMD'
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
CMD


# ─── 2. /fix komutunu güncelle ───
cat > .claude/commands/fix.md << 'CMD2'
# Quick Fix — /fix <description>

Fix: $ARGUMENTS

1. git checkout -b fix/<kebab-case-name> from develop
2. Find and fix the issue
3. flutter analyze + flutter test
4. git add -A && git commit -m "fix: <description>"
5. git push -u origin fix/<name>
6. Create PR to develop via GitHub MCP
7. Report: branch, commit, PR URL
CMD2


# ─── 3. Stop Hook düzelt (feature-specific dosya kontrolü) ───
cat > .claude/hooks/enforce-pipeline.sh << 'HOOK'
#!/bin/bash
# Stop hook: feature pipeline'ın ortasında durmasını engeller.
# Kontrol: Son 2 saatte plan dosyası oluşturulmuş ama
# aynı FEATURE_ID ile review dosyası yoksa → block.

PLAN_DIR="docs/plans"
REVIEW_DIR="docs/reviews"

# Son 2 saat içinde değişen plan dosyalarını bul
RECENT_PLAN=""
if [ -d "$PLAN_DIR" ]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    RECENT_PLAN=$(find "$PLAN_DIR" -name "*-plan.md" -mmin -120 -print -quit 2>/dev/null)
  else
    RECENT_PLAN=$(find "$PLAN_DIR" -name "*-plan.md" -mmin -120 -print -quit 2>/dev/null)
  fi
fi

if [ -n "$RECENT_PLAN" ]; then
  # Plan dosya adından FEATURE_ID çıkar
  BASENAME=$(basename "$RECENT_PLAN")
  FEATURE_ID="${BASENAME%-plan.md}"

  # Aynı ID ile review dosyası var mı?
  REVIEW_FILE="$REVIEW_DIR/${FEATURE_ID}-review.md"

  if [ ! -f "$REVIEW_FILE" ]; then
    echo '{"decision":"block","reason":"Feature pipeline incomplete. Plan exists but review missing. Continue: implement → test → review → commit → push → PR."}'
    exit 0
  fi

  # Review var ama plan'dan eski mi?
  if [[ "$OSTYPE" == "darwin"* ]]; then
    PT=$(stat -f %m "$RECENT_PLAN" 2>/dev/null || echo 0)
    RT=$(stat -f %m "$REVIEW_FILE" 2>/dev/null || echo 0)
  else
    PT=$(stat -c %Y "$RECENT_PLAN" 2>/dev/null || echo 0)
    RT=$(stat -c %Y "$REVIEW_FILE" 2>/dev/null || echo 0)
  fi

  if [ "$RT" -lt "$PT" ]; then
    echo '{"decision":"block","reason":"Review is older than plan. Complete the current feature pipeline first."}'
    exit 0
  fi
fi

echo '{"decision":"approve"}'
exit 0
HOOK

chmod +x .claude/hooks/enforce-pipeline.sh


# ─── 4. Post-edit hook (değişiklik yok, sadece ensure executable) ───
chmod +x .claude/hooks/post-edit-analyze.sh


# ─── 5. Eski PLAN.md ve REVIEW.md'yi temizle (çakışma olmasın) ───
rm -f docs/plans/PLAN.md
rm -f docs/reviews/REVIEW.md


# ─── 6. Commit ───
git add .
git commit -m "chore: fix pipeline — unique feature IDs, correct hook schema" 2>/dev/null || true


echo ""
echo "✅ Güncelleme tamamlandı!"
echo ""
echo "Şimdi:"
echo "  1. Claude Code'dan çık"
echo "  2. claude yaz, tekrar başlat"
echo "  3. Feature 2'ye başla:"
echo "     /feature Supabase veritabanı ve auth sistemi"
echo ""
echo "Claude şunu yapacak:"
echo "  Plan çıkarır (kod yazmadan) → sen evet dersin →"
echo "  feature/supabase-auth branch açar → kodlar →"
echo "  test yazar → review yapar → push + PR açar"