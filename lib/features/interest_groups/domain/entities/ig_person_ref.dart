import 'package:freezed_annotation/freezed_annotation.dart';

part 'ig_person_ref.freezed.dart';

/// A lead or mentor listed on an interest group's detail page — pure-Dart
/// domain entity (rules.md §2). Distinct from the full [UserSearchResult] /
/// public-profile shapes since the IG detail endpoint only ever nests this
/// minimal projection.
@freezed
abstract class IgPersonRef with _$IgPersonRef {
  const factory IgPersonRef({
    required String muid,
    required String fullName,
    String? profilePicUrl,
  }) = _IgPersonRef;
}
