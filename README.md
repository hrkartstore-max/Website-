# HEPRA Website Demo & Booking Platform

Next.js website catalogue for Shopify and WordPress website services, with secure admin access, image uploads, shared database storage, live demo links and WhatsApp enquiries.

## Customer-facing plans
- Shopify website: ₹999 / 3 months; domain not included. Payment and shipping integration setup depend on provider support and account approval. Shopify subscription and third-party charges may apply.
- WordPress website: ₹4,999 / year; one-year eligible domain included, payment integration and shipping integration where applicable. Hosting, renewals and provider fees must be confirmed.

## Secure admin features
- Admin sign-in protected by a server-verified signed, HttpOnly, SameSite=Strict cookie
- 8-hour session; password and session secret are server-only environment variables
- Create, edit and delete demo listings in shared Supabase Postgres
- Upload banner and tile images from a device (JPG, PNG, WebP, AVIF; maximum 5 MB each)
- Configure actual live demo URL, description, platform, badge and display price
- Public catalogue fetches shared database records, so published changes are visible to all visitors

## Required Vercel environment variables
Copy the values from `.env.example` into Vercel → Project → Settings → Environment Variables. Generate your own strong random secrets. Never commit real secrets, and never expose `SUPABASE_SERVICE_ROLE_KEY` with a `NEXT_PUBLIC_` prefix.

- `ADMIN_PASSWORD`: strong admin password, minimum 16 characters
- `ADMIN_SESSION_SECRET`: random secret, minimum 32 characters
- `SUPABASE_URL`: active Supabase project URL
- `SUPABASE_SERVICE_ROLE_KEY`: server-only service role key from the same Supabase project
- `NEXT_PUBLIC_WHATSAPP_NUMBER`: WhatsApp number with country code and digits only
- `NEXT_PUBLIC_SITE_URL`: public site URL

## Database and image storage setup
1. Use an active Supabase project and add the server environment variables in Vercel.
2. Run `supabase/migrations/202610190001_secure_admin_catalog.sql` in that project's SQL editor (or apply it using your migration workflow). It creates the catalogue table and the `demo-images` Storage bucket.
3. Redeploy the Vercel project.
4. Open `/admin`, sign in, upload a test image, create a test listing and verify it appears on the public site.

## Local development
```bash
npm install
npm run dev
```

## Security notes
- The Supabase service role key is used only in server-side API routes and bypasses Row Level Security. Do not leak it to client-side code.
- The app rejects unauthenticated catalogue writes and image uploads. Image uploads are type-limited and capped at 5 MB.
- This is a single-admin password/session model, not a multi-user role management system. Use a unique long password and rotate secrets if exposed.
- Before production launch, add rate limiting at the edge/WAF, audit logs, monitoring, backups and a tested recovery procedure.
- Payment and shipping integrations depend on provider accounts, permissions, transaction fees and supported plans; the website setup does not automatically create those provider accounts.

## Deploy
Import this repository into Vercel using the Next.js preset. Configure the environment variables and Supabase schema before expecting the admin catalogue and image uploads to work.
