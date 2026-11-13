// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enabler_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EnablerCampusDto _$EnablerCampusDtoFromJson(Map<String, dynamic> json) =>
    _EnablerCampusDto(
      id: json['id'] as String,
      collegeName: json['college_name'] as String? ?? '',
      campusCode: json['campus_code'] as String? ?? '',
      zone: json['zone'] as String?,
      orgType: json['org_type'] as String? ?? '',
    );

Map<String, dynamic> _$EnablerCampusDtoToJson(_EnablerCampusDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'college_name': instance.collegeName,
      'campus_code': instance.campusCode,
      'zone': instance.zone,
      'org_type': instance.orgType,
    };

_CampusNoteDto _$CampusNoteDtoFromJson(Map<String, dynamic> json) =>
    _CampusNoteDto(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      note: json['note'] as String? ?? '',
      priority: json['priority'] as String? ?? 'medium',
      status: json['status'] as String? ?? 'open',
      enablerName: json['enabler_name'] as String?,
      followUpDate: json['follow_up_date'] as String?,
    );

Map<String, dynamic> _$CampusNoteDtoToJson(_CampusNoteDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'note': instance.note,
      'priority': instance.priority,
      'status': instance.status,
      'enabler_name': instance.enablerName,
      'follow_up_date': instance.followUpDate,
    };
