import 'dart:convert';
import 'dart:io';

/// Loads `test/fixtures/<name>.json` and returns its `body`: the full
/// backend response envelope `{hasError, statusCode, message, response}`.
///
/// Fixtures under `dev/` were recorded from https://dev.mulearn.org by
/// `tool/record_fixtures.dart` (personal data scrubbed). Fixtures under
/// `serializer/` were built by hand from the backend serializer code, for
/// endpoints that have no data on dev yet; each names its source in `_meta`.
Map<String, dynamic> loadFixture(String name) {
  final file = File('test/fixtures/$name.json');
  if (!file.existsSync()) {
    throw StateError('Missing fixture: ${file.path}');
  }
  final decoded = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return decoded['body'] as Map<String, dynamic>;
}

/// The `response` payload of [loadFixture], for tests that feed a
/// datasource's already-unwrapped value.
Object? loadFixtureResponse(String name) => loadFixture(name)['response'];
