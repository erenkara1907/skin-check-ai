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
