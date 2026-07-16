import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/interest_groups/data/dtos/ig_person_ref_dto.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';

part 'interest_group_summary_dto.freezed.dart';
part 'interest_group_summary_dto.g.dart';

/// Confirmed live (rules.md §3/§9) as the actual cause of the directory
/// screen's "Something went wrong": at least one catalog record sends
/// `prerequisites` (and, by the same serializer, presumably
/// `career_opportunities`) as a bare `String` instead of a `List<String>`.
/// json_serializable's generated cast throws on a strict `List<dynamic>?`
/// annotation, so this custom converter tolerates both shapes instead of
/// trusting the field is always a list.
List<String>? _stringListFromJson(dynamic value) {
  if (value == null) return null;
  if (value is List) return value.map((e) => e.toString()).toList();
  if (value is String) return value.isEmpty ? [] : [value];
  return null;
}

/// Raw shape of one entry in `ig/list/`'s `interestGroup` array, and of
/// `public/ig/{id}/`'s `interestGroup` object — confirmed live to be
/// identical (rules.md §3/§9). Every field beyond `id`/`name` is nullable
/// here even where the sampled rows always had a value: a full-catalog
/// fetch parses every row eagerly, so one incomplete/legacy record (e.g. an
/// admin-created group missing `category`) would otherwise throw and take
/// down the whole list — confirmed live as the actual cause of the
/// directory screen's "Something went wrong" (rules.md §3/§9: a `@Default`
/// only covers an *absent* key, not one explicitly sent as `null`, so
/// nullability + a `??` fallback in [toDomain] is required, not optional).
@freezed
abstract class InterestGroupSummaryDto with _$InterestGroupSummaryDto {
  const factory InterestGroupSummaryDto({
    required String id,
    required String name,
    String? category,
    int? members,
    List<IgPersonRefDto>? leads,
    List<IgPersonRefDto>? mentors,
    String? about,
    String? resource,
    String? icon,
    String? code,
    @JsonKey(fromJson: _stringListFromJson) List<String>? prerequisites,
    @JsonKey(fromJson: _stringListFromJson)
    List<String>? careerOpportunities,
  }) = _InterestGroupSummaryDto;

  const InterestGroupSummaryDto._();

  factory InterestGroupSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$InterestGroupSummaryDtoFromJson(json);

  InterestGroupSummary toDomain() => InterestGroupSummary(
        id: id,
        name: name,
        category: category ?? 'General',
        memberCount: members ?? 0,
        leads: (leads ?? const []).map((e) => e.toDomain()).toList(),
        mentors: (mentors ?? const []).map((e) => e.toDomain()).toList(),
        about: (about != null && about!.isEmpty) ? null : about,
        resource: (resource != null && resource!.isEmpty) ? null : resource,
        icon: icon,
        code: code,
        prerequisites: prerequisites ?? const [],
        careerOpportunities: careerOpportunities ?? const [],
      );
}
