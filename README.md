# HEPRA Website Demo & Booking Platform

A responsive showcase for Shopify and WordPress demo websites. Visitors can browse demos and send an enquiry through WhatsApp.

## Stack
- Next.js App Router
- TypeScript
- CSS
- WhatsApp click-to-chat booking flow

## Run locally
```bash
npm install
npm run dev
```

## Configure WhatsApp
Set `NEXT_PUBLIC_WHATSAPP_NUMBER` to your WhatsApp number with country code and no plus sign, for example `919876543210`. This can be configured in Vercel Project Settings → Environment Variables. Without it, the site uses the demo placeholder number.

## Deploy
Import this repository into Vercel. Framework preset: Next.js. Build command: `npm run build`.

Note: click-to-chat opens WhatsApp with a prefilled enquiry; the visitor must press Send. For automatic messages without client action, integrate the official WhatsApp Business Platform/API on a secure backend.
