-- MotoSheet Supabase schema draft
-- Apply in Supabase SQL editor after project creation.

create type scan_session_type as enum ('morning', 'afternoon');
create type scan_classification as enum ('company', 'visitor');

create table companies (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  created_at timestamptz not null default now()
);

create table registered_motors (
  id uuid primary key default gen_random_uuid(),
  ref text,
  no text,
  company_id uuid not null references companies(id) on delete restrict,
  type text not null default 'FOC',
  months int not null default 12,
  expiry_date date not null,
  brand text not null,
  model text not null,
  plate text not null unique,
  plate_prefix text generated always as (split_part(plate, '-', 1)) stored,
  plate_number text generated always as (split_part(plate, '-', 2)) stored,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table scan_sessions (
  id uuid primary key default gen_random_uuid(),
  scan_date date not null,
  session_type scan_session_type not null,
  officer_name text,
  created_at timestamptz not null default now(),
  unique (scan_date, session_type)
);

create table scan_records (
  id uuid primary key default gen_random_uuid(),
  scan_session_id uuid not null references scan_sessions(id) on delete cascade,
  registered_motor_id uuid references registered_motors(id) on delete set null,
  classification scan_classification not null,
  plate text not null,
  city text not null default 'PHNOM PENH',
  company_name text not null default 'VISITOR',
  ref text,
  no text,
  type text,
  months int,
  expiry_date date,
  brand text not null,
  model text not null,
  scanned_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (scan_session_id, plate)
);

create view daily_scan_report as
select
  min(sr.ref) as ref,
  min(sr.no) as no,
  sr.company_name as company,
  min(sr.type) as type,
  min(sr.months) as months,
  min(sr.expiry_date) as expiry,
  min(sr.brand) as brand,
  min(sr.model) as model,
  split_part(sr.plate, '-', 1) as plate_prefix,
  split_part(sr.plate, '-', 2) as plate_number,
  bool_or(ss.session_type = 'morning') as morning,
  bool_or(ss.session_type = 'afternoon') as afternoon,
  ss.scan_date
from scan_records sr
join scan_sessions ss on ss.id = sr.scan_session_id
group by ss.scan_date, sr.company_name, sr.plate
order by sr.company_name, sr.plate;

alter table companies enable row level security;
alter table registered_motors enable row level security;
alter table scan_sessions enable row level security;
alter table scan_records enable row level security;
