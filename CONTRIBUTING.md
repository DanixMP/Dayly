# Contributing to Dayly

Thanks for taking the time to improve Dayly.

Dayly is a private, local-first video diary. Please keep contributions aligned
with that spirit: calm UX, respectful defaults, no social-feed mechanics, and no
unnecessary data collection.

## Development Setup

```bash
flutter pub get
flutter gen-l10n
flutter analyze
flutter run -d android
```

## Pull Request Guidelines

- Keep changes focused and reviewable.
- Follow the existing feature structure under `lib/features/`.
- Use semantic app widgets from `lib/ui/app_widgets.dart` instead of importing a
  UI kit directly in feature screens.
- Keep new strings localized through the ARB files in `lib/l10n/`.
- Avoid committing generated build outputs, local device files, or signing keys.
- Test media, permission, and notification changes on a real Android device when
  possible.

## Design Principles

- Preserve privacy-first behavior.
- Prefer local storage unless a feature explicitly needs export/share behavior.
- Keep the interface cinematic, warm, and minimal.
- Add abstractions only when they match the existing architecture.

## Reporting Issues

When reporting a bug, please include:

- Device model and Android version.
- Whether it happened in debug or release mode.
- Steps to reproduce.
- Relevant logs, especially `adb logcat -s flutter` for startup or runtime
  failures.
