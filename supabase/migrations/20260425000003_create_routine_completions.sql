-- Routine completions — daily check-in records used for streak calculation.
-- Code refs: lib/features/routine/data/datasources/routine_datasource.dart:50-94
-- Plan: docs/plans/skin-routine-builder-plan.md (Section 2)
-- Note: onConflict 'user_id,routine_id,completed_at' upsert at line 54 requires UNIQUE.

CREATE TABLE IF NOT EXISTS public.routine_completions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  routine_id UUID NOT NULL REFERENCES public.routines(id) ON DELETE CASCADE,
  completed_at DATE NOT NULL DEFAULT CURRENT_DATE,
  completed_steps JSONB NOT NULL DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT routine_completions_user_routine_date_unique
    UNIQUE (user_id, routine_id, completed_at)
);

CREATE INDEX IF NOT EXISTS routine_completions_user_date_idx
  ON public.routine_completions (user_id, completed_at DESC);

ALTER TABLE public.routine_completions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can CRUD own completions" ON public.routine_completions;
CREATE POLICY "Users can CRUD own completions" ON public.routine_completions
  FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
