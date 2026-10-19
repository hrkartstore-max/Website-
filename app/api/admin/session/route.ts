import { NextRequest,NextResponse } from "next/server";
import { adminConfigured, validSession } from "@/lib/admin-auth";
export async function GET(request:NextRequest){return NextResponse.json({configured:adminConfigured(),authenticated:adminConfigured()&&validSession(request)});}
