#!/bin/bash
INPUT=$(cat)
PLAN="docs/plans/PLAN.md"
REVIEW="docs/reviews/REVIEW.md"
 
if [ -f "$PLAN" ]; then
  PLAN_TIME=$(stat -f %m "$PLAN" 2>/dev/null || stat -c %Y "$PLAN" 2>/dev/null)
  NOW=$(date +%s)
  DIFF=$(( NOW - PLAN_TIME ))
 
  # Plan son 2 saat içinde oluşturulduysa ve review yoksa, durdur
  if [ "$DIFF" -lt 7200 ]; then
    if [ ! -f "$REVIEW" ] || [ "$(stat -f %m "$REVIEW" 2>/dev/null || stat -c %Y "$REVIEW" 2>/dev/null)" -lt "$PLAN_TIME" ]; then
      echo '{"decision":"block","reason":"Pipeline incomplete. Plan exists but review is missing. Continue: implement → test → review → commit."}'
      exit 0
    fi
  fi
fi
 
echo '{"decision":"allow"}'
exit 0
