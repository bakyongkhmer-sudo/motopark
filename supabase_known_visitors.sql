-- Known visitor cache for repeat outside motors.
-- Run this once in Supabase SQL editor for an existing MotoSheet database.

create table if not exists known_visitors (
  id uuid primary key default gen_random_uuid(),
  plate text not null unique,
  city text not null default 'PHNOM PENH',
  brand text not null,
  model text not null,
  first_seen_at timestamptz not null default now(),
  last_seen_at timestamptz not null default now(),
  visit_count int not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table known_visitors enable row level security;

drop policy if exists "motosheet read known visitors" on known_visitors;
drop policy if exists "motosheet write known visitors" on known_visitors;

create policy "motosheet read known visitors"
on known_visitors for select
to anon, authenticated
using (true);

create policy "motosheet write known visitors"
on known_visitors for all
to anon, authenticated
using (true)
with check (true);

grant select, insert, update on known_visitors to anon;
grant select, insert, update, delete on known_visitors to authenticated;
