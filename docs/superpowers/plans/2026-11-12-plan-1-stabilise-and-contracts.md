# Plan 1: Stabilise and Fix Broken Contracts — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the app build cleanly and make every currently broken backend integration correct against `https://dev.mulearn.org`, with fixture-backed tests that stop the same drift from happening again.

**Architecture:** Keep the existing feature-first Riverpod/Dio/Freezed structure. Add three small foundations in `core/` and `test/support/`: a pagination helper for the backend's `pageIndex/perPage` convention, a fake Dio adapter, and a fixture loader with a recorder. Then fix each broken contract in its own feature, test-first, against recorded or serializer-derived fixtures.

**Tech Stack:** Flutter 3.47.9 / Dart 3.13.7, Riverpod 3 (code-gen), go_router 16, Dio 5, Freezed 3 + json_serializable, mocktail.

**Spec:** `docs/superpowers/specs/2026-11-12-app-parity-design.md` (gap IDs refer to `../mulearn-app-audit/10-gap-register-and-roadmap.md`).

**This is plan 1 of 6.** Plan 2: session, capabilities, shared read models, design-system colours, telemetry. Plan 3: missing learner functionality (notifications, settings, Discord, home summary, achievements, circle/IG/event enrichment, states, accessibility). Plan 4: mentor and campus workspaces. Plan 5: content (problem statements, Weekly Twitches, μVerse, projects). Plan 6: hardening (images, fonts, virtualisation, app links, iOS items). Each is written when the previous one is done, so its interfaces come from real code.

## Global Constraints

- Backend target: `https://dev.mulearn.org`. **No changes to `mulearnbackend` or `authserver`.**
- Toolchain: Flutter **3.47.9** at `D:\Dev\tools\flutter`; JDK 21 at `D:\Dev\tools\jdk-21`; Android SDK at `D:\Dev\tools\android-sdk`; emulator AVD `mulearn_api36`.
- **No git commits and no pushes** until the user confirms the whole job is done. Each task ends with a checkpoint (`git status --short` plus a review of the diff) instead of a commit.
- `flutter analyze` must report **No issues found!**, and `flutter test` must pass, at the end of every task.
- After any change to a `@freezed`, `@riverpod` or `@JsonSerializable` file, run `dart run build_runner build --delete-conflicting-outputs`. Generated files are kept in the repo (rules.md §7).
- Every endpoint a task touches: cite the backend view and serializer (file:line at `mulearnbackend@87f7f80a`) in the task's checkpoint notes, and test against a fixture. Fixtures come from **dev** where dev has data, or from the **serializer** (marked `"source": "serializer"`) where it doesn't. Re-record them in Plan 3 once dev is seeded.
- Live checks on dev use **QA accounts only** (credentials in `.env.qa`, gitignored; never in source, logs or fixtures). Remove any data a check creates, where the API allows.
- No new colour literals (`Colors.*`, `Color(0x…)`) in feature code; use `MuColors`. No new cross-feature imports.
- New dependencies allowed in this plan: none, except bumping `riverpod_lint` (Task 1).
- UI copy: plain, specific, no invented data. Keep the current visual design.

## Review Focus

1. **Scroll listener firing `loadMore` repeatedly while a page is in flight**: exactly one request per page, no duplicate rows (Task 3 test `concurrent loadMore issues one request`).
2. **Empty dev data** (`data: []`, `count: 0`): an empty state, never an error, and no further page requests (Task 3 test `empty first page`, Task 5 test `empty meeting list`).
3. **Token refresh while offline or timing out**: the user stays signed in and sees a network error, not a forced sign-out (Task 13 test `refresh timeout keeps the session`).
4. **Signing out with no network**: local sign-out still completes and the cache is cleared (Task 13 test `signOut clears locally when logout call fails`).
5. **Responding to an invitation that was already answered elsewhere**: the backend's message "This invitation has already been responded to" is shown, not "Request failed (400)" (Task 6 test `already responded message surfaces`).

---

### Task 1: Build and toolchain hygiene

**Files:**
- Modify: `android/app/build.gradle.kts` (delete the duplicate `signingConfigs` block at lines 71–80; add the prod-release guard)
- Modify: `lib/features/auth/data/repositories/auth_repository_impl.dart:33,49,98,114` (`return await …` inside `try`)
- Modify: `pubspec.yaml` (`riverpod_lint: ^3.1.9`), `analysis_options.yaml` (plugin config)
- Modify: `.github/workflows/ci.yml`, `release-dev.yml`, `release-prod.yml` (pin `flutter-version: 3.47.9` next to `channel: stable`)
- Modify: `README.md` ("Prerequisites": Flutter 3.47.9)

- [ ] **Step 1: Confirm the baseline.** Run `flutter analyze`. Expected: 5 issues (4× `unawaited_return_in_try_block` in `auth_repository_impl.dart`, 1× `analysis_options_deprecated_plugins`).
- [ ] **Step 2: Fix the four returns.** Change `return _completeSignIn(payload);` to `return await _completeSignIn(payload);` at the four sites.
- [ ] **Step 3: Move riverpod_lint to the new analyzer plugin system.** Set `riverpod_lint: ^3.1.9` in `dev_dependencies`. Remove `analyzer: plugins: - custom_lint` and add a top-level block:
  ```yaml
  plugins:
    riverpod_lint: ^3.1.9
  ```
  Run `flutter pub get`. **If resolution fails** (an analyzer constraint conflict with `freezed`/`riverpod_generator`/`json_serializable`), revert to 3.0.3 and instead add `analysis_options_deprecated_plugins: ignore` under `analyzer: errors:` with a comment naming the blocking package and version.
