import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/issued_vc_subject_info.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_type.dart';

part 'issued_vc_subject_info_dto.freezed.dart';
part 'issued_vc_subject_info_dto.g.dart';

/// `credentialType`/`type` arrive as PascalCase strings (`"Badge"`,
/// `"Certificate"`, `"Recognition"`) — kept as raw [String] here and mapped
/// via [VcCredentialTypeApiValue.fromApiValue] in [toDomain], since
/// json_serializable can't auto-convert PascalCase wire values to Dart enum
/// names.
@freezed
abstract class IssuedVcSubjectInfoDto with _$IssuedVcSubjectInfoDto {
  const factory IssuedVcSubjectInfoDto({
    required String courseName,
    required String credentialId,
    required String credentialType,
    required String did,
    required String fullName,
    required String s3Url,
    required String templateId,
    required String type,
    String? completedDate,
    String? description,
    String? email,
  }) = _IssuedVcSubjectInfoDto;

  const IssuedVcSubjectInfoDto._();

  factory IssuedVcSubjectInfoDto.fromJson(Map<String, dynamic> json) =>
      _$IssuedVcSubjectInfoDtoFromJson(json);

  IssuedVcSubjectInfo toDomain() => IssuedVcSubjectInfo(
        courseName: courseName,
        credentialId: credentialId,
        credentialType: VcCredentialTypeApiValue.fromApiValue(credentialType),
        did: did,
        fullName: fullName,
        s3Url: s3Url,
        templateId: templateId,
        type: VcCredentialTypeApiValue.fromApiValue(type),
        completedDate: completedDate,
        description: description,
        email: email,
      );
}
