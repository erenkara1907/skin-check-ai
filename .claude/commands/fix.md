# Quick Fix — /fix <description>

Fix: $ARGUMENTS

Approach the bug with the **ECC build-error-resolver** mindset: find the **root cause**, not a band-aid.

---

## Steps

1. **Generate a FIX_ID** (kebab-case, max 3 words) from the description.

2. **Branch from develop**:
   ```bash
   git stash 2>/dev/null || true
   git fetch origin develop 2>/dev/null || true
   git checkout develop && git pull origin develop 2>/dev/null || true
   git checkout -b fix/<FIX_ID>
   ```

3. **Reproduce + diagnose**:
   - Read the failing code path end-to-end before editing.
   - State the root cause in one sentence.
   - State why this didn't get caught (missing test? missing guard?).

4. **Fix** the root cause. Do not paper over symptoms.

5. **Add a regression test** that fails on `develop` and passes on this branch.

6. **Verify**:
   ```bash
   flutter analyze
   flutter test
   ```
   Both must be clean before continuing.

7. **Commit** (conventional):
   ```bash
   git add -A
   git commit -m "fix(<FIX_ID>): <short description>

   - Root cause: <one line>
   - Regression test added
   - Tests: <N> passing"
   ```

8. **Push + PR** (via GitHub MCP `mcp__github__create_pull_request`):
   - base: `develop`, head: `fix/<FIX_ID>`
   - title: `fix(<FIX_ID>): <description>`
   - body: root cause + repro steps + regression test note

9. **Report**: branch, commit SHA, PR URL, regression test path.
