import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_option.freezed.dart';

/// A `{id, name}` lookup option — pure-Dart shared entity (rules.md §2) for
/// the country/state/district cascading pickers, used by both `auth`
/// (Company registration) and `profile` (college/department change) — see
/// [ReferenceOption]'s doc comment for why this lives in `core/`. Distinct
/// from [ReferenceOption] because the backend uses `name` here, not `title`.
@freezed
abstract class LocationOption with _$LocationOption {
  const factory LocationOption({
    required String id,
    required String name,
  }) = _LocationOption;
}
