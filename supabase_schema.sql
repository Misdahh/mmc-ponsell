-- MMC PONSEL production schema
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  email text,
  phone text,
  created_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  brand text not null,
  condition text not null check (condition in ('baru','bekas','rusak')),
  price bigint not null check (price >= 0),
  description text,
  image_url text,
  status text not null default 'active' check (status in ('active','sold','inactive')),
  created_at timestamptz not null default now()
);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  type text not null check (type in ('Beli HP','Service Miss Cell')),
  items jsonb default '[]'::jsonb,
  service text,
  customer_name text,
  customer_phone text,
  notes text,
  total bigint,
  status text not null default 'Menunggu konfirmasi',
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.products enable row level security;
alter table public.orders enable row level security;

create policy "profiles own read" on public.profiles for select using (auth.uid()=id);
create policy "profiles own insert" on public.profiles for insert with check (auth.uid()=id);
create policy "profiles own update" on public.profiles for update using (auth.uid()=id);

create policy "products public read active" on public.products for select using (status='active' or auth.uid()=seller_id);
create policy "products own insert" on public.products for insert with check (auth.uid()=seller_id);
create policy "products own update" on public.products for update using (auth.uid()=seller_id);
create policy "products own delete" on public.products for delete using (auth.uid()=seller_id);

create policy "orders own read" on public.orders for select using (auth.uid()=user_id);
create policy "orders own insert" on public.orders for insert with check (auth.uid()=user_id);
create policy "orders own update" on public.orders for update using (auth.uid()=user_id);

insert into storage.buckets (id, name, public) values ('product-images','product-images',true)
on conflict (id) do nothing;

create policy "product images public read" on storage.objects for select
using (bucket_id='product-images');

create policy "product images own upload" on storage.objects for insert
with check (bucket_id='product-images' and auth.uid()::text = (storage.foldername(name))[1]);

create policy "product images own update" on storage.objects for update
using (bucket_id='product-images' and auth.uid()::text = (storage.foldername(name))[1]);

create policy "product images own delete" on storage.objects for delete
using (bucket_id='product-images' and auth.uid()::text = (storage.foldername(name))[1]);

-- Optional trigger to create a profile automatically.
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path=public as $$
begin
  insert into public.profiles (id, full_name, email)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name',''), new.email)
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
for each row execute procedure public.handle_new_user();
