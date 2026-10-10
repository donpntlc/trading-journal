-- Trading-Journal: Datenbank einrichten (einmal im Supabase SQL Editor ausführen)
create table public.trades (
  id text primary key default gen_random_uuid()::text,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  date date,
  acct text,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create index trades_user_date on public.trades(user_id, date);

create table public.days (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  date date not null,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, date)
);

create table public.settings (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  key text not null,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, key)
);

alter table public.trades enable row level security;
alter table public.days enable row level security;
alter table public.settings enable row level security;

create policy "own trades" on public.trades for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "own days" on public.days for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "own settings" on public.settings for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));

create or replace function public.touch_updated_at() returns trigger
language plpgsql set search_path = '' as $$
begin new.updated_at = now(); return new; end; $$;
create trigger trades_touch before update on public.trades for each row execute function public.touch_updated_at();
create trigger days_touch before update on public.days for each row execute function public.touch_updated_at();
create trigger settings_touch before update on public.settings for each row execute function public.touch_updated_at();

alter publication supabase_realtime add table public.trades, public.days, public.settings;

-- Screenshots: lesbar per zufälligem Link, Schreiben/Löschen nur im eigenen Ordner
insert into storage.buckets (id, name, public) values ('shots', 'shots', true) on conflict do nothing;
create policy "own shots read" on storage.objects for select to authenticated
  using (bucket_id = 'shots' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "own shots write" on storage.objects for insert to authenticated
  with check (bucket_id = 'shots' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "own shots delete" on storage.objects for delete to authenticated
  using (bucket_id = 'shots' and (storage.foldername(name))[1] = (select auth.uid())::text);
