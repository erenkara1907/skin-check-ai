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
