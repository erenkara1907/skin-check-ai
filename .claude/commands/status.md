# Project Status — /status

Snapshot of the SkinCheck AI project. Run all probes in parallel where possible. Output a tight one-page summary.

---

## Probes

```bash
# Code size
find lib -name "*.dart" -not -name "*.g.dart" -not -name "*.freezed.dart" | wc -l
find lib -name "*.dart" -not -name "*.g.dart" -not -name "*.freezed.dart" -exec wc -l {} + | tail -1

# Tests
find test -name "*_test.dart" 2>/dev/null | wc -l

# Coverage (only if recent)
[ -f coverage/lcov.info ] && grep -c "^SF:" coverage/lcov.info || echo "no coverage file"

# Git
git rev-parse --abbrev-ref HEAD
git log --oneline -1
git status --porcelain | wc -l
git log develop..HEAD --oneline 2>/dev/null | wc -l

# Open PRs (GitHub MCP)
# mcp__github__list_pull_requests state=open

# Analyzer
flutter analyze 2>&1 | tail -3

# ECC plugin
ls ~/.claude/rules/common/ 2>/dev/null && echo "ECC rules: present" || echo "ECC rules: MISSING"
```

---

## Output format

```
📊 SkinCheck AI — Status (<date>)

📁 Code
  • Source files: <N> (<LOC> lines)
  • Test files: <N>
  • Coverage: <X>% (<files tracked>)

🌿 Git
  • Branch: <name>
  • Last commit: <sha> <message>
  • Uncommitted: <N> files
  • Ahead of develop: <N> commits
  • Open PRs: <list with #, title, base→head>

🩺 Quality
  • flutter analyze: <0 issues / N issues>

🔌 Tooling
  • ECC rules: <present / missing>
  • Hooks: enforce-pipeline.sh, post-edit-analyze.sh
  • Slash commands: <count>

🎯 Headline
  <one-sentence verdict — green/yellow/red and why>
```

Keep it under 25 lines. No filler.
