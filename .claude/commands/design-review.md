# Design System Audit — /design-review

Audit the entire app for compliance with the CLAUDE.md design system. Use the **ECC code-reviewer** mindset focused on UI consistency.

---

## Inputs to scan
- All `lib/features/**/presentation/screens/*.dart`
- All `lib/features/**/presentation/widgets/*.dart`
- `lib/core/theme/**`
- `lib/shared/widgets/**`

## Checklist

### 1. Colors
- Primary `#6C63FF` and secondary `#00D9A6` come from `AppTheme` / `ColorScheme`, not hardcoded literals.
- Flag any `Color(0x...)` / `Colors.<name>` outside `lib/core/theme/`.

### 2. Typography
- `Outfit` for display, `Plus Jakarta Sans` for body.
- Flag any `TextStyle(fontFamily: ...)` that bypasses the theme.

### 3. Glassmorphism cards
- 16px corner radius
- Subtle shadow + blur where the spec calls for glass
- Reusable widget — no per-screen reinvention

### 4. Dark mode
- Every screen renders correctly in dark mode.
- Flag literal whites/blacks (`Colors.white`, `Colors.black`) that don't adapt.

### 5. Touch targets
- Minimum 48×48 logical pixels.
- Flag `IconButton` / `GestureDetector` smaller than that.

### 6. State coverage
- Every async screen has loading + error + empty states.
- Flag `AsyncValue` consumers that handle only data.

### 7. Default Flutter styling (forbidden)
- Default `AppBar` styling, default `ElevatedButton`, default `Card` without theme overrides.
- Flag any usage that visibly looks like a stock Flutter widget.

### 8. Bottom nav
- Exactly 5 tabs: Home, Analyze, Progress, Routine, Profile.
- Flag any divergence.

### 9. Icons
- Lucide Icons preferred; flag stray Material `Icons.*` where Lucide exists.

### 10. Animations
- Smooth transitions on score reveals; no janky `setState` loops outside animation controllers.

---

## Output

Produce `docs/design-review-<YYYY-MM-DD>.md`:

```
## Summary
- Files scanned: <N>
- Issues found: <total> (critical / major / minor)

## Issues
### [CRITICAL] <title>
- File: <path>:<line>
- Spec rule: <which CLAUDE.md rule>
- Current: <snippet>
- Suggested fix: <one-liner>

### [MAJOR] ...
### [MINOR] ...

## Auto-fixes applied
- <file>: <what changed>

## Manual follow-ups
- <file>: <what user should decide>
```

After writing the report, **apply the safe auto-fixes** (theme references, removing hardcoded colors that have a theme equivalent). Leave subjective layout/tone changes as manual follow-ups.

Final chat output: counts by severity + report path.
