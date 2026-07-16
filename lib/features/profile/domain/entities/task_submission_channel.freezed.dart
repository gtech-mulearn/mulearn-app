// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_submission_channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskSubmissionChannel {

 String? get id; String? get name; String? get discordId;
/// Create a copy of TaskSubmissionChannel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskSubmissionChannelCopyWith<TaskSubmissionChannel> get copyWith => _$TaskSubmissionChannelCopyWithImpl<TaskSubmissionChannel>(this as TaskSubmissionChannel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskSubmissionChannel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.discordId, discordId) || other.discordId == discordId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,discordId);

@override
String toString() {
  return 'TaskSubmissionChannel(id: $id, name: $name, discordId: $discordId)';
}


}

/// @nodoc
abstract mixin class $TaskSubmissionChannelCopyWith<$Res>  {
  factory $TaskSubmissionChannelCopyWith(TaskSubmissionChannel value, $Res Function(TaskSubmissionChannel) _then) = _$TaskSubmissionChannelCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? discordId
});




}
/// @nodoc
class _$TaskSubmissionChannelCopyWithImpl<$Res>
    implements $TaskSubmissionChannelCopyWith<$Res> {
  _$TaskSubmissionChannelCopyWithImpl(this._self, this._then);

  final TaskSubmissionChannel _self;
  final $Res Function(TaskSubmissionChannel) _then;

/// Create a copy of TaskSubmissionChannel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? discordId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,discordId: freezed == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskSubmissionChannel].
extension TaskSubmissionChannelPatterns on TaskSubmissionChannel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskSubmissionChannel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskSubmissionChannel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskSubmissionChannel value)  $default,){
final _that = this;
switch (_that) {
case _TaskSubmissionChannel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskSubmissionChannel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskSubmissionChannel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name,  String? discordId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskSubmissionChannel() when $default != null:
return $default(_that.id,_that.name,_that.discordId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name,  String? discordId)  $default,) {final _that = this;
switch (_that) {
case _TaskSubmissionChannel():
return $default(_that.id,_that.name,_that.discordId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name,  String? discordId)?  $default,) {final _that = this;
switch (_that) {
case _TaskSubmissionChannel() when $default != null:
return $default(_that.id,_that.name,_that.discordId);case _:
  return null;

}
}

}

/// @nodoc


class _TaskSubmissionChannel implements TaskSubmissionChannel {
  const _TaskSubmissionChannel({this.id, this.name, this.discordId});
  

@override final  String? id;
@override final  String? name;
@override final  String? discordId;

/// Create a copy of TaskSubmissionChannel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskSubmissionChannelCopyWith<_TaskSubmissionChannel> get copyWith => __$TaskSubmissionChannelCopyWithImpl<_TaskSubmissionChannel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskSubmissionChannel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.discordId, discordId) || other.discordId == discordId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,discordId);

@override
String toString() {
  return 'TaskSubmissionChannel(id: $id, name: $name, discordId: $discordId)';
}


}

/// @nodoc
abstract mixin class _$TaskSubmissionChannelCopyWith<$Res> implements $TaskSubmissionChannelCopyWith<$Res> {
  factory _$TaskSubmissionChannelCopyWith(_TaskSubmissionChannel value, $Res Function(_TaskSubmissionChannel) _then) = __$TaskSubmissionChannelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? discordId
});




}
/// @nodoc
class __$TaskSubmissionChannelCopyWithImpl<$Res>
    implements _$TaskSubmissionChannelCopyWith<$Res> {
  __$TaskSubmissionChannelCopyWithImpl(this._self, this._then);

  final _TaskSubmissionChannel _self;
  final $Res Function(_TaskSubmissionChannel) _then;

/// Create a copy of TaskSubmissionChannel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? discordId = freezed,}) {
  return _then(_TaskSubmissionChannel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,discordId: freezed == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
