#!/bin/bash
# Stop hook: blocks the agent from stopping mid-feature-pipeline.
# Rule: if a plan file exists in docs/plans/ that was modified in the last 2 hours,
# there must be a matching review file in docs/reviews/ (and the review must be
# at least as new as the plan). Otherwise → block.
#
# Pure bash. No Python. macOS + Linux compatible.

set -u

PLAN_DIR="docs/plans"
REVIEW_DIR="docs/reviews"

# Read stdin (we don't need it, but consume to avoid SIGPIPE upstream).
cat >/dev/null 2>&1 || true

# No plan dir → nothing to enforce.
if [ ! -d "$PLAN_DIR" ]; then
  printf '{"decision":"approve"}\n'
  exit 0
fi

# Find the most recently modified plan file within the last 120 minutes.
RECENT_PLAN=$(find "$PLAN_DIR" -type f -name "*-plan.md" -mmin -120 2>/dev/null | head -n 1)

if [ -z "$RECENT_PLAN" ]; then
  printf '{"decision":"approve"}\n'
  exit 0
fi

BASENAME=$(basename "$RECENT_PLAN")
FEATURE_ID="${BASENAME%-plan.md}"
REVIEW_FILE="${REVIEW_DIR}/${FEATURE_ID}-review.md"

if [ ! -f "$REVIEW_FILE" ]; then
  printf '{"decision":"block","reason":"Feature pipeline incomplete for %s. Plan exists but review missing. Continue: implement \\u2192 test \\u2192 review \\u2192 commit \\u2192 push \\u2192 PR."}\n' "$FEATURE_ID"
  exit 0
fi

# Compare modification times — review must be newer than plan.
if [[ "$OSTYPE" == "darwin"* ]]; then
  PT=$(stat -f %m "$RECENT_PLAN" 2>/dev/null || echo 0)
  RT=$(stat -f %m "$REVIEW_FILE" 2>/dev/null || echo 0)
else
  PT=$(stat -c %Y "$RECENT_PLAN" 2>/dev/null || echo 0)
  RT=$(stat -c %Y "$REVIEW_FILE" 2>/dev/null || echo 0)
fi

if [ "$RT" -lt "$PT" ]; then
  printf '{"decision":"block","reason":"Review file for %s is older than its plan. Re-run review and update before stopping."}\n' "$FEATURE_ID"
  exit 0
fi

printf '{"decision":"approve"}\n'
exit 0
