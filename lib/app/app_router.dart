import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/app/widgets/main_shell.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/onboarding_interests_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/register_basic_info_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/register_details_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/register_role_selection_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:mulearn_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:mulearn_app/features/calendar/presentation/screens/calendar_screen.dart';
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
import 'package:mulearn_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/public_profile_screen.dart';
import 'package:mulearn_app/features/search/presentation/screens/search_screen.dart';
import 'package:mulearn_app/features/splash/presentation/screens/splash_screen.dart';
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
    redirect: (context, state) {
      final auth = ref.read(appAuthControllerProvider);
      final location = state.matchedLocation;

      // Session still being resolved from secure storage.
      if (auth.isLoading || !auth.hasValue) {
        return location == RoutePaths.splash ? null : RoutePaths.splash;
      }

      final loggedIn = auth.value ?? false;

      // Reachable while signed out — registration itself signs the user in
      // partway through, so `/register/details` must tolerate both states.
      const allowedSignedOut = {
        RoutePaths.signIn,
        RoutePaths.forgotPassword,
        RoutePaths.resetPassword,
        RoutePaths.registerBasicInfo,
        RoutePaths.registerRoleSelection,
        RoutePaths.registerDetails,
      };
      // Reachable while signed in without bouncing to `/home` — the
      // registration-details screen (mid-submission), the interests
      // onboarding step that follows it, and the three bottom-nav tabs.
      const allowedSignedIn = {
        RoutePaths.registerDetails,
        RoutePaths.onboardingInterests,
        RoutePaths.home,
        RoutePaths.leaderboard,
        RoutePaths.profile,
      };
      // Routes reachable while signed in, outside the bottom-nav shell —
      // pushed on top rather than switched to, so they're exempt from the
      // "must be one of the three tabs" redirect below.
      const allowedSignedInExtra = {
        RoutePaths.search,
        RoutePaths.interestGroups,
        RoutePaths.events,
        RoutePaths.calendar,
        RoutePaths.learningCircles,
        RoutePaths.createLearningCircle,
      };

      if (!loggedIn) {
        return allowedSignedOut.contains(location) ? null : RoutePaths.signIn;
      }
      if (allowedSignedInExtra.contains(location) ||
          location.startsWith('/u/') ||
          location.startsWith('/interest-groups/') ||
          location.startsWith('/events/') ||
          location.startsWith('/circles/') ||
          location.startsWith('/meetings/')) {
        return null;
      }
      return allowedSignedIn.contains(location) ? null : RoutePaths.home;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (_, __) => const SplashScreen(),
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
        builder: (_, state) => InterestGroupDetailScreen(
          groupId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: RoutePaths.events,
        builder: (_, __) => const EventsScreen(),
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
        path: RoutePaths.learningCircles,
        builder: (_, __) => const LearningCirclesScreen(),
      ),
      GoRoute(
        path: RoutePaths.createLearningCircle,
        builder: (_, __) => const CreateLearningCircleScreen(),
      ),
      GoRoute(
        path: RoutePaths.learningCircleDetail,
        builder: (_, state) => LearningCircleDetailScreen(
          circleId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: RoutePaths.createMeeting,
        builder: (_, state) => CreateMeetingScreen(
          circleId: state.pathParameters['id']!,
        ),
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
        builder: (_, state) => EditMeetingScreen(
          meetingId: state.pathParameters['id']!,
        ),
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
    ref.listen(appAuthControllerProvider, (_, __) => notifyListeners());
  }
}
