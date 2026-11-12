# Plan 2 — Architecture foundations Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Give the app one source of truth for "who is signed in and what they can do", one shared copy of the user's profile, a user-scoped persistent cache, crash/parse telemetry, safe async mutations, tab-correct navigation, enforced module boundaries and the dashboard's colour tokens — without changing any screen's layout.

**Architecture:** A new `lib/core/session/` module owns the current user (`/dashboard/user/info/`), mentor applications (`/dashboard/mentor/status/`), derived `Capabilities`, the shared `user-profile` payload and sign-out. Every user-scoped `keepAlive` provider watches `appAuthControllerProvider`, so signing out resets them. Cross-cutting rules (no feature→feature imports, no colour literals, no `state =` after an `await` without `ref.mounted`) become architecture tests that fail the suite.

**Tech Stack:** Flutter 3.47.9 / Dart 3.13.7, Riverpod 3.0.3 code-gen, go_router 16, Dio 5 + dio_cache_interceptor 3.5.1 (+ Hive store), Freezed 3, mocktail. One dependency promoted from transitive to direct: `path_provider ^2.1.6` (needed for the persistent cache directory; already in `pubspec.lock`).

**Spec:** `docs/superpowers/specs/2026-11-12-app-parity-design.md` (§4 goals 3–5, §8.1 foundations, §8.2 item 3). Gap IDs from `mulearn-app-audit/10-gap-register-and-roadmap.md`.

## Global Constraints

- No backend or authserver change; use the deployed contracts exactly (spec §7).
- Every endpoint used is traced to backend source on `origin/dev` and to a live dev response recorded as a fixture before code depends on it (spec §6, §8.3).
- `features/X` never imports `features/Y`; `core/` never imports `features/`; `domain/` imports neither Flutter nor Dio (`docs/rules.md` §2).
- No new colour literals in widgets; colours come from `MuColors`/`MuShadow` (`docs/rules.md` §8, spec §8.1).
- Current layouts, radii and shadows unchanged (spec §8.1); this round is not a UI revamp (spec §5).
- `flutter analyze` → `No issues found!`; `flutter test` all green on every task (spec §4.6).
- One commit per task, in order, on `feat/app-parity`; no `Co-Authored-By`/AI trailer; never push (user rule).
- Dev mutations only with QA accounts (spec §10); QA credentials live in `.env.qa` (gitignored).
- iOS can't be built here; anything iOS-only is written and marked unverified (spec §7).

## Review Focus

1. **Switching accounts on one device** — sign out, sign in as someone else: no previous user's profile, capabilities or cached responses may appear. Pinned in Task 4 (`currentUser refetches after an account switch`), Task 5 (`sign-out resets the shared profile`) and Task 6 (`a response cached for one user is not served to another`).
2. **A mentor offline** — if `/mentor/status/` fails on the network, capabilities must surface the error, not silently report "not an approved mentor" (which would hide mentor tools). Pinned in Task 4 (`a failed mentor-status fetch is an error, not a downgrade`).
3. **Unknown or extra role titles** (`Pre Member`, dynamic `WEB IGLead`, `Admins`) — no crash; only the known titles switch capabilities on. Pinned in Task 4 (`unknown role titles grant nothing`).
4. **No writable cache directory** at boot — the app must still start (memory cache). Pinned in Task 6 (`falls back to a memory store when the directory can't be opened`).
5. **Leaving a screen mid-request** — the request completes without the "Ref used after dispose" crash. Pinned in Task 3 (`an action finishing after its screen closed doesn't throw`).

---

### Task 1: Typed error kinds (spec §8.1 "Errors")

**Files:**
- Modify: `lib/core/network/api_exception.dart`
- Test: `test/core/network/api_exception_test.dart` (new group)

**Interfaces:**
- Produces: `enum ApiErrorKind { network, timeout, unauthorized, forbidden, validation, notFound, server, unknown }`; `ApiException.kind` (`ApiErrorKind`, final). Constructor gains optional `ApiErrorKind? kind`; when omitted it is derived: `401→unauthorized`, `403→forbidden`, `404→notFound`, `400`/`422` or non-empty `fieldErrors`→`validation`, `≥500→server`, `isNetworkError→network`, else `unknown`. `fromDioException` sets `timeout` for the four timeout types and `network` for `connectionError`/`unknown`.

