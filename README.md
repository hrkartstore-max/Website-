# HEPRA Website Demo & Booking Platform

Responsive showcase for Shopify and WordPress website concepts, pricing plans, demo preview and WhatsApp enquiry.

## Features
- Responsive home page and demo catalog with search/category/platform filters
- Live demo preview modal; if a real demo URL is configured in Admin, the Live Demo button opens that URL
- Shopify plan: ₹999 / 3 months; domain not included
- WordPress plan: ₹4,999 / year; includes one-year eligible domain
- Booking form that prepares a WhatsApp enquiry
- Admin prototype at `/admin` to edit demo title, category, platform, price, badge, description, tile/banner image URLs and live website links
- Import/export catalog JSON for moving a catalog between browsers

## Run locally
```bash
npm install
npm run dev
```

## Environment variables
Set `NEXT_PUBLIC_WHATSAPP_NUMBER` to your WhatsApp number with country code and digits only, e.g. `919876543210`. Optional: `NEXT_PUBLIC_SITE_URL` for metadata canonical base.

## Admin persistence limitation
The current `/admin` is a prototype that saves catalog changes in the current browser's local storage. The public catalog can read those changes only in that same browser. It is NOT a shared production CMS and is not protected by server-side authentication. For changes to appear to all visitors and for secure admin access, connect a database (for example Supabase) and implement authenticated server-side admin operations before launch.

## Pricing notes
Plan pricing and included scope are displayed as requested, but payment/shipping integration availability depends on provider accounts and approvals. Shopify subscription charges, hosting, premium plugins/apps, domain renewals, transaction charges and other third-party fees may apply. Confirm final scope and costs with the customer before accepting payment.

## Deploy on Vercel
Import this repository into Vercel with the Next.js preset. Configure environment variables in Project Settings and redeploy after changes.
