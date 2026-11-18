import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/app/app_redirect.dart';
import 'package:mulearn_app/app/widgets/main_shell.dart';
import 'package:mulearn_app/app/widgets/not_found_screen.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/widgets/workspace_gate.dart';
import 'package:mulearn_app/features/auth/presentation/providers/welcome_providers.dart';
import 'package:mulearn_app/features/auth/presentation/screens/arrival_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/onboarding_interests_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/register_basic_info_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/register_details_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/register_role_selection_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:mulearn_app/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_approvals_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_groups_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_overview_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_student_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_students_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/enabler_campus_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/enabler_campuses_screen.dart';
import 'package:mulearn_app/features/campus_profile/presentation/screens/public_campus_screen.dart';
import 'package:mulearn_app/features/dashboard/presentation/screens/home_screen.dart';
import 'package:mulearn_app/features/events/presentation/screens/event_detail_screen.dart';
import 'package:mulearn_app/features/events/presentation/screens/events_screen.dart';
import 'package:mulearn_app/features/interest_groups/presentation/screens/interest_group_detail_screen.dart';
import 'package:mulearn_app/features/interest_groups/presentation/screens/interest_groups_screen.dart';
import 'package:mulearn_app/features/leaderboard/presentation/screens/leaderboard_screen.dart';
import 'package:mulearn_app/features/learning_circles/presentation/screens/create_learning_circle_screen.dart';
import 'package:mulearn_app/features/learning_circles/presentation/screens/create_meeting_screen.dart';
import 'package:mulearn_app/features/learning_circles/presentation/screens/edit_meeting_screen.dart';
import 'package:mulearn_app/features/learning_circles/presentation/screens/learning_circle_detail_screen.dart';
import 'package:mulearn_app/features/learning_circles/presentation/screens/learning_circles_screen.dart';
import 'package:mulearn_app/features/learning_circles/presentation/screens/meeting_detail_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/availability_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/learner_sessions_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_application_form_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_applications_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_hub_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_session_detail_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_sessions_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/session_form_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/student_requests_screen.dart';
import 'package:mulearn_app/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:mulearn_app/features/opportunities/presentation/screens/opportunities_screen.dart';
import 'package:mulearn_app/features/problem_statements/presentation/screens/problem_statement_detail_screen.dart';
import 'package:mulearn_app/features/problem_statements/presentation/screens/problem_statements_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/change_password_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/connect_discord_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/journey_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/public_profile_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/settings_screen.dart';
import 'package:mulearn_app/features/projects/presentation/screens/project_detail_screen.dart';
import 'package:mulearn_app/features/projects/presentation/screens/project_form_screen.dart';
import 'package:mulearn_app/features/projects/presentation/screens/projects_screen.dart';
import 'package:mulearn_app/features/search/presentation/screens/search_screen.dart';
import 'package:mulearn_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:mulearn_app/features/tasks/presentation/screens/task_detail_screen.dart';
import 'package:mulearn_app/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:mulearn_app/features/team/presentation/screens/activity_log_screen.dart';
import 'package:mulearn_app/features/team/presentation/screens/announcement_detail_screen.dart';
import 'package:mulearn_app/features/team/presentation/screens/announcement_form_screen.dart';
import 'package:mulearn_app/features/team/presentation/screens/announcements_screen.dart';
import 'package:mulearn_app/features/team/presentation/screens/campaign_detail_screen.dart';
import 'package:mulearn_app/features/team/presentation/screens/campaign_form_screen.dart';
import 'package:mulearn_app/features/team/presentation/screens/campaigns_screen.dart';
import 'package:mulearn_app/features/team/presentation/screens/team_home_screen.dart';
import 'package:mulearn_app/features/weekly_twitches/domain/entities/twitch.dart';
import 'package:mulearn_app/features/weekly_twitches/presentation/screens/twitch_detail_screen.dart';
import 'package:mulearn_app/features/weekly_twitches/presentation/screens/weekly_twitches_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// App router (go_router) with an auth `redirect` that reads the core-level
/// [AppAuthController] (rules.md §1/§3, architecture §5).
///
/// NOTE (rules.md §2 / §10): the router is the app's composition root — it must
/// import feature screens, which `core/` is forbidden to do. It therefore lives
/// under `lib/app/` rather than `core/router/` (a deliberate, flagged deviation
/// from the build prompt's suggested location, to preserve the hard "core never
/// imports features" boundary). Route path *constants* remain in
/// `core/router/route_paths.dart`.
///
/// Guards:
///  * session still resolving → `/splash`
///  * signed out → `/sign-in`, `/forgot-password`, `/register`,
///    `/register/role`, or `/register/details` (registration itself
///    transitions from signed-out to signed-in mid-flow, so it's allowed in
///    both states — see `_alwaysAllowedSignedIn` below)
///  * signed in on any other pre-auth screen (or `/splash`) → `/profile`
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final refresh = _AuthRefreshListenable(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: refresh,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) => appRedirect(
      auth: ref.read(appAuthControllerProvider),
      arrivalSeen: ref.read(arrivalSeenProvider),
      uri: state.uri,
      needsInterests:
          ref.read(currentUserProvider).value?.needsInterests ?? false,
    ),
    // A path the app doesn't know (e.g. an old link): the dashboard's 404.
    errorBuilder: (_, __) => const NotFoundScreen(),
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.welcome,
        builder: (_, __) => const ArrivalScreen(),
      ),
      GoRoute(
        path: RoutePaths.signIn,
        builder: (_, __) => const SignInScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        builder: (_, __) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.resetPassword,
        builder: (_, __) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.registerBasicInfo,
        builder: (_, __) => const RegisterBasicInfoScreen(),
      ),
      GoRoute(
        path: RoutePaths.registerRoleSelection,
        builder: (_, __) => const RegisterRoleSelectionScreen(),
      ),
      GoRoute(
        path: RoutePaths.registerDetails,
        builder: (_, __) => const RegisterDetailsScreen(),
      ),
      GoRoute(
        path: RoutePaths.onboardingInterests,
        builder: (_, __) => const OnboardingInterestsScreen(),
      ),
      GoRoute(
        path: RoutePaths.search,
        builder: (_, __) => const SearchScreen(),
      ),
      GoRoute(
        path: RoutePaths.publicCampus,
        builder: (_, state) =>
            PublicCampusScreen(campusId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: RoutePaths.publicProfile,
        builder: (_, state) =>
            PublicProfileScreen(muid: state.pathParameters['muid']!),
      ),
      GoRoute(
        path: RoutePaths.interestGroups,
        builder: (_, __) => const InterestGroupsScreen(),
      ),
      GoRoute(
        path: RoutePaths.interestGroupDetail,
        builder: (_, state) =>
            InterestGroupDetailScreen(groupId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: RoutePaths.events,
        builder: (_, state) =>
            EventsScreen(igId: state.uri.queryParameters['ig']),
      ),
      GoRoute(
        path: RoutePaths.eventDetail,
        builder: (_, state) =>
            EventDetailScreen(eventId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: RoutePaths.calendar,
        builder: (_, __) => const CalendarScreen(),
      ),
      GoRoute(
        path: RoutePaths.opportunities,
        builder: (_, __) => const OpportunitiesScreen(),
      ),
      GoRoute(
        path: RoutePaths.problemStatements,
        builder: (_, __) => const ProblemStatementsScreen(),
      ),
      GoRoute(
        path: RoutePaths.learnerSessions,
        builder: (_, __) => const LearnerSessionsScreen(),
      ),
      GoRoute(
        path: RoutePaths.projects,
        builder: (_, __) => const ProjectsScreen(),
      ),
      // Before /projects/:id, so "new" isn't read as an id.
      GoRoute(
        path: RoutePaths.projectNew,
        builder: (_, __) => const ProjectFormScreen(),
      ),
      GoRoute(
        path: RoutePaths.project,
        builder: (_, state) =>
            ProjectDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: RoutePaths.projectEdit,
        builder: (_, state) =>
            ProjectFormScreen(projectId: state.pathParameters['id']),
      ),
      GoRoute(
        path: RoutePaths.problemStatement,
        builder: (_, state) =>
            ProblemStatementDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: RoutePaths.weeklyTwitches,
        builder: (_, state) => WeeklyTwitchesScreen(
          initial:
              TwitchShow.from(state.uri.queryParameters['show']) ??
              TwitchShow.officeHours,
        ),
      ),
      GoRoute(
        path: RoutePaths.weeklyTwitch,
        builder: (_, state) => TwitchDetailScreen(
          show:
              TwitchShow.from(state.pathParameters['show']) ??
              TwitchShow.officeHours,
          id: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: RoutePaths.learningCircles,
        builder: (_, state) =>
            LearningCirclesScreen(igId: state.uri.queryParameters['ig']),
      ),
      GoRoute(
        path: RoutePaths.createLearningCircle,
        builder: (_, __) => const CreateLearningCircleScreen(),
      ),
      GoRoute(
        path: RoutePaths.notifications,
        builder: (_, __) => const NotificationsScreen(),
      ),
      GoRoute(
        path: RoutePaths.settings,
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: RoutePaths.settingsPassword,
        builder: (_, __) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.mentor,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.mentor,
          role: 'Mentor',
          builder: (_) => const MentorHubScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.campus,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.campus,
          role: 'Campus',
          builder: (_) => const CampusOverviewScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.team,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) => const TeamHomeScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.teamAnnouncements,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) => const AnnouncementsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.teamAnnouncementNew,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) => const AnnouncementFormScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.teamAnnouncement,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) => AnnouncementDetailScreen(
            announcementId: state.pathParameters['id']!,
          ),
        ),
      ),
      GoRoute(
        path: RoutePaths.teamAnnouncementEdit,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) => AnnouncementFormScreen(
            announcementId: state.pathParameters['id'],
          ),
        ),
      ),
      GoRoute(
        path: RoutePaths.teamLog,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) => const ActivityLogScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.teamCampaigns,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) => const CampaignsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.teamCampaignNew,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) => const CampaignFormScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.teamCampaign,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.team,
          role: 'Team',
          builder: (_) =>
              CampaignDetailScreen(campaignId: state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: RoutePaths.enablerCampuses,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.enablerCampuses,
          role: 'Enabler',
          builder: (_) => const EnablerCampusesScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.enablerCampus,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.enablerCampuses,
          role: 'Enabler',
          builder: (_) =>
              EnablerCampusScreen(campusId: state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: RoutePaths.campusApprovals,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.campus,
          role: 'Campus',
          builder: (_) => const CampusApprovalsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.campusGroups,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.campus,
          role: 'Campus',
          builder: (_) => const CampusGroupsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.campusStudents,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.campus,
          role: 'Campus',
          builder: (_) => const CampusStudentsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.campusStudent,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.campus,
          role: 'Campus',
          builder: (_) => CampusStudentScreen(
            muid: state.pathParameters['muid']!,
            student: state.extra is CampusStudent
                ? state.extra! as CampusStudent
                : null,
          ),
        ),
      ),
      GoRoute(
        path: RoutePaths.mentorSessions,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.mentor,
          role: 'Mentor',
          builder: (_) => const MentorSessionsScreen(),
        ),
      ),
      // Before `:id` routes, so "new" isn't read as an id.
      GoRoute(
        path: RoutePaths.mentorSessionNew,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.mentor,
          role: 'Mentor',
          builder: (_) => const SessionFormScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.mentorSessionEdit,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.mentor,
          role: 'Mentor',
          builder: (_) =>
              SessionFormScreen(sessionId: state.pathParameters['id']),
        ),
      ),
      GoRoute(
        path: RoutePaths.mentorAvailability,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.mentor,
          role: 'Mentor',
          builder: (_) => const AvailabilityScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.mentorRequests,
        builder: (_, __) => WorkspaceGate(
          select: (a) => a.mentor,
          role: 'Mentor',
          builder: (_) => const StudentRequestsScreen(),
        ),
      ),
      // No WorkspaceGate: applying is how a mentor gets the workspace.
      GoRoute(
        path: RoutePaths.mentorApplications,
        builder: (_, __) => const MentorApplicationsScreen(),
      ),
      GoRoute(
        path: RoutePaths.mentorApply,
        builder: (_, state) => MentorApplicationFormScreen(
          editId: state.uri.queryParameters['edit'],
          fromId: state.uri.queryParameters['from'],
          tier: state.uri.queryParameters['tier'],
        ),
      ),
      GoRoute(
        path: RoutePaths.mentorSessionDetail,
        builder: (_, state) => WorkspaceGate(
          select: (a) => a.mentor,
          role: 'Mentor',
          builder: (_) =>
              MentorSessionDetailScreen(sessionId: state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: RoutePaths.connectDiscord,
        builder: (_, state) =>
            ConnectDiscordScreen(code: state.uri.queryParameters['code']),
      ),
      GoRoute(
        path: RoutePaths.taskDetail,
        builder: (_, state) =>
            TaskDetailScreen(taskId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: RoutePaths.learningCircleDetail,
        builder: (_, state) =>
            LearningCircleDetailScreen(circleId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: RoutePaths.createMeeting,
        builder: (_, state) =>
            CreateMeetingScreen(circleId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: RoutePaths.meetingDetail,
        builder: (_, state) => MeetingDetailScreen(
          meetingId: state.pathParameters['id']!,
          circleId: state.extra as String?,
        ),
      ),
      GoRoute(
        path: RoutePaths.editMeeting,
        builder: (_, state) =>
            EditMeetingScreen(meetingId: state.pathParameters['id']!),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.home,
                builder: (_, __) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.tasks,
                builder: (_, __) => const TasksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.journey,
                builder: (_, __) => const JourneyScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.leaderboard,
                builder: (_, __) => const LeaderboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Bridges the [AppAuthController] provider to go_router's [Listenable]-based
/// refresh, so the redirect re-evaluates whenever auth state changes without
/// rebuilding the whole [GoRouter].
class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(Ref ref) {
    ref
      ..listen(appAuthControllerProvider, (_, __) => notifyListeners())
      ..listen(arrivalSeenProvider, (_, __) => notifyListeners())
      // Re-run the guard once the user loads (the interests step).
      ..listen(currentUserProvider, (previous, next) {
        if (previous?.value?.needsInterests != next.value?.needsInterests) {
          notifyListeners();
        }
      });
  }
}
