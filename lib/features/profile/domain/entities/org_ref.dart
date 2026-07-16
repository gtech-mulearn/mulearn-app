import 'package:freezed_annotation/freezed_annotation.dart';

part 'org_ref.freezed.dart';

/// A `{id, name}` organization reference within [UserPreferences.orgs] —
/// pure-Dart domain entity (rules.md §2).
@freezed
abstract class OrgRef with _$OrgRef {
  const factory OrgRef({
    required String id,
    required String name,
  }) = _OrgRef;
}
