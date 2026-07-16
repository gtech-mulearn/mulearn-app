// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_circle_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LearningCircleDetailDto _$LearningCircleDetailDtoFromJson(
  Map<String, dynamic> json,
) => _LearningCircleDetailDto(
  id: json['id'] as String,
  ig: json['ig'] as String,
  title: json['title'] as String,
  createdBy: CircleUserRefDto.fromJson(
    json['created_by'] as Map<String, dynamic>,
  ),
  description: json['description'] as String? ?? '',
  org: json['org'] as String?,
  isRecurring: json['is_recurring'] as bool? ?? false,
  rank: (json['rank'] as num?)?.toInt(),
  totalKarma: (json['total_karma'] as num?)?.toInt(),
  totalMembers: (json['total_members'] as num?)?.toInt(),
  nextMeetup: json['next_meetup'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$LearningCircleDetailDtoToJson(
  _LearningCircleDetailDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'ig': instance.ig,
  'title': instance.title,
  'created_by': instance.createdBy,
  'description': instance.description,
  'org': instance.org,
  'is_recurring': instance.isRecurring,
  'rank': instance.rank,
  'total_karma': instance.totalKarma,
  'total_members': instance.totalMembers,
  'next_meetup': instance.nextMeetup,
};
