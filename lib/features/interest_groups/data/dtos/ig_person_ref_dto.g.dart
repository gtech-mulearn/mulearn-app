// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ig_person_ref_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IgPersonRefDto _$IgPersonRefDtoFromJson(Map<String, dynamic> json) =>
    _IgPersonRefDto(
      muid: json['muid'] as String,
      fullName: json['full_name'] as String?,
      profilePic: json['profile_pic'] as String?,
    );

Map<String, dynamic> _$IgPersonRefDtoToJson(_IgPersonRefDto instance) =>
    <String, dynamic>{
      'muid': instance.muid,
      'full_name': instance.fullName,
      'profile_pic': instance.profilePic,
    };
