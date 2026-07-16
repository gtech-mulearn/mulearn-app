// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_feed_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KarmaFeedDto _$KarmaFeedDtoFromJson(Map<String, dynamic> json) =>
    _KarmaFeedDto(
      topUser: json['top_user'] == null
          ? null
          : KarmaFeedTopUserDto.fromJson(
              json['top_user'] as Map<String, dynamic>,
            ),
      topCollege: json['top_college'] == null
          ? null
          : KarmaFeedTopCollegeDto.fromJson(
              json['top_college'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$KarmaFeedDtoToJson(_KarmaFeedDto instance) =>
    <String, dynamic>{
      'top_user': instance.topUser,
      'top_college': instance.topCollege,
    };
