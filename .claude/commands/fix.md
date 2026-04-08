# Quick Fix — /fix <description>

Fix: $ARGUMENTS

1. git checkout -b fix/<kebab-case-name> from develop
2. Find and fix the issue
3. flutter analyze + flutter test
4. git add -A && git commit -m "fix: <description>"
5. git push -u origin fix/<name>
6. Create PR to develop via GitHub MCP
7. Report: branch, commit, PR URL