- [ ] **Step 1: Failing tests** (`group('ApiException.kind')`):
  - connection timeout → `timeout` (and `isNetworkError` stays `true`); connection error → `network`.
  - envelopes with statusCode 401, 403, 404, 500, 502 → `unauthorized`, `forbidden`, `notFound`, `server`, `server`.
  - the recorded `dev/profile_patch_invalid_email` fixture (400 with field errors) → `validation`.
  - `const ApiException(message: 'x')` → `unknown`.
- [ ] **Step 2: Run** `flutter test test/core/network/api_exception_test.dart` → FAIL (`kind` undefined).
- [ ] **Step 3: Implement** the enum and field. **Step 4: Run** the file → PASS; `flutter analyze` clean.
- [ ] **Step 5: Commit** `feat(network): classify API errors by kind`.

### Task 2: Telemetry hook and reported parse failures (ARCH-04, REL-03, REL-04)

**Files:**
- Create: `lib/core/telemetry/crash_reporter.dart`, `lib/core/telemetry/error_hooks.dart`, `lib/core/network/tolerant_parse.dart`
- Modify: `lib/app/bootstrap.dart`; the four private parse helpers — `events_repository_impl.dart:35`, `leaderboard_repository_impl.dart:57`, `learning_circles_repository_impl.dart:239` (`_parseSkippingErrors`) and `calendar_repository_impl.dart:47` (`_parseEach`) — are deleted and their callers use `parseEachOrReport`
- Test: `test/core/telemetry/error_hooks_test.dart`, `test/core/network/tolerant_parse_test.dart`

**Interfaces:**
- Produces:
  - `abstract interface class CrashReporter { void recordError(Object error, StackTrace? stackTrace, {required bool fatal, String? reason}); }`
  - `final class LoggingCrashReporter implements CrashReporter` — forwards to `appLogger.e` (fatal) / `appLogger.w` (non-fatal). The no-op default until a Sentry/Crashlytics account exists (spec §10).
  - `CrashReporter crashReporter = const LoggingCrashReporter();` — top-level, replaceable (like `appLogger`).
  - `void installErrorHooks(CrashReporter reporter)` — `FlutterError.onError` calls `FlutterError.presentError(details)` then `recordError(fatal: true, reason: 'FlutterError')`; `PlatformDispatcher.instance.onError` records `fatal: true, reason: 'PlatformDispatcher'` and returns `true`.
  - `final class TelemetryProviderObserver extends ProviderObserver` — `providerDidFail(ProviderObserverContext context, Object error, StackTrace stackTrace)` records `fatal: false, reason: 'provider ${context.provider.name ?? context.provider.runtimeType}'`.
  - `List<T> parseEachOrReport<T>(Iterable<dynamic> items, T Function(Map<String, dynamic> json) parse, {required String what})` — parses each item alone; a failing item is skipped and reported (`fatal: false, reason: 'parse $what'`).
- `bootstrap()` calls `installErrorHooks(crashReporter)` and passes `observers: [TelemetryProviderObserver(crashReporter)]` to `ProviderScope`.

- [ ] **Step 1: Failing tests** (a `RecordingCrashReporter` test double collects calls; every test restores `FlutterError.onError` and `PlatformDispatcher.instance.onError` in `addTearDown`):
  - `PlatformDispatcher errors are recorded as fatal and handled` — after `installErrorHooks(r)`, `PlatformDispatcher.instance.onError!(StateError('x'), StackTrace.current)` returns `true`; `r.calls.single` has `fatal == true`, `reason == 'PlatformDispatcher'`.
  - `Flutter framework errors are recorded as fatal` — `FlutterError.onError!(FlutterErrorDetails(exception: StateError('y')))` → one fatal call with reason `FlutterError`.
  - `a failing provider is recorded as non-fatal` — a `ProviderContainer(observers: [TelemetryProviderObserver(r)])` reading a `FutureProvider` that throws → one call, `fatal == false`, reason starts with `provider`.
  - `tolerant_parse_test`: `parseEachOrReport([{'id': 1}, {'bad': true}, {'id': 3}], (j) => j['id'] as int, what: 'Thing')` returns `[1, 3]`; `crashReporter` (swapped to a recorder in `setUp`, restored in `tearDown`) got one call with `reason == 'parse Thing'`.
