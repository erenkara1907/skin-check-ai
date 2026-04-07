# Quick Fix — /fix <description>

Fix: $ARGUMENTS

1. git checkout -b fix/<name> from develop
2. Find and fix root cause
3. flutter analyze + flutter test
4. git add -A && git commit -m "fix: <description>"
5. git push -u origin fix/<name>
6. Create PR to develop (GitHub MCP)
7. Present: branch, commit, PR URL
