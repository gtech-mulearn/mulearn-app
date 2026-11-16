import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mulearn_app/core/session/role_titles.dart';

part 'current_user.freezed.dart';

/// The signed-in user as `GET /api/v1/dashboard/user/info/` describes them.
/// [roles] lists every role link the user has, verified or not — the
/// backend stays the authority for what each role may do.
@freezed
abstract class CurrentUser with _$CurrentUser {
  const factory CurrentUser({
    required String muid,
    required String fullName,
    @Default([]) List<String> roles,
    @Default(false) bool existInGuild,
    String? profilePic,
    String? company,

    /// Pathways picked in onboarding (`coder`, `maker`, …). Empty means the
    /// interests step was never finished.
    @Default([]) List<String> userDomains,
  }) = _CurrentUser;

  const CurrentUser._();

  /// Like the dashboard's onboarding guard: everyone but a company account
  /// must pick a pathway before using the app.
  bool get needsInterests =>
      userDomains.isEmpty && !roles.contains(RoleTitles.company);
}
