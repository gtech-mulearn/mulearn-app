# μLearn App

The official μLearn mobile app, built with Flutter. It's the mobile companion to the [mulearn-dashboard](https://github.com/gtech-mulearn/mulearn-dashboard) web app, talking to the same Django REST Framework backend.

## Features

**For every learner**

- **Auth** — email/password and OTP sign-in, registration (student/mentor/enabler flows), Google and Apple native sign-in, sign-out
- **Home** — this week's karma, the next circle meeting, shortcuts to everything below, featured events
- **Tasks** — find tasks by hashtag, interest group and level; task detail and submission
- **Profile** — view/edit own profile, karma history, Mu Voyage, achievements, badges, interest groups, socials, cover/profile photo, sharing, verifiable credentials
- **Public profiles** — read-only portfolios of members who made theirs public, and public campus pages
- **Search** — people, mentors and campuses, listed before you type and narrowed as you do
- **Leaderboard** — student and college leaderboards, all-time and monthly
- **Interest Groups** — discover, search and filter by category, join/leave (up to three)
- **Learning Circles** — browse/create/join circles, members, join requests, invites, meetings (create/edit/delete/RSVP/join-by-code), attendee and organizer reports, lead transfer
- **Events and calendar** — browse, filter, mark interest, register; a month view of events and sessions
- **Weekly Twitches** — Office Hours, Salt Mango Tree, Inspiration Station and Grab Your Superpowers episodes
- **Problem statements** — real problems from companies and μLearn: say you're trying one, submit a solution link
- **Projects** — explore, upvote and comment; publish your own with links, skills, screenshots and a team
- **Mentor sessions** — join open sessions, ask a mentor for one, rate the ones you attended
- **Internships & gigs** — jobs from verified companies; apply, track and withdraw applications
- **Notifications** — the in-app feed; tapping one opens the screen it's about

**Role workspaces** (for members who hold the role)

- **Mentor** — sessions, student requests, availability, attendance
- **Campus Lead** — campus overview with charts, students, groups, approvals
- **Enabler** — campuses and notes

The UI is built on the μLearn mobile design system in `lib/core/design_system/` (tokens, components and patterns; see [`docs/rules.md` §8](docs/rules.md)).

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

- Flutter SDK **3.47.9** (Dart 3.13.7), the version CI pins; the app requires Dart `^3.12.2`
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

### Check before a PR

The same checks CI runs:

```bash
bash .github/scripts/format_check.sh origin/dev   # format of the files you changed
flutter analyze                                    # zero issues, infos included
flutter test
```

Format with `dart format <files>` at the default width, naming files rather than folders (a folder format rewrites generated code).

### Builds and releases

Branches flow `dev` → `staging` → `master`. CI checks every PR (format of changed files, analyze, tests; PRs into `staging` and `master` also build the app). `dev` builds nothing; `staging` produces the dev-flavor QA build (`dev-latest`) and the nightly; `master` produces a signed stable APK; pushing a `vX.Y.Z` tag on `master` publishes a release. See [`docs/CI-CD.md`](docs/CI-CD.md).

### Versioning

The version lives only in `pubspec.yaml` as `MAJOR.MINOR.PATCH+BUILD`. It starts at **`1.0.0+1`**, the first release of the μLearn app. CI names each build from it (`1.0.0-dev.84` for a dev build, `1.0.0` for the tagged release) and the `+BUILD` number is the Android versionCode for releases. The installed version shows at the bottom of Settings. To cut a release, see [Creating a release](docs/CI-CD.md#creating-a-release).

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md): setup, the branch flow, what CI checks and how to open a pull request. [`docs/rules.md`](docs/rules.md) is the binding reference for stack choices, architecture, naming and testing.
