/// Centralized route paths (rules.md §5) — never hardcode a route string inline
/// in a widget.
abstract final class RoutePaths {
  const RoutePaths._();

  static const String splash = '/splash';
  static const String signIn = '/sign-in';

  /// First-launch arrival beats (signed out, once per device).
  static const String welcome = '/welcome';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String registerBasicInfo = '/register';
  static const String registerRoleSelection = '/register/role';
  static const String registerDetails = '/register/details';
  static const String onboardingInterests = '/onboarding/interests';
  static const String home = '/home';
  static const String tasks = '/tasks';
  static const String taskDetail = '/tasks/:id';
  static String taskDetailPath(String id) => '/tasks/$id';
  static const String journey = '/journey';

  /// The bottom-bar tab roots, in the shell's branch order (`app_router.dart`).
  /// Open them with `context.openTab`, never `push`.
  static const List<String> tabRoots = [
    home,
    tasks,
    journey,
    leaderboard,
    profile,
  ];
  static const String leaderboard = '/leaderboard';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String settingsPassword = '/settings/password';
  static const String settingsBlocked = '/settings/blocked';

  /// Discord's OAuth redirect, opened as an App Link (same path as the
  /// dashboard's page). Query: `code`.
  static const String connectDiscord = '/dashboard/connect-discord';

  // --- Role workspaces (Plan 4), opened from Home and Profile ---
  static const String mentor = '/mentor';
  static const String campus = '/campus';
  static const String campusStudents = '/campus/students';
  static const String campusGroups = '/campus/groups';
  static const String campusApprovals = '/campus/approvals';
  static const String enablerCampuses = '/enabler/campuses';
  static const String enablerCampus = '/enabler/campuses/:id';
  static String enablerCampusPath(String id) => '/enabler/campuses/$id';
  static const String campusStudent = '/campus/students/:muid';
  static String campusStudentPath(String muid) =>
      '/campus/students/${Uri.encodeComponent(muid)}';
  // Team workspace: announcements, push campaigns and the activity log.
  static const String team = '/team';
  static const String teamAnnouncements = '/team/announcements';
  static const String teamAnnouncementNew = '/team/announcements/new';
  static const String teamAnnouncement = '/team/announcements/:id';
  static String teamAnnouncementPath(String id) => '/team/announcements/$id';
  static const String teamAnnouncementEdit = '/team/announcements/:id/edit';
  static String teamAnnouncementEditPath(String id) =>
      '/team/announcements/$id/edit';
  static const String teamCampaigns = '/team/campaigns';
  static const String teamCampaignNew = '/team/campaigns/new';
  static const String teamCampaign = '/team/campaigns/:id';
  static String teamCampaignPath(String id) => '/team/campaigns/$id';
  static const String teamLog = '/team/log';
  static const String mentorSessions = '/mentor/sessions';
  static const String mentorSessionNew = '/mentor/sessions/new';
  static const String mentorSessionEdit = '/mentor/sessions/:id/edit';
  static String mentorSessionEditPath(String id) => '/mentor/sessions/$id/edit';
  static const String mentorRequests = '/mentor/requests';
  static const String mentorAvailability = '/mentor/availability';
  static const String mentorSessionDetail = '/mentor/sessions/:id';
  static String mentorSessionDetailPath(String id) => '/mentor/sessions/$id';

  /// A mentor's applications, and the form (open to anyone with the Mentor
  /// role, approved or not: it's how they get approved).
  static const String mentorApplications = '/mentor/applications';
  static const String mentorApply = '/mentor/apply';
  static String mentorApplyEditPath(String id) =>
      '/mentor/apply?edit=${Uri.encodeQueryComponent(id)}';
  static String mentorApplyAgainPath(String id) =>
      '/mentor/apply?from=${Uri.encodeQueryComponent(id)}';

  /// The form with a tier already chosen (its backend value).
  static String mentorApplyTierPath(String tier) =>
      '/mentor/apply?tier=${Uri.encodeQueryComponent(tier)}';

  /// Read-only view of another user's profile by muid.
  static const String publicProfile = '/u/:muid';
  static String publicProfilePath(String muid) => '/u/$muid';

  /// A college's public page (the dashboard's /dashboard/campus/:id).
  static const String publicCampus = '/campuses/:id';
  static String publicCampusPath(String id) => '/campuses/$id';

  static const String search = '/search';

  static const String interestGroups = '/interest-groups';
  static const String interestGroupDetail = '/interest-groups/:id';
  static String interestGroupDetailPath(String id) => '/interest-groups/$id';

  static const String events = '/events';

  /// Events filtered to one interest group.
  static String eventsInGroup(String igId) =>
      '/events?ig=${Uri.encodeQueryComponent(igId)}';
  static const String eventDetail = '/events/:id';
  static String eventDetailPath(String id) => '/events/$id';

  static const String calendar = '/calendar';

  /// Jobs, internships and gigs from verified companies, and your applications.
  static const String opportunities = '/opportunities';

  /// Weekly Twitches; `?show=<slug>` opens on a show.
  /// A learner's mentor sessions: join one, ask for one, rate one.
  static const String learnerSessions = '/sessions';

  static const String projects = '/projects';
  static const String projectNew = '/projects/new';
  static const String project = '/projects/:id';
  static String projectPath(String id) => '/projects/$id';
  static const String projectEdit = '/projects/:id/edit';
  static String projectEditPath(String id) => '/projects/$id/edit';

  static const String problemStatements = '/problem-statements';
  static const String problemStatement = '/problem-statements/:id';
  static String problemStatementPath(String id) => '/problem-statements/$id';

  static const String weeklyTwitches = '/weekly-twitches';
  static String weeklyTwitchesShowPath(String show) =>
      '/weekly-twitches?show=$show';
  static const String weeklyTwitch = '/weekly-twitches/:show/:id';
  static String weeklyTwitchPath(String show, String id) =>
      '/weekly-twitches/$show/$id';

  static const String learningCircles = '/circles';

  /// The circles catalogue filtered to one interest group.
  static String learningCirclesInGroup(String igId) =>
      '/circles?ig=${Uri.encodeQueryComponent(igId)}';
  static const String createLearningCircle = '/circles/create';
  static const String learningCircleDetail = '/circles/:id';
  static String learningCircleDetailPath(String id) => '/circles/$id';
  static const String createMeeting = '/circles/:id/meetings/create';
  static String createMeetingPath(String circleId) =>
      '/circles/$circleId/meetings/create';
  static const String meetingDetail = '/meetings/:id';
  static String meetingDetailPath(String id) => '/meetings/$id';
  static const String editMeeting = '/meetings/:id/edit';
  static String editMeetingPath(String id) => '/meetings/$id/edit';
}