- [ ] **Step 4: Verify analyze.** Run `flutter analyze`. Expected: `No issues found!`. Run `flutter test`. Expected: all 47 pass.
- [ ] **Step 5: Fix the Gradle signing config.** Delete the second `signingConfigs { … }` block (lines 71–80). Above `android {`, add:
  ```kotlin
  val isProdRelease = gradle.startParameter.taskNames.any { it.contains("ProdRelease", ignoreCase = true) }
  if (isProdRelease && !hasReleaseKeystore) {
      throw GradleException("Prod release builds need android/key.properties — see docs/releases.md.")
  }
  ```
- [ ] **Step 6: Verify all three build paths.**
  - `flutter build apk --flavor dev --debug -t lib/main_dev.dart` → `Built build\app\outputs\flutter-apk\app-dev-debug.apk`.
  - `flutter build apk --flavor prod --release -t lib/main_prod.dart` with no `key.properties` → fails with the message above.
  - Create a throwaway keystore in the scratchpad (`keytool -genkeypair -keystore <scratch>/tmp-release.jks -alias tmp -keyalg RSA -keysize 2048 -validity 1 -storepass tmppass -keypass tmppass -dname CN=tmp`) and a temporary `android/key.properties` pointing at it. Run the prod release build → `Built …app-prod-release.apk`. **Delete `android/key.properties` and the keystore** afterwards, and confirm `git status` doesn't list them.
- [ ] **Step 7: Pin Flutter in CI.** Add `flutter-version: 3.47.9` to each `subosito/flutter-action@v2` step. Update the README prerequisites line.
- [ ] **Step 8: Checkpoint.** `git status --short` lists only the files above plus `pubspec.lock`. Re-run `flutter analyze` and `flutter test`.

### Task 2: Fixture and fake-HTTP test support

**Files:**
- Create: `test/support/fake_http_adapter.dart`, `test/support/fixtures.dart`, `test/support/fixtures_test.dart`
- Create: `tool/record_fixtures.dart`, `tool/fixture_scrub.dart`, `test/tool/fixture_scrub_test.dart`
- Create: `.env.qa.example`; Modify: `.gitignore` (add `.env.qa`)
- Create: `test/fixtures/dev/*.json` (recorded), `test/fixtures/serializer/*.json` (hand-built from serializer code)

**Interfaces:**
- Produces:
  - `class FakeResponse { const FakeResponse(this.statusCode, this.body); final int statusCode; final Object? body; }`
  - `class FakeHttpAdapter implements HttpClientAdapter { FakeHttpAdapter(this.routes); final Map<String, FakeResponse Function(RequestOptions)> routes; final List<RequestOptions> requests; }`. The key is `'<METHOD> <path>'` (path without query). An unmatched request throws `StateError('No fake route for …')`. A `FakeResponse` with `statusCode == -1` simulates a connection error (throws `DioException.connectionError`).
  - `Dio fakeDio(FakeHttpAdapter adapter)`: a Dio with `baseUrl: 'https://dev.mulearn.org'` and the adapter.
  - `Map<String, dynamic> loadFixture(String name)`: reads `test/fixtures/<name>.json` and returns its `body` (the full envelope).
  - `Map<String, dynamic> scrubFixture(Object? json, {required Set<String> keepMuids})` in `tool/fixture_scrub.dart`. It replaces values of `full_name`, `name` (inside person objects), `email`, `mobile`, `profile_pic`, `cover_pic`, `dob` with fixed placeholders (`"Fixture User"`, `"user@example.com"`, `null` …), and every `muid` not in `keepMuids` with `"fixture-user@mulearn"`. Keys and types are kept.

- [ ] **Step 1: Write failing tests.**
  - `fixtures_test.dart`: `loadFixture('serializer/example')` returns a map containing `hasError` and `response`.
  - `fixture_scrub_test.dart`: input `{'response': {'full_name': 'Real Name', 'email': 'a@b.c', 'muid': 'someone@mulearn', 'karma': 10}}` with `keepMuids: {}` → `full_name == 'Fixture User'`, `email == 'user@example.com'`, `muid == 'fixture-user@mulearn'`, `karma == 10`. Nested lists of people are scrubbed too.
