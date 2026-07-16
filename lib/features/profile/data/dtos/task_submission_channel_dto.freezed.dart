// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_submission_channel_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskSubmissionChannelDto {

 String? get id; String? get name; String? get discordId;
/// Create a copy of TaskSubmissionChannelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskSubmissionChannelDtoCopyWith<TaskSubmissionChannelDto> get copyWith => _$TaskSubmissionChannelDtoCopyWithImpl<TaskSubmissionChannelDto>(this as TaskSubmissionChannelDto, _$identity);

  /// Serializes this TaskSubmissionChannelDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskSubmissionChannelDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.discordId, discordId) || other.discordId == discordId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,discordId);

@override
String toString() {
  return 'TaskSubmissionChannelDto(id: $id, name: $name, discordId: $discordId)';
}


}

/// @nodoc
abstract mixin class $TaskSubmissionChannelDtoCopyWith<$Res>  {
  factory $TaskSubmissionChannelDtoCopyWith(TaskSubmissionChannelDto value, $Res Function(TaskSubmissionChannelDto) _then) = _$TaskSubmissionChannelDtoCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? discordId
});




}
/// @nodoc
class _$TaskSubmissionChannelDtoCopyWithImpl<$Res>
    implements $TaskSubmissionChannelDtoCopyWith<$Res> {
  _$TaskSubmissionChannelDtoCopyWithImpl(this._self, this._then);

  final TaskSubmissionChannelDto _self;
  final $Res Function(TaskSubmissionChannelDto) _then;

/// Create a copy of TaskSubmissionChannelDto
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


/// Adds pattern-matching-related methods to [TaskSubmissionChannelDto].
extension TaskSubmissionChannelDtoPatterns on TaskSubmissionChannelDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskSubmissionChannelDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskSubmissionChannelDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskSubmissionChannelDto value)  $default,){
final _that = this;
switch (_that) {
case _TaskSubmissionChannelDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskSubmissionChannelDto value)?  $default,){
final _that = this;
switch (_that) {
case _TaskSubmissionChannelDto() when $default != null:
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
case _TaskSubmissionChannelDto() when $default != null:
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
case _TaskSubmissionChannelDto():
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
case _TaskSubmissionChannelDto() when $default != null:
return $default(_that.id,_that.name,_that.discordId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskSubmissionChannelDto extends TaskSubmissionChannelDto {
  const _TaskSubmissionChannelDto({this.id, this.name, this.discordId}): super._();
  factory _TaskSubmissionChannelDto.fromJson(Map<String, dynamic> json) => _$TaskSubmissionChannelDtoFromJson(json);

@override final  String? id;
@override final  String? name;
@override final  String? discordId;

/// Create a copy of TaskSubmissionChannelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskSubmissionChannelDtoCopyWith<_TaskSubmissionChannelDto> get copyWith => __$TaskSubmissionChannelDtoCopyWithImpl<_TaskSubmissionChannelDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskSubmissionChannelDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskSubmissionChannelDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.discordId, discordId) || other.discordId == discordId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,discordId);

@override
String toString() {
  return 'TaskSubmissionChannelDto(id: $id, name: $name, discordId: $discordId)';
}


}

/// @nodoc
abstract mixin class _$TaskSubmissionChannelDtoCopyWith<$Res> implements $TaskSubmissionChannelDtoCopyWith<$Res> {
  factory _$TaskSubmissionChannelDtoCopyWith(_TaskSubmissionChannelDto value, $Res Function(_TaskSubmissionChannelDto) _then) = __$TaskSubmissionChannelDtoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? discordId
});




}
/// @nodoc
class __$TaskSubmissionChannelDtoCopyWithImpl<$Res>
    implements _$TaskSubmissionChannelDtoCopyWith<$Res> {
  __$TaskSubmissionChannelDtoCopyWithImpl(this._self, this._then);

  final _TaskSubmissionChannelDto _self;
  final $Res Function(_TaskSubmissionChannelDto) _then;

/// Create a copy of TaskSubmissionChannelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? discordId = freezed,}) {
  return _then(_TaskSubmissionChannelDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,discordId: freezed == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
