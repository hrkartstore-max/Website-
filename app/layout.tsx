import type { Metadata } from "next";
import "./globals.css";
export const metadata: Metadata = { title: "HEPRA | Website Demos for Your Business", description: "Explore ready-made Shopify and WordPress website demos and book the one you love." };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="en"><body>{children}</body></html>; }
