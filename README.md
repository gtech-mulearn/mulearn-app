# μLearn App

The official μLearn mobile app, built with Flutter. It's the mobile companion to the [mulearn-dashboard](https://github.com/gtech-mulearn/mulearn-dashboard) web app, talking to the same Django REST Framework backend.

## Features

- **Auth** — email/password and OTP sign-in, registration (student/mentor/enabler flows), Google and Apple native sign-in, sign-out
- **Profile** — view/edit own profile, karma history, Mu Voyage, achievements, badges, interest groups, socials, cover/profile photo upload
- **Public profiles** — read-only view of another user's profile
- **Home dashboard** — karma feed, level/progress summary, featured events
- **Leaderboard** — student and college leaderboards, all-time and monthly
- **Search** — find users and mentors by name or MUID
- **Interest Groups** — browse the catalog, view group detail, join/leave
- **Events** — browse, view detail, mark interest/RSVP
- **Calendar** — unified month-grid view of events and learning-circle sessions
- **Learning Circles** — full management: browse/create/join circles, members, join requests, invites (send/receive/accept/reject), meetings (create/edit/delete/RSVP/join-by-code), attendee and organizer meeting reports, lead transfer

## Tech stack

| Layer | Choice |
|---|---|
| State management | [Riverpod 3.0](https://riverpod.dev/) with code generation (`@riverpod`) |
| Routing | [go_router](https://pub.dev/packages/go_router) |
| Models | [Freezed](https://pub.dev/packages/freezed) + [json_serializable](https://pub.dev/packages/json_serializable) |
| Networking | [Dio](https://pub.dev/packages/dio) + [dio_cache_interceptor](https://pub.dev/packages/dio_cache_interceptor) |
| Env config | [envied](https://pub.dev/packages/envied) (never `flutter_dotenv`) |
| Secure storage | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) (tokens only) |
| Backend | Django REST Framework + SimpleJWT |

## Architecture

Feature-first Clean Architecture:

```
lib/
├── core/           # shared across all features — features never import each other directly
└── features/
    └── <feature>/
        ├── data/           # DTOs, remote datasources, repository implementations
        ├── domain/         # pure Dart entities, abstract repository contracts
        └── presentation/   # Riverpod controllers, screens, feature-local widgets
```

See [`docs/mulearn-flutter-architecture.md`](docs/mulearn-flutter-architecture.md) for the full architecture writeup and [`docs/rules.md`](docs/rules.md) for the binding project conventions — read this before contributing.

## Getting started

### Prerequisites

- Flutter SDK (Dart `^3.12.2`)
- For iOS: Xcode + CocoaPods
- For Android: Android SDK (`sdk.dir` in `android/local.properties`)

### Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Environment flavors

The app ships two flavors, each with its own env file baked in at build time via `envied`:

- **dev** → `dev.mulearn.org` (`.env.dev`, committed — no secrets, just the host)
- **prod** → `mulearn.org` (`.env.prod`, not committed — provide locally or via CI)

Copy `.env.example` to `.env.prod` and fill in the production API host before running/building that flavor.

### Run

```bash
# Dev flavor
flutter run --flavor dev -t lib/main_dev.dart

# Prod flavor
flutter run --flavor prod -t lib/main_prod.dart
```

### Test

```bash
flutter analyze
flutter test
```

## Contributing

Read [`docs/rules.md`](docs/rules.md) first — it's the binding reference for stack choices, architecture, naming conventions, and testing expectations for this codebase. `flutter analyze` must pass with zero issues and `flutter test` must pass before opening a PR.
