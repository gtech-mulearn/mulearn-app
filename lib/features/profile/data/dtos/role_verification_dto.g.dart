// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_verification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoleVerificationDto _$RoleVerificationDtoFromJson(Map<String, dynamic> json) =>
    _RoleVerificationDto(
      role: json['role'] as String,
      isVerified: json['is_verified'] as bool,
    );

Map<String, dynamic> _$RoleVerificationDtoToJson(
  _RoleVerificationDto instance,
) => <String, dynamic>{
  'role': instance.role,
  'is_verified': instance.isVerified,
};
