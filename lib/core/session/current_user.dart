import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _CurrentUser;
}
