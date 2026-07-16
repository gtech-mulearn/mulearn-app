import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/issued_vc_subject_info_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/issued_vc.dart';

part 'issued_vc_dto.freezed.dart';
part 'issued_vc_dto.g.dart';

@freezed
abstract class IssuedVcDto with _$IssuedVcDto {
  const factory IssuedVcDto({
    required String message,
    required IssuedVcSubjectInfoDto subjectInfo,
  }) = _IssuedVcDto;

  const IssuedVcDto._();

  factory IssuedVcDto.fromJson(Map<String, dynamic> json) =>
      _$IssuedVcDtoFromJson(json);

  IssuedVc toDomain() =>
      IssuedVc(message: message, subjectInfo: subjectInfo.toDomain());
}
