-- Add onboarding state columns to users table.
-- Code refs: lib/features/auth/data/datasources/supabase_auth_datasource.dart:147-148
-- Plan: docs/plans/user-onboarding-plan.md (Database Migration section)

ALTER TABLE public.users
  ADD COLUMN IF NOT EXISTS onboarding_completed boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS skin_concerns text[] NOT NULL DEFAULT '{}';