- [ ] **Step 2: Run** → FAIL (files missing). **Step 3: Implement**; replace the four helpers (the `what` is the DTO name, e.g. `'EventDto'`). **Step 4: Run** `flutter test` → all PASS; analyze clean.
- [ ] **Step 5: Commit** `feat(telemetry): crash-reporter hook, provider failures and reported parse skips`.

### Task 3: Mutations that survive leaving the screen (Plan 1 finding)

The 32 `state = await AsyncValue.guard(...)` sites assign `state` after an `await`; if the screen closed meanwhile the auto-dispose provider is gone and Riverpod 3 throws. Sites (count): `meetings_controller.dart` 8, `learning_circles_controller.dart` 8, `cover_photo_controller.dart` 2, `dashboard_controller.dart` 2, `interests_controller.dart` 2, and 1 each in `search_controller`, `vc_issuance_controller`, `profile_image_controller`, `profile_controller`, `profile/interest_groups_controller`, `college_change_controller`, `interest_groups/interest_groups_controller`, `events_controller`, `register_submit_controller`, `auth_controller`.

**Files:** Modify the 15 files above. Test: `test/architecture/mounted_state_test.dart`, `test/features/learning_circles/circle_actions_mounted_test.dart`.

**Interfaces:**
- Pattern (every site): `final result = await AsyncValue.guard(...); if (ref.mounted) state = result;` — and any later read of `state.hasError`/`state.error`/`state.stackTrace` in the same method reads `result` instead. `AuthController._guard` keeps rethrowing from `result`.

- [ ] **Step 1: Failing tests:**
  - `mounted_state_test`: scans `lib/**/*.dart` (excluding `.g.dart`/`.freezed.dart`) for the regex `state\s*=\s*await\s+AsyncValue\.guard`; `expect(offenders, isEmpty)` with the offending `path:line` list as the reason.
  - `an action finishing after its screen closed doesn't throw` — `CircleActionsController.respondToInvite` with a mock repository whose `respondToInvite` returns a `Completer` future; subscribe, call the action, `container.dispose()`, then complete the completer; `await expectLater(actionFuture, completes)`.
- [ ] **Step 2: Run** → FAIL (32 offenders; the action throws). **Step 3: Implement** the pattern at all 32 sites. **Step 4: Run** `flutter test` → all PASS; analyze clean.
- [ ] **Step 5: Commit** `fix(state): don't assign provider state after the screen has closed`.

### Task 4: Session — current user, capabilities, sign-out in core (ARCH-07, SEC-13, ARCH-02 profile→auth)

