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
  static const String leaderboard = '/leaderboard';
  static const String profile = '/profile';

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
