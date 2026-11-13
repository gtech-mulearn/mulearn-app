/// Removes personal data from a recorded backend response before it is saved
/// as a test fixture. Keys and value types are preserved so DTO parsing is
/// still exercised exactly; only identifying values are replaced.
library;

const _placeholders = <String, Object?>{
  'full_name': 'Fixture User',
  'fullName': 'Fixture User',
  'user_full_name': 'Fixture User',
  'created_by_name': 'Fixture User',
  'enabler_name': 'Fixture User',
  'requested_by_name': 'Fixture User',
  // campus-details `lead: {campus_lead, enabler}` carries names.
  'campus_lead': 'Fixture User',
  'enabler': 'Fixture User',
  'email': 'user@example.com',
  'mobile': null,
  'profile_pic': null,
  'cover_pic': null,
  'dob': null,
};

const _scrubbedMuid = 'fixture-user@mulearn';

/// Returns a scrubbed deep copy of [json]. Every `muid` not in [keepMuids]
/// is replaced, so recorded fixtures never carry real people's identifiers.
Map<String, dynamic> scrubFixture(
  Object? json, {
  required Set<String> keepMuids,
}) {
  final result = _scrub(json, keepMuids);
  return result is Map<String, dynamic> ? result : {'value': result};
}

Object? _scrub(Object? node, Set<String> keepMuids) {
  if (node is Map) {
    return {
      for (final entry in node.entries)
        entry.key as String: _scrubValue(entry.key as String, entry.value, keepMuids),
    };
  }
  if (node is List) {
    return [for (final item in node) _scrub(item, keepMuids)];
  }
  return node;
}

Object? _scrubValue(String key, Object? value, Set<String> keepMuids) {
  if (const {'muid', 'mu_id', 'requested_by_muid'}.contains(key) && value is String) {
    return keepMuids.contains(value) ? value : _scrubbedMuid;
  }
  if (_placeholders.containsKey(key) && value != null && value is! Map && value is! List) {
    return _placeholders[key];
  }
  return _scrub(value, keepMuids);
}
