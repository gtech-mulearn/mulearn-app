# Plan 4 — Role workspaces (mentor, campus, enabler) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Give mentors, campus leads, enablers and lead enablers the work they do on the web dashboard, inside the current app design. Mentors get a hub, sessions, attendance, student requests, availability and an "acting as" scope. Campus roles get an overview, students, campus circles and groups, and approvals. Enablers get their campuses with review and notes. A role that isn't verified yet shows the dashboard's pending banner instead of a workspace.

**Architecture:** Two new feature folders, `lib/features/mentor/` and `lib/features/campus/` (enabler screens live in `campus/`), with the existing layers: datasource → DTO → entity → repository → controller → screen. Who sees what is decided once, in `core/session/workspace_access.dart`, from `/user/info/` roles, `/mentor/status/` applications and the profile's `role_verification`. Home and Profile only consume it. Workspaces are pushed routes (`/mentor…`, `/campus…`, `/enabler…`) opened from cards on Home and rows on Profile. They are not new tabs (spec §8.2 item 5). Home's cards make their own one-call summaries, because features never import each other.

**Tech Stack:** Flutter 3.47.9 / Dart 3.13.7, Riverpod 3.0.3 code-gen, go_router 16, Dio 5 + dio_cache_interceptor, Freezed 3, mocktail. No new packages.

**Spec:** `docs/superpowers/specs/2026-11-12-app-parity-design.md`: §8.2 item 5, §8.3 (definition of done), §10. Gap IDs: FEAT-10 (M1–M6), FEAT-11 (K1–K5), ROLE-02 (pending-role banner), UX-01 (role-aware home entry). Screen targets: `mulearn-app-audit/06-proposed-mobile-experience.md` §2.3, §2.4, plus its M1 and K1 sketches.

## Global Constraints

- No backend or authserver change. Use the contracts exactly as deployed on `https://dev.mulearn.org` (spec §2, §7).
- Before code depends on an endpoint, trace it to `mulearnbackend` `origin/dev` source and record a live dev response as a fixture with `tool/record_fixtures.dart` (PII scrubbed) (spec §6, §8.3).
- Import boundaries, enforced by `test/architecture/import_boundaries_test.dart`:
  - `features/X` never imports `features/Y`;
  - `core/` never imports `features/`;
  - `domain/` imports neither Flutter nor Dio.
- Colours and layout:
  - No colour literals in widgets (`test/architecture/no_color_literals_test.dart`).
  - Colours come from `MuColors`/`MuShadow`; pending states use `MuColors.warning`/`warningBg`/`warningFill`.
  - Current layouts, radii and shadows stay unchanged (user: "current design is good… make sure the design system colors are used").
- No `state =` after an `await` without `if (ref.mounted)`.
- Providers reading shared server state use `retry: noRetry`.
- A mutation that invalidates other providers after its request holds `ref.keepAlive()`.
- Pull-to-refresh is `MuRefresh`, rendered with `.when(skipError: true, …)`.
- Every icon-only button has a `tooltip` (`test/architecture/labelled_controls_test.dart`).
- **No timer-based polling.** Workspace data loads when a screen opens, on pull-to-refresh, and after the user's own mutation (user, 2026-11-13: about 70k members share one backend).
- No admin endpoints from the app. Admin calls (`admin@mulearn`, user-authorised) are allowed only in scratch seeding scripts.
- Dev mutations only with QA or seeded accounts, undone afterwards where the API allows (spec §10). Anything that can't be undone gets a ledger note.
- `flutter analyze` → `No issues found!`; `flutter test` all green; each commit also passes alone in `_worktrees/app-verify`.
- Never run `dart format` on the whole tree (Plan 3 ruling); format only the files you touch.
- One commit per task, in order, on `feat/app-parity`. No `Co-Authored-By`/AI trailer, never push. Leave the unrelated generated plugin-registrant changes (linux/macos/windows) out of every commit.
- Copy follows the dashboard where one exists (quoted per task). Errors show `ApiException.messageFor(e)`, i.e. the backend's own message.
- Times:
  - The backend sends ISO-8601 instants; show them in device local time.
  - The app sends `toUtc().toIso8601String()`.
  - Availability weekdays are `1=Mon … 7=Sun` (`db/mentor.py:83`), the same as Dart's `DateTime.weekday`.

## Review Focus

1. **A role the user holds but isn't verified.** This covers a self-registered Enabler (`role_verification` `is_verified: false`; see the signup escalation finding) and a mentor whose application is `PENDING`. Expected:
   - Home and Profile show the dashboard's pending banner.
   - No workspace card or row appears.
   - A deep link to `/campus` or `/mentor` shows the pending state and makes **no** workspace request.
   Pinned in Task 1 (`a pending role shows the banner and never builds the workspace`).
2. **Times near the day boundary and across zones.** Take a session at 23:30 IST, stored as 18:00Z. Expected:
   - It lists under the right local day.
   - The form sends UTC.
   - End ≤ start is refused before any request, with "Session start time must be before end time.".
   Pinned in Task 3 (`a late-evening session keeps its local day`, `end before start is refused locally`).
3. **Acting on stale state.** Examples: completing a session that is no longer `SCHEDULED`, answering a request someone already handled, approving a campus event that was already approved. Expected: the backend's message as a toast, a refetch of the item, and no optimistic success. Pinned in Task 4 (`complete on a non-scheduled session shows the backend message`), Task 5 and Task 11.
4. **Endpoints that fail on dev.** `campus/student-list/`, `campus/igs/<id>/members/`, `campus/learning-circles/<id>/members/` and `mentor/activity/` all return 500 on dev (2026-11-13). Expected: the app never calls them; circle and group rows open the existing public detail pages. Pinned in Task 9 and Task 10 (`no request goes to the failing members endpoints`).
5. **An approved mentor with no scope, or only the global scope.** Expected:
   - With no scope, the hub says "No mentoring scope yet" and New session is disabled with that reason.
   - With the global `MENTOR` scope, the form must pick an interest group before it can submit.
   Pinned in Task 3 (`a global mentor must pick an interest group`) and Task 2 (`no scope disables new session`).

## Facts this plan relies on (backend `origin/dev`, live dev 2026-11-13)

