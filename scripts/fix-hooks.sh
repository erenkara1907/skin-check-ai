#!/bin/bash
# ============================================================
# SkinCheck AI — HOOK + COMMAND DÜZELTME SCRIPTI
# ============================================================
# Bu scripti proje klasöründe çalıştır:
# cd ~/Desktop/skincheck_ai && bash fix-hooks.sh
# ============================================================

echo "🔧 Hook'ları ve komutları düzeltiyorum..."

# ─── 1. Stop Hook düzelt (allow → approve) ───
cat > .claude/hooks/enforce-pipeline.sh << 'HOOK1'
#!/bin/bash
INPUT=$(cat)
PLAN="docs/plans/PLAN.md"
REVIEW="docs/reviews/REVIEW.md"

if [ -f "$PLAN" ]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    PLAN_TIME=$(stat -f %m "$PLAN" 2>/dev/null)
  else
    PLAN_TIME=$(stat -c %Y "$PLAN" 2>/dev/null)
  fi
  NOW=$(date +%s)
  DIFF=$(( NOW - PLAN_TIME ))

  if [ "$DIFF" -lt 7200 ]; then
    if [ ! -f "$REVIEW" ]; then
      echo '{"decision":"block","reason":"Pipeline incomplete. Continue: implement → test → review → commit."}'
      exit 0
    fi
    if [[ "$OSTYPE" == "darwin"* ]]; then
      REVIEW_TIME=$(stat -f %m "$REVIEW" 2>/dev/null)
    else
      REVIEW_TIME=$(stat -c %Y "$REVIEW" 2>/dev/null)
    fi
    if [ "$REVIEW_TIME" -lt "$PLAN_TIME" ]; then
      echo '{"decision":"block","reason":"Pipeline incomplete. Review older than plan."}'
      exit 0
    fi
  fi
fi

echo '{"decision":"approve"}'
exit 0
HOOK1

# ─── 2. Post-edit Hook düzelt (PostToolUse schema) ───
cat > .claude/hooks/post-edit-analyze.sh << 'HOOK2'
#!/bin/bash
INPUT=$(cat)
FILE=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',d.get('tool_input',{}).get('path','')))" 2>/dev/null || echo "")

if [[ "$FILE" == *.dart ]]; then
  RESULT=$(flutter analyze --no-pub 2>&1 | tail -3)
  if echo "$RESULT" | grep -q "No issues found"; then
    echo '{"hookSpecificOutput":{"hookEventName":"PostToolUse"}}'
  else
    CLEAN=$(echo "$RESULT" | tr '\n' ' ' | sed 's/"/\\"/g')
    echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PostToolUse\",\"additionalContext\":\"flutter analyze: ${CLEAN}\"}}"
  fi
else
  echo '{"hookSpecificOutput":{"hookEventName":"PostToolUse"}}'
fi
exit 0
HOOK2

# ─── 3. Hook'ları executable yap ───
chmod +x .claude/hooks/enforce-pipeline.sh
chmod +x .claude/hooks/post-edit-analyze.sh

# ─── 4. /feature komutunu güncelle (branch + PR akışı ekle) ───
cat > .claude/commands/feature.md << 'FEATURE'
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
FEATURE

# ─── 5. /fix komutunu güncelle ───
cat > .claude/commands/fix.md << 'FIX'
# Quick Fix — /fix <description>

Fix: $ARGUMENTS

1. git checkout -b fix/<name> from develop
2. Find and fix root cause
3. flutter analyze + flutter test
4. git add -A && git commit -m "fix: <description>"
5. git push -u origin fix/<name>
6. Create PR to develop (GitHub MCP)
7. Present: branch, commit, PR URL
FIX

# ─── 6. develop branch oluştur ───
git checkout -b develop 2>/dev/null || git checkout develop
git push -u origin develop 2>/dev/null || true

# ─── 7. Remote ekle (eğer yoksa) ───
git remote get-url origin 2>/dev/null || git remote add origin https://github.com/erenkara1907/skin-check-ai.git

# ─── 8. Push current state ───
git add .
git commit -m "chore: fix hooks + add git workflow to pipeline" 2>/dev/null || true
git push origin develop 2>/dev/null || true

echo ""
echo "✅ Düzeltme tamamlandı!"
echo ""
echo "Şimdi Claude Code'u yeniden başlat:"
echo "  1. Claude Code'dan çık (exit veya Ctrl+C)"
echo "  2. Tekrar: claude"
echo "  3. /hooks yazıp kontrol et"
echo "  4. /feature ile devam et"