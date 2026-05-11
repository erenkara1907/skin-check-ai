#!/bin/bash
# PostToolUse hook: after Write/Edit on a .dart file, run flutter analyze
# and surface issues via additionalContext.
#
# Pure bash JSON parsing (no Python). JSON output uses minimal escaping.

set -u

INPUT=$(cat 2>/dev/null || true)

# Extract file_path from the input JSON. Tolerant of minor formatting.
# Looks for "file_path": "<value>" or "path": "<value>".
extract_path() {
  local input="$1"
  local key="$2"
  printf '%s' "$input" \
    | tr -d '\n' \
    | grep -oE "\"${key}\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" \
    | head -n 1 \
    | sed -E "s/.*\"${key}\"[[:space:]]*:[[:space:]]*\"([^\"]*)\".*/\\1/"
}

FILE=$(extract_path "$INPUT" "file_path")
if [ -z "$FILE" ]; then
  FILE=$(extract_path "$INPUT" "path")
fi

# Default no-op response.
NOOP='{"hookSpecificOutput":{"hookEventName":"PostToolUse"}}'

if [[ "$FILE" != *.dart ]]; then
  printf '%s\n' "$NOOP"
  exit 0
fi

# Skip generated files — they are written by build_runner, not by the user.
case "$FILE" in
  *.g.dart|*.freezed.dart|*.gr.dart|*.config.dart)
    printf '%s\n' "$NOOP"
    exit 0
    ;;
esac

# Run analyzer if available; otherwise no-op.
if ! command -v flutter >/dev/null 2>&1; then
  printf '%s\n' "$NOOP"
  exit 0
fi

# Limit analysis to the touched file for speed; fall back to project-wide if path resolves badly.
RESULT=$(flutter analyze --no-pub "$FILE" 2>&1 || true)

if printf '%s' "$RESULT" | grep -q "No issues found"; then
  printf '%s\n' "$NOOP"
  exit 0
fi

# Take only the last few lines (summary + a couple of issues).
TAIL=$(printf '%s' "$RESULT" | tail -n 5 | tr '\n' ' ')

# JSON-escape: backslashes, double quotes, then control chars are stripped above via tr.
ESCAPED=$(printf '%s' "$TAIL" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')

printf '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"flutter analyze on %s: %s"}}\n' "$FILE" "$ESCAPED"
exit 0
