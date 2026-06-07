-- Teman Crita Supabase Schema
-- Paste this into the Supabase SQL editor for a clean initial schema.

create extension if not exists "pgcrypto";

-- =========================
-- Core user / auth tables
-- =========================

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null default 'user' check (role in ('user', 'admin', 'psychologist')),
  full_name text not null,
  avatar_url text,
  phone text,
  bio text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.settings (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  notification_enabled boolean not null default true,
  mood_reminder_enabled boolean not null default true,
  session_reminder_enabled boolean not null default true,
  payment_reminder_enabled boolean not null default true,
  followup_reminder_enabled boolean not null default true,
  crisis_alert_enabled boolean not null default true,
  privacy_mode_enabled boolean not null default false,
  language_pref text not null default 'id',
  theme_pref text not null default 'system',
  updated_at timestamptz not null default now()
);

-- =========================
-- Mobile app core
-- =========================

create table if not exists public.mood_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  mood_level smallint not null check (mood_level between 0 and 4),
  mood_label text not null,
  mood_note text,
  source text not null default 'manual',
  created_at timestamptz not null default now()
);

create table if not exists public.psychologists (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique references public.profiles(id) on delete set null,
  license_number text,
  specialty text not null,
  languages text[] not null default '{}'::text[],
  price integer not null default 0,
  rating numeric(3,2) not null default 0,
  experience_years smallint not null default 0,
  bio text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.psychologist_availability (
  id uuid primary key default gen_random_uuid(),
  psychologist_id uuid not null references public.psychologists(id) on delete cascade,
  day_of_week smallint not null check (day_of_week between 0 and 6),
  start_time time not null,
  end_time time not null,
  is_available boolean not null default true,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.favorite_psychologists (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  psychologist_id uuid not null references public.psychologists(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (user_id, psychologist_id)
);

create table if not exists public.bookings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  psychologist_id uuid not null references public.psychologists(id) on delete restrict,
  booking_type text not null default 'single' check (booking_type in ('single', 'bundle')),
  session_type text not null check (session_type in ('online', 'home_visit')),
  session_date date,
  session_time time,
  bundle_count smallint not null default 1,
  amount integer not null default 0,
  payment_method text,
  payment_status text not null default 'unpaid' check (
    payment_status in ('unpaid', 'method_selected', 'processing', 'pending', 'success', 'failed', 'expired', 'refunded')
  ),
  booking_status text not null default 'draft' check (
    booking_status in ('draft', 'pending_payment', 'confirmed', 'canceled', 'completed', 'expired')
  ),
  transaction_id text,
  provider_ref text,
  receipt_url text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.sessions (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid unique references public.bookings(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  psychologist_id uuid not null references public.psychologists(id) on delete restrict,
  session_type text not null check (session_type in ('trial', 'online', 'home_visit')),
  session_date date not null,
  session_time time not null,
  join_link text,
  status text not null default 'upcoming' check (
    status in ('upcoming', 'reminder_sent', 'ready_to_join', 'in_session', 'completed', 'rescheduled', 'canceled', 'no_show')
  ),
  reminder_status text not null default 'none',
  summary_note text,
  homework_note text,
  started_at timestamptz,
  ended_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.trial_chats (
  id uuid primary key default gen_random_uuid(),
  session_id uuid unique references public.sessions(id) on delete cascade,
  started_at timestamptz,
  ended_at timestamptz,
  remaining_seconds integer not null default 600,
  status text not null default 'active' check (status in ('active', 'warning', 'expired', 'completed')),
  created_at timestamptz not null default now()
);

create table if not exists public.session_notes (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references public.sessions(id) on delete cascade,
  psychologist_id uuid references public.profiles(id) on delete set null,
  summary_note text,
  homework_note text,
  mood_observation text,
  followup_note text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- =========================
-- Self-help features
-- =========================

create table if not exists public.journal_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  prompt_text text,
  content text,
  tags text[] not null default '{}'::text[],
  draft_status text not null default 'draft' check (draft_status in ('draft', 'saved', 'archived')),
  saved_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.breathing_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  pattern text not null,
  duration_seconds integer not null default 60,
  progress_percent smallint not null default 0 check (progress_percent between 0 and 100),
  completion_status text not null default 'idle' check (completion_status in ('idle', 'active', 'paused', 'completed')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.affirmations (
  id uuid primary key default gen_random_uuid(),
  text text not null,
  mood_tag text,
  is_default boolean not null default false,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.user_favorite_affirmations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  affirmation_id uuid not null references public.affirmations(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (user_id, affirmation_id)
);

create table if not exists public.companion_conversations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  mood_context text,
  status text not null default 'active' check (status in ('active', 'closed')),
  escalation_flag boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.companion_messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.companion_conversations(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  sender_role text not null check (sender_role in ('user', 'bot', 'system')),
  message_text text not null,
  quick_reply_data jsonb not null default '[]'::jsonb,
  escalation_flag boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.crisis_resources (
  id uuid primary key default gen_random_uuid(),
  resource_name text not null,
  hotline_number text,
  resource_type text not null check (resource_type in ('hotline', 'chat', 'emergency', 'hospital')),
  urgency_level smallint not null default 0 check (urgency_level between 0 and 3),
  description text,
  action_url text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- =========================
-- Dashboard / internal ops
-- =========================

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  notification_type text not null,
  title text not null,
  body text not null,
  target_screen text,
  schedule_time timestamptz,
  status text not null default 'scheduled' check (status in ('scheduled', 'sent', 'delivered', 'read', 'dismissed', 'failed')),
  priority smallint not null default 0,
  read_at timestamptz,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists public.content_prompts (
  id uuid primary key default gen_random_uuid(),
  prompt_type text not null check (prompt_type in ('affirmation', 'journal_prompt', 'quick_reply', 'onboarding_copy', 'faq')),
  text text not null,
  mood_tag text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.support_tickets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete set null,
  subject text not null,
  message text not null,
  status text not null default 'open' check (status in ('open', 'in_progress', 'resolved', 'closed')),
  priority text not null default 'medium' check (priority in ('low', 'medium', 'high', 'urgent')),
  assigned_to uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.payouts (
  id uuid primary key default gen_random_uuid(),
  psychologist_id uuid not null references public.psychologists(id) on delete cascade,
  period_start date not null,
  period_end date not null,
  gross_amount integer not null default 0,
  commission_amount integer not null default 0,
  net_amount integer not null default 0,
  status text not null default 'pending' check (status in ('pending', 'processing', 'paid', 'failed')),
  paid_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.analytics_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete set null,
  source text not null check (source in ('app', 'landing', 'dashboard')),
  event_name text not null,
  page text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

-- =========================
-- Landing page / lead capture
-- =========================

create table if not exists public.waitlist_leads (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null unique,
  role_interest text,
  source text,
  created_at timestamptz not null default now()
);

create table if not exists public.contact_inquiries (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  organization text,
  message text not null,
  inquiry_type text not null check (inquiry_type in ('partnership', 'support', 'press')),
  status text not null default 'new' check (status in ('new', 'in_review', 'replied', 'closed')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- =========================
-- Helpful indexes
-- =========================

create index if not exists idx_mood_entries_user_created_at on public.mood_entries (user_id, created_at desc);
create index if not exists idx_bookings_user_status on public.bookings (user_id, booking_status);
create index if not exists idx_bookings_psychologist_status on public.bookings (psychologist_id, booking_status);
create index if not exists idx_sessions_user_date on public.sessions (user_id, session_date);
create index if not exists idx_sessions_psychologist_date on public.sessions (psychologist_id, session_date);
create index if not exists idx_notifications_user_status on public.notifications (user_id, status);
create index if not exists idx_waitlist_email on public.waitlist_leads (email);
create index if not exists idx_support_tickets_status on public.support_tickets (status);
create index if not exists idx_analytics_events_source_created_at on public.analytics_events (source, created_at desc);

