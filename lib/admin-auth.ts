import { createHmac, timingSafeEqual } from "node:crypto";
import type { NextRequest } from "next/server";
export const COOKIE_NAME = "hepra_admin_session";
const MAX_AGE = 60 * 60 * 8;
function secret(){return process.env.ADMIN_SESSION_SECRET || "";}
function sign(value:string){return createHmac("sha256",secret()).update(value).digest("hex");}
export function makeSession(){const value=String(Date.now());return value+"."+sign(value);}
export function validSession(request:NextRequest){const key=secret();if(key.length<32)return false;const token=request.cookies.get(COOKIE_NAME)?.value||"";const [time,signature,...extra]=token.split(".");if(!time||!signature||extra.length||!/^\d+$/.test(time))return false;const issued=Number(time);if(!Number.isFinite(issued)||Date.now()-issued>MAX_AGE*1000||issued>Date.now()+60_000)return false;const expected=sign(time);const a=Buffer.from(signature);const b=Buffer.from(expected);return a.length===b.length&&timingSafeEqual(a,b);}
export function passwordMatches(input:string){const expected=process.env.ADMIN_PASSWORD||"";if(expected.length<16||!input)return false;const a=Buffer.from(input);const b=Buffer.from(expected);return a.length===b.length&&timingSafeEqual(a,b);}
export function secureCookieOptions(){return {httpOnly:true,secure:process.env.NODE_ENV==="production",sameSite:"strict" as const,path:"/",maxAge:MAX_AGE};}
export function adminConfigured(){return Boolean(process.env.ADMIN_PASSWORD&&process.env.ADMIN_PASSWORD.length>=16&&secret().length>=32&&process.env.SUPABASE_URL&&process.env.SUPABASE_SERVICE_ROLE_KEY);}
