// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editable_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EditableProfileDto _$EditableProfileDtoFromJson(Map<String, dynamic> json) =>
    _EditableProfileDto(
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      district: json['district'] == null
          ? null
          : DistrictLocationDto.fromJson(
              json['district'] as Map<String, dynamic>,
            ),
      communities:
          (json['communities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EditableProfileDtoToJson(_EditableProfileDto instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'dob': instance.dob,
      'district': instance.district,
      'communities': instance.communities,
    };
