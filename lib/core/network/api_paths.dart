/// Backend endpoint paths (relative to the flavor base URL).
///
/// Centralized so a backend path change touches one place. All paths are under
/// `/api/v1/` per the μLearn OpenAPI schema.
///
/// Confirmed against the live `mulearn-dashboard` frontend source (rules.md
/// §3/§9: verify against a real client rather than the OpenAPI guess) — the
/// generated schema typed the auth payload as an opaque object, which is why
/// this used to carry unconfirmed TODOs.
abstract final class ApiPaths {
  const ApiPaths._();

  /// Login with `emailOrMuid` + either `password` or `otp`.
  static const String userAuthentication = '/api/v1/auth/user-authentication/';

  /// Request an OTP for [userAuthentication]'s OTP mode.
  static const String requestOtp = '/api/v1/auth/request-otp/';

  /// SimpleJWT refresh proxy — body is `{"refreshToken": "..."}`.
  static const String refreshToken = '/api/v1/auth/get-access-token/';

  /// Request a password-reset email.
  static const String forgotPassword =
      '/api/v1/dashboard/user/forgot-password/';

  /// `POST {"token"}` in the path — verify a password-reset token is valid
  /// before showing the new-password form.
  static const String verifyResetToken =
      '/api/v1/dashboard/user/reset-password/verify-token/';

  /// `POST {"password"}` — reset the password using a verified token
  /// (token is a path segment, appended by the caller).
  static const String resetPassword =
      '/api/v1/dashboard/user/reset-password/';

  /// `POST {"id_token" | "idToken"}` — exchange a native Google Sign-In ID
  /// token for an app session. Confirmed against the real OpenAPI contract —
  /// a native token exchange, not the web-redirect flow the dashboard
  /// frontend uses.
  static const String googleMobileLogin = '/api/v1/auth/google-mobile/';

  /// `POST {"identity_token" | "identityToken", "email"?}` — exchange a
  /// native Sign in with Apple identity token for an app session.
  static const String appleMobileLogin = '/api/v1/auth/apple-mobile/';

  /// Current user's profile.
  static const String userProfile = '/api/v1/dashboard/profile/user-profile/';

  /// `GET` — another user's profile by muid. Same shape as [userProfile].
  /// Confirmed live.
  static String publicUserProfile(String muid) =>
      '/api/v1/dashboard/profile/user-profile/$muid/';

  /// `GET` — another user's activity log by muid. Same shape as [userLog].
  static String publicUserLog(String muid) =>
      '/api/v1/dashboard/profile/user-log/$muid/';

  /// `GET` — another user's level progress by muid. Same shape as
  /// [userLevels].
  static String publicUserLevels(String muid) =>
      '/api/v1/dashboard/profile/get-user-levels/$muid/';

  /// `GET` — another user's social links by muid. Same shape as [socials].
  static String publicSocials(String muid) =>
      '/api/v1/dashboard/profile/socials/$muid/';

  /// `GET` pre-fill payload for the edit-profile form; `PATCH` to save it —
  /// same path, different verb. Confirmed live: `{full_name, email, mobile,
  /// gender, dob, district, communities, department}`.
  static const String editableProfile = '/api/v1/dashboard/profile/';

  /// `GET` — activity log entries, `{task_name, karma, created_date}`, under
  /// a bare `response` array (no wrapper key).
  static const String userLog = '/api/v1/dashboard/profile/user-log/';

  /// `GET` — level progress with nested tasks, under a bare `response` array.
  static const String userLevels =
      '/api/v1/dashboard/profile/get-user-levels/';

  /// `GET` — the current user's social links.
  static const String socials = '/api/v1/dashboard/profile/socials/';

  /// `PUT` — update the current user's social links.
  static const String socialsEdit = '/api/v1/dashboard/profile/socials/edit/';

  /// `GET /api/v1/dashboard/user/preferences/`; `PATCH` same path to update.
  static const String userPreferences = '/api/v1/dashboard/user/preferences/';

  /// `PATCH {"interest_group": string[]}` — update the user's interest
  /// groups.
  static const String editInterestGroups =
      '/api/v1/dashboard/profile/ig-edit/';

