create table if not exists public.tasks (
  id text primary key,
  user_id uuid not null references auth.users (id) on delete cascade default auth.uid(),
  title text not null check (char_length(trim(title)) between 1 and 160),
  done boolean not null default false,
  created_at timestamptz not null default now(),
  due_at timestamptz,
  reminded boolean not null default false,
  notes text not null default '',
  color text check (color is null or color in ('yellow', 'mint', 'rose', 'peach', 'sky', 'lilac'))
);

create index if not exists tasks_user_created_at_idx
  on public.tasks (user_id, created_at desc);

alter table public.tasks enable row level security;

drop policy if exists "Users can manage their own tasks" on public.tasks;
create policy "Users can manage their own tasks"
  on public.tasks
  for all
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

grant select, insert, update, delete on public.tasks to authenticated;
