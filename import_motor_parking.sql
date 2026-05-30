-- Import generated from 260530- Parking list (2).xlsx / Motor Parking
-- Review import_motor_parking_review.csv if you want to check normalized brand/model before running.
begin;
insert into companies (name) values ('ATEX') on conflict (name) do nothing;
insert into companies (name) values ('AgualRich') on conflict (name) do nothing;
insert into companies (name) values ('CambodiaRE') on conflict (name) do nothing;
insert into companies (name) values ('Damco') on conflict (name) do nothing;
insert into companies (name) values ('Global Education') on conflict (name) do nothing;
insert into companies (name) values ('I-Glocal') on conflict (name) do nothing;
insert into companies (name) values ('Inabata') on conflict (name) do nothing;
insert into companies (name) values ('Kiccpaa') on conflict (name) do nothing;
insert into companies (name) values ('Masswork') on conflict (name) do nothing;
insert into companies (name) values ('Metawater') on conflict (name) do nothing;
insert into companies (name) values ('Pinnacle Law') on conflict (name) do nothing;
insert into companies (name) values ('SM Global') on conflict (name) do nothing;
insert into companies (name) values ('VTRUST') on conflict (name) do nothing;
insert into companies (name) values ('Yusen') on conflict (name) do nothing;

insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1DC-1003'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Today', '1GQ-1071'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1FZ-1091'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1IH-1188'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IU-1191'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Today', '1NH-1197'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Unknown', 'Unknown', '1CI-1226'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1KK-1228'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1E-1274'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1BH-1292'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Nex', '1R-1295'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1DA-1311'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1JG-1368'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1KZ-1368'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1BQ-1460'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1AB-1484'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1DC-1548'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1D-1606'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2602', '014', (select id from companies where name = 'Pinnacle Law'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1H-1623'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1A-1631'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IU-1655'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1FD-1693'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1E-1693'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1D-1809'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2602', '013', (select id from companies where name = 'Global Education'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1Q-1854'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Yamaha', 'Unknown', '1HO-1898'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Cube', 'Unknown', '1BL-1968'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IT-1979'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Viva', 'Unknown', '1FJ-2050'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1Y-2140'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Smash', '1BE-2150'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1N-2176'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2602', '016', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1KP-2190'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '007', (select id from companies where name = 'CambodiaRE'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1P-2229'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1J-2271'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IR-2269'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1KF-2443'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Scopy', 'Unknown', '1LG-2471'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '013', (select id from companies where name = 'Global Education'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1W-2555'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CL-2564'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1JZ-2586'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1J-2599'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Unknown', '1II-2624'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1HL-2631'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1LV-2691'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2605', '027', (select id from companies where name = 'CambodiaRE'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1Z-2717'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'MSX', 'Unknown', '1DC-2778'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2603', '018', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1HI-2788'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1FC-2914'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Cub', 'Unknown', '1N-2941'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '007', (select id from companies where name = 'CambodiaRE'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1KI-2942'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1HQ-2962'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2604', '022', (select id from companies where name = 'CambodiaRE'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1FC-3066'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IM-3080'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1JG-3165'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Unknown', '1FW-3180'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1FY-3182'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1AW-3254'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Today', '1GM-3280'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1IG-3344'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1B-3435'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1H-3459'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1E-3477'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1IA-3482'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1BI-3499'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1V-3536'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1AU-3549'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1V-3551'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1JS-3564'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1KD-3588'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Icon', 'Unknown', '1CZ-3590'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Cube', 'Unknown', '1FB-3646'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2605', '025', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1T-3709'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Unknown', 'Unknown', '1LE-3727'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1BO-3743'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Smash', 'Unknown', '1IR-3756'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1JE-3790'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1IE-3802'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1AE-3805'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1GB-3859'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Today', '1FZ-3899'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2604', '023', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1AD-3941'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Cub', 'Unknown', '1T-3952'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1B-3955'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1GD-3961'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1Q-4066'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '007', (select id from companies where name = 'CambodiaRE'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1CK-4098'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CU-4131'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1IL-4163'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Cub', '1AB-4217'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1CR-4221'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Moove', 'Unknown', '1HI-4227'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1AA-4248'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), '2601', 12, '2026-12-31', 'Honda', 'Scoopy', '1AU-4294'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Nex', '1DG-4369'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1H-4387'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CP-4429'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1LS-4467'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1V-4472'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IU-4489'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1KM-4550'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1HQ-4612'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IL-4666'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2602', '014', (select id from companies where name = 'Pinnacle Law'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1GL-4690'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1JX-4737'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1IB-4747'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Super Cub', 'Unknown', '1A-4769'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1GH-4782'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'ICON', 'Unknown', '1B-4786'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1C-4791'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1AR-4799'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1FP-4855'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1HD-4912'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1V-4973'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1KW-4983'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2602', '015', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1LN-5003'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2604', '021', (select id from companies where name = 'Pinnacle Law'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1G-5003'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'CPX', 'Unknown', '1JJ-5020'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'GINIO', 'Unknown', '1KD-5025'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Smash', 'Unknown', '1CF-5117'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1BX-5147'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '011', (select id from companies where name = 'Metawater'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1HA-5115'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Super Cub', 'Unknown', '1Q-5273'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Smash', 'Unknown', '1BV-5274'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Cube', 'Unknown', '1IB-5332'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1BD-5333'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1HS-5534'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Smash V', 'Unknown', '1E-5335'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1G-5351'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1D-5364'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1IC-5389'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1GU-5412'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1LD-5421'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1GV-5448'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1AB-5462'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1V-5470'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1B-5569'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1Q-5572'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1BZ-5599'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1KT-5606'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1K-5624'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '011', (select id from companies where name = 'Metawater'), 'FOC', 12, '2026-12-31', 'Unknown', 'Unknown', '1CJ-5655'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1R-5670'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '007', (select id from companies where name = 'CambodiaRE'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CB-5756'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1KR-5804'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Unknown', '1CL-5860'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1CR-5877'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '019', (select id from companies where name = 'Pinnacle Law'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1KC-5880'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1IW-5900'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1I-5918'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1HS-5959'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Smash v', 'Unknown', '1CD-6027'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1GL-6061'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IS-6122'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Yamaha', 'Unknown', '1HG-6131'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1GZ-6143'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1FJ-6153'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'CUB 70', 'Unknown', '1BR-6154'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Filano', 'Unknown', '1KM-6170'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1AD-6218'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1HO-6231'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Today', '1GE-6278'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1R-6295'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1GN-6344'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1JO-6362'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1LN-6388'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1GL-6416'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1BW-6461'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1AX-6510'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Lambreta', 'Unknown', '1IL-6555'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1CJ-6558'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1KF-6560'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Scopy', 'Unknown', '1CW-6618'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1Q-6630'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Smash', 'Unknown', '1FV-6652'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Smash V', 'Unknown', '1CX-6705'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1JY-6715'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2604', '023', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1IW-6740'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1N-6780'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2604', '024', (select id from companies where name = 'Global Education'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1JN-6784'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2602', '017', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1JW-6801'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1GO-6807'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2602', '014', (select id from companies where name = 'Pinnacle Law'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1HD-6812'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Scopy', 'Unknown', '1BV-6813'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2604', '023', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1CD-6822'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1G-6883'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Scopy', 'Unknown', '1KF-6928'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Cube', 'Unknown', '1C-6984'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1AV-6891'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1P-6955'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-03-31', 'Honda', 'PCX', '1FO-6999'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2605', '025', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-03-31', 'Honda', 'Dream', '1P-7061'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-03-31', 'Honda', 'Zoomer', '1GT-7083'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '007', (select id from companies where name = 'CambodiaRE'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1D-7134'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'ICON', 'Unknown', '1AQ-7161'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1T-7224'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1P-7257'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Pulsar', 'Unknown', '1HB-7277'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1HD-7296'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1FE-7387'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1JP-7483'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1AB-7512'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Scopy', 'Unknown', '1JJ-7566'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1FK-7579'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1U-7604'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CY-7624'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '010', (select id from companies where name = 'Inabata'), 'FOC', 12, '2026-12-31', 'ICON', 'Unknown', '1BL-7741'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1DO-7801'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CP-7837'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1HS-7961'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Smash', 'Unknown', '1AR-8010'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1GM-8025'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1DH-8030'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Smash,V', 'Unknown', '1BL-8041'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1A-8089'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IH-8091'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CN-8130'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1AG-8133'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Unknown', 'Unknown', '1IM-8176'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'MSX', 'Unknown', '1JD-8285'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1H-8303'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Today', '1S-8607'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1HN-8657'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1L-8663'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1IG-8680'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1FD-8686'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1HH-8718'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Zomer X', 'Unknown', '1B-8759'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1AK-8772'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Unknown', '1E-8774'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1IX-8783'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1FF-8811'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1GY-8815'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CA-8834'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1AI-8862'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1KP-9006'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1O-9014'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1AH-9067'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2603', '020', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1P-9069'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '007', (select id from companies where name = 'CambodiaRE'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1T-9141'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'ADV', 'Unknown', '1LN-9229'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1M-9257'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1FU-9295'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1Q-9295'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Let''s', 'Unknown', '1S-9328'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1R-9333'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IR-9342'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1GQ-9345'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'ICON', 'Unknown', '1AW-9351'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1V-9417'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '013', (select id from companies where name = 'Global Education'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Nex', '1KM-9444'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Zommer', 'Unknown', '1HN-9474'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1B-9477'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '008', (select id from companies where name = 'AgualRich'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1AK-9523'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1FK-9587'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1KQ-9593'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2603', '020', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1T-9660'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1LE-9664'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '012', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'MSX', 'Unknown', '1JQ-9701'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Today', '1KT-9718'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1G-9739'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Beat', 'Unknown', '1AN-9751'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Let''s', 'Unknown', '1CB-9779'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Nex', '1GC-9800'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'PCX', '1IB-9844'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1HJ-9878'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1LY-9947'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1HH-9953'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2605', '025', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1CK-0132'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1GB-0196'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '006', (select id from companies where name = 'I-Glocal'), 'FOC', 12, '2026-12-31', 'Fino', 'Unknown', '1CN-0188'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Smash V', 'Unknown', '1GL-0242'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1AT-0311'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '013', (select id from companies where name = 'Global Education'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1JF-0355'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2604', '023', (select id from companies where name = 'ATEX'), 'FOC', 12, '2026-12-31', 'Honda', 'Today', '1R-0362'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1GH-0442'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '004', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Let''s', 'Unknown', '1CH-0555'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2605', '026', (select id from companies where name = 'SM Global'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1AQ-0057'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IP-0564'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1HF-0580'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '002', (select id from companies where name = 'Masswork'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1CY-0625'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1KG-0628'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '009', (select id from companies where name = 'Kiccpaa'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1J-0629'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1BG-0670'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1G-0678'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Unknown', '1D-0734'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1HC-0729'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Scoopy', '1IR-0735'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '001', (select id from companies where name = 'VTRUST'), 'FOC', 12, '2026-12-31', 'Honda', 'Dream', '1KS-0748'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Let''s', 'Unknown', '1AA-0752'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1GW-0778'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Click', '1IZ-0779'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Suzuki', 'Unknown', '1HB-0825'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '003', (select id from companies where name = 'Yusen'), 'FOC', 12, '2026-12-31', 'Honda', 'Wave', '1KH-0928'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
insert into registered_motors (ref, no, company_id, type, months, expiry_date, brand, model, plate) values (
  '2601', '005', (select id from companies where name = 'Damco'), 'FOC', 12, '2026-12-31', 'Honda', 'Zoomer', '1J-0936'
) on conflict (plate) do update set
  ref = excluded.ref,
  no = excluded.no,
  company_id = excluded.company_id,
  type = excluded.type,
  months = excluded.months,
  expiry_date = excluded.expiry_date,
  brand = excluded.brand,
  model = excluded.model,
  updated_at = now();
commit;

-- Skipped rows without a valid company + plate:
-- row 10 ref=2601 no=004 company=SM Global detail=Cube prefix=ភ6054ភព1 number=
-- row 266 ref=2601 no=001 company=VTRUST detail= prefix= number=9584
-- row 299 ref=2601 no=001 company=VTRUST detail=Scoopy prefix= number=0729
-- row 347 ref= no= company= detail=Total : prefix= number=
-- Duplicate plates skipped after first occurrence:
-- row 91 duplicates row 90 plate=1GB-3859 company=Damco