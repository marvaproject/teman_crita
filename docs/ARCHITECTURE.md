# TemanCrita Flutter MVP Architecture

## Current Implementation

The app is a Flutter Material 3 MVP with no new external dependencies yet, because the local Dart VM is currently crashing before test execution. The code keeps domain logic in `lib/core/models`, demo data in `lib/core/data`, theme tokens in `lib/core/theme`, and the first MVP UI in `lib/main.dart`.

## Target Architecture

- `core/theme`: colors, typography helpers, and card decorations.
- `core/models`: mood, matching request, psychologist, trial session, and booking/payment state.
- `core/data`: repository boundary for psychologists, matching, bookings, and future Supabase calls.
- `features`: split UI into auth, dashboard, matching, marketplace, trial chat, booking, and profile as the code grows.

## Supabase Boundary

Supabase is the production source for auth, profiles, mood entries, psychologists, bookings, sessions, and payment status. Flutter should read and write through repository classes. Payment creation must call a server-side Supabase Edge Function so Midtrans server keys never ship in the app.

## Payment Boundary

Flutter may collect booking choice and payment method. It must not create Midtrans transactions directly. The client sends booking data to an Edge Function, receives a transaction reference or redirect token, then refreshes booking status from Supabase.
