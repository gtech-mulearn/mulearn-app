// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LevelTask {

 String get taskName; bool get active; bool get completed; num get karma; String? get discordLink; String? get hashtag; String? get taskDescription; TaskInterestGroup? get interestGroup; TaskSubmissionChannel? get submissionChannel;
/// Create a copy of LevelTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LevelTaskCopyWith<LevelTask> get copyWith => _$LevelTaskCopyWithImpl<LevelTask>(this as LevelTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LevelTask&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.active, active) || other.active == active)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.discordLink, discordLink) || other.discordLink == discordLink)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.taskDescription, taskDescription) || other.taskDescription == taskDescription)&&(identical(other.interestGroup, interestGroup) || other.interestGroup == interestGroup)&&(identical(other.submissionChannel, submissionChannel) || other.submissionChannel == submissionChannel));
}


@override
int get hashCode => Object.hash(runtimeType,taskName,active,completed,karma,discordLink,hashtag,taskDescription,interestGroup,submissionChannel);

@override
String toString() {
  return 'LevelTask(taskName: $taskName, active: $active, completed: $completed, karma: $karma, discordLink: $discordLink, hashtag: $hashtag, taskDescription: $taskDescription, interestGroup: $interestGroup, submissionChannel: $submissionChannel)';
}


}

/// @nodoc
abstract mixin class $LevelTaskCopyWith<$Res>  {
  factory $LevelTaskCopyWith(LevelTask value, $Res Function(LevelTask) _then) = _$LevelTaskCopyWithImpl;
@useResult
$Res call({
 String taskName, bool active, bool completed, num karma, String? discordLink, String? hashtag, String? taskDescription, TaskInterestGroup? interestGroup, TaskSubmissionChannel? submissionChannel
});


$TaskInterestGroupCopyWith<$Res>? get interestGroup;$TaskSubmissionChannelCopyWith<$Res>? get submissionChannel;

}
/// @nodoc
class _$LevelTaskCopyWithImpl<$Res>
    implements $LevelTaskCopyWith<$Res> {
  _$LevelTaskCopyWithImpl(this._self, this._then);

  final LevelTask _self;
  final $Res Function(LevelTask) _then;

/// Create a copy of LevelTask
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
as TaskInterestGroup?,submissionChannel: freezed == submissionChannel ? _self.submissionChannel : submissionChannel // ignore: cast_nullable_to_non_nullable
as TaskSubmissionChannel?,
  ));
}
/// Create a copy of LevelTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskInterestGroupCopyWith<$Res>? get interestGroup {
    if (_self.interestGroup == null) {
    return null;
  }

  return $TaskInterestGroupCopyWith<$Res>(_self.interestGroup!, (value) {
    return _then(_self.copyWith(interestGroup: value));
  });
}/// Create a copy of LevelTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskSubmissionChannelCopyWith<$Res>? get submissionChannel {
    if (_self.submissionChannel == null) {
    return null;
  }

  return $TaskSubmissionChannelCopyWith<$Res>(_self.submissionChannel!, (value) {
    return _then(_self.copyWith(submissionChannel: value));
  });
}
}


/// Adds pattern-matching-related methods to [LevelTask].
extension LevelTaskPatterns on LevelTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LevelTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LevelTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LevelTask value)  $default,){
final _that = this;
switch (_that) {
case _LevelTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LevelTask value)?  $default,){
final _that = this;
switch (_that) {
case _LevelTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String taskName,  bool active,  bool completed,  num karma,  String? discordLink,  String? hashtag,  String? taskDescription,  TaskInterestGroup? interestGroup,  TaskSubmissionChannel? submissionChannel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LevelTask() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String taskName,  bool active,  bool completed,  num karma,  String? discordLink,  String? hashtag,  String? taskDescription,  TaskInterestGroup? interestGroup,  TaskSubmissionChannel? submissionChannel)  $default,) {final _that = this;
switch (_that) {
case _LevelTask():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String taskName,  bool active,  bool completed,  num karma,  String? discordLink,  String? hashtag,  String? taskDescription,  TaskInterestGroup? interestGroup,  TaskSubmissionChannel? submissionChannel)?  $default,) {final _that = this;
switch (_that) {
case _LevelTask() when $default != null:
return $default(_that.taskName,_that.active,_that.completed,_that.karma,_that.discordLink,_that.hashtag,_that.taskDescription,_that.interestGroup,_that.submissionChannel);case _:
  return null;

}
}

}

