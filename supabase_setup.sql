-- SK. Arshan Alif portfolio: Supabase setup
-- Run this in Supabase Dashboard > SQL Editor.
-- IMPORTANT: after creating your admin account in Authentication > Users,
-- copy its UUID and replace YOUR_ADMIN_AUTH_USER_UUID below.

create table if not exists public.portfolio_content (
  id bigint primary key check (id = 1),
  content jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.portfolio_content enable row level security;

drop policy if exists "Public can view portfolio" on public.portfolio_content;
create policy "Public can view portfolio"
on public.portfolio_content for select
to anon, authenticated
using (true);

drop policy if exists "Only owner can insert portfolio" on public.portfolio_content;
create policy "Only owner can insert portfolio"
on public.portfolio_content for insert
to authenticated
with check (auth.uid() = 'YOUR_ADMIN_AUTH_USER_UUID'::uuid);

drop policy if exists "Only owner can update portfolio" on public.portfolio_content;
create policy "Only owner can update portfolio"
on public.portfolio_content for update
to authenticated
using (auth.uid() = 'YOUR_ADMIN_AUTH_USER_UUID'::uuid)
with check (auth.uid() = 'YOUR_ADMIN_AUTH_USER_UUID'::uuid);

-- Storage bucket for profile photos. Public read is required so visitors can see the photo.
insert into storage.buckets (id, name, public)
values ('portfolio-photos', 'portfolio-photos', true)
on conflict (id) do update set public = true;

drop policy if exists "Public can view portfolio photos" on storage.objects;
create policy "Public can view portfolio photos"
on storage.objects for select
to anon, authenticated
using (bucket_id = 'portfolio-photos');

drop policy if exists "Only owner can upload portfolio photos" on storage.objects;
create policy "Only owner can upload portfolio photos"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'portfolio-photos'
  and auth.uid() = 'YOUR_ADMIN_AUTH_USER_UUID'::uuid
);

drop policy if exists "Only owner can update portfolio photos" on storage.objects;
create policy "Only owner can update portfolio photos"
on storage.objects for update
to authenticated
using (
  bucket_id = 'portfolio-photos'
  and auth.uid() = 'YOUR_ADMIN_AUTH_USER_UUID'::uuid
)
with check (
  bucket_id = 'portfolio-photos'
  and auth.uid() = 'YOUR_ADMIN_AUTH_USER_UUID'::uuid
);

-- Initial row for the public site. Edit from admin.html after setup.
insert into public.portfolio_content (id, content)
values (1, jsonb_build_object(
  'about', 'I am an Electrical & Electronic Engineering student/graduate interested in technology, research, innovation, and practical problem-solving.',
  'focus', 'Engineering & technology',
  'location', 'Bangladesh',
  'degree', 'B.Sc. in EEE',
  'eduDegree', 'B.Sc. Degree',
  'eduTitle', 'B.Sc. in Electrical & Electronic Engineering',
  'eduPlace', 'East West University · Bangladesh',
  'eduDetails', 'Add your official dates and CGPA',
  'github', 'https://github.com/',
  'linkedin', 'https://linkedin.com/',
  'email', '',
  'skills', jsonb_build_array('MATLAB','C / C++','Proteus','Microcontrollers','Circuit Design','Simulink'),
  'projects', jsonb_build_array(
    jsonb_build_object('title','PIC16F690 Countdown Timer','description','A microcontroller-based timer with LCD display and button/keypad control.','tags',jsonb_build_array('C','PIC16F690','Proteus')),
    jsonb_build_object('title','Power System Analysis','description','Coursework involving transmission-line parameters and power-flow analysis.','tags',jsonb_build_array('Power Systems'))
  )
))
on conflict (id) do nothing;
