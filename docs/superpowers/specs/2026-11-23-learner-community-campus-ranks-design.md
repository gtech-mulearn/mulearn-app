# Learner community sign-up, college leaderboard, own profile

Date: 2026-11-23 · Branch: `feat/learner-community-campus-ranks` (off `dev`)
Mockups: https://claude.ai/artifact/P29Adr8MUnxnRYGMEGKK5E (layout A chosen)

Three small, independent changes. Build only from `lib/core/design_system`.

## 1. Learner sign-up: "I'm not a student", School and Community

**Why.** The dashboard's learner step (PRs #630 and 6b9d0256, 2026-11-23) now
asks where a learner learns: School, College, Company or Community, with an
"I am not a student" switch that limits the choice to Company or Community.
The app only offers College or Company, so a community learner can't sign up
the same way.

**What the app does (matches `register-role-details.tsx` / `register-client.tsx`).**
- `MuSwitchTile` "I'm not a student" (subtitle "Working, or learning outside
  school and college"), off by default.
- "I learn at": compact radio tiles, 2 per row: School, College, Company,
  Community when studying; Company and Community when the switch is on.
  Turning the switch on while School or College is picked moves the pick to
  Company. Changing type clears the previous pick (no company id is ever
  sent as a community).
- College: unchanged (search, department, year of passing, "not listed").
- School: District (server search, `GET /api/v1/register/location/?q=`,
  `{id, location}`, needs a non-empty query) → School (`POST
  register/schools/list/ {district}`, `{id, title}` under `schools`), with
  "My school is not listed" (then no district needed).
- Company: the existing company list. Community: `GET
  register/community/list/` (`{id, title}` under `communities`, public). Both
  with "My … is not listed".
- Lead line follows the switch: studying "Your campus connects you with peers
  and campus events."; not studying "Pick the company you work at or the
  community you learn with."

**Submit (after the account is created).** College: unchanged. School /
Company / Community: a listed pick → `POST dashboard/user/organization/
{organization, department: null, graduation_year: null, is_student}` where
`is_student` is the switch's opposite; "not listed" → `POST
register/organization/create/ {title, org_type: "School"|"Company"|"Community"}`.
Backend verified: `UserOrgLinkSerializer` links any org type;
`UnverifiedOrganizationCreateSerializer` accepts all four types.

**Note.** The dev server's community list is empty (prod has 35), so on the
dev build only "My community is not listed" shows.

## 2. College leaderboard (layout A)

**Why.** College names are cut to one line on the podium and the rows (real
titles run 45–64 characters, often ALL CAPS), college rows don't open
anything, and colleges show letter avatars where the design system wants
campus seals.

**What changes (Colleges tab only; Students tab unchanged).**
- Top three as **podium cards**: full-width blocks in the podium colours
  (#1 `volt`, #2 `cobalt`, #3 `night`), radius 6 left / 20 right, rank in the
  54 px numeral, a 44 seal, the whole name (`title-3` weight, wraps), and
  "4,200,413 karma · 2,671 learners".
- Rows from #4: rank, 40 seal, the whole name (wraps, no line cap), karma in
  mono bold + learners, the karma bar scaled to #1, a chevron.
- Every card and row opens the campus page, `RoutePaths.publicCampusPath(id)`.
  Both endpoints already return `id` (verified in `leaderboard_view.py` and
  live); the DTO/entity gain `id`. No id → not tappable.
- ALL-CAPS titles display in normal capitalisation (small words lower-case,
  short consonant-only words and the campus code kept upper-case); mixed-case
  titles are left alone. Monthly rows with no title still fall back to code.
- The viewer's college (profile `collegeId`) gets a "Your campus" tag and the
  `cobalt-tint` row (or the tag on its podium card).
- This month: the count reads "N active learners" (the backend counts members
  who earned karma this month).
- New DS widgets in `mulearn/`: `MuCampusPodium` (the three cards) and
  `MuCampusRankRow`, reusing `MuCampusSeal`.

## 3. Your own profile always opens

**Why.** Opening yourself from search, a leaderboard or a circle goes to
`/u/<muid>`, and `GET user-profile/<muid>/` answers "Private Profile" to
everyone when the profile is private, the owner included, so you see
"Profile not found".

**What changes.** `PublicProfileScreen` compares the muid with the signed-in
user's (`currentUserProvider`, case-insensitive). If it's you, it shows your
own profile from `profileControllerProvider` with the own tools (edit,
share, settings), plus a back button because it was pushed. Everyone else's
profile is unchanged. The own header shows Back only when the route can pop,
so the You tab looks the same.

## Approaches considered

- Leaderboard: A podium cards (chosen: every name fits and the podium colours
  stay) vs B classic podium with seals (names still clip at 3 lines).
- Org type: radio tiles (chosen: all choices visible, one tap) vs the
  dashboard's dropdown.
- Own profile: show it in place (chosen: keeps your place in search) vs jump
  to the You tab; a backend owner check would also fix the dashboard but the
  app shouldn't depend on it.

## Out of scope

Students podium; pinning your campus when it's outside the top 20; the
dashboard's own-profile behaviour; backend changes.

## Tests

Widget tests: learner form switch/types/fields and the submit calls per type;
podium cards and rows render full names, open the campus page, tag your
campus; title-casing; own-muid profile shows own tools. Then on the phone.
