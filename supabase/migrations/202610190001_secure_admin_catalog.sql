create extension if not exists pgcrypto;
create table if not exists public.website_demos (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null,
  platform text not null check (platform in ('Shopify','WordPress')),
  price text not null default '',
  tag text not null default 'New',
  style text not null default 'business',
  description text not null default '',
  banner_image_url text,
  tile_image_url text,
  website_link text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.website_demos enable row level security;
revoke all on public.website_demos from anon, authenticated;
-- App server uses the service-role key only on the server. Never expose it as NEXT_PUBLIC_*.
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('demo-images','demo-images',true,5242880,array['image/jpeg','image/png','image/webp','image/avif'])
on conflict (id) do update set public=true,file_size_limit=5242880,allowed_mime_types=array['image/jpeg','image/png','image/webp','image/avif'];
-- Restrictive policies prevent direct browser writes to this bucket even if other permissive policies exist.
drop policy if exists "No direct client upload to demo images" on storage.objects;
drop policy if exists "Protect demo images from client inserts" on storage.objects;
drop policy if exists "Protect demo images from client updates" on storage.objects;
drop policy if exists "Protect demo images from client deletes" on storage.objects;
create policy "Protect demo images from client inserts" on storage.objects as restrictive for insert to anon, authenticated with check (bucket_id <> 'demo-images');
create policy "Protect demo images from client updates" on storage.objects as restrictive for update to anon, authenticated using (bucket_id <> 'demo-images') with check (bucket_id <> 'demo-images');
create policy "Protect demo images from client deletes" on storage.objects as restrictive for delete to anon, authenticated using (bucket_id <> 'demo-images');

insert into public.website_demos (title,category,platform,price,tag,style,description)
values
('Fashion Boutique','Fashion','Shopify','₹999 / 3 months','Popular','fashion','Elegant storefront for clothing and accessories.'),
('Optical Store','Optical','Shopify','₹999 / 3 months','Made for retail','optical','Showcase frames, lenses and eye-care services.'),
('Restaurant & Cafe','Restaurant','WordPress','₹4,999 / year','Food & drink','food','A delicious digital home for your menu and orders.'),
('Beauty & Salon','Salon','WordPress','₹4,999 / year','Trending','beauty','Premium service pages and appointment enquiries.'),
('Electronics Store','Electronics','Shopify','₹999 / 3 months','Ecommerce','tech','A clean product-led shop for gadgets and devices.'),
('Business Agency','Business','WordPress','₹4,999 / year','Professional','business','Build trust with a polished service-business website.'),
('Home Decor','Home & Living','Shopify','₹999 / 3 months','Lifestyle','home','Beautiful layouts for homeware and furniture.'),
('Clinic Website','Clinic','WordPress','₹4,999 / year','Healthcare','clinic','Clear service information and appointment enquiries.'),
('Kids & Toys','Kids','Shopify','₹999 / 3 months','Colourful','kids','A playful online store for toys and kids products.'),
('Real Estate','Real Estate','WordPress','₹4,999 / year','Property','estate','Present properties and collect buyer enquiries.'),
('Fitness Studio','Fitness','WordPress','₹4,999 / year','Wellness','fitness','Promote memberships, trainers and classes.'),
('Jewellery Store','Jewellery','Shopify','₹999 / 3 months','Premium','jewellery','A refined storefront for jewellery and gifting.')
on conflict do nothing;
