# MotoSheet Web Portal

This folder is a static admin portal and can be hosted on Vercel.

## Deploy On Vercel

1. Push this project to GitHub.
2. In Vercel, create a new project.
3. Select this repository.
4. Set the project root directory to:

```text
web_portal
```

5. Keep build settings empty/default:

```text
Framework Preset: Other
Build Command: empty
Output Directory: .
Install Command: empty
```

6. Deploy.

## Supabase Connection

After opening the deployed site:

1. Paste Supabase Project URL.
2. Paste Supabase publishable/anon key.
3. Click `Save config`.
4. Click `Connect`.

The portal stores these values in the browser's local storage, not in source code.

## Important

Before using the hosted portal, run `../supabase_schema.sql` in the Supabase SQL editor.

The schema currently enables Row Level Security. For production use, add Supabase Auth and policies for building-management users. During early testing, you can either add permissive temporary policies or keep the portal behind a private Vercel deployment.
