import { NextResponse } from "next/server";

export const dynamic = "force-dynamic";

export async function GET() {
  const checks = {
    ADMIN_PASSWORD: Boolean(process.env.ADMIN_PASSWORD && process.env.ADMIN_PASSWORD.length >= 16),
    ADMIN_SESSION_SECRET: Boolean(process.env.ADMIN_SESSION_SECRET && process.env.ADMIN_SESSION_SECRET.length >= 32),
    SUPABASE_URL: Boolean(process.env.SUPABASE_URL && /^https:\/\//.test(process.env.SUPABASE_URL)),
    SUPABASE_SERVICE_ROLE_KEY: Boolean(process.env.SUPABASE_SERVICE_ROLE_KEY && process.env.SUPABASE_SERVICE_ROLE_KEY.length > 20),
  };
  const missing = Object.entries(checks).filter(([, ok]) => !ok).map(([name]) => name);
  return NextResponse.json(
    { configured: missing.length === 0, checks, missing },
    { headers: { "Cache-Control": "no-store, max-age=0" } },
  );
}
