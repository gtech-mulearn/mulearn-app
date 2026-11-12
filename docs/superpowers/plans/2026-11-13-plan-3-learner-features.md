# Plan 3 — Learner features inside the current design Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Give a learner everything the backend already supports for them, inside today's screens: notifications, Settings, Discord connect, a real Home summary, correct Journey levels, achievements with claim, circle and interest-group membership actions, event filters and eligibility, and consistent loading/empty/error/refresh states with labelled controls.

**Architecture:** Each feature keeps the existing feature-first layers (datasource → DTO → entity → repository → controller → screen). New server state uses the Plan 2 foundations: `PagedState`/`PageIndexPaging` (plus a new `PagePaging` for notifications), `ApiException.kind`, `parseEachOrReport`, `capabilitiesProvider`, `myProfilePayloadProvider` and `noRetry`. UI branches on `Capabilities`; the backend stays the authority. Mutations are optimistic only where the dashboard is, and always show the backend's own message on failure.

**Tech Stack:** Flutter 3.47.9 / Dart 3.13.7, Riverpod 3.0.3 code-gen, go_router 16, Dio 5 + dio_cache_interceptor, Freezed 3, mocktail, url_launcher (already a dependency). No new packages.

**Spec:** `docs/superpowers/specs/2026-11-12-app-parity-design.md` — §4 goal 2, §8.2 item 4, §8.3, §10, §11 (account deletion, Discord). Gap IDs: API-10, API-13, UX-02, UX-03, UX-05, UX-07, UX-08, SEC-04 (hide VC issue), SEC-14 (deletion + legal), FEAT-05…09, plus the two Plan 2 phone findings (spec §13) and the Plan 2 deferred minors routed here.

## Global Constraints

- No backend or authserver change; use the contracts exactly as deployed on `https://dev.mulearn.org` (spec §2, §7).
- Every endpoint is traced to `mulearnbackend` `origin/dev` source and to a live dev response recorded as a fixture (`tool/record_fixtures.dart`, PII scrubbed) before code depends on it (spec §6, §8.3).
- `features/X` never imports `features/Y`; `core/` never imports `features/`; `domain/` imports neither Flutter nor Dio — enforced by `test/architecture/import_boundaries_test.dart`.
- No colour literals in widgets (`test/architecture/no_color_literals_test.dart`); colours from `MuColors`/`MuShadow`; current layouts, radii and shadows unchanged (spec §2, §8.1).
- No `state =` after an `await` without `if (ref.mounted)` (`test/architecture/mounted_state_test.dart`).
- Providers reading shared server state use `retry: noRetry` (`lib/core/utils/no_retry.dart`).
- No admin endpoints from the app (spec §6). Admin calls are allowed only in scratch seeding scripts run by the executor with the user-authorised admin account.
- Dev mutations only with QA accounts; undo them afterwards where the API allows (spec §10).
- `flutter analyze` → `No issues found!`; `flutter test` all green; each commit also passes alone in `_worktrees/app-verify` (Plan 2 ruling).
- One commit per task, in order, on `feat/app-parity`; no `Co-Authored-By`/AI trailer; never push (user rule).
- Copy follows the dashboard where one exists (quoted per task); errors show `ApiException.messageFor(e)`, i.e. the backend's own message.

## Review Focus

1. **A notification the app can't place** — unknown `type`, `entity_id` null, or a `redirect_url` that is `http:`, `javascript:` or otherwise not https/relative. Expected: the row still renders and marks itself read on tap, and nothing opens. Pinned in Task 2 (`unsafe or unknown targets open nothing`).
2. **An event the viewer may not register for** — `viewer_can_access_registration: false` while `registration_url` is set (karma gate, completed, cancelled). Expected: the reason shows above a disabled Register button before any tap. Pinned in Task 10 (`blocked events show the reason and disable registration`).
3. **Cancelling an RSVP too late** — within 30 minutes of the start, or after joining with the code. Expected: no Cancel action when the app can tell; the backend message as a toast if it races. Pinned in Task 8 (`cancel RSVP is offered only before the 30-minute cutoff`).
4. **A fourth interest group** — the backend caps learners at 3. Expected: Join is replaced by the cap message before any request; a raced 400 shows "Cannot join more than 3 interest groups". Pinned in Task 11 (`a learner in three groups can't join a fourth`).
5. **A Discord link the app didn't start** — `/dashboard/connect-discord` without `code`, a repeated code, or opened while signed out. Expected: no API call without a code; signed-out users sign in first and then land back on the connect screen; a failure shows the backend message with a retry. Pinned in Task 4 (`a link without a code makes no request`, `a signed-out link resumes after sign-in`).

## Facts this plan relies on (verified 2026-11-12/13)

