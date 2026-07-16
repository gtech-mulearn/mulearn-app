// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_group_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InterestGroupSummaryDto _$InterestGroupSummaryDtoFromJson(
  Map<String, dynamic> json,
) => _InterestGroupSummaryDto(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String?,
  members: (json['members'] as num?)?.toInt(),
  leads: (json['leads'] as List<dynamic>?)
      ?.map((e) => IgPersonRefDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  mentors: (json['mentors'] as List<dynamic>?)
      ?.map((e) => IgPersonRefDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  about: json['about'] as String?,
  resource: json['resource'] as String?,
  icon: json['icon'] as String?,
  code: json['code'] as String?,
  prerequisites: _stringListFromJson(json['prerequisites']),
  careerOpportunities: _stringListFromJson(json['career_opportunities']),
);

Map<String, dynamic> _$InterestGroupSummaryDtoToJson(
  _InterestGroupSummaryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'members': instance.members,
  'leads': instance.leads,
  'mentors': instance.mentors,
  'about': instance.about,
  'resource': instance.resource,
  'icon': instance.icon,
  'code': instance.code,
  'prerequisites': instance.prerequisites,
  'career_opportunities': instance.careerOpportunities,
};
