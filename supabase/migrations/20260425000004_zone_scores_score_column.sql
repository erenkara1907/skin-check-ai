-- Add per-zone score column written by the analyze-skin Edge Function.
-- Code refs: supabase/functions/analyze-skin/index.ts:216 (insert),
--            lib/features/analysis/data/repositories/analysis_repository_impl.dart:79 (read with fallback)
-- Without this column the insert silently failed and history detail views
-- showed empty zones (only the freshly-returned in-memory result was populated).

ALTER TABLE public.zone_scores
  ADD COLUMN IF NOT EXISTS score DOUBLE PRECISION
    CHECK (score IS NULL OR (score >= 0 AND score <= 100));