| Area | Contract (backend `origin/dev@b7c9a5c9`) | Live on dev |
|---|---|---|
| Notifications | `GET /api/v1/notification/?page&page_size` (20, max 100) → `response {count, page, page_size, results[]}`. Each item has `{id, type, category, title, description, entity_type, entity_id, is_read, is_archived, created_at, read_at, source: personal\|broadcast, redirect_url}`. Also `GET unread-count/` → `{unread_count}` (personal only), `PATCH <id>/read/`, `PATCH read-all/`, `PATCH <id>/archive/`. A foreign id gets 404. (`api/notification/notification_view.py`) | QA student: 35 items, 21 unread, type `LC_INVITE` / `entity_type learning_circle` |
| Notification types | `_ENTITY_TYPE_MAP` (`api/notification/service.py:323`): every `LC_*` → `learning_circle`; every `EVENT_*` and `*_EVENT_PENDING` → `event`; company types → `company`/`company_admin_link`; mentor types → `mentor_application`; `JOB_*` → `job`/`job_application`. `KARMA_*` → `karma_activity_log` and media types → `media_content` (per the dashboard's `notification-href.ts`) | — |
| Learner summary | `GET /api/v1/dashboard/home/learner/summary/` → `{stats:{weekly_karma,total_karma,rank,active_circles,streak_days}, next_meeting:{id,circle_id,circle_name,title,starts_at,duration_minutes,meeting_link,rsvp_status}\|null, quick_action_counts:{circles,leaderboard_rank,job_openings}}` | Recorded (`dev/learner_summary`) |
| Change password | `POST /api/v1/dashboard/profile/change-password/ {current_password, password}`. Wrong current password → 400 "Current Password is incorrect". The dashboard requires new ≥ 8 characters, different from the current one, and confirmed. | — |
| Discord | `GET /api/v1/register/connect-discord/?code=` exchanges the code with `redirect_uri={FR_DOMAIN}/dashboard/connect-discord` (no trailing slash). The **dev dashboard is `https://mulearn-dashboard.vercel.app`** (user, 2026-11-13; Next build of `mulearn-dashboard`, backend `dev.mulearn.org`). Its `NEXT_PUBLIC_DISCORD_AUTH_URL` is `https://discord.com/oauth2/authorize?client_id=785516660160593940&response_type=code&redirect_uri=https%3A%2F%2Fmulearn-dev.vercel.app%2Fdashboard%2Fconnect-discord&scope=identify+guilds+guilds.join`. The redirect host `mulearn-dev.vercel.app` is an old Vite build, not this repo. Other hosts: `dev-app.mulearn.org` (old Vite, another client id), `dev.mulearn.org` (marketing site), `app.mulearn.org` (production Next dashboard). | Bad code → backend message (Task 4 records it) |
| Achievements | `list/user/<muid>/` (earned), `eligible/` → `[{achievement_id, achievement_name, eligible, reason, progress}]`, `progress/` → the same plus `claimed`, `list/` (catalog: icon, description, `has_vc`), `POST claim/<id>/` → `{achievement_name, vc_pending}` or 400 with `{progress}`. Progress dicts carry `current`, `required`, `percentage`. | Dev has 4 achievements and no rules; Task 7 seeds QA-only ones |
| Circles | `DELETE leave/<id>/` (creator: "The circle creator cannot leave. Delete the circle instead."; lead: "You are the lead. Transfer leadership before leaving."). `DELETE members/remove/<id>/ {muid}` (lead or creator only). `DELETE meeting/rsvp/<id>/` ("Cannot remove RSVP within 30 minutes of the meeting start time", "Cannot remove RSVP after joining the meeting"). `POST invite/<id>/ {muid, lead}`. `GET list/?status=joined\|pending\|not_joined&ig=&search=` | List filters recorded empty for one IG (Task 9 records a non-empty one) |
| Interest groups | `POST /api/v1/dashboard/ig/<id>/join/` (cap: "Cannot join more than 3 interest groups"; "Already joined…" is a 200). `DELETE /api/v1/dashboard/ig/<id>/leave/`. `GET /api/v1/public/ig/<id>/` → `interestGroup{…, icon_image, cover_image, office_hours, career_opportunities[], prerequisites[], impact_projects[]}` | Recorded shape; seeded IGs have no images |
| Events | `GET /dashboard/events/?search&event_type&ig_id&start_date&end_date&eligible_only=true&pageIndex&perPage`. `event_type` ∈ hackathon, workshop, webinar, seminar, bootcamp, meetup, conference, competition, ideathon, cultural_event, sports_event, community_event, expo, networking_event (`db/events.py`). Detail adds `linked_tasks[{id,title,description,hashtag,karma,bonus_time,bonus_karma,active,ig}]`, `viewer_can_access_registration`, `viewer_access_blocked_reason` | `eligible_only` + search: 22 events, 11 pages at perPage 2. Completed event: reason "This event has already completed." |
| Levels | `get-user-levels/` lists lvl1…lvl7; every level has **0 tasks on dev**. `user-profile.level` is `"lvl1"` for the QA student. The dashboard parses the digits (`level.utils.ts`, `parseLevelNumber`). | Root cause of the Journey bug (spec §13) |
| Support / legal | Support address `info@mulearn.org` (on mulearn.org). Legal: `https://mulearn.org/privacy-policy`, `https://mulearn.org/terms-and-conditions` (spec §10). The dashboard's Delete Account says "Contact support to delete your account". | — |

---

### Task 1: Notifications data — feed, unread count, read and archive (API-10)

**Files:**
- Modify: `lib/core/network/paging.dart` (add `PagePaging`), `lib/core/network/api_paths.dart`
- Replace: `lib/features/notifications/data/datasources/notifications_remote_datasource.dart`, `…/data/repositories/notifications_repository_impl.dart`, `…/domain/entities/app_notification.dart`, `…/domain/repositories/notifications_repository.dart`, `…/presentation/providers/notifications_controller.dart`
- Create: `lib/features/notifications/data/dtos/notification_dto.dart`, `lib/features/notifications/presentation/providers/unread_notifications.dart`
- Test: `test/core/network/paging_test.dart` (group), `test/features/notifications/notification_dto_test.dart`, `test/features/notifications/notifications_controller_test.dart`, `test/features/notifications/unread_notifications_test.dart`

**Interfaces:**
- Produces:
  - `abstract final class PagePaging { static Map<String, Object> query(int page, {int pageSize = 20}); static PageInfo parse(Map<String, dynamic> response); }` — `parse` reads `{count, page, page_size}`; `hasNext = page * page_size < count` (the dashboard's rule).
  - `ApiPaths.notifications = '/api/v1/notification/'`, `notificationsUnreadCount`, `notificationsReadAll`, `notificationRead(String id)`, `notificationArchive(String id)`.
  - Entity `AppNotification {id, type, category, title, description, entityType?, entityId?, redirectUrl?, isBroadcast, read, createdAt}` (the old `NotificationKind`/`targetRoute` go away).
  - `NotificationsController` (`PagedState<AppNotification>`; `refresh()`, `loadMore()`, `markRead(id)`, `markAllRead()`, `archive(id)`).
  - `@Riverpod(keepAlive: true, retry: noRetry) class UnreadNotifications` → `int`; watches `appAuthControllerProvider` (0 when signed out); `refresh()`; polls every 60 s while the app is resumed, refreshes on resume, and stops polling when paused (the dashboard's `REFETCH_INTERVAL`).
- Consumes: `PagedState`, `parseEachOrReport`, `ApiException`, `noRetry`.

- [ ] **Step 1: Record fixtures.** Re-run the existing `notifications_page1`/`notifications_unread_count` targets and add `notification_read_foreign` (PATCH `<random uuid>/read/` → 404 envelope). Expected: `notifications_page1` has `count` > 0 and a `results[0]` with every field in the facts table.
- [ ] **Step 2: Failing tests.**
  - `PagePaging.parse({'count': 35, 'page': 1, 'page_size': 20, ...})` → `hasNext` true; page 2 of 35 → false.
  - `NotificationDto` over `dev/notifications_page1` parses every item; `source: 'broadcast'` → `isBroadcast`; `created_at` parsed as UTC.
  - Controller: first page then `loadMore` requests `?page=2&page_size=20` and appends with dedupe by id. A `loadMore` failure keeps the loaded items and exposes the error for the retry row. `markRead` flips `read` at once and sends `PATCH …/<id>/read/`. A failed `markRead` restores `read: false` and rethrows the backend message. `archive` removes the item at once and restores it at its index on failure. `markAllRead` sends `PATCH read-all/` and marks every loaded item read.
  - `UnreadNotifications`: reads `unread_count`; returns 0 with no request when signed out; `markRead`/`markAllRead`/`archive` refresh it.
- [ ] **Step 3: Run** `flutter test test/features/notifications test/core/network/paging_test.dart` → FAIL (types missing).
- [ ] **Step 4: Implement.** Parse items with `parseEachOrReport(what: 'NotificationDto')`.
- [ ] **Step 5: Run** the same → PASS; `flutter analyze` clean.
- [ ] **Step 6: Live check (QA student).** Mark one unread notification read and confirm `unread-count` drops by 1. The backend has no unread action, so this read stays: ledger the id.
- [ ] **Step 7: Commit** `feat(notifications): real feed, unread count, read and archive`.

### Task 2: Notifications screen and tap-through (API-10, L16)

**Files:**
- Create: `lib/features/notifications/domain/notification_target.dart`
- Modify: `lib/features/notifications/presentation/screens/notifications_screen.dart`, `…/widgets/notification_list_tile.dart`, `lib/features/dashboard/presentation/screens/home_screen.dart` (the bell badge), `lib/core/router/app_router.dart` if the route needs the badge provider
- Test: `test/features/notifications/notification_target_test.dart`, `test/features/notifications/notifications_screen_test.dart`

**Interfaces:**
- Produces: `sealed class NotificationTarget` with `AppRoute(String location)`, `WebPage(Uri uri)` and `NoTarget`; plus `NotificationTarget notificationTarget(AppNotification n, {required Uri dashboardBase})`. Rules, in order:
  1. A `redirect_url` that is https or starts with `/`. Same-origin or relative `/dashboard/learning-circle/<id>` → `AppRoute('/circles/<id>')`, `/dashboard/events/<id>` → `/events/<id>`, `/dashboard/profile` → `/profile`. Any other relative path → `WebPage(dashboardBase.resolve(path))`; any other https URL → `WebPage`. Anything else is ignored and the typed rule applies.
  2. Typed: `learning_circle` + id → `/circles/<id>`; `EVENT_CANCELLED` + id → `/events/<id>`; other event types (organiser/approval/collab) → `WebPage(<base>/dashboard/manage-events/<id>)`; `karma_activity_log` → `/profile`; `company*`, `job*` and `mentor_application` → `WebPage` using the dashboard's paths from `notification-href.ts`; `media_content` → `WebPage(<base>/dashboard/weekly-twitches)` (until Plan 5).
  3. Otherwise `NoTarget`.
- Consumes: Task 1 controller and `UnreadNotifications`; `FlavorConfig.dashboardUrl`.

- [ ] **Step 1: Failing tests.**
  - `notification_target_test` table: one row per rule above.
  - `unsafe or unknown targets open nothing`: `redirect_url: 'javascript:alert(1)'`, `'http://x.org'`, `type: 'SOMETHING_NEW'` with no entity → `NoTarget`. `'https://evil.example/x'` → `WebPage` (external, like the dashboard).
  - Screen: items grouped under "Today" and "Earlier" by local date. Unread items show a dot and are announced "Unread". Tapping marks read, then navigates for an `AppRoute`. Swiping ← archives, then a toast "Notification archived". "Mark all read" calls the controller. The empty state reads "You're all caught up". Load-more errors show the retry row and keep the list.
  - Home: the bell shows the unread count (hidden at 0, "99+" above 99); its semantics label is "Notifications, N unread".
- [ ] **Step 2: Run** `flutter test test/features/notifications` → FAIL.
- [ ] **Step 3: Implement.** `WebPage` opens with `launchUrl(mode: LaunchMode.externalApplication)`. Reuse `MuEmptyState`, `ErrorRetryView` and `MuLoadMoreFooter`.
- [ ] **Step 4: Run** → PASS; analyze clean. **Step 5: Phone:** open Notifications as the QA student, tap an `LC_INVITE` row → the circle opens; the badge drops.
- [ ] **Step 6: Commit** `feat(notifications): inbox with tap-through, archive and unread badge`.

### Task 3: Settings (UX-03, SEC-14; Plan 2 minor 8)

**Files:**
- Create: `lib/features/profile/presentation/screens/settings_screen.dart`, `lib/features/profile/presentation/screens/change_password_screen.dart`, `lib/features/profile/presentation/providers/change_password_controller.dart`, `lib/core/config/app_links.dart`
- Modify: `lib/core/router/route_paths.dart` + `app_router.dart` (`/settings`, `/settings/password`); `profile_screen.dart` (a Settings entry in the header); `basic_details_tab.dart` (sign-out and the visibility toggle move to Settings); profile datasource/repository (`changePassword`); `ProfileController.togglePublic` (invalidates `myProfilePayloadProvider` after success)
- Test: `test/features/profile/change_password_test.dart`, `test/features/profile/settings_screen_test.dart`

**Interfaces:**
- Produces:
  - `abstract final class AppLinks { static final Uri privacyPolicy, terms; static const String supportEmail = 'info@mulearn.org'; static Uri deletionRequest(String muid); }`. `deletionRequest` is `mailto:info@mulearn.org` with subject `Account deletion request` and a body naming the muid.
  - `Future<void> ProfileRepository.changePassword({required String current, required String next})` → `POST ApiPaths.changePassword {current_password, password}`.
  - `String? validateNewPassword({required String current, required String next, required String confirm})`, returning the dashboard's messages: "Password must be at least 8 characters", "The new password must be different from the current password.", "Passwords do not match".
- Settings sections:
  - **Account:** Change password; Connected accounts → Discord row (Task 4 fills in the action; this task shows the status from `capabilities.needsDiscord`: "Connected" or "Not connected").
  - **Privacy:** Public profile switch.
  - **Legal:** Privacy policy, Terms.
  - **Sign out**, then **Delete account**. Delete opens a sheet that explains the request goes to support, deletion is permanent and handled within the support process, and the dashboard's "Contact support to delete your account". Its button is "Email support" (the `deletionRequest` mailto). No call to `DELETE /dashboard/profile/` (spec §11).

- [ ] **Step 1: Live check (no mutation).** `POST change-password/` with a wrong `current_password` → record `dev/change_password_wrong_current` (400 "Current Password is incorrect").
- [ ] **Step 2: Failing tests.**
  - The validator: each of the three messages, plus null for a valid triple.
  - The repository sends the exact body; the recorded 400 surfaces as `ApiException.message == 'Current Password is incorrect'` beside the current-password field.
  - On success: toast "Password changed" and pop.
  - The settings screen shows each section. "Delete account" opens the sheet and its button launches a `mailto:` whose path is `info@mulearn.org` (via a `UrlLauncherPlatform` fake). The Public profile switch calls `togglePublic` and the payload is invalidated.
- [ ] **Step 3: Run** → FAIL. **Step 4: Implement.** **Step 5: Run** → PASS; analyze clean.
- [ ] **Step 6: Live mutation (QA student).** Change the password to a temporary one, sign in through `/api/v1/auth/user-authentication/` with it, then change it back and sign in again.
  - Both sign-ins succeed: ledger it.
  - If the authserver rejects the new password: password change doesn't reach authserver logins. Ruling: hide "Change password" behind `false` with a ledger note, and tell the user (a backend/authserver gap; spec §2 forbids fixing it here).
- [ ] **Step 7: Commit** `feat(settings): settings screen — password, privacy, legal, sign-out, deletion via support`.

### Task 4: Discord connect (UX-02)

**Files:**
- Modify: `lib/core/config/env.dart`, `flavor_config.dart`, `.env.dev`, `.env.prod.example` (if present).
  - Add `DISCORD_AUTH_URL`. Dev: the dev dashboard's URL from the facts table. Prod: `defaultValue: ''`.
  - Change dev `DASHBOARD_URL` to `https://mulearn-dashboard.vercel.app` (the user named this the dev dashboard). Plan 1's `https://dev.mulearn.org` is the marketing site, so the Company hand-off and the web links went to the wrong host.
- Modify: `android/app/src/main/AndroidManifest.xml` — add an `autoVerify` VIEW intent-filter for `https://${discordRedirectHost}/dashboard/connect-discord`. The host comes from the redirect in `DISCORD_AUTH_URL`, set as a flavour `manifestPlaceholders` entry in `android/app/build.gradle(.kts)`: dev `mulearn-dev.vercel.app`, prod `app.mulearn.org`.
- Create: `lib/core/session/discord_connect.dart` (datasource + controller), `lib/features/profile/presentation/screens/connect_discord_screen.dart`
- Modify: router (`/dashboard/connect-discord` → the connect screen, query `code`; the sign-in redirect keeps `from=`), Settings Discord row, `task_detail_screen.dart` (when `needsDiscord`: "Connect Discord to earn karma" replaces the post-proof hint), app-resume hook (when `needsDiscord`, invalidate `currentUserProvider` on resume)
- Test: `test/core/session/discord_connect_test.dart`, `test/features/profile/connect_discord_screen_test.dart`, `test/core/router/deep_link_test.dart`

**Interfaces:**
- Produces:
  - `ApiPaths.connectDiscord = '/api/v1/register/connect-discord/'`.
  - `Future<void> SessionRemoteDataSource.connectDiscord(String code)` → `GET` with `queryParameters: {'code': code}`.
  - `@riverpod class DiscordConnectController` (`AsyncValue<void>`; `connect(String code)`). It runs once per code; on success it invalidates `currentUserProvider`.
  - `Uri? discordAuthUri` from flavour config (null when empty, which hides every Connect button).
- Flow: Connect → `launchUrl(discordAuthUri, mode: externalApplication)`. Discord redirects to `https://<host>/dashboard/connect-discord/?code=…`, the App Link opens the app, and the screen calls the API. It shows "Connecting…", then "Discord connected" (the dashboard's success copy is "You will be added to the discord server soon" from the API) with a "Open the μLearn server" link `https://discord.gg/gtech-mulearn-771670169691881483`, or "Couldn't connect Discord" + backend message + "Try again" (restarts the OAuth flow).
- **Ruling recorded in this plan:** the app uses the same authorize URL as the dev dashboard (dashboard parity; the backend's exchange `redirect_uri` must equal the one Discord was given, and only the backend's environment knows `FR_DOMAIN`). A verified App Link needs `/.well-known/assetlinks.json` on the redirect host.
  - **Dev:** that host is `mulearn-dev.vercel.app`, an old Vite build that is not a repo in this workspace (the user's approval covered `mulearn-dashboard`). Two ways to close it, both ops and neither a code change here: host `assetlinks.json` on `mulearn-dev.vercel.app`; or point the dev backend's `FR_DOMAIN` and the Discord app's redirect at `mulearn-dashboard.vercel.app` and add the file to `mulearn-dashboard` (feature branch from `dev`). Until then, Android opens the web page and the app picks the result up on resume via `exist_in_guild`, if the web completes it.
  - **Production:** `app.mulearn.org` is the Next dashboard (`mulearn-dashboard`, Netlify). Its `public/.well-known/assetlinks.json` needs the release/Play signing SHA-256, which isn't available here, so that file is a user item, not part of this task.
  - The intent-filter and the in-app handling ship now. They are testable with `adb shell am start -a android.intent.action.VIEW -d "https://mulearn-dev.vercel.app/dashboard/connect-discord?code=x" org.mulearn.muapp.dev`.

- [ ] **Step 1: Live check.** `GET connect-discord/?code=not-a-real-code` (QA student) → record `dev/connect_discord_bad_code` (failure envelope). Expected: `hasError: true`, message "Failed to get access token".
- [ ] **Step 2: Failing tests.**
  - `a link without a code makes no request`.
  - A code calls `GET …/connect-discord/?code=abc` exactly once even if the screen rebuilds.
  - Success invalidates `currentUserProvider`; the recorded failure shows "Failed to get access token" and "Try again".
  - `a signed-out link resumes after sign-in`: the router redirects `/dashboard/connect-discord?code=abc` to `/sign-in?from=…` and back after sign-in, keeping the code.
  - The trailing-slash form `/dashboard/connect-discord/?code=abc` matches the same route.
  - Task detail shows "Connect Discord to earn karma" only when `needsDiscord`; no Connect buttons when `discordAuthUri` is null.
- [ ] **Step 3: Run** → FAIL. **Step 4: Implement.** **Step 5: Run** → PASS; analyze clean.
- [ ] **Step 6: Phone.** Use the `adb am start` link above (bad code) → the failure screen shows the backend message. Confirm the Connect button opens Discord's authorize page.
- [ ] **Step 7: Commit** `feat(discord): connect Discord from the app via the dashboard redirect link`.

### Task 5: Home — learner summary, next meetup, setup checklist, level label (FEAT-05, spec §13)

**Files:**
- Create: `lib/core/utils/level_label.dart`, `lib/features/dashboard/data/dtos/learner_summary_dto.dart`, `lib/features/dashboard/domain/entities/learner_summary.dart`
- Modify: dashboard datasource/repository/controller (`learnerSummaryProvider`), `home_screen.dart` (`_KarmaHeroCard` reads the summary; a "Next up" card; a "Get set up" checklist), `api_paths.dart` (`learnerSummary`)
- Test: `test/core/utils/level_label_test.dart`, `test/features/dashboard/learner_summary_test.dart`, `test/features/dashboard/home_screen_test.dart`

**Interfaces:**
- Produces:
  - `int levelNumber(String? level)` (digits in `"lvl7"`; 1 when missing or < 1, as in the dashboard's `parseLevelNumber`) and `String levelLabel(String? level)` → `'Level N'`.
  - `@Riverpod(retry: noRetry) Future<LearnerSummary> learnerSummary(Ref)`, where `LearnerSummary {weeklyKarma, totalKarma, rank, activeCircles, streakDays, NextMeeting? nextMeeting}` and `NextMeeting {id, circleId, circleName, title, startsAt, durationMinutes, rsvpStatus}`.
- **Ruling:** the summary's `stats.streak_days` is used; `/home/learner/streak/` is not called (one request; the dashboard does the same).

- [ ] **Step 1: Re-record** `learner_summary`. Add a serializer fixture `serializer/learner_summary_no_meeting` (`next_meeting: null`) citing `api/dashboard/home/` views.
- [ ] **Step 2: Failing tests.**
  - `levelLabel('lvl1') == 'Level 1'`, `'lvl10'` → `'Level 10'`, `null` → `'Level 1'`.
  - The DTO parses both fixtures.
  - Home shows "Level 1", not "Level lvl1". It shows "+N this week" from `weekly_karma`, "N-day streak" (hidden at 0) and the rank from the summary.
  - The "Next up" card shows `title`, `circle_name` and the local start time, opens `/meetings/<id>`, and is absent when `next_meeting` is null.
  - "Get set up" lists "Connect Discord" (when `needsDiscord` and `discordAuthUri` exists) and "Join interest groups" (when the user has none). It disappears when both are done.
  - A summary failure shows the section's retry and doesn't blank the rest of Home.
- [ ] **Step 3–5:** run → FAIL, implement, run → PASS; analyze clean. **Step 6: Phone:** Home as the QA student shows "Level 1" and the seeded next meeting.
- [ ] **Step 7: Commit** `feat(home): learner summary, next meetup and setup checklist; readable level`.

### Task 6: Journey level status from the user's real level (spec §13)

**Files:**
- Modify: `lib/features/profile/presentation/screens/journey_screen.dart` (status from the profile `level`)
- Create: `lib/features/profile/domain/level_status.dart`
- Test: `test/features/profile/level_status_test.dart`, `test/features/profile/journey_screen_test.dart`

**Interfaces:**
- Produces: `enum LevelStatus { cleared, current, locked }` and `List<LevelStatus> levelStatuses(List<UserLevel> levels, {required String? currentLevel})`. A level whose number (`levelNumber(level.name)`) is below the current one is cleared, equal is current, above is locked. Task completion no longer decides the status.

- [ ] **Step 1: Failing tests.**
  - `dev/get_user_levels` (record it: lvl1…lvl7, all with 0 tasks) and `currentLevel: 'lvl1'` → `[current, locked × 6]`; `'lvl3'` → `[cleared, cleared, current, locked × 4]`.
  - Unsorted input still maps by number.
  - The screen header says "Level 1"; a level with no tasks says "No tasks in this level yet" instead of a 100% ring.
- [ ] **Step 2–4:** FAIL → implement → PASS; analyze clean. **Step 5: Phone:** Journey shows lvl1 "YOU ARE HERE" and the rest locked.
- [ ] **Step 6: Commit** `fix(journey): level status follows the user's level, not task completion`.

### Task 7: Achievements — earned, ready to claim, in progress; VC issue hidden (FEAT-06, SEC-04)

**Files:**
- Create: `lib/features/profile/data/dtos/achievement_progress_dto.dart`, `lib/features/profile/domain/entities/achievement_progress.dart`, `lib/core/config/feature_flags.dart`
- Modify: profile datasource/repository (`getEligible`, `getProgress`, `getCatalog`, `claim`), `achievements_controller.dart`, `achievements_tab.dart`
- Test: `test/features/profile/achievements_test.dart`

**Interfaces:**
- Produces:
  - `AchievementProgress {achievementId, name, eligible, claimed, reason?, current?, required?, percentage?}`.
  - `Future<ClaimResult> claim(String id)`, where `ClaimResult {achievementName, vcPending}`.
  - `abstract final class FeatureFlags { static const bool vcIssuance = false; }` (spec §10).
  - The own profile has three segments, labelled as the dashboard does: "Earned", "Eligible" and "In Progress". Another user's profile shows Earned only.
  - In Progress = `progress/` items that are not eligible, not earned and not in `eligible/` (the dashboard's filter). Icons and descriptions come from `list/` by id.
- **Seeding (executor script, admin account; scratch only, never committed):**
  - Create two achievements, both with `has_vc: false`: "QA Starter Badge" with rule `{rule_type: 'milestone', conditions: {milestone_type: 'total_karma', required_value: 0}}`, and "QA Rising Badge" with `required_value: 500`.
  - Record `achievement_eligible`, `achievement_progress` and `achievement_catalog` as the QA student.
  - Claim the Starter badge in the live check, record `achievement_claim_ok` and the repeat claim's failure.
  - Then, as admin, revoke the claim and delete both achievements. Ledger the ids and the cleanup.

- [ ] **Step 1: Seed and record** (above). Expected: eligible has the Starter badge; progress has Rising with `percentage` 0.
- [ ] **Step 2: Failing tests.**
  - The DTOs parse the fixtures, and a progress dict without `percentage` derives it from current/required.
  - The segments filter as specified.
  - Claim: the item moves Eligible → Earned (refetch), with a toast from the backend message. A failed claim shows the backend message and leaves the item in place.
  - "Issue" is absent while `FeatureFlags.vcIssuance` is false; "View" stays for issued items with a `vc_url`.
- [ ] **Step 3–5:** FAIL → implement → PASS; analyze clean. **Step 6:** live claim + cleanup (above).
- [ ] **Step 7: Commit** `feat(achievements): eligible and in-progress achievements with claim; hide VC issuance`.

### Task 8: Circle membership actions — leave, remove, cancel RSVP, invite as co-lead (FEAT-07)

**Files:**
- Modify: `api_paths.dart` (`circleLeave`, `circleMemberRemove`), circles datasource/repository (`leaveCircle`, `removeMember({muid})`, `cancelRsvp`, `sendInvite({muid, lead})`), `learning_circles_controller.dart`, `meetings_controller.dart`, `learning_circle_detail_screen.dart`, `meeting_detail_screen.dart`
- Test: `test/features/learning_circles/circle_membership_actions_test.dart`, `test/features/learning_circles/meeting_rsvp_test.dart`

**Interfaces:**
- Produces (repository): `leaveCircle(String id)` → `DELETE leave/<id>/`; `removeMember(String id, {required String muid})` → `DELETE members/remove/<id>/` with body `{muid}`; `cancelRsvp(String meetingId)` → `DELETE meeting/rsvp/<id>/`; `sendInvite(String id, {required String muid, bool asLead = false})` → body `{muid, lead}`.
- UI rules:
  - "Leave circle" in the detail menu is shown only to members who are neither lead nor creator. A lead sees "Transfer leadership before leaving." in its place.
  - "Remove" on a member row is for the lead or creator only, never on themselves or the creator. It confirms "Remove <name> from the circle?".
  - "Cancel RSVP" on the meeting is shown only when the user has RSVP'd, has not joined, and now is more than 30 min before the start.
  - The invite sheet gets an "Invite as co-lead" switch.
  - After success: leaving pops to the circles list and invalidates user circles; the others refetch the affected detail.

- [ ] **Step 1: Failing tests.**
  - Each repository call's method, path and body.
  - `cancel RSVP is offered only before the 30-minute cutoff`: start = now + 31 min → shown; now + 29 min → hidden; joined → hidden.
  - The menu visibility rules for member, lead and creator.
  - The backend's lead message ("You are the lead. Transfer leadership before leaving.") surfaces as a toast if the app's view was stale.
- [ ] **Step 2–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Live (QA accounts, seeded circles):**
  - The QA student leaves a seeded circle, then re-requests to join, and a seed lead accepts.
  - RSVP a meeting more than 30 min out, then cancel.
  - The QA mentor (as a lead) invites the QA student as co-lead, then the student rejects it.
  - Record the success envelopes as fixtures and ledger the cleanup.
- [ ] **Step 6: Commit** `feat(circles): leave, remove member, cancel RSVP and invite as co-lead`.

### Task 9: Circle discovery filters (FEAT-07, L7)

**Files:**
- Modify: circles datasource (`fetchCircles({pageIndex, String? status, String? igId, String? search})`), `learning_circles_controller.dart` (a `CircleFilter` family key), `learning_circles_screen.dart` (status chips All / Joined / Pending / Not joined, an IG picker from the catalog, a search field debounced 300 ms; the invitations section keeps its count badge)
- Test: `test/features/learning_circles/circle_filters_test.dart`

**Interfaces:**
- Produces: `@freezed CircleFilter {String? status, String? igId, String search}`, where status ∈ `joined | pending | not_joined` (the backend values). `CirclesController(CircleFilter)` is `PagedState`. Changing the filter restarts at page 1; empty values are omitted from the query.

- [ ] **Step 1: Record** `circles_filtered` (`?status=not_joined&search=<a seeded title word>&pageIndex=1&perPage=20`) → non-empty.
- [ ] **Step 2: Failing tests.**
  - The query carries only the set keys.
  - Typing within 300 ms sends one request.
  - A filter change discards the previous pages.
  - The empty state reads "No circles match these filters" and offers "Clear filters".
- [ ] **Step 3–5:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 6: Commit** `feat(circles): filter discovery by status, interest group and search`.

### Task 10: Events — filters, search, eligibility up front, linked tasks (FEAT-09, UX-07)

**Files:**
- Modify: events datasource (`fetchEvents({pageIndex, EventFilter filter})`), `events_controller.dart` (an `EventFilter` family key), `events_screen.dart` (a search field debounced 300 ms; filter sheet with Type (the 14 backend values, title-cased), "My interest groups" (pick one of the user's IGs → `ig_id`), From date (`start_date`) and "Only events I can join" (`eligible_only=true`)); `event_dto.dart`/`event.dart` (`canRegister`, `blockedReason`, `linkedTasks`); `event_detail_screen.dart`
- Create: `lib/features/events/domain/entities/event_linked_task.dart` (+ DTO)
- Test: `test/features/events/event_filters_test.dart`, `test/features/events/event_detail_eligibility_test.dart`

**Interfaces:**
- Produces: `@freezed EventFilter {String search, String? eventType, String? igId, DateTime? from, bool eligibleOnly}`; `EventLinkedTask {id, title, hashtag?, karma?, igName?}`.
- On the detail: `blockedReason` shows as an inline banner directly above the CTA. Register/Interested are disabled when `canRegister` is false. Linked tasks list as tiles with hashtag (copy button) and karma.
- **Ruling recorded in this plan:** `/dashboard/events/tasks/` is not added to the Tasks tab, because `task/list/`'s `events` category already lists event tasks there. Cost if wrong: event tasks visible only via task/list's rules.
- **Seeding:** as admin, add one task to a published seeded event (`manage/<event_id>/tasks/`) so `linked_tasks` is non-empty. Record `event_detail_linked_tasks` and the completed event's `event_detail_blocked`. Leave the task in place as seed data (allowed: realistic seed data, spec §10 note in the ledger).

- [ ] **Step 1: Seed and record** (above) plus `events_filtered` (`?search=…&event_type=workshop&eligible_only=true&pageIndex=1&perPage=20`).
- [ ] **Step 2: Failing tests.**
  - The query keys, with empty ones omitted and `start_date` as `YYYY-MM-DD`.
  - The debounce sends one request.
  - A filter change restarts paging.
  - `blocked events show the reason and disable registration` (the recorded completed event).
  - Linked tasks parse and render. The event with no linked tasks shows no section.
- [ ] **Step 3–5:** FAIL → implement → PASS; analyze clean. **Step 6: Phone:** Events as the QA student — search, Type: Workshop, and the completed event shows its reason.
- [ ] **Step 7: Commit** `feat(events): search and filters, eligibility before action, linked tasks`.

### Task 11: Interest groups — dedicated join/leave and a richer detail (FEAT-08, API-13, UX-07)

**Files:**
- Modify: `api_paths.dart` (`igJoin(id)`, `igLeave(id)`); IG datasource/repository (`join`, `leave`); `InterestGroupMembershipController.toggle` (uses join/leave instead of `ig-edit`, so no full-list rewrite); `interest_group_summary_dto.dart` + entity (`iconImage`, `coverImage`, `officeHours`, `impactProjects`); `interest_group_detail_screen.dart` (cover/icon with the current placeholder fallback; Office hours; Circles in this group (`circlesList?ig=`, first page); Events in this group (`events?ig_id=`, first page); Impact projects (from the detail)); `interest_group_card.dart` (the cap state)
- Test: `test/features/interest_groups/membership_test.dart` (replaces `membership_toggle_test.dart`), `test/features/interest_groups/ig_detail_test.dart`

**Interfaces:**
- Produces: `join(String id)` → `POST /api/v1/dashboard/ig/<id>/join/`; `leave(String id)` → `DELETE …/<id>/leave/`. `const int maxLearnerGroups = 3` (`dash_ig_view.py:1275`).
- Consumes: `myInterestGroupIdsProvider` (Plan 2), Task 9's `fetchCircles(igId:)`, Task 10's `fetchEvents(pageIndex: 1, filter: EventFilter(igId: id))`.
- The Profile → Edit interest groups multi-select keeps `ig-edit`: it is an explicit full-set editor, and it refreshes the payload first.

- [ ] **Step 1: Live (QA student).** Record the `public_ig_detail` fixture. The student is in 3 groups: join a 4th → record `ig_join_cap` (400 "Cannot join more than 3 interest groups"). Leave one, then rejoin it → record `ig_leave_ok`/`ig_join_ok`. Membership ends unchanged (ledger).
- [ ] **Step 2: Failing tests.**
  - Join and leave send the dedicated calls and never `ig-edit`.
  - `a learner in three groups can't join a fourth`: the card shows "You're in 3 of 3 groups. Leave one to join another." with no Join button. A raced 400 shows the backend message.
  - The detail parses `icon_image`/`cover_image` and falls back when null.
  - The detail's circles and events sections request `?ig=<id>` and `?ig_id=<id>`, and hide when empty.
- [ ] **Step 3–5:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 6: Commit** `feat(interest-groups): join and leave without rewriting membership; richer group page`.

### Task 12: Loading, empty, error and refresh states; labelled controls (UX-05, UX-08; Plan 2 minors 5, 7)

**Files:**
- Modify:
  - `MuIconButton`: `tooltip` becomes required and is used as the semantics label.
  - Every list screen with pull-to-refresh: Home, Profile, Events, Circles, IGs, Notifications, Leaderboard, Tasks.
  - `ProfileController.refresh`/`MyProgressSummaryController.refresh`: `await ref.refresh(myProfilePayloadProvider.future)`.
  - Mutation controllers that invalidate after an await (`college_change_controller`, `cover_photo_controller`, `profile_image_controller`, `learning_circles_controller`): hold `ref.keepAlive()` for the mutation and close it in `finally`.
- Create: `test/architecture/labelled_controls_test.dart`
- Test: per-screen widget tests under `test/features/**/…_states_test.dart`

**Interfaces:**
- Rules:
  - Pull-to-refresh awaits the refetch. On failure it keeps the data and shows a toast with the backend message.
  - A first-load failure shows `ErrorRetryView`; an empty list shows `MuEmptyState` with screen-specific copy.
  - Load-more failures keep the list and show the retry row.
  - Every `IconButton`/`MuIconButton` has a `tooltip`; image avatars get `semanticLabel` with the person's name.
  - A profile mutation no longer resets the Profile tab: the body keeps the previous data while the shared profile refreshes (`skipLoadingOnRefresh`).
- `labelled_controls_test`: scans `lib/` (skipping generated files) and fails on any `IconButton(` call without `tooltip:` within the call.

- [ ] **Step 1: Failing tests.**
  - The architecture test lists the current offenders: 26 icon buttons and 1 Semantics usage (counted 2026-11-13).
  - For each list screen: the refresh indicator stays until the data arrives, and a refresh failure keeps the old rows.
  - `college change finishes its invalidations after the sheet closes`: close the sheet mid-request, then check that `currentUserCollegeProvider` re-fetches.
- [ ] **Step 2–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Phone:** TalkBack reads the Home bell, the back buttons and the Profile edit button by name.
- [ ] **Step 6: Commit** `feat(ux): consistent loading, empty, error and refresh states; labelled controls`.

### Task 13: Close out Plan 3

**Files:**
- Modify: `docs/superpowers/specs/2026-11-12-app-parity-design.md` (add §14 "Gap status after Plan 3": one row per gap ID with commit, live evidence and what is pending), `tool/record_fixtures.dart` (every fixture this plan recorded is a target), `docs/rules.md` (`noRetry` for shared-state readers; `MuIconButton.tooltip` required)

- [ ] **Step 1:** Re-run the recorder for all targets. Expected: every target 200 except the deliberate failure fixtures (named `*_wrong_*`, `*_bad_*`, `*_cap`, `*_foreign`), which record their documented status.
- [ ] **Step 2:** `flutter analyze` → clean; `flutter test` → all pass; the dev APK builds (`flutter build apk --flavor dev -t lib/main_dev.dart`).
- [ ] **Step 3:** Write §14, including the user/ops hand-offs:
  - `assetlinks.json` on `mulearn-dev.vercel.app`, or the `FR_DOMAIN` move described in Task 4;
  - the Play signing fingerprint for `app.mulearn.org`;
  - the prod `DISCORD_AUTH_URL`;
  - whether a backend password change reaches authserver logins (Task 3).
- [ ] **Step 4: Commit** `docs: close out plan 3`.
