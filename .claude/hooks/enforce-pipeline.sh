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
