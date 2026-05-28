# MotoSheet Supabase Setup

## 1. Create Supabase Project

Create a Supabase project, then open the SQL editor and run:

```sql
-- paste contents of supabase_schema.sql
```

The schema creates:

- `companies`
- `registered_motors`
- `scan_sessions`
- `scan_records`
- `daily_scan_report`

## 2. Credentials

In Supabase, copy:

- Project URL
- Anon public key

Do not commit real keys into source control.

## 3. Build Android App With Backend

```sh
flutter build apk --debug \
  --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY
```

Without these values, the app uses local sample data only.

## 4. Run Web Portal

Open:

```text
web_portal/index.html
```

Paste the Supabase URL and anon key, then click `Connect`.

The portal supports:

- Register motor
- Upsert company by name
- View/delete registered motors
- View daily report

## 5. Current Security Note

The schema enables row level security but does not add final production policies.
Before real deployment, add policies for authenticated building-management users and parking officers.

Suggested roles:

- Admin: manage companies and registered motors
- Officer: read registered motors and insert scan records
