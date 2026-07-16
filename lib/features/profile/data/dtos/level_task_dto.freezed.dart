// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_task_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LevelTaskDto {

 String get taskName; bool get active; bool get completed; num get karma; String? get discordLink; String? get hashtag; String? get taskDescription; TaskInterestGroupDto? get interestGroup; TaskSubmissionChannelDto? get submissionChannel;
/// Create a copy of LevelTaskDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LevelTaskDtoCopyWith<LevelTaskDto> get copyWith => _$LevelTaskDtoCopyWithImpl<LevelTaskDto>(this as LevelTaskDto, _$identity);

  /// Serializes this LevelTaskDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelTaskDto&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.active, active) || other.active == active)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.discordLink, discordLink) || other.discordLink == discordLink)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.taskDescription, taskDescription) || other.taskDescription == taskDescription)&&(identical(other.interestGroup, interestGroup) || other.interestGroup == interestGroup)&&(identical(other.submissionChannel, submissionChannel) || other.submissionChannel == submissionChannel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskName,active,completed,karma,discordLink,hashtag,taskDescription,interestGroup,submissionChannel);

@override
String toString() {
  return 'LevelTaskDto(taskName: $taskName, active: $active, completed: $completed, karma: $karma, discordLink: $discordLink, hashtag: $hashtag, taskDescription: $taskDescription, interestGroup: $interestGroup, submissionChannel: $submissionChannel)';
}


}

/// @nodoc
abstract mixin class $LevelTaskDtoCopyWith<$Res>  {
  factory $LevelTaskDtoCopyWith(LevelTaskDto value, $Res Function(LevelTaskDto) _then) = _$LevelTaskDtoCopyWithImpl;
@useResult
$Res call({
 String taskName, bool active, bool completed, num karma, String? discordLink, String? hashtag, String? taskDescription, TaskInterestGroupDto? interestGroup, TaskSubmissionChannelDto? submissionChannel
});


$TaskInterestGroupDtoCopyWith<$Res>? get interestGroup;$TaskSubmissionChannelDtoCopyWith<$Res>? get submissionChannel;

}
/// @nodoc
class _$LevelTaskDtoCopyWithImpl<$Res>
    implements $LevelTaskDtoCopyWith<$Res> {
  _$LevelTaskDtoCopyWithImpl(this._self, this._then);

  final LevelTaskDto _self;
  final $Res Function(LevelTaskDto) _then;

/// Create a copy of LevelTaskDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskName = null,Object? active = null,Object? completed = null,Object? karma = null,Object? discordLink = freezed,Object? hashtag = freezed,Object? taskDescription = freezed,Object? interestGroup = freezed,Object? submissionChannel = freezed,}) {
  return _then(_self.copyWith(
taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,discordLink: freezed == discordLink ? _self.discordLink : discordLink // ignore: cast_nullable_to_non_nullable
as String?,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,taskDescription: freezed == taskDescription ? _self.taskDescription : taskDescription // ignore: cast_nullable_to_non_nullable
as String?,interestGroup: freezed == interestGroup ? _self.interestGroup : interestGroup // ignore: cast_nullable_to_non_nullable
as TaskInterestGroupDto?,submissionChannel: freezed == submissionChannel ? _self.submissionChannel : submissionChannel // ignore: cast_nullable_to_non_nullable
as TaskSubmissionChannelDto?,
  ));
}
/// Create a copy of LevelTaskDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskInterestGroupDtoCopyWith<$Res>? get interestGroup {
    if (_self.interestGroup == null) {
    return null;
  }

  return $TaskInterestGroupDtoCopyWith<$Res>(_self.interestGroup!, (value) {
    return _then(_self.copyWith(interestGroup: value));
  });
}/// Create a copy of LevelTaskDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskSubmissionChannelDtoCopyWith<$Res>? get submissionChannel {
    if (_self.submissionChannel == null) {
    return null;
  }

  return $TaskSubmissionChannelDtoCopyWith<$Res>(_self.submissionChannel!, (value) {
    return _then(_self.copyWith(submissionChannel: value));
  });
}
}


