-- MotoSheet simple access policies
-- Run this after supabase_schema.sql so the Vercel portal and Android app
-- can read/write with the Supabase publishable key.
--
-- This is suitable for a low-cost internal pilot. Before sharing the portal
-- publicly, add Supabase Auth and replace these broad policies with logged-in
-- building-management/officer roles.

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

create policy "motosheet public read companies"
on companies for select
to anon, authenticated
using (true);

create policy "motosheet public insert companies"
on companies for insert
to anon, authenticated
with check (true);

create policy "motosheet public update companies"
on companies for update
to anon, authenticated
using (true)
with check (true);

create policy "motosheet public read registered motors"
on registered_motors for select
to anon, authenticated
using (true);

create policy "motosheet public insert registered motors"
on registered_motors for insert
to anon, authenticated
with check (true);

create policy "motosheet public update registered motors"
on registered_motors for update
to anon, authenticated
using (true)
with check (true);

create policy "motosheet public delete registered motors"
on registered_motors for delete
to anon, authenticated
using (true);

create policy "motosheet public read scan sessions"
on scan_sessions for select
to anon, authenticated
using (true);

create policy "motosheet public insert scan sessions"
on scan_sessions for insert
to anon, authenticated
with check (true);

create policy "motosheet public update scan sessions"
on scan_sessions for update
to anon, authenticated
using (true)
with check (true);

create policy "motosheet public read scan records"
on scan_records for select
to anon, authenticated
using (true);

create policy "motosheet public insert scan records"
on scan_records for insert
to anon, authenticated
with check (true);

create policy "motosheet public update scan records"
on scan_records for update
to anon, authenticated
using (true)
with check (true);

grant usage on schema public to anon, authenticated;
grant select, insert, update on companies to anon, authenticated;
grant select, insert, update, delete on registered_motors to anon, authenticated;
grant select, insert, update on scan_sessions to anon, authenticated;
grant select, insert, update on scan_records to anon, authenticated;
grant select on daily_scan_report to anon, authenticated;