  /// `GET` — the full interest-group catalog, under
  /// `response.interestGroup` (note the singular, camelCase key). Each entry
  /// is the same rich shape as [interestGroupDetail] (about, leads, mentors,
  /// members count, etc.) — confirmed live (rules.md §3/§9), not the minimal
  /// `{id, name, category}` the reference dashboard's Zod schema implies.
  static const String interestGroupsList = '/api/v1/dashboard/ig/list/';

  /// `GET` — a single interest group's full detail, under
  /// `response.interestGroup` (singular object this time). Confirmed live:
  /// the role-gated `/api/v1/dashboard/ig/get/{id}/` 400s for a Student
  /// account ("You do not have the required role to access this page."),
  /// this public alternative is the one that actually works for browsing.
  static String interestGroupDetail(String id) => '/api/v1/public/ig/$id/';

  /// `PUT {"is_public": bool}` — toggle profile visibility.
  static const String shareUserProfile =
      '/api/v1/dashboard/profile/share-user-profile/';

  /// `GET`/`POST` (multipart, field `cover`)/`DELETE` — the cover photo.
  static const String coverPic = '/api/v1/dashboard/profile/cover-pic/';

  /// `POST` (multipart, fields `profile` + `user_id`) — the profile photo.
  static const String updateProfileImage =
      '/api/v1/dashboard/user/profile/update/';

  /// `PATCH {"org_id", "department_id"}` — change the user's college.
  static const String changeCollege =
      '/api/v1/dashboard/college/change-college/';

  /// `GET` — badges (completed TFP task titles) for [muid]. Confirmed live —
  /// no trailing slash, unlike almost every other endpoint here.
  static String badges(String muid) => '/api/v1/dashboard/profile/badges/$muid';

  /// `GET` — a user's earned achievements by [muid].
  static String userAchievements(String muid) =>
      '/api/v1/dashboard/achievement/list/user/$muid/';

  /// `POST {"achievement_id", "vc_url"}` — save the VC URL after a
  /// successful QSeverse issuance (confusingly named `issueVC` in the
  /// reference client; it only persists a URL, the actual issuance is
  /// [qseverseIssueVc]).
  static const String saveIssuedVcUrl =
      '/api/v1/dashboard/achievement/issue-vc/';

  /// `POST {"subject_info", "credential_info", "template_id", "send_email"}`
  /// — the external QSeverse integration that actually issues the VC.
  static const String qseverseIssueVc =
      '/api/v1/integrations/qseverse/issue-vc/';

  /// `GET` — DIDs already connected/verified for [muid] via QSeverse.
  static String qseverseConnectedUsers(String muid) =>
      '/api/v1/integrations/qseverse/connected-users/search?key=muid&value=$muid';

  // --- Search — confirmed live (rules.md §3/§9) ---

  /// `GET {"search", "role"?, "pageIndex", "perPage"}` — the same endpoint
  /// serves both general user search and mentor search; `role=mentor`
  /// filters server-side, confirmed live by comparing results with/without
  /// the param.
  static const String userSearch = '/api/v1/dashboard/user/search/';

  // --- Registration (rules.md §3/§9: confirmed against the live dashboard
  // frontend, not the OpenAPI schema) ---

  /// Create a new user account — student/mentor/enabler, and the Company
  /// role's initial POC account (a company record is created separately via
  /// [companyRegister]).
  static const String register = '/api/v1/register/';

  /// `GET` — list of roles, `{id, title}`, under `response.roles`. Role UUIDs
  /// are resolved by case-insensitive title match against this list.
  static const String registerRoles = '/api/v1/register/role/list/';

  /// `GET` — list of colleges, `{id, title}`, under `response.colleges`.
  /// Also reused by learning-circle creation (rules.md §2): confirmed live
  /// that `learningcircle/create/`'s `org` field validates against this id
  /// space specifically — `/api/v1/dashboard/college/`'s `id` (a different,
  /// analytics-row id space) 400s with "Invalid pk" there.
  static const String registerColleges = '/api/v1/register/colleges/';

  /// `GET` — list of departments, `{id, title}`, under `response.departments`.
  static const String registerDepartments =
      '/api/v1/register/department/list/';

  /// `GET` — list of companies, `{id, title}`, under `response.companies`.
  static const String registerCompanies = '/api/v1/register/company/list/';

