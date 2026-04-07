#!/bin/bash
INPUT=$(cat)
FILE=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('file_path',''))" 2>/dev/null || echo "")
 
if [[ "$FILE" == *.dart ]]; then
  RESULT=$(flutter analyze --no-pub 2>&1 | tail -3)
  if echo "$RESULT" | grep -q "No issues found"; then
    echo '{"decision":"allow"}'
  else
    echo "{\"decision\":\"allow\",\"reason\":\"flutter analyze: $RESULT\"}"
  fi
else
  echo '{"decision":"allow"}'
fi
exit 0
