import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_person_ref.dart';

part 'interest_group_summary.freezed.dart';

/// Full interest-group detail — used both for the directory's catalog cards
/// and the detail screen, since `ig/list/` and `public/ig/{id}/` return the
/// same rich shape (confirmed live, rules.md §3/§9). Pure-Dart domain entity
/// (rules.md §2).
@freezed
abstract class InterestGroupSummary with _$InterestGroupSummary {
  const factory InterestGroupSummary({
    required String id,
    required String name,
    required String category,
    required int memberCount,
    required List<IgPersonRef> leads,
    required List<IgPersonRef> mentors,
    String? about,
    String? resource,
    String? icon,
    String? code,
    @Default([]) List<String> prerequisites,
    @Default([]) List<String> careerOpportunities,
  }) = _InterestGroupSummary;
}
