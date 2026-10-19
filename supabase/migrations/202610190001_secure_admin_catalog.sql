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
-- No direct client writes to this bucket. Uploads go through the authenticated server API.
drop policy if exists "No direct client upload to demo images" on storage.objects;
create policy "No direct client upload to demo images" on storage.objects for insert to anon, authenticated with check (bucket_id <> 'demo-images');
