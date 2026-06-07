# TemanCrita MVP Revenue Implementation Plan

## Sprint 1 - Foundation

- Replace Flutter counter app with TemanCrita shell.
- Add theme tokens and reusable card/button/input widgets.
- Add domain models for mood, matching request, psychologist, trial session, and booking.
- Add smoke tests for onboarding/login and unit tests for MVP state rules.

## Sprint 2 - Core User Flow

- Implement onboarding and auth placeholder ready for Supabase Auth.
- Implement dashboard with mood check-in and session CTA.
- Implement bottom navigation with Home, Eksplor, Curhat AI, Mood, Profil.

## Sprint 3 - Matching And Marketplace

- Implement matching input with max-three-tag validation.
- Implement recommendation list from repository.
- Implement psychologist cards and detail screen.

## Sprint 4 - Revenue Flow

- Implement trial chat timer and expired upsell.
- Implement booking summary, single-session and bundle selection.
- Implement payment method selection and success state.
- Preserve server-side payment boundary for future Midtrans Edge Function.

## Definition Of Done

- `flutter analyze` has no errors.
- `flutter test` passes.
- User can manually complete onboarding -> login -> matching -> detail -> booking -> payment success.