| Area | Contract | Live on dev (QA accounts) |
|---|---|---|
| Roles and verification | `/dashboard/user/info/` `roles`. Profile `role_verification: [{role, is_verified}]`. `/mentor/status/` → `[{id, status, mentor_tier, organization, verified_by, verified_at, created_at}]`. The dashboard's banner (`verification-status-banner.tsx`): **Mentor** is pending unless the overview has scopes or the application is APPROVED/REJECTED; **Enabler** is pending unless `role_verification` Enabler `is_verified`. | mentor: roles `[Mentor]`, Mentor `is_verified: false`, application APPROVED. enabler: `[Student, Enabler]` verified. campuslead: `[Student, Campus Lead]` verified |
| Campus gate | `campus_staff_required` (`api/dashboard/campus/dash_campus_helper.py:33`) = Campus Lead, Lead Enabler, Enabler, which is also the dashboard's `CAMPUS_MANAGEMENT_ROLES`. Zonal and District Campus Lead are **not** included. | — |
| Mentor gates | Sessions, participants, availability and requests are `role_required([Mentor])`. Mutations also need `mentor_active_required`: 403 "Your mentor account is deactivated. Please contact an administrator." Persona permission classes return `True`, so the active persona is a preference, not a gate (`utils/mentor_permissions.py`). | — |
| Mentor overview | `GET mentor/overview/` → `{scopes:[{scope_type, scope_id, scope_name, metrics:{total_ig_learners, active_ig_learners, inactive_ig_learners, upcoming_sessions, completed_sessions, pending_tasks, ig_learning_circles, open_opportunities, ig_tasks}]}`. `scope_type` ∈ `COMPANY_MENTOR`, `IG_MENTOR`, `CAMPUS_MENTOR`, `MENTOR` (global) (`db/user.py:194`). | 200 |
| Mentor analytics | `analytics/personal/` → `{sessions:{total, completed, upcoming, cancelled}, karma_earned, hours_contributed, profile_hours, rating:{average, count}, recent_feedback}`. `profile/completion/` → `{percentage, checklist:{about, expertise, linkedin, preferred_igs}}` | 75 % |
| Persona | `persona/status/` → `{active_persona, active_scope_type, active_scope_id, active_scope_name}`. `persona/current/` → `{active_persona, …, available_scopes:[{scope_type, scope_id}]}`. `POST persona/switch/ {persona: learner\|mentor, scope_type?, scope_id?}` | 200 |
| Sessions | `GET session/list/?status=&sortBy=starts_at\|-starts_at&pageIndex&perPage` lists only the caller's own sessions (`created_by`, not deleted). `status` is an exact match. `session/list/<id>/` returns the detail. Row: `{id, entity_id, entity_name, session_type, title, description, mode, starts_at, ends_at, status, created_by_id, created_by_name, created_at, max_participants, meeting_link, venue, is_recurring, parent_session_id, recurrence_type, recurrence_interval, recurrence_end_date}`. Status ∈ REQUESTED, SCHEDULED, PENDING_APPROVAL, COMPLETED, CANCELLED, REJECTED. Mode ∈ ONLINE, OFFLINE, HYBRID. | 2 SCHEDULED |
| Create / edit / delete | `POST session/create/` with `{session_type, entity_id, title, description?, mode, starts_at, ends_at, meeting_link?, venue?, max_participants?, is_recurring, recurrence_type?, recurrence_interval?, recurrence_end_date?}`. Errors: "session_type and entity_id are required."; "Session start time must be before end time."; ONLINE with a venue → `venue` error; OFFLINE with a link → `meeting_link` error; HYBRID needs both. `recurrence_type` ∈ DAILY, WEEKLY, MONTHLY. Scope → type: IG_MENTOR→IG_SESSION, CAMPUS_MENTOR→CAMPUS_SESSION, COMPANY_MENTOR→COMPANY_SESSION. A global mentor picks an IG, which becomes IG_SESSION (the dashboard's `applySessionTarget`). `PATCH session/update/<id>/` ("Cannot edit a session that is completed/cancelled/rejected."). `DELETE session/update/<id>/` soft-deletes. | — |
| Complete | `POST session/complete/<id>/` works only when SCHEDULED; otherwise "Only a scheduled session can be marked completed (current status: …)." It marks the mentor's own link ATTENDED with the duration in minutes. | — |
| Participants | `GET session/participant/list/<id>/` (paged; `search` on name/muid) → `{id (link), session_id, user_id, user_full_name, mu_id, participant_role, attendance_status, progress_note, feedback, contributed_minutes, …session_*}`. `PATCH session/participant/update/<link_id>/ {attendance_status: INVITED\|ATTENDED\|ABSENT, progress_note, contributed_minutes (>0)}`. `POST session/participant/add/<id>/ {muid}` | 1 participant |
| Student requests | `GET session/student-requests/` (paged) returns REQUESTED sessions in the mentor's scopes. `PATCH session/student-requests/<id>/verify/ {status: APPROVED\|REJECTED, starts_at?, ends_at?, mode?, meeting_link?, venue?}` (corrected in Task 5: POST is 405; the dashboard PATCHes). If it is no longer REQUESTED: 404 "Session request not found or is not in REQUESTED status.". A learner creates one with `POST session/student/request/ {session_type, entity_id, title, description, mode, starts_at, ends_at, meeting_link, venue, max_participants}`. | empty (Task 5 seeds one) |
| Availability | `GET/POST availability/`, `PATCH/DELETE availability/<id>/`. Row `{id, mentor_user_id, ig_id, ig_name, weekday, start_time, end_time, timezone, is_active, valid_from, valid_to, created_at}`. Write `{ig?, weekday, start_time "HH:MM", end_time, timezone (IANA; "Enter a valid IANA timezone name (e.g. Asia/Kolkata)."), is_active}` | empty |
| Mentor IGs | `GET mentor/tasks/ig-dropdown/` → `[{id, name}]` | 1 IG |
| Campus overview | `campus/home-summary/` → `{campus:{org_id, college_name, campus_code, campus_zone}, stat_cards:[{key, label, value, delta, delta_type, period}], member_funnel:{max, stages:[{key, label, count, percentage}]}, circle_health:[{circle_id, circle_name, ig_id, ig_name, member_count, sessions_per_month, last_session_at, status}], recent_activity:[{id, type, title, description, created_at, actor:{id, full_name, muid, profile_pic}, metadata}]}`. `campus/weekly-karma/` → `{college_name, "YYYY-MM-DD": n…}`. `campus/campus-details/` → `{…, campus_level, total_karma, total_members, active_members, rank, lead:{campus_lead, enabler}, karma_last_7_days, karma_last_30_days, active_ig_count}` | 200 for lead and enabler |
| Students | `campus/student-details/?search&sortBy=karma\|-karma\|level\|join_date\|full_name&is_alumni&ig&pageIndex&perPage` → `{full_name, muid, karma, rank, level, join_date, last_karma_gained, graduation_year, department, is_alumni, ig_count, lc_count}`. This is what the dashboard uses. `campus/students/<muid>/activity/` (paged; `search`) → `{id, task_name, ig_name, karma, status, created_at}`. **`campus/student-list/` returns 500.** | 23 students |
| Campus circles / IGs | `campus/learning-circles/` → `{id, name, ig_name, member_count, meeting_count, last_meeting_time}`. `campus/igs/` → `{id, name, code, campus_member_count, cover_image, icon_image}`. **The `<id>/members/` endpoints of both return 500.** | 14 circles, 22 IGs |
| Org-link approvals | `GET user/unverified-org-links/?search&pageIndex&perPage` is for Admin and Campus Lead; other roles get 400 "You do not have the required role". Row: `{id, user_id, full_name, muid, email, mobile, joined, org_id, org_title, org_type, graduation_year, is_alumni, link_created_at}`. `PATCH user/unverified-org-links/<id>/ {verified: bool}`; the dashboard only verifies ("Verify This Member"). | lead: empty (Task 11 seeds one) |
| Campus event approvals | `GET campus/events/?status=pending_campus_approval` (row `{id, title, status, scope, organiser_type, start_datetime, end_datetime, venue_type, venue_city, interest_count, cover_image, tags}`). `POST events/campus/<id>/approve/`. `POST events/campus/<id>/reject/ {reason}` ("A rejection reason is required."). Open to Campus Lead, Zonal and District Campus Lead, Enabler, Lead Enabler. If it is no longer pending: "Event is not pending campus approval." | 5 events, none pending |
| Collaboration invites | `GET events/my-invites/` → `[{id, entity_type, entity_id, entity_detail, role_label, invite_status, rejection_reason, responded_at, created_at, event_id, event_title, event_start_datetime, event_cover_image}]`, pending only, for entities the caller leads. `POST events/manage/<event_id>/collaborators/<id>/accept/`. `…/reject/ {reason}`. Dashboard nav: Campus Lead. | `[]` |
| Enabler | `enabler/home-summary/` → `{total_campuses, total_students, total_karma}`. `enabler/campuses/` (paged) → `{id, college_name, campus_code, zone, org_type}`. `campuses/<id>/review/` returns one campus. `campuses/<id>/notes/` GET (paged, newest first) / POST `{note, status?, priority?, follow_up_date?}` → `{id, enabler_name, note, status (default "open"), priority (default "medium"), follow_up_date, created_at, updated_at}`. There is no edit or delete. `role_required([Enabler, Lead Enabler])`. The dashboard does not use these endpoints. | 1 campus |

---

### Task 1: Who sees which workspace; the pending-role banner (ROLE-02)

**Files:**
- Create:
  - `lib/core/session/workspace_access.dart`, holding `WorkspaceState`, `WorkspaceAccess`, `deriveWorkspaceAccess`, `roleVerificationProvider` and `workspaceAccessProvider`.
  - `lib/core/widgets/role_pending_banner.dart`.
  - `lib/core/widgets/workspace_gate.dart`.
- Modify:
  - `lib/core/session/capabilities.dart`: remove `canUseCampusWorkspace`, which is now superseded.
  - `lib/core/session/role_titles.dart`.
  - `lib/app/app_redirect.dart`: `/mentor`, `/campus` and `/enabler` paths count as signed-in screens.
  - `lib/features/dashboard/presentation/screens/home_screen.dart` and `lib/features/profile/presentation/screens/profile_screen.dart`: add the banner.
  - `tool/fixture_scrub.dart`: add placeholders for `user_full_name`, `created_by_name`, `enabler_name`, `campus_lead`, `enabler` and `mu_id`, plus `mobile` and `email` inside rows.
  - `tool/record_fixtures.dart`: profiles for the three role accounts.
- Test:
  - `test/core/session/workspace_access_test.dart`;
  - `test/core/widgets/workspace_gate_test.dart`;
  - `test/app/app_redirect_test.dart` (group);
  - `test/features/dashboard/home_role_banner_test.dart`;
  - `test/tool/fixture_scrub_test.dart` (group).

**Interfaces:**
- Produces:
  - `enum WorkspaceState { hidden, pending, open }`.
  - `@freezed WorkspaceAccess {WorkspaceState mentor, WorkspaceState campus, WorkspaceState enablerCampuses, bool campusLead, String? pendingCampusRole}`.
    - `campusLead` is true when Campus Lead is held **and** verified. It gates org links and collaboration invites.
    - `pendingCampusRole` is the role title the banner names.
  - `WorkspaceAccess deriveWorkspaceAccess({required List<String> roles, required List<MentorApplication> mentorApplications, required Map<String, bool> roleVerified})`. Rules:
    - **mentor:** `hidden` without the Mentor role. Otherwise `open` if any application is `APPROVED`, `pending` if any is neither `APPROVED` nor `REJECTED`, else `hidden`. This is the dashboard's rule; the Mentor `role_verification` row stays false after approval on dev.
    - **campus:** `hidden` unless the user holds one of Campus Lead / Lead Enabler / Enabler. Then `open` if any held one is verified in `roleVerified`, else `pending`.
    - **enablerCampuses:** the same rule over Enabler / Lead Enabler.
  - `@Riverpod(keepAlive: true, retry: noRetry) Future<Map<String, bool>> roleVerification(Ref)` reads `myProfilePayloadProvider` `role_verification`.
  - `@Riverpod(keepAlive: true, retry: noRetry) Future<WorkspaceAccess?> workspaceAccess(Ref)` is `null` when signed out.
  - `RolePendingBanner({required String role})`. Copy is verbatim from the dashboard for Mentor and Enabler:
    - Mentor: "Mentor account pending verification" / "Your mentor profile is awaiting admin approval. You will be notified once your account is verified."
    - Enabler: "Enabler account pending verification" / "Your enabler profile is awaiting admin approval. You will be notified once your account is verified."
    - Campus Lead and Lead Enabler use the same pattern with their title. The dashboard shows no banner for these; this is the app's extension (ruling).
  - `WorkspaceGate({required WorkspaceState Function(WorkspaceAccess) select, required String role, required WidgetBuilder builder})`. It calls `builder` only when the state is `open`. When `pending` it shows the banner. When `hidden` it shows `MuEmptyState` "This workspace isn't available for your account." with a Back button.

- [ ] **Step 1: Record** the `user_profile_mentor`, `user_profile_enabler` and `user_profile_campuslead` fixtures, after the scrub additions (`dart run tool/record_fixtures.dart user_profile_mentor user_profile_enabler user_profile_campuslead`). Expected: each file's `role_verification` matches the facts table, and no real names or emails remain.
- [ ] **Step 2: Failing tests:**
  - `deriveWorkspaceAccess` against the recorded role accounts: mentor `open`; enabler `campus: open, enablerCampuses: open, campusLead: false`; campus lead `campus: open, campusLead: true`.
  - A table of edge cases:
    - Enabler unverified → `pending`, `pendingCampusRole == 'Enabler'`;
    - Zonal Campus Lead only → campus `hidden`;
    - mentor `PENDING` → `pending`;
    - mentor `REJECTED` only → `hidden`;
    - no Mentor role but an APPROVED application → `hidden`.
  - `a pending role shows the banner and never builds the workspace`: a builder that throws if called; deep link `/campus` with an unverified enabler → banner text, builder not called, no request to `/campus/`.
  - `appRedirect`: signed in, `/mentor/sessions/abc` and `/campus/students` stay; signed out, `/mentor` → `/sign-in?from=%2Fmentor`.
  - Home and Profile show the banner for a pending mentor and nothing for the QA student.
  - The scrub test: `user_full_name`/`mu_id`/`email`/`mobile` in nested rows are replaced.
- [ ] **Step 3: Run** `flutter test test/core/session/workspace_access_test.dart test/core/widgets/workspace_gate_test.dart test/app/app_redirect_test.dart test/features/dashboard/home_role_banner_test.dart test/tool`. Expected: FAIL (types missing).
- [ ] **Step 4: Implement**, then run the same command. Expected: PASS. `flutter analyze` → `No issues found!`.
- [ ] **Step 5: Commit** `feat(roles): workspace access from roles and verification; pending-role banner`.

### Task 2: Mentor hub and entry points (M1, UX-01)

**Files:**
- Create:
  - `lib/features/mentor/data/datasources/mentor_remote_datasource.dart`;
  - `…/data/dtos/{mentor_scope_dto, mentor_analytics_dto, mentor_profile_completion_dto, mentor_session_dto}.dart`;
  - `…/domain/entities/{mentor_scope, mentor_analytics, mentor_profile_completion, mentor_session}.dart`;
  - `…/domain/repositories/mentor_repository.dart`, `…/data/repositories/mentor_repository_impl.dart`, `…/data/mentor_repository_provider.dart`;
  - `…/presentation/providers/mentor_hub_providers.dart`;
  - `…/presentation/screens/mentor_hub_screen.dart`.
- Modify:
  - `lib/core/network/api_paths.dart`: add `abstract final class MentorPaths`.
  - `lib/core/router/route_paths.dart`, `lib/app/app_router.dart`.
  - `home_screen.dart`: add a `_WorkspaceCards` section with a dashboard-owned call.
  - `profile_screen.dart`: add a "Workspaces" row.
  - `tool/record_fixtures.dart`.
- Test: `test/features/mentor/mentor_dtos_test.dart`, `test/features/mentor/mentor_hub_screen_test.dart`, `test/features/dashboard/home_workspace_cards_test.dart`.

**Interfaces:**
- Produces:
  - **`MentorPaths`** (all under `/api/v1/dashboard/mentor/`): `overview`, `analyticsPersonal`, `profileCompletion`, `personaStatus`, `personaCurrent`, `personaSwitch`, `sessions` (`session/list/`), `session(id)`, `sessionCreate`, `sessionUpdate(id)`, `sessionComplete(id)`, `participants(id)`, `participantAdd(id)`, `participantUpdate(linkId)`, `studentRequests`, `studentRequestVerify(id)`, `availability`, `availabilitySlot(id)`, `igDropdown`.
  - **Entities:**
    - `MentorScope {MentorScopeType type, String id, String name, MentorScopeMetrics metrics}` with `enum MentorScopeType { igMentor, campusMentor, companyMentor, global, unknown }`.
    - `MentorScopeMetrics {totalIgLearners, activeIgLearners, upcomingSessions, completedSessions, pendingTasks, igLearningCircles, openOpportunities, igTasks}` (ints, default 0).
    - `MentorAnalytics {sessionsTotal, sessionsCompleted, sessionsUpcoming, sessionsCancelled, karmaEarned, num hoursContributed, double? ratingAverage, int ratingCount}`.
    - `MentorProfileCompletion {int percentage, Map<String, bool> checklist}`.
    - `MentorSession {id, entityId, entityName, SessionType type, title, description, SessionMode mode, DateTime startsAt, DateTime endsAt, SessionStatus status, int? maxParticipants, String? meetingLink, String? venue, bool isRecurring}`.
    - Enums in `…/domain/entities/session_enums.dart`, each with a `wire` string and `fromWire(String?)` that falls back to `unknown`:
      - `SessionType { igSession, campusSession, companySession, unknown }`;
      - `SessionMode { online, offline, hybrid, unknown }`;
      - `SessionStatus { requested, scheduled, pendingApproval, completed, cancelled, rejected, unknown }`;
      - `RecurrenceType { daily, weekly, monthly }`.
  - **Repository:** `getOverview()`, `getAnalytics()`, `getProfileCompletion()`, `getSessions({SessionStatus? status, required bool ascending, required int pageIndex, int perPage = 20})` → `(List<MentorSession>, PageInfo)`, `getSession(id)`.
  - **Providers** (auto-dispose, `noRetry`): `mentorOverviewProvider`, `mentorAnalyticsProvider`, `mentorProfileCompletionProvider`, `mentorNextSessionsProvider` (SCHEDULED, `sortBy=starts_at`, `perPage=5`, keeping only `endsAt` after now via `clockProvider`), `mentorRequestCountProvider` (`student-requests/?perPage=1` → `pagination.count`).
  - **Routes:** `RoutePaths.mentor = '/mentor'`, wrapped in `WorkspaceGate(select: (a) => a.mentor, role: 'Mentor')`.
  - **Hub layout** follows audit 06 "M1 Mentor home", top to bottom:
    - "Next up" (up to 3 sessions, each opening the detail; Task 4);
    - "Requests (n) · Review ›" (Task 5);
    - "Profile n% complete", whose missing checklist items link to "Finish on web" (`${FlavorConfig.dashboardUrl}/dashboard/profile` through `openExternalProvider`);
    - "This month": sessions completed, karma earned, ★ average with count;
    - one card per scope with its learner and session metrics;
    - "Sessions ›" and "Availability ›".
  - With no scopes, the hub shows "No mentoring scope yet" and the New session action is disabled with that reason.
  - **Home `_WorkspaceCards`**: "Mentor workspace · n upcoming sessions" → `/mentor`, where n is the sum of the scopes' `upcoming_sessions`.
    - It uses the dashboard feature's own call: `DashboardRepository.getMentorUpcomingCount()` → `GET mentor/overview/`.
    - It is shown only when `workspaceAccess.mentor == open`.
    - When the call fails, the card still shows, without the count.
  - **Profile:** a "Mentor workspace" row under a "Workspaces" header, same rule.

- [ ] **Step 1: Record:**
  - `mentor_overview`, `mentor_analytics`, `mentor_profile_completion`;
  - `mentor_sessions_scheduled` (`?status=SCHEDULED&sortBy=starts_at`);
  - `mentor_session_detail` (first id; the recorder may resolve it from the list);
  - `mentor_student_requests`, `mentor_ig_dropdown`.

  Expected: 200s matching the facts table.
- [ ] **Step 2: Failing tests:**
  - The DTOs parse every recorded fixture. Unknown enum strings become `unknown`, and a missing `rating.average` becomes `null`.
  - The hub renders "Next up" from the fixture, the completion percentage, and one card per scope.
  - `no scope disables new session` (overview `{scopes: []}`).
  - Home shows the mentor card only for an `open` mentor, and taps go to `/mentor`.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Phone:** sign in as the QA mentor (deep link `/mentor` with `am start`), check that the hub renders, and ledger the result.
- [ ] **Step 6: Commit** `feat(mentor): mentor hub and workspace entry on Home and Profile`.

### Task 3: Mentor sessions — list, create, edit, delete (M2)

**Files:**
- Create:
  - `lib/features/mentor/domain/entities/session_draft.dart`, `…/domain/session_filter.dart`;
  - `…/presentation/providers/mentor_sessions_controller.dart`, `…/presentation/providers/session_form_controller.dart`;
  - `…/presentation/screens/mentor_sessions_screen.dart`, `…/presentation/screens/session_form_screen.dart`.
- Modify: mentor datasource, repository and routes.
- Test: `test/features/mentor/session_draft_test.dart`, `test/features/mentor/mentor_sessions_screen_test.dart`, `test/features/mentor/session_form_test.dart`.

**Interfaces:**
- Produces:
  - **`SessionFilter`**: `enum SessionFilter { upcoming, awaitingApproval, completed, all }` with getters `SessionStatus? status` and `bool ascending`, which feed Task 2's `getSessions(status:, ascending:, pageIndex:)`.
    - upcoming = SCHEDULED, ascending (`sortBy=starts_at`);
    - awaitingApproval = PENDING_APPROVAL, descending (`-starts_at`);
    - completed = COMPLETED, descending;
    - all = no status, descending.
    - Chip labels: "Upcoming", "Awaiting approval", "Completed", "All".
  - **`MentorSessionsController(SessionFilter)`** is a `PagedState<MentorSession>` with `refresh`/`loadMore`. Rows group under local-date headers.
  - **`SessionTarget`**: `{SessionType type, String entityId, String label}`, built by `sessionTargets(List<MentorScope> scopes, List<IgOption> igs)`.
    - Each non-global scope maps to its type (IG_MENTOR→IG_SESSION, CAMPUS_MENTOR→CAMPUS_SESSION, COMPANY_MENTOR→COMPANY_SESSION) with the scope's id and name.
    - A global scope expands to one IG_SESSION target per IG from `igDropdown`.
  - **`SessionDraft`**: `{SessionTarget? target, String title, String description, SessionMode mode, DateTime? startsLocal, DateTime? endsLocal, String meetingLink, String venue, int? maxParticipants, bool isRecurring, RecurrenceType? recurrenceType, int recurrenceInterval = 1, DateTime? recurrenceEndDate}`.
    - `String? validate()` returns, in order:
      1. "Pick where this session belongs.";
      2. "Title is required.";
      3. "Session start time must be before end time." when end ≤ start;
      4. "Venue is required for a hybrid session." / "Meeting link is required for a hybrid session.";
      5. "Choose how often it repeats." when recurring with no type.
    - `Map<String, Object?> toCreateJson()` follows the dashboard's `toBackendPayload`:
      - UTC ISO times;
      - ONLINE sends `venue: ""`; OFFLINE sends `meeting_link: ""`;
      - empty optional strings are omitted;
      - `recurrence_end_date` is `YYYY-MM-DD` or `null`;
      - non-recurring drafts omit the recurrence keys.
    - `toUpdateJson()` is the same minus target and recurrence: an edit changes this session only (ruling: the web's `apply_to_series` stays on the web).
  - **Repository:** `createSession(SessionDraft)`, `updateSession(id, SessionDraft)` (PATCH), `deleteSession(id)` (DELETE `session/update/<id>/`), `getMentorIgs()` → `List<IgOption{id, name}>`.
  - **Routes:**
    - `/mentor/sessions`;
    - `/mentor/sessions/new` (declared before `:id`);
    - `/mentor/sessions/:id/edit`, prefilled from `getSession`, only for SCHEDULED, PENDING_APPROVAL or REQUESTED; others show "Cannot edit a session that is …".
  - **Delete** confirms "Delete this session?". A successful create, edit or delete invalidates the sessions controllers and `mentorNextSessionsProvider`, holding `keepAlive`.
  - **Pickers:**
    - "Where": the targets;
    - mode as a segmented control: Online / In person / Hybrid;
    - date and time pickers (local);
    - "Repeats" as a switch, then Daily / Weekly / Monthly, every n, and an optional end date.

- [ ] **Step 1: Failing tests:**
  - `a late-evening session keeps its local day`: `starts_at 2026-11-20T18:00:00Z` under an IST test zone groups under 20 Nov at 23:30. Use `TZ`-independent helpers: inject the offset through `clockProvider` or convert explicitly.
  - `end before start is refused locally`: no request is sent and the message is shown.
  - `toCreateJson`:
    - ONLINE with a venue typed then switched → `venue: ""`, `meeting_link` kept;
    - HYBRID missing the link → the validate message;
    - recurring weekly ×2 until 2026-12-31 → the exact keys.
  - `a global mentor must pick an interest group`: global scope plus 1 IG → that IG is the only target, and submit is disabled until it is picked.
  - Each filter chip sends its query. Load-more appends.
  - The backend `venue` field error shows under the field (`ApiException` field errors).
- [ ] **Step 2–3:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 4: Live (QA mentor):**
  1. Create an IG session 2 days out, ONLINE, then edit its title.
  2. Record `mentor_session_create_ok` and `mentor_session_create_bad_mode` (OFFLINE with a link → 400).
  3. Delete the session and confirm it has gone from `session/list/`.
  4. Ledger it.
- [ ] **Step 5: Commit** `feat(mentor): sessions list with filters; create, edit and delete sessions`.

### Task 4: Session detail — participants, attendance, add participant, complete (M3)

**Files:**
- Create:
  - `lib/features/mentor/data/dtos/session_participant_dto.dart`, `…/domain/entities/session_participant.dart`;
  - `…/presentation/providers/session_detail_providers.dart`, with `mentorSessionProvider(id)` and `SessionParticipantsController(id)`;
  - `…/presentation/screens/mentor_session_detail_screen.dart`, `…/presentation/widgets/attendance_sheet.dart`.
- Test: `test/features/mentor/session_participant_dto_test.dart`, `test/features/mentor/mentor_session_detail_test.dart`.

**Interfaces:**
- Produces:
  - `SessionParticipant {linkId, userId, fullName, muid, role, AttendanceStatus attendance, String? progressNote, String? feedback, int? contributedMinutes}` with `enum AttendanceStatus { invited, attended, absent, unknown }`.
  - Repository:
    - `getParticipants(sessionId, {pageIndex, String? search})`;
    - `updateParticipant(linkId, {AttendanceStatus? attendance, String? progressNote, int? contributedMinutes})`, which sends only the keys given;
    - `addParticipant(sessionId, {required String muid})`;
    - `completeSession(id)`.
  - Detail screen:
    - The header shows title, scope, local date and time, mode with a link (opened through `openExternalProvider`) or the venue, and a status pill.
    - "Participants (n)" rows show name, muid and an attendance chip (labels "Invited" / "Attended" / "Absent", as on the dashboard), plus minutes and note.
    - Tapping a row opens `AttendanceSheet`: Attended / Absent, minutes (> 0, "Minutes must be more than 0"), and a note.
    - "Add participant" takes a muid.
    - Learner feedback shows read-only.
    - "Mark as completed" appears only when the status is SCHEDULED. It asks "Mark Session as Completed" (dashboard title) and then refetches the detail and the lists.
  - Attendance updates are optimistic per row with rollback and toast on failure; the dashboard's quick "Absent" action is the same.

- [ ] **Step 1: Record** `mentor_session_participants` (the QA session). Expected: the facts-table shape, with names scrubbed.
- [ ] **Step 2: Failing tests:**
  - The DTO parses the fixture.
  - Attendance optimistic update and rollback: a 400 restores the chip and toasts.
  - `complete on a non-scheduled session shows the backend message`: a 400 with "Only a scheduled session can be marked completed (current status: COMPLETED)." → toast and refetch.
  - The Complete button is hidden for COMPLETED.
  - Add participant posts `{muid}`.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Live (QA mentor + QA student):**
  1. Create a session 1 hour out and add the QA student by muid.
  2. Mark them Attended with 30 minutes and a note.
  3. Complete it, then check the status is COMPLETED.
  4. Record `mentor_participant_update_ok` and `mentor_session_complete_twice` (the second complete → 400).
  5. Delete the session; the soft delete hides it.
  6. Ledger it.
- [ ] **Step 6: Commit** `feat(mentor): session detail with attendance, participants and completion`.

### Task 5: Student requests (M4)

**Files:**
- Create: `lib/features/mentor/presentation/providers/student_requests_controller.dart`, `…/presentation/screens/student_requests_screen.dart`, `…/presentation/widgets/approve_request_sheet.dart`.
- Test: `test/features/mentor/student_requests_test.dart`.

**Interfaces:**
- Produces:
  - `StudentRequestsController` is a `PagedState<MentorSession>`; requests use the session shape.
  - `answerRequest(id, {required bool approve, DateTime? startsLocal, DateTime? endsLocal, SessionMode? mode, String? meetingLink, String? venue})` → `POST …/verify/` with `status` APPROVED or REJECTED and only the overrides changed.
  - The route is `/mentor/requests`. Rows show title, requester-proposed local time, mode, Approve and Decline.
  - Approve opens a sheet prefilled with the proposed time and mode, which the mentor may change. Decline confirms.
  - On success: remove the row, decrement the count, and invalidate `mentorRequestCountProvider` and the Upcoming list.
  - On 404 "…not in REQUESTED status.": toast plus a list refetch.

- [ ] **Step 1: Seed:** as the QA student, `POST session/student/request/` an IG session request in the QA mentor's IG scope, 3 days out. Record `mentor_student_requests_one`.
- [ ] **Step 2: Failing tests:**
  - The list renders the seeded request.
  - Approve sends `{status: APPROVED}` plus the changed `starts_at` only.
  - Decline sends `{status: REJECTED}`.
  - A raced 404 toasts the backend message and refetches.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Live:**
  1. Approve the seeded request; it moves to SCHEDULED and shows under Upcoming.
  2. Seed a second request and decline it.
  3. Delete the approved session.
  4. Ledger it.
- [ ] **Step 6: Commit** `feat(mentor): review student session requests`.

### Task 6: Availability (M5)

**Files:**
- Create:
  - `lib/features/mentor/data/dtos/availability_slot_dto.dart`, `…/domain/entities/availability_slot.dart`;
  - `…/presentation/providers/availability_controller.dart`;
  - `…/presentation/screens/availability_screen.dart`, `…/presentation/widgets/slot_form_sheet.dart`.
- Test: `test/features/mentor/availability_test.dart`.

**Interfaces:**
- Produces:
  - `AvailabilitySlot {id, String? igId, String? igName, int weekday, int startMinutes, int endMinutes, String timezone, bool isActive}`. It parses `"HH:MM[:SS]"` and writes `"HH:MM"`.
  - `const mentorTimezones = ['Asia/Kolkata', 'UTC', 'Asia/Dubai', 'Asia/Singapore', 'Europe/London', 'America/New_York']`, defaulting to `Asia/Kolkata`.
    - Ruling: there is no package for the device's IANA name. A slot with another zone shows its own zone and keeps it on edit.
    - Cost if wrong: mentors elsewhere pick the nearest listed zone, or use the web.
  - `AvailabilityController`: `add(SlotInput)`, `update(id, SlotInput)`, `setActive(id, bool)`, `delete(id)`.
  - The route is `/mentor/availability`. Slots group Mon…Sun as "10:00–11:30 · Web Dev · Asia/Kolkata", each with an active switch.
  - "Add slot" asks for the day, start, end (end > start, "End time must be after start time"), an optional IG (from `igDropdown`) and the zone. Delete confirms.

- [ ] **Step 1: Failing tests:**
  - The time parse and format round-trip.
  - Weekday 7 is Sunday.
  - End ≤ start is refused.
  - The active switch is an optimistic PATCH `{is_active}` with rollback.
  - The backend's timezone error shows under the field.
- [ ] **Step 2–3:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 4: Live (QA mentor):**
  1. Add a Wednesday 18:00–19:00 slot and record `mentor_availability_list`.
  2. Turn it off, then delete it.
  3. Record `mentor_availability_bad_tz` (`timezone: "Mars/Base"` → 400).
  4. Ledger it.
- [ ] **Step 5: Commit** `feat(mentor): weekly availability slots`.

### Task 7: Acting-as scope and persona (M6)

**Files:**
- Create: `lib/features/mentor/data/dtos/persona_dto.dart`, `…/domain/entities/persona.dart`, `…/presentation/providers/persona_controller.dart`, `…/presentation/widgets/acting_as_menu.dart`.
- Modify: `mentor_hub_screen.dart`, `session_form_screen.dart` (default target).
- Test: `test/features/mentor/persona_test.dart`.

**Interfaces:**
- Produces:
  - `Persona {bool isMentor, MentorScopeType? scopeType, String? scopeId, String? scopeName}`.
  - `PersonaController` (keepAlive while the hub is open) offers `switchTo(MentorScope? scope)`. A `null` scope means "Learner" and sends `{persona: learner}`; otherwise it sends `{persona: mentor, scope_type, scope_id}`.
  - The hub header gets an "Acting as: <scope name> ▾" menu, listing the overview scopes plus "Learner".
  - The active scope:
    - becomes the default target in the session form;
    - is the scope card shown first on the hub.
  - The learner persona only changes the menu label and the default target. The dashboard's home ignores persona, and the backend gates nothing on it (facts table).

- [ ] **Step 1: Record** `mentor_persona_status`, `mentor_persona_current`.
- [ ] **Step 2: Failing tests:**
  - Each switch sends its body.
  - The menu marks the active scope.
  - The form defaults to it.
  - A 403 "deactivated" message is toasted and the label stays unchanged.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Live:** switch the QA mentor to its IG scope, then back to the scope it started on, read from `persona/status/` first. Ledger it.
- [ ] **Step 6: Commit** `feat(mentor): acting-as scope and persona switch`.

### Task 8: Campus overview and entry points (K1, UX-01)

**Files:**
- Create:
  - `lib/features/campus/data/datasources/campus_remote_datasource.dart`;
  - `…/data/dtos/{campus_summary_dto, weekly_karma_dto, campus_details_dto, campus_student_dto}.dart`;
  - `…/domain/entities/{campus_summary, campus_details, campus_student}.dart`;
  - `…/domain/repositories/campus_repository.dart`, `…/data/repositories/campus_repository_impl.dart`, `…/data/campus_repository_provider.dart`;
  - `…/presentation/providers/campus_overview_providers.dart`;
  - `…/presentation/screens/campus_overview_screen.dart`.
- Modify:
  - `api_paths.dart`: `abstract final class CampusPaths` and `EnablerPaths`.
  - Routes.
  - `home_screen.dart` `_WorkspaceCards`: add the campus card, with its own call to `campus/home-summary/`.
  - `profile_screen.dart`: Workspaces rows.
  - `tool/record_fixtures.dart`.
- Test: `test/features/campus/campus_dtos_test.dart`, `test/features/campus/campus_overview_test.dart`, `test/features/dashboard/home_workspace_cards_test.dart` (group).

**Interfaces:**
- Produces:
  - **`CampusPaths`** (under `/api/v1/dashboard/`):
    - `homeSummary`, `weeklyKarma`, `details` (`campus/campus-details/`);
    - `students` (`campus/student-details/`), `studentActivity(muid)` (URL-encoded);
    - `circles`, `igs`, `events`;
    - `orgLinks` (`user/unverified-org-links/`), `orgLink(id)`;
    - `eventApprove(id)`, `eventReject(id)`;
    - `myInvites`, `inviteAccept(eventId, id)`, `inviteReject(eventId, id)`.
  - **`EnablerPaths`:** `homeSummary`, `campuses`, `campusReview(id)`, `campusNotes(id)`.
  - **Entities:**
    - `CampusSummary {orgId, collegeName, campusCode, zone, List<StatCard> stats, List<FunnelStage> funnel, List<CircleHealth> circleHealth, List<CampusActivity> recentActivity}`;
    - `StatCard {key, label, num value, num? delta, String? deltaType, String? period}`;
    - `CircleHealth {circleId, circleName, igName, memberCount, sessionsPerMonth, DateTime? lastSessionAt, String status}`;
    - `WeeklyKarma {List<(DateTime day, int karma)>}`, where non-date keys are ignored;
    - `CampusDetails {level, totalKarma, totalMembers, activeMembers, rank, karmaLast7Days, karmaLast30Days, activeIgCount}`;
    - `CampusStudent {fullName, muid, karma, rank, level, joinDate, lastKarmaGained?, graduationYear?, department?, isAlumni, igCount, lcCount}`.
  - **Overview screen** (`/campus`, `WorkspaceGate(select: (a) => a.campus)`), laid out as audit 06 "K1":
    - title = college name;
    - the stat cards as `MuStatBlock`s;
    - the member funnel as horizontal bars;
    - the circle-health counts grouped by `status` (each opens `/circles/<id>`);
    - the weekly karma as a 7-day bar row;
    - "Recent activity";
    - "Top students" (`student-details?sortBy=-karma&perPage=5`) → "Students ›";
    - for `campusLead`, "Approvals (n) ›".
  - **Home card:** "Campus workspace · <college> · <first stat label> <value>" → `/campus`.
    - It uses `DashboardRepository.getCampusHeadline()` → `GET campus/home-summary/`, keeping `college_name` and the first stat card.
    - When the call fails, the card shows without the headline.
  - **Profile:** "Campus workspace", plus "My campuses" when `enablerCampuses == open` (Task 12).

- [ ] **Step 1: Record**, as campuslead and enabler: `campus_home_summary`, `campus_weekly_karma`, `campus_details`, `campus_students_top`.
- [ ] **Step 2: Failing tests:**
  - The DTOs parse the fixtures.
  - Weekly karma ignores `college_name` and orders the days.
  - The overview renders the stats, the funnel, the circle-health groups and the top 5.
  - The Approvals link appears only for `campusLead`.
  - Home shows the campus card only for `campus == open`.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Phone:** as the QA campus lead, open `/campus` and check it. Ledger it.
- [ ] **Step 6: Commit** `feat(campus): campus overview and workspace entry on Home and Profile`.

### Task 9: Students and student activity (K2)

**Files:**
- Create: `lib/features/campus/data/dtos/student_activity_dto.dart`, `…/domain/entities/student_activity.dart`, `…/domain/student_filter.dart`, `…/presentation/providers/campus_students_controller.dart`, `…/presentation/screens/{campus_students_screen, campus_student_screen}.dart`.
- Test: `test/features/campus/campus_students_test.dart`.

**Interfaces:**
- Produces:
  - `@freezed StudentFilter {String search, StudentSort sort, bool? alumni}` with `enum StudentSort { karma, level, joined, name }`. The query values are `-karma`, `-level`, `-join_date` and `full_name`.
  - `CampusStudentsController(StudentFilter)` is a `PagedState<CampusStudent>`. Search is debounced 300 ms (the Plan 3 pattern).
  - `StudentActivity {id, taskName, igName, karma, status, createdAt}`, with a paged controller per muid.
  - The routes are `/campus/students` and `/campus/students/:muid`.
    - The list row shows name, muid, level label (`levelLabel`), karma and rank, "n groups · n circles", and an alumni tag.
    - The student screen shows the row's facts, "View public profile ›" (`/u/<muid>`), and the activity list. When empty it says "No activity yet".
  - The app calls `student-details`, as the dashboard does, never `student-list` (500 on dev).

- [ ] **Step 1: Record** `campus_students_page1`, `campus_students_search` (a seeded name), and `campus_student_activity`. The activity fixture comes from a student who has activity: seed one approved task log through the admin script if none has any; ledger the seed.
- [ ] **Step 2: Failing tests:**
  - The sort and alumni chips send their query; search is debounced.
  - The row shows the level as "Level n".
  - The student screen shows activity, and the empty copy when there is none.
  - No request goes to `campus/student-list/`.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Commit** `feat(campus): campus students with search, sort and activity`.

### Task 10: Campus circles and interest groups (K3)

**Files:**
- Create: `lib/features/campus/data/dtos/{campus_circle_dto, campus_ig_dto}.dart`, `…/domain/entities/{campus_circle, campus_ig}.dart`, `…/presentation/providers/campus_groups_controllers.dart`, `…/presentation/screens/campus_groups_screen.dart`.
- Test: `test/features/campus/campus_groups_test.dart`.

**Interfaces:**
- Produces:
  - `CampusCircle {id, name, igName, memberCount, meetingCount, DateTime? lastMeetingTime}`.
  - `CampusIg {id, name, code, campusMemberCount, String? iconImage}`.
  - Two paged controllers.
  - The route `/campus/groups` has two tabs, "Circles" and "Interest groups", each with search.
    - A circle row ("n members · n meetings · last met <relative>") opens `/circles/<id>`.
    - An IG row ("n members from your campus") opens `/interest-groups/<id>`.
  - Ruling: the per-group member lists (`<id>/members/`) return 500 on dev, so the rows open the existing pages. Cost if wrong: a campus lead can't see member lists in the app until the endpoints are fixed; this goes on the TODO.

- [ ] **Step 1: Record** `campus_circles_page1`, `campus_igs_page1`.
- [ ] **Step 2: Failing tests:**
  - Both tabs render and paginate, and search sends `search`.
  - Rows navigate to the public routes.
  - `no request goes to the failing members endpoints`.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Commit** `feat(campus): campus circles and interest groups`.

### Task 11: Approvals — college links, campus events, collaboration invites (K4)

**Files:**
- Create:
  - `lib/features/campus/data/dtos/{org_link_request_dto, pending_campus_event_dto, collab_invite_dto}.dart`;
  - `…/domain/entities/{org_link_request, pending_campus_event, collab_invite}.dart`;
  - `…/presentation/providers/approvals_controllers.dart`;
  - `…/presentation/screens/campus_approvals_screen.dart`, `…/presentation/widgets/reason_sheet.dart`.
- Test: `test/features/campus/campus_approvals_test.dart`.

**Interfaces:**
- Produces:
  - **Entities:**
    - `OrgLinkRequest {id, fullName, muid, String? graduationYear, bool isAlumni, DateTime requestedAt}`. Email and mobile are **not** parsed or shown; the app needs no contact data (ruling, privacy).
    - `PendingCampusEvent {id, title, DateTime start, String? venueCity, String scope, List<String> tags}`.
    - `CollabInvite {id, eventId, eventTitle, DateTime? eventStart, String roleLabel, String entityName}`.
  - **Controllers:** `OrgLinkRequestsController` (paged, search), `PendingCampusEventsController` (paged, `status=pending_campus_approval`), and `collabInvitesProvider`.
  - **Actions:**
    - `verifyLink(id)` → PATCH `{verified: true}`. There is no reject, as on the dashboard.
    - `approveEvent(id)`; `rejectEvent(id, reason)`.
    - `acceptInvite(eventId, id)`; `rejectInvite(eventId, id, reason)`.
    - Each removes the row on success. A raced failure ("Event is not pending campus approval.", "Invite is already …") toasts and refetches.
  - **Screen** (`/campus/approvals`): sections, each hidden when empty, with an overall "Nothing to review" state.
    - "College links" (campusLead only): "Verify" asks "Verify <name> as a member of <college>?".
    - "Campus events" (any open campus role): Approve, or Reject with a required reason ("A rejection reason is required.").
    - "Collaboration invites" (campusLead only).

- [ ] **Step 1: Seed (scratch, admin where needed):**
  - a QA-only user with an **unverified** link to the campus lead's college;
  - a campus-scoped event by a seed student at that campus in `pending_campus_approval`;
  - a collaboration invite from a seed organiser's event to the campus.

  Record `campus_org_links_one`, `campus_events_pending`, `campus_collab_invites_one`, and `campus_org_links_enabler_denied` (enabler → 400).
- [ ] **Step 2: Failing tests:**
  - The DTOs drop email and mobile.
  - Each section's visibility by role.
  - Reject without a reason is refused locally.
  - The raced "already" messages toast and refetch.
  - Verify sends `{verified: true}`.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Live:**
  1. Verify the seeded link, then restore it with PATCH `{verified: false}`.
  2. Reject the seeded event with a reason; approve a second one.
  3. Accept or reject the invite.
  4. Delete the seeded events and users (admin script).
  5. Ledger every residue.
- [ ] **Step 6: Commit** `feat(campus): approvals for college links, campus events and collaboration invites`.

### Task 12: Enabler — my campuses, review and notes (K5)

**Files:**
- Create: `lib/features/campus/data/dtos/{enabler_summary_dto, enabler_campus_dto, campus_note_dto}.dart`, `…/domain/entities/{enabler_campus, campus_note}.dart`, `…/presentation/providers/enabler_controllers.dart`, `…/presentation/screens/{enabler_campuses_screen, enabler_campus_screen}.dart`, `…/presentation/widgets/note_form_sheet.dart`.
- Test: `test/features/campus/enabler_test.dart`.

**Interfaces:**
- Produces:
  - `EnablerCampus {id, collegeName, campusCode, zone, orgType}`.
  - `CampusNote {id, author, note, status, priority, DateTime? followUp, DateTime createdAt}`.
  - `EnablerCampusesController` is paged. The header is `enabler/home-summary` ("n campuses · n students · n karma").
  - `CampusNotesController(campusId)` is paged and has `add(NoteInput{note, priority, followUp})`.
    - Priority is one of `low | medium | high` ("medium" default). Status is left to the backend default "open" and shown read-only.
    - Ruling: the backend accepts free text and the dashboard has no notes UI, so the app offers the backend's default plus its two neighbours.
  - The routes are `/enabler/campuses` and `/enabler/campuses/:id` (`WorkspaceGate(select: (a) => a.enablerCampuses, role: 'Enabler')`).
    - The detail shows the review facts and the notes newest first, with "Add note".
    - With no notes: "No notes yet. Add what you discussed and when to follow up."
    - There is no edit or delete; the API has none.

- [ ] **Step 1: Record** `enabler_home_summary`, `enabler_campuses`, `enabler_campus_review`, `enabler_campus_notes`.
- [ ] **Step 2: Failing tests:**
  - The DTOs parse.
  - The notes list orders and empties correctly.
  - Add posts `{note, priority, follow_up_date}` (YYYY-MM-DD) and prepends the result.
  - "Not assigned to this campus" is toasted.
- [ ] **Step 3–4:** FAIL → implement → PASS; analyze clean.
- [ ] **Step 5: Live:** the QA enabler adds one note "[QA] app plan 4 check" to its campus and records `enabler_note_add_ok`. Ledger it as left in place: there is no delete API.
- [ ] **Step 6: Commit** `feat(campus): enabler campuses with review and notes`.

### Task 13: Close out Plan 4

**Files:**
- Modify: `docs/superpowers/specs/2026-11-12-app-parity-design.md` (add "§15 Gap status after Plan 4"), `docs/rules.md`, `docs/backend-and-ops-todo.md`.

- [ ] **Step 1:** Spec §15: a table with one row per gap (FEAT-10 M1–M6, FEAT-11 K1–K5, ROLE-02, UX-01) giving status, commits, live evidence and pending device checks. Add the findings for later plans.
- [ ] **Step 2:** `docs/rules.md`:
  - "Who sees a workspace is decided only in `core/session/workspace_access.dart`; screens use `WorkspaceGate`."
  - "Workspace routes live under `/mentor`, `/campus` and `/enabler`, and must be listed in `app_redirect.dart`."
- [ ] **Step 3:** `docs/backend-and-ops-todo.md`, backend gaps table:
  - `campus/student-list/`, `campus/igs/<id>/members/`, `campus/learning-circles/<id>/members/` and `mentor/activity/` return 500 on dev;
  - the Mentor `role_verification` row stays unverified after the application is approved;
  - enabler notes have no edit or delete;
  - a self-registered Enabler or Campus Lead is served campus data, because the JWT ignores `verified`; the app gates on it, but the backend should too.
- [ ] **Step 4:** Run `flutter analyze` and `flutter test`. Expected: `No issues found!` and all green. Build the dev debug APK.
- [ ] **Step 5: Commit** `docs: close out plan 4`.
