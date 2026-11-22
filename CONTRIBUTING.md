# Contributing to the μLearn app

Thanks for helping build the μLearn app. This guide covers how to set up, how
work flows from a branch to a release, and what a pull request needs to pass.
The binding rules for code live in [`docs/rules.md`](docs/rules.md); the
pipeline is described in [`docs/CI-CD.md`](docs/CI-CD.md).

## Before you start

- Read [`docs/rules.md`](docs/rules.md): the stack, architecture, naming,
  testing and design rules every change follows.
- Skim [`docs/mulearn-flutter-architecture.md`](docs/mulearn-flutter-architecture.md)
  for how features are laid out.
- For anything bigger than a small fix, open or comment on an issue first so
  nobody builds the same thing twice.

## Set up

You need Flutter **3.47.9** (the version CI pins) and, for Android, the
Android SDK.

```bash
git clone git@github.com:gtech-mulearn/mulearn-app.git
cd mulearn-app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --flavor dev -t lib/main_dev.dart
```

The **dev** flavor talks to `dev.mulearn.org` and needs nothing else. The
**prod** flavor needs a local `.env.prod`: copy `.env.example` and fill in
the production host. Never commit `.env.prod`, keystores, `key.properties` or
any account credentials.

## How work flows

```
feature/*  ──PR──►  dev  ──PR──►  staging  ──PR──►  master  ──tag vX.Y.Z──►  release
```

1. Branch from `dev`: `feature/<short-name>` or `fix/<short-name>`.
2. Commit in small steps with [Conventional Commits](https://www.conventionalcommits.org/):
   `feat(events): show the venue map`, `fix(profile): handle a missing photo`.
   Release notes are built from these subjects, so write them for a reader.
3. Open a pull request into `dev` (the default branch). CI validates it
   (format, analyze, test); `dev` needs that to pass and builds nothing.
4. `dev` is promoted to `staging` by PR for QA: PRs into `staging` also build
   the app, and every merge there produces the dev-flavor QA build.
5. `staging` is promoted to `master`; releases are tags on `master`
   (see [Creating a release](docs/CI-CD.md#creating-a-release)).

Don't push directly to, or force-push, `dev`, `staging` or `master`.

## What CI checks on every pull request

CI runs these, in order, and the PR can't merge until they pass. Run them
yourself first; each takes under a few minutes.

1. **Format of the files you changed.**

   ```bash
   bash .github/scripts/format_check.sh origin/dev
   ```

   Fix what it lists with `dart format <file> <file> …` at the **default
   width** (don't pass `--line-length`). Format the files you name, never a
   folder: formatting a folder rewrites generated `.g.dart` / `.freezed.dart`
   files. Generated files and files starting with `// GENERATED` are skipped.

   When a wrapped line turns `if (x) doThing();` into two lines, the
   analyzer then asks for braces (`curly_braces_in_flow_control_structures`):
   add them.

2. **Analyze, with zero issues.** Run it from the repo root so `test/` and
   `tool/` are included; infos fail it too.

   ```bash
   flutter analyze
   ```

3. **Tests.**

   ```bash
   flutter test
   ```

4. **An Android build** of the dev flavor (release mode, unsigned), on PRs
   into `staging` and `master`. Locally:

   ```bash
   flutter build apk --release --flavor dev -t lib/main_dev.dart
   ```

## Writing the change

- **Generated code is committed.** After changing a `@riverpod`, `@freezed`
  or `@JsonSerializable` class, run `dart run build_runner build
  --delete-conflicting-outputs` and commit the `.g.dart` / `.freezed.dart`
  files that changed with it.
- **Check the backend before the screen.** The API is the source of truth:
  confirm the endpoint, its fields and its permission rules in the backend
  code or a real response before building UI on them. Tests use recorded
  responses in `test/fixtures/dev/` (each carries a `_meta` block saying
  where it came from); if you invent a response because the server has no
  data yet, say so in the test.
- **Build UI from the design system** (`lib/core/design_system/`, imported
  via `design_system.dart`). Read colours and type through `context.mu`;
  never hardcode a colour, radius or spacing value. Every icon-only button
  needs a `tooltip`. Architecture tests enforce several of these.
- **Search fields** use `SearchDebouncer` (`lib/core/utils/search_debouncer.dart`),
  and lists keyed by a query keep recent results with `ref.keepRecent()`, so
  typing doesn't flood the server.
- **Tests come with features.** A new feature needs at least controller or
  widget tests for its main paths. Widget tests run at 360 dp and catch
  overflows.
- **No new dependency without asking.** If you need a package that isn't in
  [`docs/rules.md` §1](docs/rules.md), say why in the issue or PR first.
- No `print()`, no commented-out code, no secrets.

## Versions

The version lives only in `pubspec.yaml` (`version: MAJOR.MINOR.PATCH+BUILD`,
starting at `1.0.0+1`). Don't change it in a feature PR: it is bumped in its
own PR when a release is cut ([Versioning](docs/CI-CD.md#versioning)). The
installed version shows at the bottom of Settings, which is what to quote in
a bug report.

## Opening the pull request

- Base it on `dev`, keep it to one topic, and fill in:
  - **What** changed and **why** (link the issue);
  - **How you checked it**: tests added, and the screens you looked at on a
    device or emulator;
  - **Screenshots** (light and dark) for anything visible.
- Keep the PR green: if CI fails, the log says which step and, for
  formatting, the exact `dart format` command to run.
- A reviewer may ask for changes; push new commits rather than force-pushing
  over the review.

## Reporting a bug

Open an issue with the steps to reproduce, what you expected, what happened,
your device and Android/iOS version, and the app version from Settings
(tap it to copy).
