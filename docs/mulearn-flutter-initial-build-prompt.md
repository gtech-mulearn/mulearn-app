# Prompt: Scaffold the μLearn Flutter App — Initial Build (Auth + Profile)

Use this as the initial instruction to an AI coding agent (Claude Code or similar). It assumes the architecture doc (`mulearn-flutter-architecture.md`) has already been agreed on. This build covers **only** login and a basic profile screen — everything else is out of scope for this pass.

---

## Context to give the agent

You are scaffolding a new Flutter app for μLearn. The backend is Django REST Framework, deployed, with SimpleJWT auth and a drf-spectacular OpenAPI schema (attached as `mulearn-openapi.yaml`). Follow the architecture already decided:

- **State management:** Riverpod 3.0 with code-gen (`@riverpod` annotations)
- **Routing:** go_router, with `redirect` reading auth state from a Riverpod provider
- **Env config:** envied (not flutter_dotenv) — type-safe, build-time
- **Networking:** Dio, with a cache interceptor (`dio_cache_interceptor`) placed *before* the auth interceptor in the chain
- **Models:** Freezed + json_serializable, immutable domain entities separate from API DTOs
- **Architecture:** feature-first Clean Architecture — `data/ → domain/ → presentation/` per feature, `core/` shared beneath all features, features never import each other directly
- **Storage:** flutter_secure_storage for tokens

Scope for this build: **project scaffolding + auth (login only, no registration) + a read-only profile screen.** Do not build registration, password reset, social account linking, or any dashboard features beyond profile — those come later.

---

## 1. Project scaffolding

1. `flutter create` a new project. Confirm package name / bundle ID with me before generating — do not assume `com.mulearn.app`; ask if not specified.
2. Set up **flavors** for `dev` and `prod` from the start (`main_dev.dart`, `main_prod.dart`, `bootstrap.dart` shared init), even though we'll only actually point at one backend URL right now. Ask me for the dev and prod API base URLs before wiring envied — don't invent a placeholder that looks real (like `api.mulearn.org`) since that could get committed and confused for the actual value later.
3. Add dependencies per the architecture doc:
   ```yaml
   dependencies:
     flutter_riverpod: ^3.0.0
     riverpod_annotation: ^3.0.0
     go_router: ^15.0.0
     dio: ^5.7.0
     dio_cache_interceptor: ^3.5.1
     dio_cache_interceptor_hive_store: ^3.2.2
     freezed_annotation: ^2.4.4
     json_annotation: ^4.9.0
     envied: ^0.5.4
     flutter_secure_storage: ^9.2.2
     cached_network_image: ^3.4.1
     google_fonts: ^6.2.1

   dev_dependencies:
     build_runner: ^2.4.13
     riverpod_generator: ^3.0.0
     freezed: ^2.5.7
     json_serializable: ^6.8.0
     envied_generator: ^0.5.4
     mocktail: ^1.0.4
     very_good_analysis: ^6.0.0
   ```
   Check pub.dev for whatever the actual current versions are at build time rather than trusting these numbers verbatim — pin what's current.
4. Set up the folder structure from the architecture doc:
   ```
   lib/
   ├── main.dart
   ├── main_dev.dart / main_prod.dart
   ├── bootstrap.dart
   ├── core/
   │   ├── config/        (env.dart, flavor_config.dart)
   │   ├── theme/          (mulearn_colors.dart, mulearn_theme.dart, mulearn_gradients.dart)
   │   ├── network/        (dio_provider.dart, auth_interceptor.dart, cache_config.dart, api_exception.dart)
   │   ├── router/         (app_router.dart, route_paths.dart)
   │   ├── storage/        (secure_storage_provider.dart, cache_store_provider.dart)
   │   └── widgets/
   └── features/
       ├── auth/
       │   ├── data/
       │   ├── domain/
       │   └── presentation/
       └── profile/
           ├── data/
           ├── domain/
           └── presentation/
   ```

---

## 2. Theming

Port these brand tokens from μLearn's landing page CSS into `core/theme/mulearn_colors.dart` and a `ThemeData` in `mulearn_theme.dart`:

- Primary blue: `#0961F5`
- Gradient (trusty): 135° from `#2E85FE` to `#AF2EE6`
- Greyish: `#C4C4C4`, Blackish: `#1A1A1A`, Whitish: `#FEFEFE`, Gray-600: `#666771`
- Border radius base: ~10px (`0.625rem`)
- Headings: bold/black weight scale (h1 heaviest → h5 medium), matching the web app's `h1`–`h5` rules

Don't over-build this — just enough for the login and profile screens to look on-brand. Full design system work is a separate task.

---

## 3. Auth feature

### 3a. Flag this before writing code — don't guess

The OpenAPI spec's auth endpoints (`/api/v1/auth/user-authentication/`, `/api/v1/auth/google-mobile/`, `/api/v1/auth/apple-mobile/`, `/api/v1/auth/refresh-token/`) all return an **opaque passthrough object** — `response: { type: object, additionalProperties: {} }` — described only as "Upstream auth payload (access_token, refresh_token, user info, etc.)". The spec does not define:

- The actual field names in that payload (is it `access_token` or `access`? `refresh_token` or `refresh`?)
- The request body shape for `user-authentication` (spec shows no `requestBody` at all for these four endpoints, which is unusual for a login POST)
- Whether `user-authentication` is email/password, or something else, and whether `google-mobile`/`apple-mobile` expect a native SDK id_token in the body

**Do not assume field names and write code around a guess.** Before implementing the auth repository, either:
1. Hit the actual endpoint (Postman/curl) against the dev backend and inspect the real response, or
2. Ask me for a sample request/response pair from the backend team.

