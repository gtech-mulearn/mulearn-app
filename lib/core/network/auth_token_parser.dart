/// A parsed JWT access + refresh token pair extracted from an auth payload.
class ParsedAuthTokens {
  const ParsedAuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;
}

/// Extracts the access/refresh tokens out of an auth endpoint's (unwrapped)
/// `response` payload.
///
/// Field names (`accessToken`/`refreshToken`, camelCase) are confirmed against
/// the live `mulearn-dashboard` frontend source rather than the OpenAPI schema,
/// which types this payload as an opaque object (rules.md §3/§9).
class AuthTokenParser {
  const AuthTokenParser._();

  /// Returns the tokens if both are present, else null (caller decides how to
  /// surface the failure). [payload] is the already-unwrapped `response` object.
  static ParsedAuthTokens? tryParse(Map<String, dynamic> payload) {
    final access = _string(payload, 'accessToken');
    final refresh = _string(payload, 'refreshToken');
    if (access == null || refresh == null) return null;
    return ParsedAuthTokens(accessToken: access, refreshToken: refresh);
  }

  /// For refresh responses, which only rotate the access token
  /// (`get-access-token/` returns `{"accessToken": "..."}`, no refresh token).
  static String? tryParseRefreshed(Map<String, dynamic> payload) =>
      _string(payload, 'accessToken');

  static String? _string(Map<String, dynamic> map, String key) {
    final value = map[key];
    return value is String && value.isNotEmpty ? value : null;
  }
}
