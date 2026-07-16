import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/auth_token_parser.dart';

void main() {
  group('AuthTokenParser.tryParse', () {
    test('reads accessToken/refreshToken', () {
      final tokens = AuthTokenParser.tryParse({
        'accessToken': 'a-token',
        'refreshToken': 'r-token',
      });
      expect(tokens, isNotNull);
      expect(tokens!.accessToken, 'a-token');
      expect(tokens.refreshToken, 'r-token');
    });

    test('returns null when a token is missing or empty', () {
      expect(AuthTokenParser.tryParse({'accessToken': 'a'}), isNull);
      expect(
        AuthTokenParser.tryParse({'accessToken': '', 'refreshToken': 'r'}),
        isNull,
      );
    });
  });

  group('AuthTokenParser.tryParseRefreshed', () {
    test('reads the rotated access token', () {
      expect(
        AuthTokenParser.tryParseRefreshed({'accessToken': 'new'}),
        'new',
      );
    });

    test('returns null when no access token is present', () {
      expect(AuthTokenParser.tryParseRefreshed({}), isNull);
    });
  });
}
