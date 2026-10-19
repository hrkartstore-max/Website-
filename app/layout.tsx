import type { Metadata, Viewport } from "next";
import "./globals.css";
export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || "https://hepra.in"),
  title: { default: "HEPRA — Website Demos for Your Business", template: "%s | HEPRA" },
  description: "Explore business-ready Shopify and WordPress website concepts. Choose a demo, tell us about your business, and book a website discussion with HEPRA.",
  applicationName: "HEPRA",
  keywords: ["website design", "Shopify website", "WordPress website", "business website", "website demo", "HEPRA"],
  openGraph: { title: "HEPRA — Website Demos for Your Business", description: "Find a website style that fits your business. Browse demos and enquire with HEPRA.", type: "website", siteName: "HEPRA" },
  robots: { index: true, follow: true }
};
export const viewport: Viewport = { width: "device-width", initialScale: 1, themeColor: "#d87858" };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="en"><body>{children}</body></html>; }
