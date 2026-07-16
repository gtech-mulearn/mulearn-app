import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/socials.dart';

part 'socials_dto.freezed.dart';
part 'socials_dto.g.dart';

/// Raw API shape confirmed against a real
/// `GET /api/v1/dashboard/profile/socials/` response (rules.md §3/§9).
@freezed
abstract class SocialsDto with _$SocialsDto {
  const factory SocialsDto({
    String? github,
    String? facebook,
    String? instagram,
    String? linkedin,
    String? dribble,
    String? behance,
    String? stackoverflow,
    String? medium,
    String? hackerrank,
  }) = _SocialsDto;

  const SocialsDto._();

  factory SocialsDto.fromJson(Map<String, dynamic> json) =>
      _$SocialsDtoFromJson(json);

  Socials toDomain() => Socials(
        github: github,
        facebook: facebook,
        instagram: instagram,
        linkedin: linkedin,
        dribble: dribble,
        behance: behance,
        stackoverflow: stackoverflow,
        medium: medium,
        hackerrank: hackerrank,
      );
}
