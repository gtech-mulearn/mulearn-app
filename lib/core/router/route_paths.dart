/// Centralized route paths (rules.md §5) — never hardcode a route string inline
/// in a widget.
abstract final class RoutePaths {
  const RoutePaths._();

  static const String splash = '/splash';
  static const String signIn = '/sign-in';
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
  static const List<String> tabRoots = [home, tasks, journey, leaderboard, profile];
  static const String leaderboard = '/leaderboard';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String settingsPassword = '/settings/password';

  /// Discord's OAuth redirect, opened as an App Link (same path as the
  /// dashboard's page). Query: `code`.
  static const String connectDiscord = '/dashboard/connect-discord';

  // --- Role workspaces (Plan 4), opened from Home and Profile ---
  static const String mentor = '/mentor';
  static const String campus = '/campus';
  static const String campusStudents = '/campus/students';
  static const String campusGroups = '/campus/groups';
  static const String campusApprovals = '/campus/approvals';
  static const String campusStudent = '/campus/students/:muid';
  static String campusStudentPath(String muid) => '/campus/students/${Uri.encodeComponent(muid)}';
  static const String mentorSessions = '/mentor/sessions';
  static const String mentorSessionNew = '/mentor/sessions/new';
  static const String mentorSessionEdit = '/mentor/sessions/:id/edit';
  static String mentorSessionEditPath(String id) => '/mentor/sessions/$id/edit';
  static const String mentorRequests = '/mentor/requests';
  static const String mentorAvailability = '/mentor/availability';
  static const String mentorSessionDetail = '/mentor/sessions/:id';
  static String mentorSessionDetailPath(String id) => '/mentor/sessions/$id';

  /// Read-only view of another user's profile by muid.
  static const String publicProfile = '/u/:muid';
  static String publicProfilePath(String muid) => '/u/$muid';

  static const String search = '/search';

  static const String interestGroups = '/interest-groups';
  static const String interestGroupDetail = '/interest-groups/:id';
  static String interestGroupDetailPath(String id) => '/interest-groups/$id';

  static const String events = '/events';
  static const String eventDetail = '/events/:id';
  static String eventDetailPath(String id) => '/events/$id';

  static const String calendar = '/calendar';

  static const String learningCircles = '/circles';
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
