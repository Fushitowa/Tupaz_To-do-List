# Supabase setup

1. In the Supabase dashboard for this project, open **SQL Editor** and run `migrations/20261025000000_create_tasks.sql`.
2. In **Authentication → Sign In / Providers**, enable **Allow anonymous sign-ins**. The app uses an anonymous Auth user so row-level security can keep each browser's tasks private.
3. Restart the Vite dev server after changing `.env.local`.

The browser key in `.env.local` is a publishable key. Never put a `service_role` or secret key in a `VITE_` variable.

Anonymous accounts are tied to this browser's saved session. Clearing site data or using another browser/device creates a different user; tasks do not transfer between them without adding an account sign-in flow.
