-- Routines table — stores user's morning/evening skincare routines.
-- Code refs: lib/features/routine/data/datasources/routine_datasource.dart
-- Plan: docs/plans/skin-routine-builder-plan.md (Section 2)

CREATE TABLE IF NOT EXISTS public.routines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK (type IN ('morning', 'evening')),
  -- Column name matches the client (routine_repository_impl.dart:33,120 reads
  -- and writes `steps_json`). The original plan said `steps`; the code
  -- diverged in mid-April 2026 (project memory) — keep them aligned.
  steps_json JSONB NOT NULL DEFAULT '[]'::jsonb,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS routines_user_id_idx ON public.routines (user_id);
CREATE INDEX IF NOT EXISTS routines_user_type_active_idx
  ON public.routines (user_id, type, is_active);

ALTER TABLE public.routines ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can CRUD own routines" ON public.routines;
CREATE POLICY "Users can CRUD own routines" ON public.routines
  FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
