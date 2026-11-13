import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/auth/jwt_claims.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_claims.g.dart';

/// The signed-in user's `muid`, read directly off the stored JWT access
/// token's payload claim (confirmed live: `{"id", "muid", "roles", "expiry",
/// "tokenType"}`) rather than a network call — this app never verifies the
/// signature client-side, it only reads a claim already trusted because the
/// token came from secure storage after a successful sign-in.
///
/// Lives in `core/` (rules.md §2) because "which user am I" is needed by
/// multiple features (e.g. `learning_circles` determining lead/ownership)
/// without any of them importing `features/auth` or `features/profile`.
@riverpod
Future<String?> currentUserMuid(Ref ref) async {
  // Re-read on every sign-in/out so a cached muid never outlives its session.
  if (!await ref.watch(appAuthControllerProvider.future)) return null;
  final token = await ref.watch(tokenStorageProvider).readAccessToken();
  return token == null ? null : jwtClaim(token, 'muid');
}

/// The signed-in user's id (the JWT `id` claim) — the id meeting attendees
/// are listed by (`attendees[].user_id`).
@riverpod
Future<String?> currentUserId(Ref ref) async {
  if (!await ref.watch(appAuthControllerProvider.future)) return null;
  final token = await ref.watch(tokenStorageProvider).readAccessToken();
  return token == null ? null : jwtClaim(token, 'id');
}