Only write the Freezed DTO and the token-storage code once you know the real shape. Scaffold everything else (UI, provider structure, interceptor skeleton) in the meantime with a `// TODO: confirm actual auth response field names` marker.

### 3b. What to build

- `data/datasources/auth_remote_datasource.dart` — Dio calls to whichever endpoint we confirm is correct for login (most likely `POST /api/v1/auth/user-authentication/`).
- `data/repositories/auth_repository_impl.dart` — implements the domain contract, maps the raw response into domain `AuthSession` (access token, refresh token, and whatever user summary comes back, if any).
- `domain/entities/auth_session.dart` — Freezed, immutable.
- `domain/repositories/auth_repository.dart` — abstract contract: `signIn(...)`, `refreshToken()`, `signOut()`, `currentSession()`.
- `presentation/providers/auth_controller.dart` — `@riverpod` `AsyncNotifier<AuthSession?>`.
- `presentation/screens/sign_in_screen.dart` — simple email/password form (or whatever the confirmed auth method turns out to be), calling `authControllerProvider`. Use the brand theme; keep it minimal — this isn't a polished onboarding flow yet, just functional.
- `core/network/auth_interceptor.dart` — attaches `Authorization: Bearer <token>` from secure storage; on 401, attempts silent refresh via `/api/v1/auth/refresh-token/`, retries the original request once, and on unrecoverable failure clears storage and flips auth state to signed-out.
- `core/router/app_router.dart` — `redirect` logic: unauthenticated → `/sign-in`; authenticated and on `/sign-in` → `/profile`.

### 3c. Token storage

Store access + refresh tokens in `flutter_secure_storage`, keyed clearly (e.g. `access_token`, `refresh_token`). If the confirmed backend response includes token rotation (a new refresh token issued on every refresh — check `SIMPLE_JWT` settings with the backend team, specifically `ROTATE_REFRESH_TOKENS`), store the new refresh token on every successful refresh, not just the access token.

---

## 4. Profile feature

### 4a. Endpoint

Use `GET /api/v1/dashboard/profile/user-profile/` — returns a `UserProfile` object wrapped in the standard envelope:
```json
{ "hasError": false, "statusCode": 200, "message": {...}, "response": { ...UserProfile } }
```

Relevant `UserProfile` fields for a basic profile screen:
- `full_name` (string)
- `muid` (string)
- `karma` (integer)
- `level` (string)
- `profile_pic` (string, readOnly — likely a URL)
- `cover_pic` (string, readOnly)
- `roles` (string, readOnly — check at runtime whether this is actually a list serialized as a string or a genuine comma-separated display value; the schema types it as `string` despite the name suggesting plural)
- `interest_groups` (string, readOnly — same caveat as `roles`)
- `rank` (string, readOnly)
- `is_public` (boolean)

Note: several fields the schema marks `type: string` for things that sound like they should be lists or numbers (`roles`, `interest_groups`, `rank`, `karma_distribution`, `percentile`) — this is a common drf-spectacular artifact when a `SerializerMethodField` isn't explicitly typed. **Confirm the actual runtime shape of these fields against a real response before building the DTO**, rather than trusting the spec's `string` type literally. If `roles` or `interest_groups` come back as JSON arrays despite the spec saying `string`, adjust the Freezed model accordingly.

### 4b. What to build

- `data/datasources/profile_remote_datasource.dart` — Dio/Retrofit call to the endpoint above.
- `data/dtos/user_profile_dto.dart` — Freezed + json_serializable, matching the *actual* confirmed response shape.
- `data/repositories/profile_repository_impl.dart` — maps DTO → domain entity.
- `domain/entities/user_profile.dart` — pure Dart, immutable, only the fields the UI actually needs (don't carry every API field into the domain model if the UI doesn't use it).
- `domain/repositories/profile_repository.dart` — abstract contract: `getCurrentUserProfile()`.
- `presentation/providers/profile_controller.dart` — `@riverpod` `FutureProvider` or `AsyncNotifier` that calls the repository once, on screen load.
- `presentation/screens/profile_screen.dart` — simple layout:
  - Avatar (`cached_network_image`, fallback placeholder if `profile_pic` is null/empty)
  - Full name, muid
  - Karma count
  - Level
  - Roles / interest groups (render whatever shape the confirmed response actually has)
  - A sign-out button that calls `authControllerProvider`'s sign-out and lets the router redirect handle navigation — don't manually `context.go('/sign-in')` from the button; let the redirect do its job.

Use `AsyncValue.when(data:, error:, loading:)` for the loading/error/success states. Keep the error state simple — a retry button is enough for this pass, no elaborate error UI yet.

---

## 5. Explicit non-goals for this build

Do not implement, even partially:
- Registration (`POST /api/v1/register/`) — the `User` schema behind it is large and clearly meant for a multi-step onboarding flow, not this pass.
- Editing the profile (`PATCH /api/v1/dashboard/profile/`) — read-only display only for now.
- Any caching layer beyond what's needed for the profile fetch to not re-hit the network on every screen revisit within a session (a simple `FutureProvider` with Riverpod's built-in caching is enough; don't wire up `dio_cache_interceptor` policies in depth yet — just get the dependency in place).
- Push notifications, deep linking, or any feature beyond auth + profile.

If you find yourself about to build any of the above "since it's related," stop and flag it instead.

---

## 6. Before you start writing feature code

Confirm with me:
1. The dev/prod API base URLs.
2. The actual response shape of the login endpoint (see section 3a) — this blocks the auth DTO.
3. The actual runtime shape of `roles` / `interest_groups` / other suspiciously-typed fields on `UserProfile` (see section 4a) — this blocks the profile DTO.
4. Package name / bundle ID for the Flutter project.

Everything else in this prompt (folder structure, theming, dependency list, screen layout) you can proceed on without asking.
