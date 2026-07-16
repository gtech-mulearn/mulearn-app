// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_interest_group_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskInterestGroupDto {

 String? get id; String? get name;
/// Create a copy of TaskInterestGroupDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskInterestGroupDtoCopyWith<TaskInterestGroupDto> get copyWith => _$TaskInterestGroupDtoCopyWithImpl<TaskInterestGroupDto>(this as TaskInterestGroupDto, _$identity);

  /// Serializes this TaskInterestGroupDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskInterestGroupDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TaskInterestGroupDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $TaskInterestGroupDtoCopyWith<$Res>  {
  factory $TaskInterestGroupDtoCopyWith(TaskInterestGroupDto value, $Res Function(TaskInterestGroupDto) _then) = _$TaskInterestGroupDtoCopyWithImpl;
@useResult
$Res call({
 String? id, String? name
});




}
/// @nodoc
class _$TaskInterestGroupDtoCopyWithImpl<$Res>
    implements $TaskInterestGroupDtoCopyWith<$Res> {
  _$TaskInterestGroupDtoCopyWithImpl(this._self, this._then);

  final TaskInterestGroupDto _self;
  final $Res Function(TaskInterestGroupDto) _then;

/// Create a copy of TaskInterestGroupDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskInterestGroupDto].
extension TaskInterestGroupDtoPatterns on TaskInterestGroupDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskInterestGroupDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskInterestGroupDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskInterestGroupDto value)  $default,){
final _that = this;
switch (_that) {
case _TaskInterestGroupDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskInterestGroupDto value)?  $default,){
final _that = this;
switch (_that) {
case _TaskInterestGroupDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskInterestGroupDto() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name)  $default,) {final _that = this;
switch (_that) {
case _TaskInterestGroupDto():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _TaskInterestGroupDto() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskInterestGroupDto extends TaskInterestGroupDto {
  const _TaskInterestGroupDto({this.id, this.name}): super._();
  factory _TaskInterestGroupDto.fromJson(Map<String, dynamic> json) => _$TaskInterestGroupDtoFromJson(json);

@override final  String? id;
@override final  String? name;

/// Create a copy of TaskInterestGroupDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskInterestGroupDtoCopyWith<_TaskInterestGroupDto> get copyWith => __$TaskInterestGroupDtoCopyWithImpl<_TaskInterestGroupDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskInterestGroupDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskInterestGroupDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TaskInterestGroupDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TaskInterestGroupDtoCopyWith<$Res> implements $TaskInterestGroupDtoCopyWith<$Res> {
  factory _$TaskInterestGroupDtoCopyWith(_TaskInterestGroupDto value, $Res Function(_TaskInterestGroupDto) _then) = __$TaskInterestGroupDtoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name
});




}
/// @nodoc
class __$TaskInterestGroupDtoCopyWithImpl<$Res>
    implements _$TaskInterestGroupDtoCopyWith<$Res> {
  __$TaskInterestGroupDtoCopyWithImpl(this._self, this._then);

  final _TaskInterestGroupDto _self;
  final $Res Function(_TaskInterestGroupDto) _then;

/// Create a copy of TaskInterestGroupDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_TaskInterestGroupDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
