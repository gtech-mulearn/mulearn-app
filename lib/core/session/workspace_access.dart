import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/session/role_titles.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_access.freezed.dart';
part 'workspace_access.g.dart';

/// Whether the user gets a role workspace: not at all, a "pending
/// verification" banner instead, or the workspace itself.
enum WorkspaceState { hidden, pending, open }

/// Which role workspaces the signed-in user sees. The single place this is
/// decided; Home, Profile and the workspace routes only read it. The backend
/// still authorises every request.
@freezed
abstract class WorkspaceAccess with _$WorkspaceAccess {
  const factory WorkspaceAccess({
    required WorkspaceState mentor,
    required WorkspaceState campus,
    required WorkspaceState enablerCampuses,

    /// Campus Lead held **and** verified: college-link approvals and
    /// collaboration invites (backend `role_required([Admin, Campus Lead])`).
    required bool campusLead,

    /// Every campus role held but not verified yet, in naming order. Each
    /// gets its own banner, even when another held role opens the campus
    /// (the dashboard checks Enabler verification on its own).
    @Default(<String>[]) List<String> pendingCampusRoles,
  }) = _WorkspaceAccess;
}

/// The campus workspace's roles, in banner-naming order: the backend's
/// `campus_staff_required` and the dashboard's `CAMPUS_MANAGEMENT_ROLES`.
/// Zonal and District Campus Leads are not campus staff.
const _campusRoles = [RoleTitles.campusLead, RoleTitles.leadEnabler, RoleTitles.enabler];
const _enablerRoles = [RoleTitles.leadEnabler, RoleTitles.enabler];

/// Mentor: open with an APPROVED application, pending while one is PENDING
/// (the dashboard's banner rule). REJECTED and GRANT_REVOKED show nothing:
/// "awaiting admin approval" would be untrue. The Mentor `role_verification`
/// row is ignored; it stays false after approval on dev.
///
/// Campus roles: open when a held role is verified in [roleVerified]
/// (lower-case titles, as the dashboard compares them), pending otherwise.
WorkspaceAccess deriveWorkspaceAccess({
  required List<String> roles,
  required List<MentorApplication> mentorApplications,
  required Map<String, bool> roleVerified,
}) {
  bool verified(String role) => roleVerified[role.toLowerCase()] ?? false;

  WorkspaceState roleState(List<String> titles) {
    final held = titles.where(roles.contains).toList();
    if (held.isEmpty) return WorkspaceState.hidden;
    return held.any(verified) ? WorkspaceState.open : WorkspaceState.pending;
  }

  WorkspaceState mentor() {
    if (!roles.contains(RoleTitles.mentor)) return WorkspaceState.hidden;
    final statuses = mentorApplications.map((a) => a.status.toUpperCase()).toSet();
    if (statuses.contains('APPROVED')) return WorkspaceState.open;
    if (statuses.contains('PENDING')) return WorkspaceState.pending;
    return WorkspaceState.hidden;
  }

  return WorkspaceAccess(
    mentor: mentor(),
    campus: roleState(_campusRoles),
    enablerCampuses: roleState(_enablerRoles),
    campusLead: roles.contains(RoleTitles.campusLead) && verified(RoleTitles.campusLead),
    pendingCampusRoles: [
      for (final role in _campusRoles)
        if (roles.contains(role) && !verified(role)) role,
    ],
  );
}

/// The pending role a pending workspace names: for an Enabler workspace an
/// enabler role, otherwise the first pending campus role. Null when none.
String? pendingRoleFor(WorkspaceAccess access, {required bool enablerWorkspace}) {
  final candidates = enablerWorkspace ? _enablerRoles : _campusRoles;
  return candidates.where(access.pendingCampusRoles.contains).firstOrNull;
}

/// The profile's `role_verification: [{role, is_verified}]` as lower-case
/// role → verified. Rows without a role or a boolean are skipped.
Map<String, bool> parseRoleVerification(Object? raw) {
  if (raw is! List) return const {};
  return {
    for (final row in raw)
      if (row is Map && row['role'] is String && row['is_verified'] is bool)
        (row['role'] as String).toLowerCase(): row['is_verified'] as bool,
  };
}

/// The signed-in user's role verification, read from the shared profile.
@Riverpod(keepAlive: true, retry: noRetry)
Future<Map<String, bool>> roleVerification(Ref ref) async {
  final payload = await ref.watch(myProfilePayloadProvider.future);
  return parseRoleVerification(payload['role_verification']);
}

/// [WorkspaceAccess] for the signed-in user; `null` when signed out. The
/// profile is read only for users holding a campus role.
@Riverpod(keepAlive: true, retry: noRetry)
Future<WorkspaceAccess?> workspaceAccess(Ref ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return null;
  final applications = await ref.watch(mentorApplicationsProvider.future);
  final needsVerification = _campusRoles.any(user.roles.contains);
  final verified = needsVerification ? await ref.watch(roleVerificationProvider.future) : const <String, bool>{};
  return deriveWorkspaceAccess(roles: user.roles, mentorApplications: applications, roleVerified: verified);
}
