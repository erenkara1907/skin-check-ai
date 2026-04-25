-- Progress logs — historical user-progress events used by GDPR export/delete.
-- Code refs: lib/features/profile/data/datasources/profile_datasource.dart:86-89,104-108
-- CLAUDE.md lists this table in the Database section.
-- Today the column set is generic; future progress events can extend it.

CREATE TABLE IF NOT EXISTS public.progress_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  analysis_id UUID REFERENCES public.analyses(id) ON DELETE SET NULL,
  score_delta DOUBLE PRECISION,
  photo_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS progress_logs_user_created_idx
  ON public.progress_logs (user_id, created_at DESC);

ALTER TABLE public.progress_logs ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can CRUD own progress logs" ON public.progress_logs;
CREATE POLICY "Users can CRUD own progress logs" ON public.progress_logs
  FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
