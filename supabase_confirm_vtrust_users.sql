-- Confirm existing Vtrust portal users so they can log in with password.
-- Use this for the internal pilot if Supabase email confirmation is enabled.
--
-- Run in Supabase SQL Editor after creating users from Settings > Admin users.

update auth.users
set
  email_confirmed_at = coalesce(email_confirmed_at, now()),
  updated_at = now()
where email in (
  select email
  from public.portal_admin_users
);
