-- MotoSheet access policies
-- Run this after supabase_schema.sql.
--
-- Web portal:
--   Requires Supabase Auth login for registering, updating, and deleting motors.
-- Android app:
--   Can read the active registry and upload scan sessions/records with the
--   publishable key, so officers do not need to log in on every phone.

drop policy if exists "motosheet public read companies" on companies;
drop policy if exists "motosheet public insert companies" on companies;
drop policy if exists "motosheet public update companies" on companies;
drop policy if exists "motosheet public read registered motors" on registered_motors;
drop policy if exists "motosheet public insert registered motors" on registered_motors;
drop policy if exists "motosheet public update registered motors" on registered_motors;
drop policy if exists "motosheet public delete registered motors" on registered_motors;
drop policy if exists "motosheet public read scan sessions" on scan_sessions;
drop policy if exists "motosheet public insert scan sessions" on scan_sessions;
drop policy if exists "motosheet public update scan sessions" on scan_sessions;
drop policy if exists "motosheet public read scan records" on scan_records;
drop policy if exists "motosheet public insert scan records" on scan_records;
drop policy if exists "motosheet public update scan records" on scan_records;
drop policy if exists "motosheet read companies" on companies;
drop policy if exists "motosheet manage companies after login" on companies;
drop policy if exists "motosheet read registered motors" on registered_motors;
drop policy if exists "motosheet manage registered motors after login" on registered_motors;
drop policy if exists "motosheet read scan sessions" on scan_sessions;
drop policy if exists "motosheet write scan sessions" on scan_sessions;
drop policy if exists "motosheet read scan records" on scan_records;
drop policy if exists "motosheet write scan records" on scan_records;

create policy "motosheet read companies"
on companies for select
to anon, authenticated
using (true);

create policy "motosheet manage companies after login"
on companies for all
to authenticated
using (true)
with check (true);

create policy "motosheet read registered motors"
on registered_motors for select
to anon, authenticated
using (true);

create policy "motosheet manage registered motors after login"
on registered_motors for all
to authenticated
using (true)
with check (true);

create policy "motosheet read scan sessions"
on scan_sessions for select
to anon, authenticated
using (true);

create policy "motosheet write scan sessions"
on scan_sessions for all
to anon, authenticated
using (true)
with check (true);

create policy "motosheet read scan records"
on scan_records for select
to anon, authenticated
using (true);

create policy "motosheet write scan records"
on scan_records for all
to anon, authenticated
using (true)
with check (true);

grant usage on schema public to anon, authenticated;
grant select on companies to anon;
grant select on registered_motors to anon;
grant select, insert, update on scan_sessions to anon;
grant select, insert, update on scan_records to anon;
grant select, insert, update, delete on companies to authenticated;
grant select, insert, update, delete on registered_motors to authenticated;
grant select, insert, update on scan_sessions to authenticated;
grant select, insert, update on scan_records to authenticated;
grant select on daily_scan_report to authenticated;
