-- Copy this file into Supabase Dashboard > SQL Editor and run it yourself.
-- It creates or completes the tables used by Home, My Courses, and Course Videos.
-- It does not insert courses, videos, enrollments, or Storage files.

begin;

create table if not exists public.courses (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text not null default '',
  price numeric(10, 2) not null default 0 check (price >= 0),
  image_url text,
  created_at timestamptz not null default now()
);

create table if not exists public.enrollments (
  user_id uuid not null references auth.users(id) on delete cascade,
  course_id uuid not null references public.courses(id) on delete cascade,
  enrolled_at timestamptz not null default now(),
  primary key (user_id, course_id)
);

create table if not exists public.course_videos (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references public.courses(id) on delete cascade,
  title text not null,
  description text not null default '',
  video_path text not null,
  thumbnail_url text,
  position integer not null default 1 check (position > 0),
  created_at timestamptz not null default now()
);

-- These statements also complete an earlier course_videos table if it exists.
alter table public.course_videos
  add column if not exists description text not null default '';
alter table public.course_videos
  add column if not exists thumbnail_url text;

create index if not exists courses_created_at_idx
  on public.courses(created_at desc, id);
create index if not exists enrollments_course_id_idx
  on public.enrollments(course_id);
create unique index if not exists course_videos_course_position_idx
  on public.course_videos(course_id, position);

alter table public.courses enable row level security;
alter table public.enrollments enable row level security;
alter table public.course_videos enable row level security;

revoke all on table public.courses from anon, authenticated;
revoke all on table public.enrollments from anon, authenticated;
revoke all on table public.course_videos from anon, authenticated;

grant usage on schema public to authenticated;
grant select on table public.courses to authenticated;
grant select, insert on table public.enrollments to authenticated;
grant select on table public.course_videos to authenticated;

drop policy if exists "Signed-in users can read published courses"
  on public.courses;
drop policy if exists "Signed-in users can read courses"
  on public.courses;
create policy "Signed-in users can read courses"
  on public.courses
  for select
  to authenticated
  using (true);

drop policy if exists "Users can read their enrollments"
  on public.enrollments;
create policy "Users can read their enrollments"
  on public.enrollments
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can start courses"
  on public.enrollments;
create policy "Users can start courses"
  on public.enrollments
  for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Enrolled users can read course videos"
  on public.course_videos;
create policy "Enrolled users can read course videos"
  on public.course_videos
  for select
  to authenticated
  using (
    exists (
      select 1
      from public.enrollments enrollment
      where enrollment.user_id = (select auth.uid())
        and enrollment.course_id = course_videos.course_id
    )
  );

-- Create a PRIVATE Storage bucket named course-videos in the Dashboard first.
-- Every video object path must begin with its course UUID:
-- <course_id>/<file_name>.mp4
drop policy if exists "Enrolled users can stream course video files"
  on storage.objects;
create policy "Enrolled users can stream course video files"
  on storage.objects
  for select
  to authenticated
  using (
    bucket_id = 'course-videos'
    and exists (
      select 1
      from public.enrollments enrollment
      where enrollment.user_id = (select auth.uid())
        and enrollment.course_id::text = (storage.foldername(name))[1]
    )
  );

commit;

-- The app no longer reads currency or is_published.
-- If an older courses table already contains them, leaving them is harmless.
-- Remove them later from Table Editor only if you are sure you do not need them.
