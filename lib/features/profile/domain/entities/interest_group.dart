import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/interest_group_level.dart';

part 'interest_group.freezed.dart';

/// An interest group the user belongs to — pure-Dart domain entity
/// (rules.md §2). Confirmed against a real API response as a full object
/// (`{id, name, karma, level}`), not the bare string this project originally
/// (incorrectly) modeled it as.
@freezed
abstract class InterestGroup with _$InterestGroup {
  const factory InterestGroup({
    required String name,
    required InterestGroupLevel level,
    String? id,
    int? karma,
  }) = _InterestGroup;
}
