# μLearn App: Backend Parity and Gap Closure (Design)

**Date:** 2026-11-12 · **Branch:** `feat/app-parity` (from `origin/main@3becd80`) · **Status:** draft for approval
**Source of the gaps:** the audit in `../mulearn-app-audit/` (outside this repo; `10-gap-register-and-roadmap.md` is the master list). IDs below (API-01, AUTH-02, …) refer to that register.

## 1. Intent

The app was last changed on 2026-09-07. Since then the backend and dashboard moved on, and several core journeys are broken or missing. The goal is that **every app-side gap in the register is closed**, so a student, a mentor or an enabler can use the app against the current backend for everything the backend supports for their role. Every change is checked against the real backend, the dashboard and solid engineering practice.

"Done" (user's words): *every gap fixed*.

## 2. Decisions already made (by the user)

| Decision | Detail |
|---|---|
| Backend and authserver are off-limits | No changes to `mulearnbackend` or `authserver` in this work. Gaps that can only be fixed there stay open. The app works around or hides what depends on them. |
| Target backend | The deployed **`https://dev.mulearn.org`**. Its Google/Apple sign-in configuration is already set up. |
| Keep the current design | The September redesign (screens, components, five tabs) stays. A UI revamp happens later, after functionality. |
| Design-system colours | Every colour comes from the design-system tokens, aligned with the μLearn dashboard palette. No hardcoded colours in widgets. |
| Toolchain | Flutter **3.47.9** installed at `D:\Dev\tools\flutter`, on the user PATH. |
| Test accounts | A QA student account was created on dev (`qastudentone@mulearn`). Credentials are in Claude's memory file `reference_e2e_test_accounts.md`, never in the repo. |
| Git | New branch `feat/app-parity`. **No commits until the user confirms the whole job is done** (standing rule). No pushes. |

## 3. Facts confirmed live on dev (2026-11-12)

- `POST /api/v1/register/` does **not** require email verification on dev yet. It returns `{accessToken, refreshToken, data:{id, muid, email, role, full_name}}`.
- All `/api/v1/auth/*` paths are served by the authserver. `user-authentication/` (password and OTP), `get-access-token/` and `request-otp/` work. The backend's own `/api/v1/auth/refresh-token/` returns **404** on dev and must not be used.
- Access token 15 min; refresh token 7 days; `get-access-token` returns the **same** refresh token (no rotation). JWT claims: `id, muid, roles, expiry ("YYYY-MM-DD HH:MM:SS+00:00"), tokenType, iat`.
- `GET /api/v1/dashboard/user/info/` returns `muid, full_name, email, mobile, gender, dob, exist_in_guild, joined, roles[], profile_pic, dynamic_type[], user_domains[], user_endgoals[], interested_in_work, interested_in_gig_work, company`.

## 4. Goals

1. Every broken integration works against dev (API-01…API-07, API-09, API-13, API-14, AUTH-01, COMPANY-01, BUILD-01).
2. Every missing integration the backend already supports exists in the app (notifications, settings and account actions, Discord connect, learner summary and streak, achievement claim, circle leave/remove/cancel-RSVP/filters, IG join/leave and detail enrichment, event filters, linked tasks and eligibility, mentor workspace, campus/enabler workspace, problem statements, Weekly Twitches, μVerse reader, projects).
3. The app knows who the user is and what they can do (session + capabilities from `/dashboard/user/info/` and the JWT). Mentors and enablers get their tools, learners get theirs, and Company users are directed to the web.
4. The data layer can't silently drift again: recorded dev responses become contract fixtures, and every DTO is tested against them.
5. Reliability: sessions survive flaky networks; lists keep their data on refresh and load-more errors; uploads are compressed; the cache is user-scoped and cleared on sign-out.
6. Quality gates: `flutter analyze` with zero issues and `flutter test` green on every task. CI on `main` already runs both.

## 5. Non-goals (this round)

- Any backend or authserver change: SEC-01/02/03/04/05/06/07/08 server fixes, BE-1…7, server-side pagination of `user-log`, push delivery (FEAT-16), the VC issuance redesign.
- UI revamp: the tab restructure (UX-04), merging Journey with Mu Voyage (UX-06), radius/shadow changes, dark mode, new visual layouts.
- Localisation (no `intl`/ARB this round).
- OIDC "Sign in with μLearn" (AUTH-07). Not deployed on dev, so it can't be verified; it stays on the roadmap.

## 6. Anti-goals (failure even if it "works")

- Building against assumptions. Every endpoint used must be traced to backend code **and** confirmed with a real dev response (recorded as a fixture) before the screen is built on it.
- Exposing admin functionality, or calling admin endpoints.
- Weakening security to make a feature work (for example, completing VC issuance through the unauthenticated QSeverse proxy, or sending client-chosen credential content).
- Hardcoded colours or ad-hoc styles introduced while adding features.
- Leaving test data on dev without cleaning it up.
- Silent failures: parse errors must surface (log and degrade one item, never blank a whole screen, never drop data without a trace).

## 7. Constraints

- **No backend changes**, so the app must use the contracts exactly as deployed, including the three pagination conventions (`pageIndex/perPage`; `page/page_size` for notifications; unpaginated arrays) and validation errors that sometimes arrive under `response`.
- **Windows machine:** iOS can't be built or run here. iOS-only changes (`PrivacyInfo.xcprivacy`, iOS flavour schemes) can be written but **not verified**, and are marked so.
- **No Android SDK installed yet:** without it, verification is limited to `flutter analyze`, unit/widget/contract tests and live API checks. Running the app on a device needs the SDK (see open questions).
- **Shared dev database:** mutations (create circle, meetings, RSVP) only with QA accounts, removed afterwards where the API allows.
- **Discord linking:** the backend exchanges the Discord code with a hardcoded `redirect_uri = {FR_DOMAIN}/dashboard/connect-discord` (`api/register/register_views.py:28-76`), so the app can't receive Discord's code itself without host-side App Links.
- **Account deletion:** the backend `DELETE /dashboard/profile/` hard-deletes the user (cascade). The dashboard intentionally does **not** use it ("Contact support to delete your account").
- The existing stack and conventions in `docs/rules.md` stay (Riverpod code-gen, go_router, Dio, Freezed DTO→entity, feature-first), apart from the deliberate refinements in §8.

## 8. How it gets built (design)

### 8.1 Foundations (built first; everything else uses them)
- **Contract fixtures:** `test/fixtures/dev/<endpoint>.json`, recorded from dev with QA accounts by a small Dart CLI (`tool/record_fixtures.dart`, reading credentials from a gitignored `.env.qa`). PII is scrubbed before saving (emails, names, phones replaced). Every DTO gets a `fromJson` test over its fixtures, including null and edge variants.
- **Pagination:** `Paged<T>` plus adapters: `PageIndexPaging` (`pageIndex`, `perPage` → `{data, pagination:{count,totalPages,isNext,isPrev,nextPage}}`), `PagePaging` (`page`, `page_size`), `Unpaged`. A generic `PagedController<T>` handles refresh, load-more, dedupe by id, and keep-on-error with a retry row.
- **Errors:** `ApiException` also reads field errors from `response` when `hasError` is true (API-09). A typed `ApiError` classification (network, timeout, unauthorized, forbidden, validation, notFound, server).
- **Session and capabilities:** a `session` module owns tokens, `GET /dashboard/user/info/` (the "me" source), roles, `exist_in_guild` and persona. `capabilitiesProvider` derives `isLearner`, `isMentor` (plus mentor status), `isEnabler`, `isCampusLead`, `isCompany` and `needsDiscord`. The UI branches on capabilities only; the backend remains the authority.
- **Shared read models:** one provider per backend resource. `learnerSummaryProvider` (`/dashboard/home/learner/summary/` + `/streak/`) replaces the four duplicate `user-profile` fetches and the `ProfileEventBus`. Mutations invalidate providers by key.
- **Auth reliability:** a refresh network failure keeps the session (shows an offline state and retries); only an authoritative refresh rejection signs out. `FormData` is cloned before a retry. Sign-out calls `POST /api/v1/auth/logout/` (best-effort) and clears tokens, the HTTP cache and user-scoped providers.
- **Telemetry hook:** `PlatformDispatcher.instance.onError` plus a pluggable crash-reporter facade (no-op until a DSN or account is provided).
- **Design-system colours:** `MuColors` values aligned to the dashboard palette (brand blue `#2E85FE` stays primary; karma purple becomes `#8F44ED`; success/warning/danger fills from the dashboard, with darker text variants for contrast). Every widget literal (`Colors.*`, `Color(0x…)`) moves to tokens, enforced by a custom lint or test. The current layouts, radii and shadows are unchanged.

### 8.2 Order of work (each item is a plan task with its own tests and dev check)
1. **Stabilise:** BUILD-01 (duplicate `signingConfigs`); remove Company from mobile signup (COMPANY-01, Company users get a "manage on web" note); Google on Android (AUTH-02, see the open questions); sign-out revoke; telemetry hook.
2. **Contracts:** fixtures and paging/error foundations; fix API-01…07, API-13, API-14, IG list → `/public/ig/list/`, Google `isNewUser` → onboarding with `tempToken` (AUTH-01), Apple "no account" → sign-up guidance (AUTH-03), transient refresh (AUTH-05).
3. **Architecture:** session/capabilities, shared read models, user-scoped persistent cache, cross-feature imports removed (ARCH-02), `goBranch` for tab switches (UX-09).
4. **Missing functionality inside the current design:** notifications (feed + unread badge + mark read/archive + tap-through); Settings (change password, sign-out, account deletion per the open question, legal links); Discord connect; Home summary/streak/next meetup; achievements claim/eligible/progress; circles (leave, remove member, cancel RSVP, invite as co-lead, filters, invitations inbox); IGs (join/leave endpoints, detail with circles/events/impact projects); events (filters, search, linked tasks, eligibility shown up front); empty/error/refresh states everywhere (UX-05); a11y labels (UX-08 minus dark mode).
5. **Role workspaces:** mentor (home section, sessions, attendance, requests, availability, persona switch); campus and enabler (overview, students, approvals, enabler campuses and notes). Entry points sit inside the current Home and Profile, not new tabs.
6. **Content:** problem statements, Weekly Twitches (read-only), μVerse reader, projects.
7. **Hardening:** image compression, bundled fonts, list virtualisation, app-link handling for reset password (in-app parsing; host files are a hand-off), `PrivacyInfo.xcprivacy` and iOS flavours (written, unverified here).

### 8.3 Verification for every task (definition of done per task)
1. The backend view and serializer behind each endpoint used, read and cited in the task notes.
2. A live dev response recorded as a fixture; the DTO test passes on it.
3. The dashboard's equivalent behaviour checked (copy, rules, gating), with deliberate differences noted.
4. Tests first (TDD): controller/repository unit tests, widget tests for new UI states.
5. `flutter analyze` 0 issues; `flutter test` all green.
6. Where a mutation is involved: performed once on dev with a QA account, then cleaned up.
7. No new colour literals; no cross-feature imports.

## 9. Left to the builder

File and class naming within the conventions; exact widget composition using the existing `Mu*` components; test structure; fixture scrubbing details; the choice of image compression and lint packages (subject to the rules' "discuss new dependencies" clause; each new package is named in the plan with its reason).

## 10. Calls made by the designer (check these)

| Call | Reason |
|---|---|
| "Issue verifiable credential" is **hidden** (behind a disabled flag) until the backend offers a safe server-side endpoint | Making it work today means using an unauthenticated proxy with client-chosen content (anti-goal §6). |
| Email verification (AUTH-04) is **deferred until it is deployed on dev** | It isn't live on dev (confirmed), so it can't be verified. Building against an unpushed branch breaks the "verify against dev" rule. It stays on the list as blocked. |
| Jobs and learner mentor sessions (FEAT-19) are **not built** | The dashboard deliberately hides both for learners. The app follows the dashboard. |
| Company role: removed from mobile registration; Company users see a "manage your company on the web" note | Company features are web-only, and mobile company signup is broken. |
| Legal links: `https://mulearn.org/privacy-policy`, `https://mulearn.org/terms-and-conditions` | Both found live (HTTP 200) and linked from mulearn.org. |
| Crash reporting: facade plus `PlatformDispatcher.onError` now; provider (Sentry or Crashlytics) wired when an account or DSN exists | No account exists yet. The hook costs nothing. |
| iOS-only items (`PrivacyInfo.xcprivacy`, iOS dev/prod flavours) are written but marked **unverified** | No Mac or Xcode on this machine. |
| No store submission or version bump in this round | Release is the release owner's step. |
| Test data on dev is created only with QA accounts and removed afterwards where the API allows | Shared dev database. |

## 11. User answers (2026-11-12)

| Question | Answer | Effect on the build |
|---|---|---|
| Install the Android SDK and an emulator on D:? | **Yes** | Every task also gets a run on the Android emulator (dev flavour) where it has UI. |
| Account deletion | **Contact support, for now** | Settings → "Delete account" opens a request flow: explain what happens, then hand off to support (support address taken from mulearn.org; never a fake one). No call to `DELETE /dashboard/profile/`. |
| Mentor / Enabler / Campus Lead QA accounts | **The user will approve them on dev** | Claude registers QA accounts per role and gives the user their muids to approve. Role-workspace tasks wait for the approval. |
| Google sign-in on Android (web client ID, Android OAuth client) | **Pending; continue building** | AUTH-02 is blocked. Until the values arrive, the Google button is hidden on Android, and the code path is ready for a `serverClientId` from env config. |
| Discord connect via App Links | **Yes, the dashboard repo may be touched** | Add `public/.well-known/assetlinks.json` (and the iOS `apple-app-site-association`) to `mulearn-dashboard` on its own feature branch from `dev` (never `master`/`production`). The app handles `https://dev.mulearn.org/dashboard/connect-discord?code=…` and calls `/register/connect-discord/` itself. Signing-key fingerprints are needed for the file. |

**Approval:** the user said "continue building" after answering; treated as approval of this design.

## 12. Gap status after Plan 1 (2026-11-12)

Dev was seeded through its APIs on 2026-11-12 (admin account, user-authorised): 23 interest groups, 12 learners at the dev college, 14 learning circles with invites, 9 meetings, 30 events, 2 mentor sessions; the QA mentor was assigned IG mentor. Each row's commit is on `feat/app-parity`; "isolated" means analyze + the full suite passed on that commit alone.

| Item | Status | Evidence / what is pending |
|---|---|---|
| Build hygiene (signing, Flutter pin, analyzer) | Done | `f2c4749` |
| Fixture + fake-HTTP test support | Done | `a01cb37`; fixtures re-recorded against seeded dev in `3255dab` |
| API-01/02, REL-02 paging (events, circles) | Done — device check pending | `485c3d0`; dev has 22 events visible to the QA student (2 pages). Paging on the phone not yet confirmed by the user. |
| API-09 errors under `response` | Done | `6b31d5f`; live 400 from `PATCH /dashboard/profile/` |
| API-15 event organiser objects (new) | Done — device check pending | `3255dab`; found with seeded data: IG/campus-organised events broke the Events list and Home "Happening soon" |
| API-03 circle meeting paging | Done | `cfc8844`; live paginated list recorded |
| API-04/05 invites | Done | `bb66b4b`; live: old body 400, `{action}` 200, repeat 400 |
| API-06 calendar mentor sessions | Done | `bd35760`; live with 2 real sessions after mentor assignment |
| API-07 leaderboard rows, profile links | Done | `651a6d2`; dev student boards stay empty for seeded users — the cron ranks only `exist_in_guild` users |
| API-11/12/14 dead code and fields | Done | `397c71f`; department now from `GET /dashboard/profile/` (live) |
| AUTH-01/02/03 social sign-in | Done — real accounts pending | `f0ab1e6`; contracts verified in authserver/backend source. Android Google needs the web client id (`GOOGLE_SERVER_CLIENT_ID`); Apple needs an iOS device. |
| COMPANY-01 company sign-up | Done | `3af429b`; handed off to the dashboard (`DASHBOARD_URL`) |
| AUTH-05, REL-05, SEC-09, SEC-12 session + sign-out | Done — device cycle pending | `7e91c66`; live: logout revokes the refresh token |
| SEC-05 IG member emails | Backend-only | Not an app change (see Plan 1 "Correction to the audit") |
| API-13 IG icon fields | Moved to Plan 3 | Seeded IGs have no icon images yet |

New findings for later plans:
- Action controllers set `state` after an `await` without `ref.mounted`; leaving a screen mid-request throws (hardening plan).
- The dev database lost `interest_group.icon` outside db-scripts on 2026-11-12; restored by the user. A restore alter (1.93) sits uncommitted in a db-scripts worktree by the user's choice.

## 13. Gap status after Plan 2 (2026-11-12)

| Item | Status | Evidence / what is pending |
|---|---|---|
| Typed error kinds (§8.1 Errors) | Done | `ebd8152` |
| ARCH-04 / REL-03 / REL-04 telemetry hook | Done (logging reporter) | `f9bdc36`; a Sentry/Crashlytics account is still needed to send reports anywhere |
| Mutations after leaving a screen (Plan 1 finding) | Done | `8347965`; architecture test forbids the pattern |
| Session + capabilities (§8.1, SEC-13, ARCH-02 profile→auth) | Done | `daf9518`; live: QA mentor's role link is unverified while its application is APPROVED — capabilities use `/mentor/status/` |
| ARCH-07 / PERF-01 shared user-profile read model | Done | `0a93404`; one request for Profile, Home summary, IG membership, college; ProfileEventBus removed |
| SEC-12 / PERF-04 persistent, user-scoped cache | Done | `4b91c17`; Hive store opened on the phone without falling back |
| ARCH-02 module boundaries | Done | `87871b9`; architecture test enforces feature/core/domain rules |
| UX-09 / REL-06 tab navigation | Done — device check pending | `1ec49b2` |
| DS-01 dashboard colour tokens | Done | `987853b`; contrast and no-literal tests; seen on the phone (purple avatar/karma glow) |

Seen on the phone (2026-11-12, QA student): Home "Happening soon" now lists the featured events (Plan 1 Task 4b confirmed).

New findings for Plan 3:
- Home shows the raw level name ("Level lvl1"); the dashboard formats it.
- Journey marks lvl2–lvl6 "CLEARED" and lvl7 "YOU ARE HERE" for a 0-karma lvl1 student — the level status logic disagrees with `/profile/user-profile/`'s `level`.
- Riverpod 3 auto-retries failing providers app-wide; only the shared profile opts out. Decide a global retry policy (hardening plan).