/// Adds pattern-matching-related methods to [LevelTaskDto].
extension LevelTaskDtoPatterns on LevelTaskDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LevelTaskDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LevelTaskDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LevelTaskDto value)  $default,){
final _that = this;
switch (_that) {
case _LevelTaskDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LevelTaskDto value)?  $default,){
final _that = this;
switch (_that) {
case _LevelTaskDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String taskName,  bool active,  bool completed,  num karma,  String? discordLink,  String? hashtag,  String? taskDescription,  TaskInterestGroupDto? interestGroup,  TaskSubmissionChannelDto? submissionChannel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LevelTaskDto() when $default != null:
return $default(_that.taskName,_that.active,_that.completed,_that.karma,_that.discordLink,_that.hashtag,_that.taskDescription,_that.interestGroup,_that.submissionChannel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String taskName,  bool active,  bool completed,  num karma,  String? discordLink,  String? hashtag,  String? taskDescription,  TaskInterestGroupDto? interestGroup,  TaskSubmissionChannelDto? submissionChannel)  $default,) {final _that = this;
switch (_that) {
case _LevelTaskDto():
return $default(_that.taskName,_that.active,_that.completed,_that.karma,_that.discordLink,_that.hashtag,_that.taskDescription,_that.interestGroup,_that.submissionChannel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String taskName,  bool active,  bool completed,  num karma,  String? discordLink,  String? hashtag,  String? taskDescription,  TaskInterestGroupDto? interestGroup,  TaskSubmissionChannelDto? submissionChannel)?  $default,) {final _that = this;
switch (_that) {
case _LevelTaskDto() when $default != null:
return $default(_that.taskName,_that.active,_that.completed,_that.karma,_that.discordLink,_that.hashtag,_that.taskDescription,_that.interestGroup,_that.submissionChannel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LevelTaskDto extends LevelTaskDto {
  const _LevelTaskDto({required this.taskName, required this.active, required this.completed, required this.karma, this.discordLink, this.hashtag, this.taskDescription, this.interestGroup, this.submissionChannel}): super._();
  factory _LevelTaskDto.fromJson(Map<String, dynamic> json) => _$LevelTaskDtoFromJson(json);

@override final  String taskName;
@override final  bool active;
@override final  bool completed;
@override final  num karma;
@override final  String? discordLink;
@override final  String? hashtag;
@override final  String? taskDescription;
@override final  TaskInterestGroupDto? interestGroup;
@override final  TaskSubmissionChannelDto? submissionChannel;

/// Create a copy of LevelTaskDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LevelTaskDtoCopyWith<_LevelTaskDto> get copyWith => __$LevelTaskDtoCopyWithImpl<_LevelTaskDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LevelTaskDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LevelTaskDto&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.active, active) || other.active == active)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.discordLink, discordLink) || other.discordLink == discordLink)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.taskDescription, taskDescription) || other.taskDescription == taskDescription)&&(identical(other.interestGroup, interestGroup) || other.interestGroup == interestGroup)&&(identical(other.submissionChannel, submissionChannel) || other.submissionChannel == submissionChannel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskName,active,completed,karma,discordLink,hashtag,taskDescription,interestGroup,submissionChannel);

@override
String toString() {
  return 'LevelTaskDto(taskName: $taskName, active: $active, completed: $completed, karma: $karma, discordLink: $discordLink, hashtag: $hashtag, taskDescription: $taskDescription, interestGroup: $interestGroup, submissionChannel: $submissionChannel)';
}


}

/// @nodoc
abstract mixin class _$LevelTaskDtoCopyWith<$Res> implements $LevelTaskDtoCopyWith<$Res> {
  factory _$LevelTaskDtoCopyWith(_LevelTaskDto value, $Res Function(_LevelTaskDto) _then) = __$LevelTaskDtoCopyWithImpl;
@override @useResult
$Res call({
 String taskName, bool active, bool completed, num karma, String? discordLink, String? hashtag, String? taskDescription, TaskInterestGroupDto? interestGroup, TaskSubmissionChannelDto? submissionChannel
});


@override $TaskInterestGroupDtoCopyWith<$Res>? get interestGroup;@override $TaskSubmissionChannelDtoCopyWith<$Res>? get submissionChannel;

}
/// @nodoc
class __$LevelTaskDtoCopyWithImpl<$Res>
    implements _$LevelTaskDtoCopyWith<$Res> {
  __$LevelTaskDtoCopyWithImpl(this._self, this._then);

  final _LevelTaskDto _self;
  final $Res Function(_LevelTaskDto) _then;

/// Create a copy of LevelTaskDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskName = null,Object? active = null,Object? completed = null,Object? karma = null,Object? discordLink = freezed,Object? hashtag = freezed,Object? taskDescription = freezed,Object? interestGroup = freezed,Object? submissionChannel = freezed,}) {
  return _then(_LevelTaskDto(
taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,discordLink: freezed == discordLink ? _self.discordLink : discordLink // ignore: cast_nullable_to_non_nullable
as String?,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,taskDescription: freezed == taskDescription ? _self.taskDescription : taskDescription // ignore: cast_nullable_to_non_nullable
as String?,interestGroup: freezed == interestGroup ? _self.interestGroup : interestGroup // ignore: cast_nullable_to_non_nullable
as TaskInterestGroupDto?,submissionChannel: freezed == submissionChannel ? _self.submissionChannel : submissionChannel // ignore: cast_nullable_to_non_nullable
as TaskSubmissionChannelDto?,
  ));
}

/// Create a copy of LevelTaskDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskInterestGroupDtoCopyWith<$Res>? get interestGroup {
    if (_self.interestGroup == null) {
    return null;
  }

  return $TaskInterestGroupDtoCopyWith<$Res>(_self.interestGroup!, (value) {
    return _then(_self.copyWith(interestGroup: value));
  });
}/// Create a copy of LevelTaskDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskSubmissionChannelDtoCopyWith<$Res>? get submissionChannel {
    if (_self.submissionChannel == null) {
    return null;
  }

  return $TaskSubmissionChannelDtoCopyWith<$Res>(_self.submissionChannel!, (value) {
    return _then(_self.copyWith(submissionChannel: value));
  });
}
}

// dart format on
