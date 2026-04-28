# Security Scan — /security-scan

Full security audit using the **ECC security-reviewer** mindset. Scope: client app + Supabase backend.

---

## 1. Hardcoded secrets in client

```bash
# OpenAI / generic
grep -rEn "sk-[a-zA-Z0-9]{20,}" lib/ test/ || echo "no openai key literals"

# Supabase service role / common patterns
grep -rEn "(SUPABASE_SERVICE_ROLE|sb_secret|service_role)" lib/ test/ || echo "no service role literals"

# Bearer tokens, JWTs
grep -rEn "(Bearer [A-Za-z0-9._-]{20,}|eyJ[A-Za-z0-9._-]{20,})" lib/ test/ || echo "no token literals"

# RevenueCat / 3rd-party
grep -rEn "(rcb_|rcv_|appl_|goog_)[A-Za-z0-9]{10,}" lib/ test/ || echo "no rc key literals"
```

Any hit outside `lib/core/config/env_config.dart` (which must read from env, not literal strings) → **CRITICAL**.

## 2. Supabase RLS policies
Use Supabase MCP:
- `mcp__supabase__list_tables` → confirm every public table has `rls_enabled = true`.
- For each table, sanity-check policies cover SELECT / INSERT / UPDATE / DELETE for the right roles.
- Flag any table without a policy as **CRITICAL**.

## 3. Storage buckets
- All buckets must be **private**.
- Verify the app uses signed URLs (`createSignedUrl`) — `grep -rn "getPublicUrl" lib/` should be empty for user content; flag any hits.

## 4. Auth flow
- Login/signup goes through Supabase auth, not custom HTTP.
- Tokens never logged: `grep -rn -i "token\|jwt\|refresh" lib/ | grep -i "log\|print"` → must be clean.
- Session storage uses `flutter_secure_storage` (or Supabase's secure default), not plain `SharedPreferences`.

## 5. HTTPS-only
- All `Dio` base URLs start with `https://`.
- No `http://` literals outside test fixtures.

## 6. Sensitive data logging
- `Logger` calls do not include skin photos, base64 image bytes, email/phone, or auth tokens.
- `grep -rn "Logger" lib/ | grep -iE "photo|image|base64|email|phone|token"` → review every hit.
- No `print()` anywhere in `lib/` (CLAUDE.md rule).

## 7. OWASP Mobile Top 10 (M1–M10)
Walk each, one bullet per:

- **M1 Improper Credential Usage** — credentials only via env / secure storage
- **M2 Inadequate Supply Chain Security** — `pubspec.lock` committed; flag any `git:` deps
- **M3 Insecure Authentication/Authorization** — Supabase auth + RLS
- **M4 Insufficient Input/Output Validation** — server-side validation in Edge Functions
- **M5 Insecure Communication** — HTTPS only, certificate pinning if applicable
- **M6 Inadequate Privacy Controls** — GDPR delete-all-data path exists
- **M7 Insufficient Binary Protections** — `--obfuscate --split-debug-info` in release builds
- **M8 Security Misconfiguration** — debug flags off in release; no `kDebugMode` leaking secrets
- **M9 Insecure Data Storage** — secure storage for tokens; no PII in `SharedPreferences`
- **M10 Insufficient Cryptography** — no homemade crypto; rely on platform / Supabase

## 8. Dependencies
```bash
flutter pub outdated --mode=null-safety
```
Note any transitively-vulnerable packages (security advisories from pub.dev).

---

## Output

Write `docs/security-report-<YYYY-MM-DD>.md`:

```
## Summary
Date: <YYYY-MM-DD>
Severity: <critical N / high N / medium N / low N>

## Findings
### [CRITICAL] <title>
- Where: <file:line | table | bucket>
- Detail: <what>
- Fix: <how>

### [HIGH] ...
### [MEDIUM] ...
### [LOW] ...

## OWASP M1–M10 status
<one line per item: pass / partial / fail + note>

## Auto-remediations applied
<none, or list>

## Required manual remediations
<list with owner / urgency>
```

Final chat output: severity counts + report path. Do **NOT** print any leaked secret values; show file:line only.
