import 'package:freezed_annotation/freezed_annotation.dart';

part 'interest_group_list_item.freezed.dart';

/// A `{id, name, category}` entry in the full interest-group catalog — pure
/// Dart domain entity (rules.md §2), used by the group picker/editor.
/// Distinct from [InterestGroup] (the user's *own* group membership shape) —
/// this is the minimal projection of the much richer
/// `GET /api/v1/dashboard/ig/list/` response, whose real payload nests full
/// lead/mentor user objects per group that the picker UI never needs.
@freezed
abstract class InterestGroupListItem with _$InterestGroupListItem {
  const factory InterestGroupListItem({
    required String id,
    required String name,
    String? category,
  }) = _InterestGroupListItem;
}
