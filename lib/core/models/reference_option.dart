import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference_option.freezed.dart';

/// A `{id, title}` lookup option — pure-Dart shared entity (rules.md §2).
///
/// Lives in `core/` rather than a single feature because both `auth`
/// (registration's role/college/department/company pickers) and `profile`
/// (college/department change, communities) need the identical shape —
/// exactly the "promote to core/" scenario rules.md §2 describes for
/// cross-feature reuse.
@freezed
abstract class ReferenceOption with _$ReferenceOption {
  const factory ReferenceOption({
    required String id,
    required String title,
  }) = _ReferenceOption;
}