/// @nodoc


class _LevelTask implements LevelTask {
  const _LevelTask({required this.taskName, required this.active, required this.completed, required this.karma, this.discordLink, this.hashtag, this.taskDescription, this.interestGroup, this.submissionChannel});
  

@override final  String taskName;
@override final  bool active;
@override final  bool completed;
@override final  num karma;
@override final  String? discordLink;
@override final  String? hashtag;
@override final  String? taskDescription;
@override final  TaskInterestGroup? interestGroup;
@override final  TaskSubmissionChannel? submissionChannel;

/// Create a copy of LevelTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LevelTaskCopyWith<_LevelTask> get copyWith => __$LevelTaskCopyWithImpl<_LevelTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LevelTask&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.active, active) || other.active == active)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.discordLink, discordLink) || other.discordLink == discordLink)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.taskDescription, taskDescription) || other.taskDescription == taskDescription)&&(identical(other.interestGroup, interestGroup) || other.interestGroup == interestGroup)&&(identical(other.submissionChannel, submissionChannel) || other.submissionChannel == submissionChannel));
}


@override
int get hashCode => Object.hash(runtimeType,taskName,active,completed,karma,discordLink,hashtag,taskDescription,interestGroup,submissionChannel);

@override
String toString() {
  return 'LevelTask(taskName: $taskName, active: $active, completed: $completed, karma: $karma, discordLink: $discordLink, hashtag: $hashtag, taskDescription: $taskDescription, interestGroup: $interestGroup, submissionChannel: $submissionChannel)';
}


}

/// @nodoc
abstract mixin class _$LevelTaskCopyWith<$Res> implements $LevelTaskCopyWith<$Res> {
  factory _$LevelTaskCopyWith(_LevelTask value, $Res Function(_LevelTask) _then) = __$LevelTaskCopyWithImpl;
@override @useResult
$Res call({
 String taskName, bool active, bool completed, num karma, String? discordLink, String? hashtag, String? taskDescription, TaskInterestGroup? interestGroup, TaskSubmissionChannel? submissionChannel
});


@override $TaskInterestGroupCopyWith<$Res>? get interestGroup;@override $TaskSubmissionChannelCopyWith<$Res>? get submissionChannel;

}
/// @nodoc
class __$LevelTaskCopyWithImpl<$Res>
    implements _$LevelTaskCopyWith<$Res> {
  __$LevelTaskCopyWithImpl(this._self, this._then);

  final _LevelTask _self;
  final $Res Function(_LevelTask) _then;

/// Create a copy of LevelTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskName = null,Object? active = null,Object? completed = null,Object? karma = null,Object? discordLink = freezed,Object? hashtag = freezed,Object? taskDescription = freezed,Object? interestGroup = freezed,Object? submissionChannel = freezed,}) {
  return _then(_LevelTask(
taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,discordLink: freezed == discordLink ? _self.discordLink : discordLink // ignore: cast_nullable_to_non_nullable
as String?,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,taskDescription: freezed == taskDescription ? _self.taskDescription : taskDescription // ignore: cast_nullable_to_non_nullable
as String?,interestGroup: freezed == interestGroup ? _self.interestGroup : interestGroup // ignore: cast_nullable_to_non_nullable
as TaskInterestGroup?,submissionChannel: freezed == submissionChannel ? _self.submissionChannel : submissionChannel // ignore: cast_nullable_to_non_nullable
as TaskSubmissionChannel?,
  ));
}

/// Create a copy of LevelTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskInterestGroupCopyWith<$Res>? get interestGroup {
    if (_self.interestGroup == null) {
    return null;
  }

  return $TaskInterestGroupCopyWith<$Res>(_self.interestGroup!, (value) {
    return _then(_self.copyWith(interestGroup: value));
  });
}/// Create a copy of LevelTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskSubmissionChannelCopyWith<$Res>? get submissionChannel {
    if (_self.submissionChannel == null) {
    return null;
  }

  return $TaskSubmissionChannelCopyWith<$Res>(_self.submissionChannel!, (value) {
    return _then(_self.copyWith(submissionChannel: value));
  });
}
}

// dart format on
