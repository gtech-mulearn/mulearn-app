import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/org_ref.dart';

part 'org_ref_dto.freezed.dart';
part 'org_ref_dto.g.dart';

@freezed
abstract class OrgRefDto with _$OrgRefDto {
  const factory OrgRefDto({
    required String id,
    required String name,
  }) = _OrgRefDto;

  const OrgRefDto._();

  factory OrgRefDto.fromJson(Map<String, dynamic> json) =>
      _$OrgRefDtoFromJson(json);

  OrgRef toDomain() => OrgRef(id: id, name: name);
}