- [ ] **Step 2: Run them.** `flutter test test/support test/tool` → FAIL (missing files).
- [ ] **Step 3: Implement** the adapter, loader and scrubber, and add `test/fixtures/serializer/example.json` (`{"_meta":{"source":"serializer"},"body":{"hasError":false,"statusCode":200,"message":{"general":[]},"response":{}}}`).
- [ ] **Step 4: Implement `tool/record_fixtures.dart`.** It is plain Dart (imports `dio` only, nothing from `lib/`) and runs as `dart run tool/record_fixtures.dart`. It reads `.env.qa` (`QA_<ROLE>_EMAIL`, `QA_<ROLE>_PASSWORD` for `STUDENT`, `MENTOR`, `ENABLER`, `CAMPUSLEAD`), signs in through `/api/v1/auth/user-authentication/`, GETs a fixed list, scrubs each body, and writes `test/fixtures/dev/<slug>.json` as `{"_meta":{"source":"dev","endpoint":"…","account":"student","recorded_at":"<ISO date>"},"body":<envelope>}`. Initial list (student unless noted): `/dashboard/user/info/`, `/dashboard/profile/user-profile/`, `/dashboard/task/list/`, `/dashboard/events/?pageIndex=1&perPage=20`, `/dashboard/learningcircle/list/?pageIndex=1&perPage=20`, `/dashboard/learningcircle/user-circles/`, `/dashboard/learningcircle/invite/status/`, `/dashboard/calendar/events/?start_date=<first of month>&end_date=<last of month>` (student and mentor), `/leaderboard/students/`, `/leaderboard/students-monthly/`, `/leaderboard/college/`, `/leaderboard/college-monthly/`, `/dashboard/ig/list/`, `/dashboard/profile/karma-feed/`, `/notification/?page=1&page_size=20`, `/notification/unread-count/`, `/dashboard/home/learner/summary/`, `/dashboard/home/learner/streak/`. It never prints tokens or passwords.
- [ ] **Step 5: Record.** Create `.env.qa` from the four QA accounts (values from Claude's memory file, not typed into any tracked file). Run the recorder. Expected: one file per endpoint, and `grep -ri "example.com\|@mulearn" test/fixtures/dev` shows only placeholders and QA muids.
- [ ] **Step 6: Run the tests.** `flutter test test/support test/tool` → PASS. `flutter analyze` → no issues (add `tool/` to analysis if it's excluded).
- [ ] **Step 7: Checkpoint.** `git status --short` must **not** list `.env.qa`.

### Task 3: Pagination foundation; Events and Circles "load more" (API-01, API-02, REL-02)

Backend: `CommonUtils.get_paginated_queryset` reads `pageIndex` and `perPage` (`utils/utils.py:73,78`) and returns `{count, totalPages, isNext, isPrev, nextPage}` (`utils/utils.py:140-150`). Used by `EventListAPI` (`api/dashboard/events/public_views.py:204-224`) and `LearningCircleView.get` (`api/dashboard/learningcircle/learningcircle_views.py:102-138`).

**Files:**
- Create: `lib/core/network/paging.dart`; Test: `test/core/network/paging_test.dart`
- Modify: `lib/features/events/data/datasources/events_remote_datasource.dart`, `data/repositories/events_repository_impl.dart`, `domain/repositories/events_repository.dart`, `presentation/providers/events_controller.dart`, `presentation/screens/events_screen.dart`
- Modify: `lib/features/learning_circles/data/datasources/learning_circles_remote_datasource.dart` (`fetchCircles`), `data/repositories/learning_circles_repository_impl.dart` (`getCircles`), `domain/repositories/learning_circles_repository.dart`, `presentation/providers/learning_circles_controller.dart` (`CirclesListController`), `presentation/screens/learning_circles_screen.dart`
- Test: `test/features/events/events_remote_datasource_test.dart`, `test/features/events/events_list_controller_test.dart`, `test/features/learning_circles/circles_list_controller_test.dart`

**Interfaces:**
- Produces (in `lib/core/network/paging.dart`):
  - `@freezed abstract class PageInfo { const factory PageInfo({required bool hasNext, required int totalPages, required int count}) }`
  - `abstract final class PageIndexPaging { static const int defaultPerPage = 20; static Map<String, Object> query(int pageIndex, {int perPage = defaultPerPage}); static PageInfo parse(Map<String, dynamic>? pagination); }`. `parse(null)` → `PageInfo(hasNext: false, totalPages: 1, count: 0)`.
  - `@freezed abstract class PagedState<T> { const factory PagedState({required List<T> items, required bool hasMore, @Default(false) bool isLoadingMore, Object? loadMoreError}) }`
  - `List<T> mergeUniqueBy<T, K>(List<T> current, List<T> incoming, K Function(T) key)`: keeps the first occurrence, order preserved.
- Changes: `EventsRepository.getEvents({int pageIndex = 1})`; `LearningCirclesRepository.getCircles({int pageIndex = 1})`; `EventsListController` and `CirclesListController` now hold `PagedState<…>` and keep `Future<void> loadMore()` (which is also the retry action).

- [ ] **Step 1: Write the failing paging tests.**
  ```dart
  expect(PageIndexPaging.query(2), {'pageIndex': 2, 'perPage': 20});
  expect(PageIndexPaging.parse({'count': 41, 'totalPages': 3, 'isNext': true, 'isPrev': false, 'nextPage': 2}),
      const PageInfo(hasNext: true, totalPages: 3, count: 41));
  expect(PageIndexPaging.parse(null), const PageInfo(hasNext: false, totalPages: 1, count: 0));
  expect(mergeUniqueBy([a1, b1], [b2, c1], (x) => x.id).map((x) => x.id), ['a', 'b', 'c']);
  ```
- [ ] **Step 2: Write the failing datasource test.** With `FakeHttpAdapter` routing `GET /api/v1/dashboard/events/` to `loadFixture('dev/events_page1')`: `fetchEvents(pageIndex: 2)` sends query `{pageIndex: 2, perPage: 20}` and **no** `page` key (`adapter.requests.single.queryParameters`).
- [ ] **Step 3: Write the failing controller tests** (repository mocked with mocktail), for both `EventsListController` and `CirclesListController`:
  - `build loads page 1`: items are page 1, `hasMore` comes from `hasNext`, `getEvents(pageIndex: 1)` is called once.
  - `loadMore appends page 2 without duplicates`: page 2 repeats one id from page 1 → that id appears once.
  - `loadMore error keeps items`: page 2 throws → `items` unchanged, `loadMoreError` non-null, `isLoadingMore` false. A second `loadMore` retries page 2.
  - `concurrent loadMore issues one request`: two `loadMore()` calls without awaiting → `getEvents(pageIndex: 2)` called once.
  - `empty first page`: `data: []`, `count: 0` → `items` empty, `hasMore` false, and `loadMore()` makes no call.
- [ ] **Step 4: Run** `flutter test test/core/network/paging_test.dart test/features/events test/features/learning_circles/circles_list_controller_test.dart` → FAIL.
- [ ] **Step 5: Implement** `paging.dart`, the two datasources (send `PageIndexPaging.query(pageIndex)`), repositories (use `PageIndexPaging.parse`), and controllers. Run build_runner.
- [ ] **Step 6: Update the screens.** Read `state.value!.items`. At the list end: show a `MuSkeleton` row while `isLoadingMore`; when `loadMoreError != null`, show a row with "Couldn't load more." and a "Try again" `MuGhostButton` that calls `loadMore()`. Keep the existing empty states.
- [ ] **Step 7: Run all tests and analyze.** PASS / no issues.
- [ ] **Step 8: Check on the emulator.** `flutter run --flavor dev -t lib/main_dev.dart -d emulator-5554`, sign in as the QA student, open Events and Circles, and capture screenshots with `adb exec-out screencap -p > <scratch>/events.png`. Expected on today's dev data: the empty state, no error, no repeated requests in the dev log (the dev `LogInterceptor` prints each request line).
- [ ] **Step 9: Checkpoint.**

### Task 4: Validation errors that arrive under `response` (API-09)

Backend sends `CustomResponse(response=serializer.errors).get_failure_response()` in `profile_view.py:123` (profile PATCH), `profile_view.py:258` (ig-edit), `dash_user_views.py:610` (org link), `qseverse_views.py:44-50`.

**Files:** Modify `lib/core/network/api_exception.dart` (`fromEnvelopeBody`); Test `test/core/network/api_exception_test.dart`; Fixture `test/fixtures/dev/profile_patch_invalid_email.json`.

- [ ] **Step 1: Record the live fixture.** As the QA student, `PATCH /api/v1/dashboard/profile/` with body `{"email": "not-an-email"}`. Expected: HTTP 400, `hasError: true`, the field error under `response.email`. Save it (scrubbed) as the fixture. The QA student's email is unchanged, because the request fails validation.
- [ ] **Step 2: Write the failing tests.**
  - The envelope `{'hasError': true, 'statusCode': 400, 'message': {'general': []}, 'response': {'interest_group': ['Cannot select more than 3 interest groups']}}` gives `message == 'Cannot select more than 3 interest groups'` and `errorFor('interest_group')` equal to the same text.
  - Nested `response: {'user': {'email': ['Enter a valid email address.']}}` → `errorFor('email') == 'Enter a valid email address.'`.
  - When `message.general` is non-empty, it still wins over `response` field errors.
  - The recorded fixture parses to a non-null `errorFor('email')`.
  - `hasError: true` with `response: []` and no messages → `'Request failed (400).'`.
- [ ] **Step 3: Run** → FAIL. **Step 4: Implement.** When `message` yields no general text and no field errors, and `data['response']` is a `Map`, apply `_flattenFieldErrors` to it. **Step 5: Run** → PASS; analyze clean. **Step 6: Checkpoint.**

### Task 4b: Event organiser contract (API-15, found 2026-11-12 with seeded dev data)

The audit could not see this: dev had no events. Once IG- and campus-organised events existed, the Events list and Home's "Happening soon" failed to parse. The featured section hid the error and rendered nothing. Backend `OrganizerInfoSerializer` (api/dashboard/events/serializers.py) sends:
- `organiser_ig` as `MinimalIGSerializer {id, name, icon, cover_image, icon_image}` or null;
- `organiser_campus` and `organiser_company` as `MinimalCampusSerializer {id, title, org_type}` or null.

The app typed `organiserIg` and `organiserCampus` as `String?`.

**Files:**
- Add `lib/core/models/event_organizer_ig(_dto).dart`.
- Rename `event_organizer_company(_dto).dart` to `event_organizer_org(_dto).dart`, a shared campus/company org type.
- Modify `event_organizer(_dto).dart`.
- Add the targets `events_page2` and `events_featured` to `tool/record_fixtures.dart`, then re-record every `test/fixtures/dev/*.json` against the seeded data.
- Test: `test/core/models/event_organizer_dto_test.dart`.

- [x] **Step 1: Re-record the fixtures.** Seeded dev now has 22 events visible to the QA student (2 pages) and 3 featured events, covering admin, global_ig and campus organisers.
- [x] **Step 2: Write the failing tests.**
  - Every recorded event parses, through both `EventDto` and `FeaturedEventDto`.
  - An IG organiser keeps its id and name.
  - A campus organiser keeps its id and title.
  - An admin event has no organiser entity.
  - A company organiser parses with the `{id, title, org_type}` shape.
- [x] **Step 3: Run** → compile failure (`String` has no `id`/`name`/`title`). **Step 4: Implement** the typed IG and org DTOs and entities. **Step 5: Run** → PASS; the full suite and analysis are clean.
- [ ] **Step 6: On device.** Home's "Happening soon" shows featured events, and the Events list loads.

### Task 5: Circle meeting list pagination (API-03)

Backend: `LearningCircleMeetingListView.get` returns `paginated_response({data, pagination})` (`learningcircle_views.py:251-281`, since `5dd14fa0`, 2026-08-19). Items are `CircleMeetupMinSerializer` (`learningcircle_serializer.py:628-720`).

**Files:**
- Create: `lib/features/learning_circles/domain/entities/meeting_page.dart` (`MeetingPage {required List<Meeting> meetings, required bool hasNext}`)
- Modify: the datasource `fetchCircleMeetings(String circleId, {int pageIndex = 1})` → `Future<Map<String, dynamic>>`; the repository and contract `getCircleMeetings(String circleId, {int pageIndex = 1})` → `Future<MeetingPage>`
- Modify: `presentation/providers/meetings_controller.dart`. Replace the `circleMeetings` FutureProvider family with `@riverpod class CircleMeetingsController` (family param `String circleId`) holding `PagedState<Meeting>` with `loadMore()`. Update the invalidations at `meetings_controller.dart:40,61` and `learning_circle_detail_screen.dart:565,680` to `circleMeetingsControllerProvider(circleId)`.
- Fixture: `test/fixtures/serializer/meeting_list_page.json` (one item built from the serializer's 21 fields, `pagination` with `isNext: true`)
- Test: `test/features/learning_circles/circle_meetings_controller_test.dart`, plus a datasource test

- [ ] **Step 1: Failing datasource test.** `fetchCircleMeetings('c1', pageIndex: 2)` requests `GET /api/v1/dashboard/learningcircle/meeting/list/c1/` with `{pageIndex: 2, perPage: 20}`. The repository maps the fixture to `MeetingPage(hasNext: true)` with one meeting whose `igName` comes from `ig_name`.
- [ ] **Step 2: Failing controller tests:** `build loads page 1`, `loadMore appends`, `empty meeting list` (`data: []` → empty, `hasMore` false).
- [ ] **Step 3: Run → FAIL. Step 4: Implement** (build_runner). **Step 5: Run → PASS; analyze clean.**
- [ ] **Step 6: Live check (gated on seed data).** Once dev has an interest group: the QA campus lead creates a circle and a meeting; the app's circle detail shows the meeting; then delete the meeting and the circle. Until then, record "blocked: no IG on dev" in the checkpoint notes.
- [ ] **Step 7: Checkpoint.**

### Task 6: Invitations: respond with `action`, parse received invites (API-04, API-05)

Backend: `CircleInviteStatusAPI.post` requires `action ∈ {accept, reject}` (`learningcircle_views.py:1592-1596`) and replies "This invitation has already been responded to" for answered links (`:1585-1589`). `GET invite/status/` items are `{link_id, circle_id, circle_title, ig, is_lead_invite, invited_by:{user_id, full_name, profile_pic}|null, created_at}` (`learningcircle_serializer.py:767-790`).

**Files:**
- Create: `lib/features/learning_circles/domain/entities/received_circle_invite.dart`, `data/dtos/received_circle_invite_dto.dart`
- Modify: the datasource `respondToInvite` body; the repository and contract `getMyPendingInvites()` → `Future<List<ReceivedCircleInvite>>`; the `myPendingCircleInvites` provider type (`learning_circles_controller.dart:46`); the invite section of `learning_circles_screen.dart:253-331`
- Fixture: `test/fixtures/serializer/my_invites.json` (two items, one with `invited_by: null`)
- Test: `test/features/learning_circles/received_invites_test.dart`

**Interfaces:**
- Produces: `ReceivedCircleInvite { required String linkId, required String circleId, required String circleTitle, String? igName, @Default(false) bool isLeadInvite, String? invitedByName, String? invitedByProfilePic, String? createdAt }`

- [ ] **Step 1: Failing tests.**
  - The DTO parses both fixture items; the second has `invitedByName == null`.
  - `respondToInvite('l1', accept: true)` posts to `/api/v1/dashboard/learningcircle/invite/status/l1/` with body `{'action': 'accept'}`; `accept: false` sends `{'action': 'reject'}`.
  - `already responded message surfaces`: the fake route returns 400 `{'hasError': true, 'statusCode': 400, 'message': {'general': ['This invitation has already been responded to']}, 'response': {}}` → the controller's `AsyncError` holds an `ApiException` with exactly that message.
- [ ] **Step 2: Run → FAIL. Step 3: Implement** (build_runner). The invite tile shows the circle title (primary), the IG name, "Invited by {name}" when known, and "Invited as lead" when `isLeadInvite`. Accept and Decline buttons stay as they are. **Step 4: Run → PASS; analyze clean.**
- [ ] **Step 5: Live check (gated on seed data):** the QA campus lead invites the QA student → the student sees it in the app → declines → the backend confirms; then delete the circle.
- [ ] **Step 6: Checkpoint.**

### Task 7: Calendar mentor sessions (API-06)

Backend: `sessions.{upcoming,ongoing,completed}` items are `MentorshipSessionCalendarSerializer` `{id, title, description, mode, starts_at, ends_at, status, meeting_link, venue, mentor_name, mentee_count}` (`api/calendar/serializers.py:7-41`). They are filled only for users detected as mentors (`dashboard_calendar_view.py` `_detect_user_role`).

**Files:** Create `lib/features/calendar/data/dtos/calendar_session_dto.dart`; Modify `data/repositories/calendar_repository_impl.dart`; Fixtures `test/fixtures/serializer/calendar_with_sessions.json`, `test/fixtures/dev/calendar_student.json`; Test `test/features/calendar/calendar_repository_test.dart`; Modify `README.md` (feature line: "…events and, for mentors, mentorship sessions").

**Interfaces:**
- Produces: `CalendarSessionDto { required String id, required String title, required String startsAt, required String endsAt, @Default('') String status, String? mode, String? meetingLink, String? venue, String? mentorName, int? menteeCount }` with `CalendarEntry toDomain()` → `CalendarEntry(kind: CalendarEntryKind.session, start: startsAt, end: endsAt, venueType: mode, organiserName: mentorName, …)`.

- [ ] **Step 1: Failing test.** The fixture has 1 event, 1 valid session and 1 session missing `starts_at` → `getEntries` returns 2 entries (1 event, 1 session with `start` equal to the fixture's `starts_at`). The malformed item is skipped and logged, and nothing throws. The dev student fixture parses to the events present and zero sessions.
- [ ] **Step 2: Run → FAIL. Step 3: Implement.** Parse each item in its own try/catch through a shared `_parseEach` helper that logs with `appLogger.e`. **Step 4: Run → PASS; analyze clean.**
- [ ] **Step 5: Live check (gated on mentor approval):** the approved QA mentor creates one session through `/dashboard/mentor/session/create/` (Plan 4 builds the UI; here use the recorder's HTTP client), the calendar shows it, then delete or cancel it.
- [ ] **Step 6: Checkpoint.**

### Task 8: Leaderboard rows without a college; open profiles (API-07)

Backend: `"institution": u.colleges[0].org.title if u.colleges else None` and `"muid": u.muid` (`mu_celery/leaderboard_cron.py:56-60`).

**Files:** Modify `lib/features/leaderboard/data/dtos/student_leaderboard_entry_dto.dart`, `domain/entities/student_leaderboard_entry.dart` (`String? institution`, `String? muid`), `presentation/screens/leaderboard_screen.dart:220`, `presentation/widgets/leaderboard_podium.dart`, `lib/features/dashboard/presentation/screens/home_screen.dart:124`; Fixture `test/fixtures/serializer/students_leaderboard.json` (3 rows, one with `institution: null`); Test `test/features/leaderboard/student_leaderboard_dto_test.dart`.

- [ ] **Step 1: Failing test.** All 3 fixture rows parse; the null row has `institution == null`; every row has its `muid`.
- [ ] **Step 2: Run → FAIL. Step 3: Implement.** Omit the subtitle when `institution` is null (no placeholder text). A row or podium item with a `muid` is tappable and calls `context.push(RoutePaths.publicProfilePath(muid))`. **Step 4: Run → PASS; analyze clean.**
- [ ] **Step 5: Emulator check:** Ranks and Home "Top performers" render on today's dev data (empty) without errors; screenshot.
- [ ] **Step 6: Checkpoint.**

### Task 9: Dead code and dead fields (API-11, API-12, API-14)

**Files:**
- Delete: `approveMember` across `learning_circles_remote_datasource.dart:107-117`, the repository, the contract and `learning_circles_controller.dart:172-198`
- Delete: the karma-feed chain (`KarmaFeedController` in `dashboard_controller.dart:23-35`, `getKarmaFeed`/`fetchKarmaFeed`, `karma_feed*_dto.dart`, `karma_feed*.dart` entities, `karma_feed_card.dart`, `ApiPaths.karmaFeed`) and its two tests in `dashboard_controller_test.dart`
- Delete: unreferenced widgets `top_performer_card.dart`, `home_interest_groups_list.dart`, `home_recommended_circles_list.dart`, `create_circle_card.dart`, `home_circle_card.dart`, `core/widgets/mu_banner.dart`, `profile/presentation/widgets/edit_interest_groups_dialog.dart`, and `home_recommendations_controller.dart` (confirm each has no remaining references with `grep -rn "<ClassName>" lib test` before deleting)
- Modify: `profile/data/dtos/user_profile_dto.dart` and `domain/entities/user_profile.dart`: remove `email`, `mobile`, `departmentId`, `departmentName`, `isVerified` (never returned by `UserProfileSerializer`, `profile_serializer.py:148-172`)
- Modify: the usages. `basic_details_tab.dart:166-167` and `edit_profile_dialog.dart:202` read the department from `EditableProfile` (`department.title`, from `GET /dashboard/profile/`). `edit_profile_dialog.dart:79-82` drops the `profile.email`/`profile.mobile` fallbacks. `profile_screen.dart:147`/`public_profile_screen.dart:129` drop `userEmail` (pass the editable profile's email for the own profile only, if the dialog needs it).

- [ ] **Step 1:** Run `flutter test` (baseline green). **Step 2:** Make the deletions and edits; run build_runner. **Step 3:** `flutter analyze` → no issues (this catches every dangling reference); `flutter test` → pass (minus the two deleted karma-feed tests).
- [ ] **Step 4: Emulator check:** the Profile → Basic Details and Edit Profile dialog still show the department and email for the QA student (who has none set: they appear as empty fields, not as errors).
- [ ] **Step 5: Checkpoint.**

### Task 10: Social sign-in: Google sign-up, Android availability, Apple guidance (AUTH-01, AUTH-02, AUTH-03)

Backend and authserver: an unknown Google email returns `{isNewUser: true, tempToken, email, fullName}` with no tokens (authserver `muauth/views.py:451-466`). `POST /register/` accepts a top-level `tempToken`, forces the email from it and drops any password (`register_views.py:346-391`). Apple returns "No account found with this email" for unknown users (authserver `views.py:1035-1046`). Dev ignores a client `email` for Apple (fixed `AppleMobileAuthAPIView`); production trusts it, so the app **stops sending** it.

**Files:**
- Create: `lib/features/auth/domain/entities/social_sign_in_outcome.dart`
- Modify: `core/config/env.dart` (add an optional `GOOGLE_SERVER_CLIENT_ID` with `defaultValue: ''` to both classes) and `.env.dev`/`.env.example` (`GOOGLE_SERVER_CLIENT_ID=` empty for now); `core/config/flavor_config.dart` (`googleServerClientId`)
- Modify: `data/datasources/google_native_signin_datasource.dart` (pass `serverClientId` on Android; `bool get isAvailable`), `auth_remote_datasource.dart` (Apple without `email`), `auth_repository_impl.dart`, `domain/repositories/auth_repository.dart`, `presentation/providers/auth_controller.dart`, `register_wizard_state.dart` (+`googleTempToken`), `register_wizard_controller.dart` (`setGoogleSignUp`), `register_remote_datasource.dart` (`register(…, String? tempToken)`), `register_submit_controller.dart`, `screens/sign_in_screen.dart` (hide the button when unavailable; route `NeedsRegistration`; Apple dialog), `screens/register_basic_info_screen.dart` (Google mode: email shown read-only, no password fields)
- Test: `test/features/auth/social_sign_in_test.dart`; extend `register_submit_controller_test.dart`

**Interfaces:**
- Produces:
  - `sealed class SocialSignInOutcome {}`; `final class SocialSignedIn extends SocialSignInOutcome {}`; `final class SocialNeedsRegistration extends SocialSignInOutcome { const SocialNeedsRegistration({required this.tempToken, required this.email, required this.fullName}); }`
  - `AuthRepository.signInWithGoogle({required String idToken})` → `Future<SocialSignInOutcome>`
  - `AuthController.signInWithGoogle()` → `Future<SocialSignInOutcome>` (rethrows on error, as today)
  - `final class AppleAccountNotFound implements Exception {}`, thrown by `AuthController.signInWithApple` when the `ApiException` message equals `No account found with this email`
  - `GoogleNativeSignInDataSource.isAvailable` → `bool` (iOS: true; Android: `googleServerClientId.isNotEmpty`; other platforms: false)
  - `RegisterWizardController.setGoogleSignUp({required String tempToken, required String email, required String fullName})`

- [ ] **Step 1: Failing tests.**
  - The repository given `{'isNewUser': true, 'tempToken': 't', 'email': 'e@x.org', 'fullName': 'N'}` returns `SocialNeedsRegistration(tempToken: 't', …)` and saves **no** tokens. Given `{accessToken, refreshToken, isNewUser: false}`, it returns `SocialSignedIn` and saves tokens.
  - The Apple datasource body is exactly `{'identity_token': x, 'identityToken': x}` (no `email`).
  - `isAvailable`: Android with an empty id → false; Android with an id → true; iOS → true.
  - The register datasource with `tempToken: 't'` posts `{'tempToken': 't', 'user': {'full_name': 'N', 'role': '<id>'}}` (no `email` or `password`). The submit controller in Google mode doesn't require a password.
- [ ] **Step 2: Run → FAIL. Step 3: Implement** (build_runner). Sign-in screen: `SocialNeedsRegistration` → `setGoogleSignUp` then `context.push(RoutePaths.registerBasicInfo)`. `AppleAccountNotFound` → a dialog with the text "No μLearn account uses this Apple ID's email yet. Create an account with that email first, then sign in with Apple." and the actions "Create account" (to `/register`) and "Close". **Step 4: Run → PASS; analyze clean.**
- [ ] **Step 5: Emulator check:** the Google button is hidden on the Android emulator (empty client id); the sign-in screen otherwise renders unchanged; screenshot. Note in the checkpoint: a real Google/Apple account test is pending the user (needs real identities and the Android client id).
- [ ] **Step 6: Checkpoint.**

### Task 11: Remove Company from mobile registration (COMPANY-01)

Backend: `CompanyRegisterSerializer` requires `verification_document_url` (`api/dashboard/company/serializers.py:44`), and the app creates the user before the company record (`register_submit_controller.dart:138-172`).

**Files:**
- Modify: `domain/entities/registration_role.dart` (remove `company`), `screens/register_role_selection_screen.dart` (remove the Company card; add a line under the cards: "Representing a company? Company accounts are created on the μLearn dashboard." followed by the dashboard address as selectable text), `screens/register_details_screen.dart` (remove the company branch), `register_submit_controller.dart` (remove `submitCompany`), `register_remote_datasource.dart`/`register_repository(_impl).dart` (remove `registerCompany`), `core/network/api_paths.dart` (remove `companyRegister`)
- Modify: `core/config/env.dart`, `.env.dev`, `.env.example` (add `DASHBOARD_URL`; dev value `https://dev.mulearn.org`; the prod value is set by the release owner in `.env.prod`)
- Delete: `widgets/company_details_form.dart`, `domain/entities/company_details.dart`
- Test: update `register_submit_controller_test.dart` (remove the `submitCompany` test); add `test/features/auth/register_role_selection_test.dart` (widget test: no "Company" option; the dashboard note is visible)

- [ ] **Step 1: Failing widget test** for the role screen. **Step 2: Run → FAIL. Step 3: Implement** (build_runner). **Step 4: Run all → PASS; analyze clean.** **Step 5: Emulator check** of the role screen (screenshot). **Step 6: Checkpoint.**

### Task 12: Session reliability and real sign-out (AUTH-05, REL-05, SEC-09, SEC-12)

Authserver: `LogoutAPIView` takes `{refreshToken}` and records a global-logout timestamp; after that, `get-access-token` with an older refresh token answers "Token has been invalidated. Please log in again." (authserver `muauth/views.py:598-658`, `:526-540`). The refresh endpoint is `POST /api/v1/auth/get-access-token/` (the backend's `/auth/refresh-token/` is a 404 on dev).

**Files:**
- Modify: `lib/core/network/auth_interceptor.dart`, `core/network/api_paths.dart` (`logout = '/api/v1/auth/logout/'`), `features/auth/data/datasources/auth_remote_datasource.dart` (`logout`), `auth_repository_impl.dart` (`signOut`), `presentation/providers/auth_controller.dart` (inject the `CacheStore`)
- Test: `test/core/network/auth_interceptor_test.dart`; extend `test/features/auth/auth_controller_test.dart`
- Create: `test/support/fake_secure_storage.dart` (`class FakeSecureStorage extends Fake implements FlutterSecureStorage`, backed by a `Map<String, String>`, overriding `read`, `write`, `delete`, `containsKey`)

**Interfaces:**
- Produces: `enum RefreshOutcome { refreshed, rejected, unavailable }` (in `auth_interceptor.dart`); `AuthRemoteDataSource.logout(String refreshToken)` → `Future<void>` (5 s send/receive timeout, `skipAuth`); `AuthRepositoryImpl({…, required CacheStore cacheStore})`.
- Rules: `rejected` = the refresh request got an HTTP response (any 4xx, or `hasError: true`) → clear tokens and emit `SessionEvent.expired`. `unavailable` = no response (timeout, connection error) or 5xx → keep the tokens, pass the original error on, emit nothing. Before a retry, `FormData` bodies are replaced with `formData.clone()`.

- [ ] **Step 1: Failing interceptor tests** (`FakeHttpAdapter` on both Dios, `TokenStorage` over an in-memory `FlutterSecureStorage` fake):
  - `403 then refresh then retry succeeds`: the original call resolves with the retried response; the new access token is stored.
  - `refresh rejected signs out`: the refresh route returns 400 `hasError` → storage cleared, one `SessionEvent.expired`.
  - `refresh timeout keeps the session`: the refresh route simulates a connection error → tokens still stored, no event, the caller gets the original 403 `DioException`.
  - `concurrent 403s share one refresh`: two parallel calls → the refresh route is hit once.
  - `multipart retry clones FormData`: the retried request's `data` is a `FormData` and `!identical` to the original.
- [ ] **Step 2: Failing sign-out tests:**
  - `signOut calls logout then clears`: logout is called with the stored refresh token; tokens are cleared; `cacheStore.clean()` is called.
  - `signOut clears locally when logout call fails`: logout throws a connection error → tokens are still cleared and the cache cleaned; the router state is signed-out.
- [ ] **Step 3: Run → FAIL. Step 4: Implement. Step 5: Run → PASS; analyze clean.**
- [ ] **Step 6: Live check on dev:** sign in as the QA student, call logout with that refresh token, then call `get-access-token` with the same refresh token → expect `hasError: true` with "Token has been invalidated. Please log in again." Then on the emulator: sign in, sign out, sign in again → Home loads.
- [ ] **Step 7: Checkpoint.**

### Task 13: Plan close-out

- [ ] **Step 1:** `flutter analyze` → No issues found!; `flutter test` → all pass; `flutter build apk --flavor dev --debug -t lib/main_dev.dart` → built.
- [ ] **Step 2:** Re-run the recorder (Task 2) and the full test suite to catch any change on dev since Task 2.
- [ ] **Step 3:** Update the gap status table in the spec (§12, to be added) with each Plan 1 item: done / done-pending-live-check (and why) / blocked.
- [ ] **Step 4:** Report to the user: what's done, which live checks are pending seed data or the mentor approval, and the next plan.

## Prerequisite needed from the user (does not block starting)

Dev has **no active interest groups, no circles and no events** (checked 2026-11-12). Circles require an IG, so Tasks 5 and 6 and the mentor part of Task 7 can't be checked live until an admin creates or activates at least 3 interest groups on dev, and approves the QA mentor (`qamentorone@mulearn`) once its mentor application is submitted. Every other step runs now.

## Correction to the audit

`/api/v1/public/ig/list/` returns only `id, name, leads, mentors, thinktank, impact_projects` (`dash_ig_serializer.py:437-449`). It lacks the category, description, member count and icon that the catalogue shows, so the app **keeps** `/api/v1/dashboard/ig/list/`. The email exposure there (SEC-05) is server-side, whatever client calls it, and the app's DTO already ignores `email`. SEC-05 is therefore backend-only. The IG icon fields (API-13) need a real IG to confirm their URL format, so they move to Plan 3 (after seeding).