  /// `GET` — list of countries, `{id, name}`, under `response.countries`.
  static const String registerCountries = '/api/v1/register/country/list/';

  /// `POST {"country": id}` — list of states, `{id, name}`, under
  /// `response.states`.
  static const String registerStates = '/api/v1/register/state/list/';

  /// `POST {"state": id}` — list of districts, `{id, name}`, under
  /// `response.districts`.
  static const String registerDistricts = '/api/v1/register/district/list/';

  /// `GET` — list of communities, `{id, title}`, under `response.communities`.
  static const String registerCommunities =
      '/api/v1/register/community/list/';

  /// `POST {"district": id}` — colleges AND departments in a district (used
  /// by the college-change picker), `{id, title}` each, under
  /// `response.colleges`/`response.departments`. Distinct from
  /// [registerColleges] (unfiltered, singular-vs-plural path segment
  /// `college` not `colleges` — confirmed live, not a typo).
  static const String collegesByDistrict = '/api/v1/register/college/list/';

  /// `POST {"district": id}` — schools in a district, `{id, title}`, under
  /// `response.schools`.
  static const String schoolsByDistrict = '/api/v1/register/schools/list/';

  /// `POST` — link the just-registered user to an existing college/company.
  static const String selectOrganization =
      '/api/v1/dashboard/user/organization/';

  /// `POST` — submit a not-yet-listed college/company for admin review,
  /// linking the user to it.
  static const String createOrganization =
      '/api/v1/register/organization/create/';

  /// `POST {"domains": [...]}` — save chosen learning pathways.
  static const String selectDomains = '/api/v1/register/select-domains/';

  /// `POST {"endgoals": [...]}` — save chosen end goals.
  static const String selectEndgoals = '/api/v1/register/select-endgoals/';

  /// `POST` — create the Company record for the Company role (called after
  /// [register] has already authenticated the POC user).
  static const String companyRegister = '/api/v1/dashboard/company/register/';

  // --- Dashboard (home screen) — confirmed live (rules.md §3/§9) ---

  /// `GET` — the current top user + top college highlight, under
  /// `response.top_user` / `response.top_college`. Despite the name, this is
  /// a small highlight widget, not a paginated activity feed (that's
  /// [userLog]).
  static const String karmaFeed = '/api/v1/dashboard/profile/karma-feed/';

  /// `GET` — featured events, under `response.data` with a `pagination`
  /// sibling key. Confirmed live: 5 items, `isNext: false` for this account,
  /// so the home screen's "featured" widget doesn't need load-more paging.
  static const String featuredEvents = '/api/v1/dashboard/events/featured/';

  /// `GET ?page=` — the full paginated event list, under `response.data`
  /// with a `pagination` sibling (`{count, totalPages, isNext, isPrev,
  /// nextPage}`). Confirmed live (rules.md §3/§9).
  static const String events = '/api/v1/dashboard/events/';

  /// `GET` — full detail for a single event (description, banner, co-owners,
  /// collaborators, `viewer_interest_status`, registration info). Confirmed
  /// live.
  static String eventDetail(String id) => '/api/v1/dashboard/events/$id/';

  /// `POST` to mark interest, `DELETE` to remove it. Confirmed live: `POST`
  /// 400s with "You need N karma to access this event." when under
  /// `min_karma`; both return the standard envelope with a human-readable
  /// `message.general` either way.
  static String eventInterest(String id) =>
      '/api/v1/dashboard/events/$id/interest/';

  /// `GET ?start_date=YYYY-MM-DD&end_date=YYYY-MM-DD` (range capped at 93
  /// days by the backend — confirmed live, rules.md §3/§9) — unified
  /// calendar feed under `response.{events,sessions}.{upcoming,ongoing,
  /// completed}`. A `month=` (month name) shortcut also exists but only
  /// covers the current year, so the app always uses the explicit range
  /// form.
  static const String calendarEvents = '/api/v1/dashboard/calendar/events/';

  // --- Learning circles — confirmed live (rules.md §3/§9); path segment is
  // `learningcircle` (singular, no space), verified against the real
  // backend rather than assumed from the reference dashboard's client. ---

