import 'dart:convert';

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
  final token = await ref.watch(tokenStorageProvider).readAccessToken();
  if (token == null) return null;
  final parts = token.split('.');
  if (parts.length != 3) return null;
  try {
    final normalized = base64Url.normalize(parts[1]);
    final payload = jsonDecode(utf8.decode(base64Url.decode(normalized)))
        as Map<String, dynamic>;
    return payload['muid'] as String?;
  } on FormatException {
    return null;
  }
}
