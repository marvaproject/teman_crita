# TemanCrita Working Context

## Current State

- Workspace root `System` contains business/system docs.
- Flutter source lives in sibling folder `../teman_crita`.
- The source started as the default Flutter counter app.
- MVP domain models, demo repository, theme token file, app shell, core screens, and tests have been added.

## Decisions

- Initial scope: MVP revenue.
- Backend target: Supabase directly, with payment via server-side function.
- Current implementation uses a local repository/demo data so UI and domain flow can run before Supabase credentials are available.
- Midtrans must be integrated through Supabase Edge Functions, not from Flutter client code.

## Risks

- Local Flutter/Dart command currently crashes in `runtime/vm/cpuinfo_macos.cc` before tests run.
- `../teman_crita` is not a git repository, so branch/worktree workflow cannot be applied.
- Supabase credentials and Edge Function endpoint are not present yet.

## Next Steps

- Fix local Flutter SDK/runtime issue, then run `flutter analyze` and `flutter test`.
- Add real Supabase dependencies and repository implementations once `flutter pub get` is usable.
- Split `lib/main.dart` into feature folders after verification is working.