Backend: `UserInfoAPI` → `UserSerializer` (`api/dashboard/user/dash_user_serializer.py:41-100`) returns **all** role links' titles, verified or not. `MentorStatusAPI` (`/dashboard/mentor/status/`) returns the user's mentor applications `[{id, status, mentor_tier, organization, verified_by, verified_at, created_at}]` and 400 `"No mentor requests found for your account."` for non-mentors (both live on dev 2026-11-12; the QA mentor's role link is `is_verified: false` while its application is `APPROVED`). Role titles: `utils/types.py RoleType`. The dashboard opens its campus workspace to Campus Lead, Lead Enabler and Enabler (`src/lib/auth/route-access.ts`) and treats a mentor as verified when an application is `APPROVED` (`profile-client.tsx:84-86`).

**Files:**
- Create: `lib/core/session/role_titles.dart`, `current_user.dart` (+ `current_user_dto.dart`), `mentor_application.dart` (+ `mentor_application_dto.dart`), `capabilities.dart`, `session_remote_datasource.dart`, `session_providers.dart`, `session_actions.dart`
- Modify: `lib/core/network/api_paths.dart` (`userInfo = '/api/v1/dashboard/user/info/'`, `mentorStatus = '/api/v1/dashboard/mentor/status/'`); `lib/core/auth/current_user_claims.dart` (`currentUserMuid` watches `appAuthControllerProvider`); `features/auth/.../auth_controller.dart` (`signOut` delegates to `SessionActions`); `auth_repository(_impl).dart` and `auth_remote_datasource.dart` (remove `signOut`/`logout` — moved); `features/profile/.../basic_details_tab.dart` (sign-out via `sessionActionsProvider`, drop the `features/auth` import); `tool/record_fixtures.dart` (target `mentor_status`, account `mentor`)
- Move: `test/features/auth/sign_out_test.dart` → `test/core/session/sign_out_test.dart` (same three cases, against `SessionActions`)
- Test: `test/core/session/capabilities_test.dart`, `test/core/session/session_providers_test.dart`
- Fixture: `test/fixtures/dev/mentor_status.json` (recorded)

**Interfaces:**
- `abstract final class RoleTitles` — `student = 'Student'`, `mentor = 'Mentor'`, `enabler = 'Enabler'`, `leadEnabler = 'Lead Enabler'`, `campusLead = 'Campus Lead'`, `zonalCampusLead = 'Zonal Campus Lead'`, `districtCampusLead = 'District Campus Lead'`, `company = 'Company'`.
- `CurrentUser { required String muid, required String fullName, @Default([]) List<String> roles, @Default(false) bool existInGuild, String? profilePic, String? company }` (Freezed; DTO maps `full_name`, `exist_in_guild`, `profile_pic`).
- `MentorApplication { required String id, required String status, required String mentorTier }`.
- `Capabilities { isLearner, isMentor, isMentorApproved, isEnabler, isCampusLead, isCompany, canUseCampusWorkspace, needsDiscord }` (all `bool`), `factory Capabilities.derive(CurrentUser user, List<MentorApplication> mentorApplications)`:
  `isLearner = Student`; `isMentor = Mentor`; `isMentorApproved = isMentor && any status == 'APPROVED'`; `isEnabler = Enabler || Lead Enabler`; `isCampusLead = Campus Lead || Zonal Campus Lead || District Campus Lead`; `isCompany = Company`; `canUseCampusWorkspace = isCampusLead || isEnabler`; `needsDiscord = !existInGuild`.
- `SessionRemoteDataSource(Dio)`: `Future<Map<String, dynamic>> fetchUserInfo()`, `Future<List<dynamic>> fetchMentorApplications()` (maps the 400 "No mentor requests found…" envelope to `[]`), `Future<void> logout(String refreshToken)` (moved unchanged from `AuthRemoteDataSource`).
- `session_providers.dart` (all `@Riverpod(keepAlive: true)`, each `ref.watch(appAuthControllerProvider.future)` first):
  - `Future<CurrentUser?> currentUser(Ref)` — `null` when signed out.
  - `Future<List<MentorApplication>> mentorApplications(Ref)` — `[]` unless `currentUser.roles` contains `Mentor` (no request otherwise).
  - `Future<Capabilities?> capabilities(Ref)` — `null` when signed out; errors from either source propagate as `AsyncError`.
- `@riverpod class SessionActions` — `Future<void> signOut()`: `appAuthController.setSignedOut()` first (synchronous redirect), then best-effort `logout` (errors logged), `tokenStorage.clear()`, `cacheStore.clean()`.
- `AuthController.signOut()` → `ref.read(sessionActionsProvider.notifier).signOut()`.

- [ ] **Step 1: Record** `mentor_status` with `dart run tool/record_fixtures.dart`; keep only `test/fixtures/dev/mentor_status.json` (restore the others with `git checkout`). Expected: one item with `status: "APPROVED"`, `mentor_tier: "IG_MENTOR"`.
- [ ] **Step 2: Failing tests:**
  - `capabilities_test` (users from `dev/user_info*.json`, applications from `dev/mentor_status.json`): student → `isLearner`, `needsDiscord`, nothing else; mentor + APPROVED → `isMentor && isMentorApproved`; mentor + `[]` → `isMentor && !isMentorApproved`; enabler → `isEnabler && canUseCampusWorkspace && isLearner`; campus lead → `isCampusLead && canUseCampusWorkspace`; `unknown role titles grant nothing` — roles `['Pre Member', 'WEB IGLead', 'Admins']` → every flag false except `needsDiscord`.
  - `session_providers_test` (fake HTTP on `dioProvider`, `appAuthControllerProvider` driven by a fake `TokenStorage`):
    - `a learner never calls mentor status` — the adapter has no `/mentor/status/` route; `capabilities` resolves.
    - `a failed mentor-status fetch is an error, not a downgrade` — mentor `user/info` + `/mentor/status/` → `FakeResponse(-1)`; `capabilitiesProvider` is `AsyncError`.
    - `currentUser refetches after an account switch` — signed in as student (1 call), `setSignedOut()` → `null`, sign in with the mentor's info → mentor returned, 2 `user/info` calls.
  - `sign_out_test` (moved) passes against `SessionActions`; plus `sign-out flips the router state before any network call` (the adapter's logout handler asserts `appAuthControllerProvider` is already `false`).
- [ ] **Step 3: Run** → FAIL. **Step 4: Implement** (build_runner). **Step 5: Run** `flutter test` → PASS; analyze clean; `grep -rn "features/auth" lib/features/profile` → no output.
- [ ] **Step 6: Commit** `feat(session): current user, capabilities and sign-out in core`.

### Task 5: One shared user-profile read model (ARCH-07, PERF-01)

Today four providers each `GET /dashboard/profile/user-profile/` (`profile_remote_datasource.dart:14`, `dashboard_remote_datasource.dart:25`, `interest_groups_remote_datasource.dart:33`, `core/auth/current_user_college.dart:26`) and `ProfileEventBus` keeps two of them in step. The spec's `learnerSummaryProvider` (`/dashboard/home/learner/summary/`) can't replace them: live, it returns only `stats {weekly_karma, total_karma, rank, active_circles, streak_days}`, `next_meeting` and quick-action counts — no percentile, level, college or interest groups. So the one shared read model is the `user-profile` payload; the learner summary arrives with Home's weekly karma / streak / next meetup in Plan 3.

**Files:**
- Create: `lib/core/session/my_profile_payload.dart`
- Modify: `features/profile` (repository gains `UserProfile profileFromPayload(Map<String, dynamic> payload)`; `fetchCurrentUserProfile`/`getCurrentUserProfile` removed; `ProfileController.build` watches the payload; `refresh()` invalidates it), `features/dashboard` (`MyProgressSummary summaryFromPayload(Map<String, dynamic>)`; `fetchMyProgressSummary` removed; controller drops the bus), `features/interest_groups` (`List<String> groupIdsFromPayload(Map<String, dynamic>)`; `fetchMyGroupIds`/`getMyGroupIds` removed; `myInterestGroupIds` and `InterestGroupMembershipController.toggle` read the payload), `core/auth/current_user_college.dart` (maps from the payload)
- Modify (invalidate `myProfilePayloadProvider` after success instead of emitting): `profile_image_controller.dart`, `cover_photo_controller.dart`, `profile_controller.dart` (visibility), `college_change_controller.dart`, `editable_profile_controller.dart` (save), `interest_groups/.../interest_groups_controller.dart` (set groups)
- Delete: `lib/core/events/profile_event_bus.dart` (+ `.g.dart`)
- Test: `test/core/session/my_profile_payload_test.dart`; update existing profile/dashboard/IG tests that stub the removed methods

**Interfaces:**
- Consumes: `appAuthControllerProvider` (Task 4 pattern), `dioProvider`.
- Produces: `@Riverpod(keepAlive: true) Future<Map<String, dynamic>> myProfilePayload(Ref ref)` — the unwrapped `user-profile` object; watches `appAuthControllerProvider.future`; maps `DioException` to `ApiException`. Each feature maps it with its own DTO through its repository's `...FromPayload` method (pure, no I/O).

- [ ] **Step 1: Failing tests** (`dev/user_profile.json` served by a fake adapter that counts calls):
  - `four readers share one request` — read `profileControllerProvider`, `myProgressSummaryControllerProvider`, `myInterestGroupIdsProvider` and `currentUserCollegeProvider` together → exactly 1 `GET .../user-profile/`.
  - `a profile mutation refreshes every reader` — after `ref.invalidate(myProfilePayloadProvider)` (what `ProfileImageController` now does), the summary provider re-reads → 2 requests total, no event bus.
  - `sign-out resets the shared profile` — `setSignedOut()` then sign in again → the payload is fetched again.
- [ ] **Step 2: Run** → FAIL. **Step 3: Implement** (build_runner). **Step 4: Run** `flutter test` → PASS; analyze clean; `grep -rn "ApiPaths.userProfile\b" lib` → only `my_profile_payload.dart`.
- [ ] **Step 5: Commit** `refactor(session): one shared user-profile read model; drop ProfileEventBus`.

### Task 6: User-scoped persistent HTTP cache (SEC-12, PERF-04)

**Files:**
- Create: `lib/core/network/cache_scope_interceptor.dart`, `lib/core/auth/jwt_claims.dart`, `lib/core/storage/cache_store_factory.dart`
- Modify: `lib/core/network/cache_config.dart` (both options use `CacheConfig.keyBuilder`), `lib/core/network/dio_provider.dart` (order: `CacheScopeInterceptor` → `DioCacheInterceptor` → `AuthInterceptor`), `lib/app/bootstrap.dart` (persistent store), `lib/core/auth/current_user_claims.dart` (uses `jwtClaim`), `pubspec.yaml` (`path_provider: ^2.1.6`)
- Test: `test/core/network/cache_scope_test.dart`, `test/core/storage/cache_store_factory_test.dart`

**Interfaces:**
- `String? jwtClaim(String token, String name)` — base64url-decodes the payload; `null` on any malformed token.
- `CacheScopeInterceptor(TokenStorage)` — `onRequest` sets `options.extra[CacheScopeInterceptor.extraKey] = jwtClaim(access, 'id') ?? 'anon'`; `static const extraKey = 'mu_cache_scope'`.
- `static String CacheConfig.keyBuilder(RequestOptions r) => '${r.extra[CacheScopeInterceptor.extraKey] ?? 'anon'}|${CacheOptions.defaultCacheKeyBuilder(r)}'`.
- `Future<CacheStore> openCacheStore({Future<Directory> Function() directory = getApplicationCacheDirectory})` — Hive store (`buildHiveCacheStore`) in that directory; on any error logs and returns `MemCacheStore()`.

- [ ] **Step 1: Failing tests:**
  - `cache keys differ per user for the same URL` — two `RequestOptions` for the same path with scope extras `u1`/`u2` → different keys; no scope → prefix `anon|`.
  - `a response cached for one user is not served to another` — a Dio over a fake adapter with `CacheScopeInterceptor` + `DioCacheInterceptor(CacheConfig.leaderboard(MemCacheStore()))`; GET as user A (token whose `id` is A), GET again as A → adapter called once; switch the stored token to user B, GET → adapter called twice.
  - `falls back to a memory store when the directory can't be opened` — `openCacheStore(directory: () async => throw const FileSystemException('no dir'))` returns a `MemCacheStore`.
- [ ] **Step 2: Run** → FAIL. **Step 3: Implement** (`flutter pub get` after the pubspec change; build_runner). **Step 4: Run** `flutter test` → PASS; analyze clean.
- [ ] **Step 5: Commit** `feat(cache): persistent, user-scoped HTTP cache`.

### Task 7: Leaderboard read model in core; module-boundary tests (ARCH-02)

The last cross-feature edge is `home_screen.dart:20` importing `features/leaderboard/.../leaderboard_controller.dart` for "Top performers" (the profile→auth edge goes in Task 4).

**Files:**
- Move: `features/leaderboard/data/**`, `features/leaderboard/domain/**` and the providers `leaderboardRemoteDataSource`, `leaderboardRepository`, `studentLeaderboard`, `collegeLeaderboard` → `lib/core/leaderboard/` (`data/`, `domain/`, `leaderboard_providers.dart`). `features/leaderboard` keeps `presentation/screens` and `presentation/widgets`.
- Modify: `home_screen.dart`, `leaderboard_screen.dart` imports; move the leaderboard tests to `test/core/leaderboard/`
- Test: `test/architecture/import_boundaries_test.dart`

**Interfaces:**
- Produces: `package:mulearn_app/core/leaderboard/leaderboard_providers.dart` exporting `studentLeaderboardProvider(monthly:)`, `collegeLeaderboardProvider(monthly:)` with unchanged signatures and return types.

- [ ] **Step 1: Failing test** `import_boundaries_test` — reads every `lib/**/*.dart` (excluding generated files) and collects violations of: a file under `lib/features/<x>/` importing `package:mulearn_app/features/<y>/` with `y != x`; a file under `lib/core/` importing `package:mulearn_app/features/`; a file under any `/domain/` importing `package:flutter/` or `package:dio/`. `expect(violations, isEmpty, reason: violations.join('\n'))`.
- [ ] **Step 2: Run** → FAIL listing `home_screen.dart → features/leaderboard`. **Step 3: Implement** the move (build_runner). **Step 4: Run** `flutter test` → PASS; analyze clean.
- [ ] **Step 5: Commit** `refactor: move the leaderboard read model to core; enforce module boundaries`.

### Task 8: Tab switches go to the tab, not on top of it (UX-09, REL-06)

`home_screen.dart:87,104,243,274` and `mu_voyage_tab.dart:50` `context.push` the shell branch roots `/tasks`, `/leaderboard`, `/profile`, `/journey`, stacking a second copy over the shell and desyncing the bottom bar.

**Files:**
- Create: `lib/core/router/tab_navigation.dart`
- Modify: `lib/core/router/route_paths.dart` (`static const tabRoots = [home, tasks, journey, leaderboard, profile]`, the shell's branch order in `app_router.dart:233-277`), the five call sites
- Test: `test/core/router/tab_navigation_test.dart`

**Interfaces:**
- `extension TabNavigation on BuildContext { void openTab(String tabRoot); }` — asserts `RoutePaths.tabRoots.contains(tabRoot)`, then `go(tabRoot)`.

- [ ] **Step 1: Failing test** `opening a tab switches branch without stacking a page` — a `GoRouter` with a two-branch `StatefulShellRoute.indexedStack` (`/home`, `/tasks`); a button on `/home` calls `context.openTab('/tasks')`; after tap: `router.routerDelegate.currentConfiguration.uri.path == '/tasks'` and `router.canPop()` is `false`; tapping again changes nothing.
- [ ] **Step 2: Run** → FAIL. **Step 3: Implement**; replace the five `push` calls with `openTab`. **Step 4: Run** `flutter test` → PASS; analyze clean; `grep -rnE "push\(RoutePaths\.(home|tasks|journey|leaderboard|profile)\)" lib` → no output.
- [ ] **Step 5: Commit** `fix(nav): open tabs via the shell instead of pushing them`.

### Task 9: Dashboard colour tokens; no colour literals (DS-01)

Dashboard palette (`mulearn-dashboard/src/app/globals.css:56-79`): brand blue `#2e85fe`, brand purple `#8f44ed`, success `#4caf50`, warning `#ff8d0c`, destructive `#f44336`. Fills that light fail text contrast on white (2.78 / 2.32 / 3.68), so text uses darker variants of the same hues (WCAG ratios computed 2026-11-12).

**Files:**
- Modify: `lib/core/theme/mulearn_colors.dart`, `lib/core/theme/mu_shadow.dart`, and the files holding the 95 literals (largest: `onboarding_interests_screen.dart` 22, `profile_header.dart` 9, `home_screen.dart` 8, `interest_group_detail_screen.dart` 6, `public_profile_header.dart` 6, `task_detail_screen.dart` 6, `journey_screen.dart` 5, `splash_screen.dart` 4; full list from the test's failure output)
- Test: `test/architecture/no_color_literals_test.dart`, `test/core/theme/contrast_test.dart`

**Interfaces / values:**
- Changed: `karmaAccent #8F44ED`, `karmaAccentTint #F3EBFD`, `success #2E7D32`, `successBg #E8F5E9`, `warning #B45309`, `warningBg #FFF3E0`, `error #C62828`, `errorBg #FEEBEE`. `primary #2E85FE` unchanged.
- New: `successFill #4CAF50`, `warningFill #FF8D0C`, `errorFill #F44336`, `onBrand #FFFFFF` (text/icons on brand, dark or image surfaces), `onBrandMuted #B9B9C2`, `paper #FFFFFF` (white fills), `inkBody #33333A` (long-form body text), `imageScrim 0x52000000`, `static const List<Color> coverScrim = [Color(0x1A000000), Color(0x99000000)]`; `MuShadow.podium = [BoxShadow(color: Color(0x991A1A1A), blurRadius: 20, offset: Offset(0, 8))]`.
- Mapping: `Colors.white` → `onBrand` when it colours text/icons/borders, `paper` when it fills a background; `Colors.black.withValues(alpha: 0.32)` → `imageScrim`; `Color(0xFF33333A)` → `inkBody`; `Color(0xFFB9B9C2)` → `onBrandMuted`; `[Color(0x1A000000), Color(0x99000000)]` → `coverScrim`; podium `BoxShadow(Color(0x991A1A1A)…)` → `MuShadow.podium`; `Colors.green` → `successFill`. `Colors.transparent` is allowed.

- [ ] **Step 1: Failing tests:**
  - `no_color_literals_test` — regex `(?<![A-Za-z_])Colors\.(?!transparent\b)[a-zA-Z]+|(?<![A-Za-z_])Color\(0x|Color\.from(ARGB|RGBO)\(` over `lib/**/*.dart` excluding `lib/core/theme/` and generated files; `expect(offenders, isEmpty, reason: offenders.join('\n'))`.
  - `contrast_test` — WCAG contrast ≥ 4.5 for `success`, `warning`, `error`, `karmaAccent` on `MuColors.paper`, and for `success`/`successBg`, `warning`/`warningBg`, `error`/`errorBg`; `karmaAccent == Color(0xFF8F44ED)` and `primary == Color(0xFF2E85FE)`.
- [ ] **Step 2: Run** → FAIL (95 offenders; old values). **Step 3: Implement** the token values and the replacements. **Step 4: Run** `flutter test` → PASS; analyze clean.
- [ ] **Step 5: On the phone** (hot restart): Home, Profile header, Leaderboard podium, onboarding interests and task detail look as before apart from the purple and status hues; screenshot only while μLearn is in the foreground.
- [ ] **Step 6: Commit** `feat(theme): dashboard colour tokens; no colour literals in widgets`.

### Task 10: Plan close-out

- [ ] **Step 1:** `flutter analyze` → `No issues found!`; `flutter test` → all pass; `flutter build apk --flavor dev --debug -t lib/main_dev.dart` → built.
- [ ] **Step 2:** Re-run `dart run tool/record_fixtures.dart` and `flutter test` (then restore committed fixtures) to catch dev drift.
- [ ] **Step 3: On the phone** (attach + hot restart): sign out and sign in as the QA student, then as the QA mentor — Home shows each user's own data; Home → "Find a task" / "View all" switches tabs with the bottom bar in step; Plan 1's pending checks (Events second page, "Happening soon").
- [ ] **Step 4:** Add the Plan 2 rows to spec §12; commit `docs: close out plan 2`.
- [ ] **Step 5:** Report to the user; next is Plan 3 (missing learner functionality inside the current design).
