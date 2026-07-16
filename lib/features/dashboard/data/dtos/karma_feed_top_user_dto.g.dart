// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_feed_top_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KarmaFeedTopUserDto _$KarmaFeedTopUserDtoFromJson(Map<String, dynamic> json) =>
    _KarmaFeedTopUserDto(
      fullName: json['full_name'] as String,
      muid: json['muid'] as String,
      karma: json['karma'] as num,
    );

Map<String, dynamic> _$KarmaFeedTopUserDtoToJson(
  _KarmaFeedTopUserDto instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'muid': instance.muid,
  'karma': instance.karma,
};
