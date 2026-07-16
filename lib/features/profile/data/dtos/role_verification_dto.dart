import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/role_verification.dart';

part 'role_verification_dto.freezed.dart';
part 'role_verification_dto.g.dart';

@freezed
abstract class RoleVerificationDto with _$RoleVerificationDto {
  const factory RoleVerificationDto({
    required String role,
    required bool isVerified,
  }) = _RoleVerificationDto;

  const RoleVerificationDto._();

  factory RoleVerificationDto.fromJson(Map<String, dynamic> json) =>
      _$RoleVerificationDtoFromJson(json);

  RoleVerification toDomain() =>
      RoleVerification(role: role, isVerified: isVerified);
}
