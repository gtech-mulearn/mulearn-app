# Learner community sign-up, college leaderboard, own profile — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Learners can sign up at a School, College, Company or Community (with "I'm not a student"), the Colleges leaderboard shows whole names on podium cards and seal rows that open the campus page, and your own profile always opens for you.

**Architecture:** Three independent slices on branch `feat/learner-community-campus-ranks`. Sign-up: the submit controller learns two more org types, the register repository gains three lookups, the learner form is rebuilt from DS parts. Leaderboard: the college entry gains `id`, two new DS widgets render the board, the screen wires taps and "Your campus". Profile: `PublicProfileScreen` hands your own muid to the You-tab screen.

**Tech Stack:** Flutter, Riverpod (riverpod_annotation codegen), freezed, Dio, go_router, mocktail, `lib/core/design_system`.

**Spec:** `docs/superpowers/specs/2026-11-23-learner-community-campus-ranks-design.md` (mockups: https://claude.ai/artifact/P29Adr8MUnxnRYGMEGKK5E, layout A).

## Global Constraints

- Build UI only from `lib/core/design_system` (import the barrel `design_system.dart`); colours via `context.mu.colors`, text via `context.mu.text`, spacing `MuSpacing`, radii `MuRadii`. No Material widgets for new UI.
- `volt` = #1 / karma only; `cobalt` = identity/commit; `night` = dark layer.
- Copy is sentence case, no exclamation marks, no emoji. Numbers via `muGrouped`.
- Commits: one per task, in order, conventional message, **no `Co-Authored-By` or any AI attribution line**, never push.
- Stage explicit paths only (never `git add lib`/folders). After any `dart run build_runner build --delete-conflicting-outputs`, run `git checkout -- lib/core/config/env.g.dart` and stage only generated files whose source changed (CRLF-only diffs: `git checkout` them).
- Format only the hand-written files you changed: `dart format <file> …` at the default width (no `--line-length`). Never a folder. Add braces where an 80-col wrap splits an `if`.
- Tests: run single files with `flutter test <file>`; the full suite only as `timeout 1500 flutter test -j 1`.
- Every task ends with `flutter analyze` clean (infos fail CI).

## Review Focus

- Switching org type after a pick must clear it: a company id is never submitted as a community (Task 3 test `switching type clears the pick`).
- Turning "I'm not a student" on while College is picked moves to Company and the hidden college fields don't block submit (Task 3 test `not a student falls back to company`).
- A college entry without `id` (older cached payload) renders and simply isn't tappable (Task 6 test `a college without an id does not open`).
- One or two colleges only: cards render, no empty rows card, no crash (Task 5 test `podium with fewer than three`).
- Own-profile match ignores case and surrounding spaces in the route muid (Task 7 test uses `' QAStudentOne@mulearn '`).

---

### Task 1: Learner org types in the submit controller

**Files:**
- Modify: `lib/features/auth/presentation/providers/register_submit_controller.dart`
- Test: `test/features/auth/register_submit_controller_test.dart`

**Interfaces:**
- Produces: `enum OrganizationType { college, company, school, community }`; `apiValue` → `'College' | 'Company' | 'School' | 'Community'`. `submitGeneric({…existing…, bool isStudent = true})`.

- [ ] **Step 1: Write the failing tests** in the `submitGeneric — student` group (mock setup as the existing `Company-employed` test):
  - `Community pick links the community, not as a student`: `submitGeneric(role: student, organization: 'community-1', organizationType: OrganizationType.community, isStudent: false)` → `verify(selectOrganization(organization: 'community-1', isStudent: false)).called(1)`; `verifyNever(createOrganization(...))`.
  - `School not listed submits a School for review`: `organization: 'others', customOrganization: 'Govt HSS Palai', organizationType: OrganizationType.school` → `verify(createOrganization(title: 'Govt HSS Palai', orgType: 'School')).called(1)`.
  - `Community not listed submits a Community for review`: same with `OrganizationType.community`, title `'Flutter Thrissur'` → `orgType: 'Community'`.
  - Existing `Company-employed` test stays green (default `isStudent: true`).
- [ ] **Step 2: Run** `flutter test test/features/auth/register_submit_controller_test.dart` — expect FAIL (no `school`/`community`, no `isStudent`).
- [ ] **Step 3: Implement.** Add the two enum values and `apiValue` cases (a `switch`). Add `bool isStudent = true`. Replace the student/company branch condition with `role == student && organizationType != null && organizationType != OrganizationType.college`; inside, "others" → `createOrganization(title: customOrganization, orgType: organizationType.apiValue)`, else `selectOrganization(organization: organization, isStudent: isStudent)`. Mentor and College paths unchanged. Update the enum doc comment.
- [ ] **Step 4: Run** the test file — expect PASS. `flutter analyze` clean (exhaustive switches in `mentor_details_form.dart` still compile; it only uses college/company).
- [ ] **Step 5: Commit** `feat(auth): learners can link a school or community, as a student or not`.

### Task 2: Registration lookups — communities, district search, schools

**Files:**
- Modify: `lib/core/network/api_paths.dart` (add `registerLocationSearch = '/api/v1/register/location/'`, doc: `GET ?q=` → list of `{id, location}` districts, `q` required)
- Modify: `lib/features/auth/data/datasources/register_remote_datasource.dart`
- Modify: `lib/features/auth/domain/repositories/register_repository.dart`, `lib/features/auth/data/repositories/register_repository_impl.dart`
- Modify: `lib/features/auth/presentation/providers/register_providers.dart` (+ regenerated `.g.dart`)
- Test: `test/features/auth/register_lookups_test.dart` (new)

**Interfaces:**
- Produces on `RegisterRepository`:
  - `Future<List<ReferenceOption>> fetchCommunities();` — via `LocationRemoteDataSource.fetchCommunities()`.
  - `Future<List<ReferenceOption>> searchDistricts(String query);` — `title` = the backend's `location` ("Kottayam, Kerala, India").
  - `Future<List<ReferenceOption>> fetchSchools(String districtId);` — via `LocationRemoteDataSource.fetchSchoolsByDistrict`.
- Produces providers: `registerCommunitiesProvider` (`Future<List<ReferenceOption>>`), `registerSchoolsProvider(String districtId)`.
- `RegisterRemoteDataSource.searchDistricts(String query) → Future<List<dynamic>>`: `GET registerLocationSearch`, `queryParameters: {'q': query}`, `skipAuth`, `ApiEnvelope.unwrapList`.

- [ ] **Step 1: Write the failing tests** with `FakeHttpAdapter` + `fakeDio` building `RegisterRepositoryImpl(remote: RegisterRemoteDataSource(dio), locationRemote: LocationRemoteDataSource(dio), tokenStorage: TokenStorage(FakeSecureStorage()))`:
  - `searchDistricts sends q and maps location to title`: route `GET /api/v1/register/location/` returns `{hasError:false,…,response:[{id:'d1',location:'Kottayam, Kerala, India'}]}` → result `[ReferenceOption(id:'d1', title:'Kottayam, Kerala, India')]`; `adapter.requests.single.uri.queryParameters['q'] == 'kott'`.
  - `fetchCommunities maps the community list`: `GET /api/v1/register/community/list/` → `{communities:[{id:'c1',title:'Flutter Kerala'}]}` → one option titled `'Flutter Kerala'`.
  - `fetchSchools posts the district`: `POST /api/v1/register/schools/list/` → `{schools:[{id:'s1',title:'Govt HSS Palai'}]}`; request `data` equals `{'district':'d1'}`.
  - `a failed lookup throws ApiException`: status 500 on the community route → `throwsA(isA<ApiException>())`.
- [ ] **Step 2: Run** `flutter test test/features/auth/register_lookups_test.dart` — FAIL.
- [ ] **Step 3: Implement** the path, datasource method, contract + impl (wrap `DioException` → `ApiException.fromDioException`, as the existing location methods do), and the two providers next to `registerCompanies`. Run build_runner, restore `env.g.dart`.
- [ ] **Step 4: Run** the test — PASS; analyze clean.
- [ ] **Step 5: Commit** `feat(auth): look up communities, districts and schools for sign-up` (include `register_providers.g.dart`).

### Task 3: Learner details form — "I'm not a student", four types

**Files:**
- Modify: `lib/core/design_system/input/mu_selection.dart` (add `MuChoiceTile<T>`; barrel already exports the file)
- Modify: `lib/features/auth/presentation/widgets/student_details_form.dart` (rewrite)
- Modify: `lib/features/auth/presentation/screens/register_details_screen.dart` (lead follows the switch)
- Test: `test/core/design_system/mu_form_components_test.dart` (tile), `test/features/auth/student_details_form_test.dart` (new)

**Interfaces:**
- Consumes: Task 1 `OrganizationType`, `submitGeneric(isStudent:)`; Task 2 providers and `searchDistricts`.
- Produces: `MuChoiceTile<T>({required T value, required T? groupValue, required String title, required IconData icon, required ValueChanged<T>? onChanged})` — compact radio card for a 2-column grid: `surface`, `radius-card`, 1 px `line` border (2 px `cobalt` when on), 40 icon well top-left (`surfaceSunk`/`ink2`, on: `cobaltTint`/`cobaltText`), `MuRadioMark` top-right, `title3` title under; `MuPressable` 0.98; Semantics `inMutuallyExclusiveGroup`, `checked`, `button`, label = title; min height 48.
- Produces: `StudentDetailsForm({required VoidCallback onSubmitted, ValueChanged<bool>? onStudyingChanged})`.

Form rules (spec §1, exact copy):
- Top: `MuSwitchTile(label: "I'm not a student", subtitle: 'Working, or learning outside school and college')`, default off.
- Label `I learn at`, then a 2-column grid of `MuChoiceTile`: studying → School (`LucideIcons.school`), College (`LucideIcons.graduationCap`), Company (`LucideIcons.briefcase`), Community (`LucideIcons.users`); not studying → Company, Community. Default College.
- Turning the switch on while School/College is picked selects Company. Any type change clears organization, its picked label, custom name and district.
- College fields: unchanged from today.
- School: `MuSelectField(label: 'District', hint: 'Search your district', search: repo.searchDistricts, validator 'Pick your district to continue.')` — hidden once "not listed" is picked for the school; then `MuSelectField(label: 'School', hint: district == null ? 'Pick your district first' : 'Select your school', options: registerSchoolsProvider(district), allowOther: true, otherLabel: 'My school is not listed', validator 'Pick your school to continue.')`.
- Company: today's company field. Community: `label: 'Community', hint: 'Select your community', options: registerCommunitiesProvider, allowOther, otherLabel: 'My community is not listed', validator 'Pick your community to continue.'`, error `"Couldn't load communities. Go back and try again."`.
- "Not listed" → `MuTextField(label: '<School|Company|Community> name')`, ≥3 chars, `'Use at least 3 characters.'`.
- Submit: College as today; others `submitGeneric(role: student, organization:, customOrganization:, organizationType:, isStudent: !notStudent)`.
- `RegisterDetailsScreen` becomes a `ConsumerStatefulWidget` holding `_studying` (default true) from `onStudyingChanged`; the student lead is `'Your campus connects you with peers and campus events.'` when studying, else `'Pick the company you work at or the community you learn with.'`.

- [ ] **Step 1: Write the failing tests.**
  - DS: `choice tile shows its state and reports taps` — two tiles in a group; tapping the off one calls `onChanged` with its value; the on one's Semantics is `checked`.
  - Form (pump `StudentDetailsForm` in `ProviderScope` with `registerRepositoryProvider` → `MockRegisterRepository` stubbing `fetchDepartments`, `fetchCompanies` → `[ReferenceOption(id:'co1', title:'Faya')]`, `fetchCommunities` → `[ReferenceOption(id:'cm1', title:'Flutter Kerala')]`, `fetchRoles`; override `registerSubmitControllerProvider` is not needed — assert through the repository mock with the wizard filled as in Task 1's tests, or spy `submitGeneric` via a fake notifier; implementer's choice, but assertions below must hold):
    - `studying shows four types`: texts School, College, Company, Community present.
    - `not a student shows company and community only`: tap the switch → School and College gone, Company and Community present, Company selected.
    - `not a student falls back to company`: with College selected and nothing filled, turn the switch on, pick Faya, tap `Finish sign-up` → `selectOrganization(organization: 'co1', isStudent: false)` called once (no college validation error shown).
    - `community pick submits the community`: switch on, tap Community, open the field, tap `Flutter Kerala`, submit → `selectOrganization(organization: 'cm1', isStudent: false)`.
    - `switching type clears the pick`: pick Faya under Company, switch to Community, submit → validation text `Pick your community to continue.` shown and `selectOrganization` never called.
    - `school not listed needs no district`: tap School, open School field, tap `My school is not listed`, enter `Govt HSS Palai`, submit → `createOrganization(title: 'Govt HSS Palai', orgType: 'School')`; `District` field not shown.
- [ ] **Step 2: Run** both test files — FAIL.
- [ ] **Step 3: Implement** `MuChoiceTile`, the form, the screen lead.
- [ ] **Step 4: Run** both files plus `test/features/auth/` — PASS; analyze clean; `dart format` the three lib files and two tests.
- [ ] **Step 5: Commit** `feat(auth): learner sign-up asks school, college, company or community, with "I'm not a student"`.

### Task 4: College entry id and campus display names

**Files:**
- Modify: `lib/core/leaderboard/domain/entities/college_leaderboard_entry.dart`, `lib/core/leaderboard/data/dtos/college_leaderboard_entry_dto.dart` (+ `.freezed.dart`, `.g.dart`)
- Create: `lib/core/utils/campus_name.dart`
- Test: `test/core/leaderboard/college_leaderboard_dto_test.dart` (new), `test/core/utils/campus_name_test.dart` (new)

**Interfaces:**
- Produces: `CollegeLeaderboardEntry.id` (`String?`); DTO field `String? id` mapped through `toDomain`.
- Produces: `String campusDisplayName({String? title, String? code})` in `campus_name.dart`.

Algorithm (spec: ALL-CAPS → normal capitalisation; mixed case untouched):
blank title → `code` (trimmed, non-empty) else `'Unknown college'`. Title containing any lowercase letter → trimmed title as is. Otherwise per space-separated word: letters-only core; index > 0 and core in `{of, and, for, the, at, in, on, by, to}` → lower case; `ST` → `St` (keep trailing punctuation); core equals `code` (case-insensitive) or contains no vowel `AEIOU` → unchanged; else lower-case the word and upper-case the first letter and every letter after a non-letter other than `'`.

- [ ] **Step 1: Write the failing tests.**
  - DTO: `loadFixtureResponse('dev/leaderboard_college')` first item → `id == 'ad3a3793-d780-4ec1-b03e-fac92e0faa0d'`, `code == 'SJC'`; a monthly-shaped map `{id:'x', code:'CHN', title:'…', total_karma:21145, students:18}` → `totalStudents == 18`, `id == 'x'`; a map without `id` → `id == null`.
  - Names (`campusDisplayName(title:, code:)` → expected):
    - `'ST JOSEPHS COLLEGE OF ENGINEERING AND TECHNOLOGY PALAI'`, `'SJC'` → `'St Josephs College of Engineering and Technology Palai'`
    - `'AWH ENGINEERING COLLEGE'`, `'AWH'` → `'AWH Engineering College'`
    - `'GOVERNMENT COMMERCIAL INSTITUTE, MANNANTHALA, THIRUVANANTHAPURAM'`, `'GCI-01'` → `'Government Commercial Institute, Mannanthala, Thiruvananthapuram'`
    - `'M.DASAN INSTITUTE OF TECHNOLOGY'`, `'DMC'` → `'M.Dasan Institute of Technology'`
    - `'LBS COLLEGE OF ENGINEERING'`, `'KSD'` → `'LBS College of Engineering'`
    - `'ADI SHANKARA INSTITUTE OF ENGG AND TECHNOLOGY'`, `'ASI'` → `'Adi Shankara Institute of Engg and Technology'`
    - `'Mar Baselios College of Engineering and Technology'` → unchanged; `'MES MK Mackar Pillay College For Advanced Studies'` → unchanged
    - `null`, `'MBT'` → `'MBT'`; `'  '`, `null` → `'Unknown college'`
- [ ] **Step 2: Run** both files — FAIL.
- [ ] **Step 3: Implement**; build_runner; restore `env.g.dart`; replace `_collegeDisplayName` in `leaderboard_screen.dart` with `campusDisplayName(title: e.title, code: e.code)` (delete the private helper).
- [ ] **Step 4: Run** the two files and `test/core/leaderboard/` — PASS; analyze clean.
- [ ] **Step 5: Commit** `feat(leaderboard): college entries carry their id; campus names read in normal case`.

### Task 5: DS — campus podium cards and campus rank rows

**Files:**
- Create: `lib/core/design_system/mulearn/mu_campus_ranks.dart`; export it from `lib/core/design_system/design_system.dart`
- Modify: `lib/core/design_system/mulearn/mu_campus_crest.dart` (`MuCampusSeal` gains `bool inverse = false`)
- Test: `test/core/design_system/mu_campus_ranks_test.dart` (new)

**Interfaces:**
- Produces:
  - `class MuCampusRank { const MuCampusRank({required String name, required int karma, required String detail, String? code, bool isMine = false}); }` — `detail` is the count text after karma (`'2,671 learners'`).
  - `MuCampusPodium({required List<MuCampusRank> top, ValueChanged<int>? onOpen})` — 1–3 entries, rank = index + 1.
  - `MuCampusRankRow({required int rank, required MuCampusRank entry, required int maxKarma, VoidCallback? onTap})`.
  - `MuCampusSeal(inverse: true)`: fill `onNight` at 14 % alpha, ink white, ring white at 50 % — for seals on `cobalt`/`night`.

Anatomy (mockup board A; spec §2):
- Card: full width, `BorderRadius.horizontal(left: Radius.circular(6), right: Radius.circular(20))`, padding 16 (left 14), gap 8 between cards. #1 `volt`/`onVolt`, #2 `cobalt`/`onCobalt`, #3 `night`/`onNight`. Row: rank in `mu.text.poster` 54, height 0.86, width 34 → 44 seal (`inverse` on #2/#3) → column: optional "Your campus" tag (`night`/`onNight` on #1, `surface`/`ink` on #2/#3), name (`title3` size 16, no `maxLines`), line `"<muGrouped(karma)> karma · <detail>"` with karma in `code` w700.
- Row: rank 26 wide (`title3` 18, `ink3`; `cobaltText` when mine), seal 40, column: optional tag (`cobalt`/`onCobalt`), name `bodyStrong` (no `maxLines`), caption with karma `code` w700 `ink` + `' karma · <detail>'` `caption`, 4 px bar `cobalt` on `surfaceSunk` scaled to `maxKarma`; trailing `LucideIcons.chevronRight` 16 `ink3` only when `onTap != null`. Mine: `cobaltTint` background, radius 14. Whole row taps, min height 48.
- Semantics on both: `container`, `button: onTap/onOpen != null`, `excludeSemantics`, label `'Rank N, <name>, <karma> karma, <detail>'` plus `', your campus'` when mine.

- [ ] **Step 1: Write the failing tests** (host: `MaterialApp` + 320-wide `SizedBox`, as `mu_mulearn_components_test.dart`):
  - `podium cards show whole names and open by index`: 3 entries, #2 named `'St Josephs College of Engineering and Technology Palai'`; `tester.widget<Text>(find.text(thatName)).maxLines` is null; tapping it → `onOpen(1)`.
  - `podium with fewer than three`: 1 and 2 entries render 1 and 2 cards (find by semantics label prefix `Rank 1`, `Rank 2`) without throwing.
  - `rank row: bar scales to #1, chevron only when tappable`: `maxKarma 4200413`, entry karma `894306` → the bar `FractionallySizedBox.widthFactor` ≈ 0.213; no `chevronRight` icon when `onTap` null, one when set.
  - `your campus is tagged and announced`: `isMine: true` → text `Your campus` found; semantics label ends with `', your campus'`.
- [ ] **Step 2: Run** — FAIL.
- [ ] **Step 3: Implement.**
- [ ] **Step 4: Run** the file and `test/core/design_system/` — PASS (contrast test included); analyze clean.
- [ ] **Step 5: Commit** `feat(design-system): campus podium cards and campus rank rows`.

### Task 6: Colleges board uses the cards, opens campuses, tags yours

**Files:**
- Modify: `lib/features/leaderboard/presentation/screens/leaderboard_screen.dart` (`_CollegeBoard` only)
- Test: `test/features/leaderboard/college_board_test.dart` (new)

**Interfaces:**
- Consumes: Task 4 `entry.id`, `campusDisplayName`; Task 5 widgets; `profileControllerProvider` → `UserProfile.collegeId`; `RoutePaths.publicCampusPath(id)`.

Rules: top = first ≤3 entries in `MuCampusPodium`, entries 4+ in rows inside the existing `surface` card (radius `MuRadii.card`, padding h16 v4); rows card omitted when none. `detail`: all time `'<muGrouped(n)> learners'` (`'1 learner'`); this month `'<n> active learners'` (`'1 active learner'`). `isMine = entry.id != null && entry.id == collegeId`. Tap → `context.push(RoutePaths.publicCampusPath(id))`; no id → `onTap`/`onOpen` null for that entry. Bottom padding `MuSpacing.navClearance`. Students board untouched.

- [ ] **Step 1: Write the failing tests** with the `empty_states_test.dart` harness pattern (FakeHttpAdapter, tokens, `user_profile`/`user_info` fixtures, router `'/s'` + `GoRoute('/campuses/:id', builder: Text('campus ${id}'))`), routes for `ApiPaths.studentLeaderboard`(+Monthly) → `[]`, college routes → 5 entries built in the test (ids `c1…c5`; entry 2 id `ad3a3793-d780-4ec1-b03e-fac92e0faa0d` = the fixture user's college, title `'ST JOSEPHS COLLEGE OF ENGINEERING AND TECHNOLOGY PALAI'`; entry 5 has no `id`). Tap `Colleges`, pump.
  - `college names show in full and normal case`: `find.text('St Josephs College of Engineering and Technology Palai')` found.
  - `tapping a college opens its campus page`: tap the row for entry 4 → `find.text('campus c4')`.
  - `a college without an id does not open`: tap entry 5 → still on the board (no `campus` text).
  - `your campus is tagged`: `find.text('Your campus')` findsOneWidget.
  - `this month counts active learners`: tap `This month` with monthly route returning `students: 18` on #1 → `find.textContaining('18 active learners')`.
- [ ] **Step 2: Run** — FAIL.
- [ ] **Step 3: Implement.**
- [ ] **Step 4: Run** the file and `test/features/empty_states_test.dart` — PASS; analyze clean.
- [ ] **Step 5: Commit** `feat(leaderboard): colleges on podium cards with whole names; each opens its campus`.

### Task 7: Your own profile always opens

**Files:**
- Modify: `lib/features/profile/presentation/screens/public_profile_screen.dart`
- Modify: `lib/features/profile/presentation/widgets/profile_header.dart` (Back when the route can pop)
- Test: `test/features/profile/own_public_profile_test.dart` (new)

**Interfaces:**
- Consumes: `currentUserProvider` (`lib/core/session/session_providers.dart`), `ProfileScreen`.

Rules: in `PublicProfileScreen.build`, while `currentUserProvider` has no value and is loading → the existing loading view; if `current.value?.muid.trim().toLowerCase() == muid.trim().toLowerCase()` → `return const ProfileScreen();` (no request to `user-profile/<muid>/`). Otherwise unchanged. In the header row, show the glass Back button when `!isOwn || (ModalRoute.of(context)?.canPop ?? false)`; own tools unchanged.

- [ ] **Step 1: Write the failing tests** (harness as Task 6; router `'/'` → `Text('root')`, `'/u/:muid'` → `PublicProfileScreen`, `'/me'` → `ProfileScreen`; route `GET /api/v1/dashboard/profile/user-profile/qastudentone@mulearn/` → 400 `'Private Profile'`):
  - `your own private profile opens with your tools`: `router.push('/u/${Uri.encodeComponent(' QAStudentOne@mulearn ')}')`, pump → `find.byTooltip('Edit profile')` found, `find.text('Profile not found')` nothing, `find.byTooltip('Back')` found; no recorded request path ends with `/user-profile/qastudentone@mulearn/`.
  - `someone else's private profile still says not found`: push `/u/someone@mulearn` with that route → 400 → `find.text('Profile not found')` found.
  - `the You tab has no back button`: `router.go('/me')` → `find.byTooltip('Back')` nothing, `find.byTooltip('Edit profile')` found.
- [ ] **Step 2: Run** — FAIL.
- [ ] **Step 3: Implement.**
- [ ] **Step 4: Run** the file, `test/features/profile/`, `test/features/empty_states_test.dart` — PASS; analyze clean.
- [ ] **Step 5: Commit** `fix(profile): your own profile opens for you even when it is private`.

### Task 8: Branch verification and phone check

- [ ] **Step 1:** `flutter analyze` → `No issues found!`.
- [ ] **Step 2:** `bash .github/scripts/format_check.sh origin/dev` → passes.
- [ ] **Step 3:** `timeout 1500 flutter test -j 1` → all pass (compare against the pre-branch count; report any failure with output).
- [ ] **Step 4:** Build the dev APK (`flutter build apk --debug --flavor dev -t lib/main_dev.dart`), `adb install -r`, and check on the phone/emulator side by side with the mockup: Colleges all time + this month, tap a college → campus page, sign-up step 3 both switch states (dev's community list is empty: only "My community is not listed"), your own profile from search. Report what was checked and anything that differs.
- [ ] **Step 5:** No commit unless a fix was needed (then its own commit, same rules).
