import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';

/// An authenticated session — pure-Dart domain entity (rules.md §2: no Flutter,
/// no Dio imports here).
///
/// Holds the JWT pair. Any user summary returned by the login endpoint is
/// intentionally NOT modeled yet: the auth payload shape is unconfirmed
/// (build prompt §3a), and the read-only profile is fetched separately from
/// `/dashboard/profile/user-profile/`. Extend this once the real login response
/// is confirmed, if a user summary is worth carrying.
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    required String refreshToken,
  }) = _AuthSession;
}
