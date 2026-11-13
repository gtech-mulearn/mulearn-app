import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/router/route_paths.dart';

// Reachable while signed out — registration itself signs the user in partway
// through, so `/register/details` must tolerate both states.
const _allowedSignedOut = {
  RoutePaths.signIn,
  RoutePaths.forgotPassword,
  RoutePaths.resetPassword,
  RoutePaths.registerBasicInfo,
  RoutePaths.registerRoleSelection,
  RoutePaths.registerDetails,
};

// Reachable while signed in without bouncing to `/home` — the
// registration-details screen (mid-submission), the interests onboarding step
// that follows it, and the five bottom-nav tabs.
const _allowedSignedIn = {
  RoutePaths.registerDetails,
  RoutePaths.onboardingInterests,
  RoutePaths.home,
  RoutePaths.tasks,
  RoutePaths.journey,
  RoutePaths.leaderboard,
  RoutePaths.profile,
};

// Pushed on top of the shell rather than switched to, so exempt from the
// "must be one of the five tabs" rule.
const _allowedSignedInExtra = {
  RoutePaths.search,
  RoutePaths.interestGroups,
  RoutePaths.events,
  RoutePaths.calendar,
  RoutePaths.createLearningCircle,
  RoutePaths.learningCircles,
  RoutePaths.notifications,
  RoutePaths.settings,
  RoutePaths.settingsPassword,
  RoutePaths.connectDiscord,
};

/// Role workspaces (Plan 4): `/mentor…`, `/campus…`, `/enabler…`. Access
/// is decided by `WorkspaceGate` on the screen, not here.
bool _isWorkspace(String path) => const ['/mentor', '/campus', '/enabler']
    .any((root) => path == root || path.startsWith('$root/'));

bool _isSignedInScreen(String path) =>
    _allowedSignedIn.contains(path) ||
    _allowedSignedInExtra.contains(path) ||
    _isWorkspace(path) ||
    path.startsWith('/u/') ||
    path.startsWith('/interest-groups/') ||
    path.startsWith('/events/') ||
    path.startsWith('/circles/') ||
    path.startsWith('/meetings/') ||
    (path.startsWith('/tasks/') && path != RoutePaths.tasks);

String _normalise(String path) => path.length > 1 && path.endsWith('/') ? path.substring(0, path.length - 1) : path;

/// A `from` worth resuming: an in-app path (never `//host` or a URL) to a
/// signed-in screen.
String? _resumable(String? from) {
  if (from == null || !from.startsWith('/') || from.startsWith('//')) return null;
  final uri = Uri.tryParse(from);
  if (uri == null || uri.hasScheme || uri.hasAuthority) return null;
  return _isSignedInScreen(_normalise(uri.path)) ? from : null;
}

String _with(String path, String? from) =>
    from == null ? path : '$path?from=${Uri.encodeQueryComponent(from)}';

/// The router's auth guard. A deep link (e.g. Discord's redirect App Link)
/// keeps its target: through the splash screen while the session loads
/// (`/splash?from=`), and through sign-in when signed out
/// (`/sign-in?from=`); it is resumed once signed in.
String? appRedirect({required AsyncValue<bool> auth, required Uri uri}) {
  final path = _normalise(uri.path);
  final from = _resumable(uri.queryParameters['from']);
  // A real App Link reaches the router as its full URI (Android passes the
  // intent's data; go_router keeps scheme and host): resume its in-app part.
  final here = _resumable(Uri(path: uri.path, query: uri.hasQuery ? uri.query : null).toString());

  // Session still being resolved from secure storage.
  if (auth.isLoading || !auth.hasValue) {
    return path == RoutePaths.splash ? null : _with(RoutePaths.splash, here);
  }

  final loggedIn = auth.value ?? false;
  if (!loggedIn) {
    if (_allowedSignedOut.contains(path)) return null;
    return _with(RoutePaths.signIn, path == RoutePaths.splash ? from : here);
  }
  if ((path == RoutePaths.splash || path == RoutePaths.signIn) && from != null) return from;
  if (_isSignedInScreen(path)) return null;
  return RoutePaths.home;
}
