import 'dart:convert';

/// Reads claim [name] from a JWT's payload without verifying the signature —
/// only for tokens the app already holds from a successful sign-in (claims:
/// `id, muid, roles, expiry, tokenType, iat`). Returns `null` for a missing
/// claim or any malformed token.
String? jwtClaim(String token, String name) {
  final parts = token.split('.');
  if (parts.length != 3) return null;
  try {
    final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    if (payload is! Map<String, dynamic>) return null;
    final value = payload[name];
    return value is String ? value : null;
  } on FormatException {
    return null;
  }
}
