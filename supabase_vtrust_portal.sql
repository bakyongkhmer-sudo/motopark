-- MotoSheet Vtrust portal auth/settings support
-- Run this once in Supabase SQL Editor.

create table if not exists portal_admin_users (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  email text not null unique,
  full_name text not null,
  role text not null default 'Parking officer',
  status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists portal_settings (
  key text primary key,
  value jsonb not null,
  updated_at timestamptz not null default now()
);

alter table portal_admin_users enable row level security;
alter table portal_settings enable row level security;

drop policy if exists "portal admins read after login" on portal_admin_users;
drop policy if exists "portal admins manage after login" on portal_admin_users;
drop policy if exists "portal settings read after login" on portal_settings;
drop policy if exists "portal settings manage after login" on portal_settings;

create policy "portal admins read after login"
on portal_admin_users for select
to authenticated
using (true);

create policy "portal admins manage after login"
on portal_admin_users for all
to authenticated
using (true)
with check (true);

create policy "portal settings read after login"
on portal_settings for select
to authenticated
using (true);

create policy "portal settings manage after login"
on portal_settings for all
to authenticated
using (true)
with check (true);

grant select, insert, update, delete on portal_admin_users to authenticated;
grant select, insert, update, delete on portal_settings to authenticated;

insert into portal_settings (key, value) values
  ('general', '{"buildingName":"Vtrust Tower","address":"No. 138, Norodom Blvd, Phnom Penh","buildingCode":"PNH-VT","capacity":240,"timezone":"Asia/Phnom_Penh","language":"English","dateFormat":"YYYY-MM-DD"}'),
  ('scan', '{"morningStart":"08:00","morningEnd":"11:30","afternoonStart":"14:00","afternoonEnd":"17:30","lateTolerance":15,"requireBothRounds":true}'),
  ('reminders', '{"daysBefore":30,"emailTenant":true,"dailyDigest":true,"subject":"Motor registration renewal reminder"}'),
  ('integrations', '{"apiEnabled":true,"sendGrid":"connected","googleDrive":"connected","slack":"off"}'),
  ('billing', '{"plan":"Building Pro","price":"49","billingEmail":"parking@vtrusttower.com.kh","taxId":"K001-1234-5678"}')
on conflict (key) do nothing;