  static const String circlesList =
      '/api/v1/dashboard/learningcircle/list/';
  static const String circlesCreate =
      '/api/v1/dashboard/learningcircle/create/';
  static const String userCircles =
      '/api/v1/dashboard/learningcircle/user-circles/';

  static String circleDetail(String id) =>
      '/api/v1/dashboard/learningcircle/info/$id/';
  static String circleEdit(String id) =>
      '/api/v1/dashboard/learningcircle/edit/$id/';
  static String circleDelete(String id) =>
      '/api/v1/dashboard/learningcircle/delete/$id/';
  static String circleMembers(String id) =>
      '/api/v1/dashboard/learningcircle/members/$id/';
  static String circleMembersAdd(String id) =>
      '/api/v1/dashboard/learningcircle/members/add/$id/';
  static String circleTransferLead(String id) =>
      '/api/v1/dashboard/learningcircle/transfer-lead/$id/';

  /// `POST` to request joining; `GET` (lead only) lists pending requests;
  /// `PATCH {"link_id", "action": "accept"|"reject"}` (lead only) responds.
  static String circleJoin(String id) =>
      '/api/v1/dashboard/learningcircle/join/$id/';

  static String circleInvite(String id) =>
      '/api/v1/dashboard/learningcircle/invite/$id/';
  static String circleInviteSent(String id) =>
      '/api/v1/dashboard/learningcircle/invite/sent/$id/';
  static const String circleInviteStatus =
      '/api/v1/dashboard/learningcircle/invite/status/';

  /// `POST {"is_accepted": bool}` — respond to a specific pending invite by
  /// its `link_id` (confirmed live under `invite/sent/`'s response shape;
  /// distinct from the ambiguous unfiltered `circleInviteStatus`).
  static String circleInviteRespond(String linkId) =>
      '/api/v1/dashboard/learningcircle/invite/status/$linkId/';

  static String meetingCreate(String circleId) =>
      '/api/v1/dashboard/learningcircle/meeting/create/$circleId/';
  static String meetingList(String circleId) =>
      '/api/v1/dashboard/learningcircle/meeting/list/$circleId/';
  static String meetingDetail(String id) =>
      '/api/v1/dashboard/learningcircle/meeting/info/$id/';
  static String meetingEdit(String id) =>
      '/api/v1/dashboard/learningcircle/meeting/edit/$id/';
  static String meetingDelete(String id) =>
      '/api/v1/dashboard/learningcircle/meeting/delete/$id/';
  static String meetingRsvp(String id) =>
      '/api/v1/dashboard/learningcircle/meeting/rsvp/$id/';
  static String meetingJoin(String id) =>
      '/api/v1/dashboard/learningcircle/meeting/join/$id/';
  static String meetingLeave(String id) =>
      '/api/v1/dashboard/learningcircle/meeting/leave/$id/';
  static String meetingAttendeeReport(String id) =>
      '/api/v1/dashboard/learningcircle/meeting/attendee-report/$id/';
  static String meetingReport(String id) =>
      '/api/v1/dashboard/learningcircle/meeting/report/$id/';

  // --- Leaderboard — confirmed live (rules.md §3/§9) ---

  /// `GET` — top 20 students all-time, `{full_name, total_karma,
  /// institution, profile_pic}` each, bare array under `response`.
  static const String studentLeaderboard = '/api/v1/leaderboard/students/';

  /// `GET` — top 20 students this month, same shape as [studentLeaderboard].
  static const String studentLeaderboardMonthly =
      '/api/v1/leaderboard/students-monthly/';

  /// `GET` — all colleges all-time, `{code, title, total_students,
  /// total_karma}` each, bare array under `response`.
  static const String collegeLeaderboard = '/api/v1/leaderboard/college/';

  /// `GET` — all colleges this month, same shape as [collegeLeaderboard].
  static const String collegeLeaderboardMonthly =
      '/api/v1/leaderboard/college-monthly/';
}

/// Per-request option flags read by the interceptors.
abstract final class RequestFlags {
  const RequestFlags._();

  /// Set on a request's `headers` to skip the auth interceptor's token attach
  /// (used by the refresh call to avoid recursion).
  static const String skipAuth = 'x-skip-auth';

  /// Set on a request's `extra` once it has been retried after a token refresh,
  /// so a second 401 doesn't loop.
  static const String retried = 'x-retried';
}
