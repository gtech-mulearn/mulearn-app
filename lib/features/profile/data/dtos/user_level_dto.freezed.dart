// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_level_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserLevelDto {

 String get name; num get karma; List<LevelTaskDto> get tasks;
/// Create a copy of UserLevelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLevelDtoCopyWith<UserLevelDto> get copyWith => _$UserLevelDtoCopyWithImpl<UserLevelDto>(this as UserLevelDto, _$identity);

  /// Serializes this UserLevelDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLevelDto&&(identical(other.name, name) || other.name == name)&&(identical(other.karma, karma) || other.karma == karma)&&const DeepCollectionEquality().equals(other.tasks, tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,karma,const DeepCollectionEquality().hash(tasks));

@override
String toString() {
  return 'UserLevelDto(name: $name, karma: $karma, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $UserLevelDtoCopyWith<$Res>  {
  factory $UserLevelDtoCopyWith(UserLevelDto value, $Res Function(UserLevelDto) _then) = _$UserLevelDtoCopyWithImpl;
@useResult
$Res call({
 String name, num karma, List<LevelTaskDto> tasks
});




}
/// @nodoc
class _$UserLevelDtoCopyWithImpl<$Res>
    implements $UserLevelDtoCopyWith<$Res> {
  _$UserLevelDtoCopyWithImpl(this._self, this._then);

  final UserLevelDto _self;
  final $Res Function(UserLevelDto) _then;

/// Create a copy of UserLevelDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? karma = null,Object? tasks = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<LevelTaskDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserLevelDto].
extension UserLevelDtoPatterns on UserLevelDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserLevelDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserLevelDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserLevelDto value)  $default,){
final _that = this;
switch (_that) {
case _UserLevelDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserLevelDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserLevelDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  num karma,  List<LevelTaskDto> tasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserLevelDto() when $default != null:
return $default(_that.name,_that.karma,_that.tasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  num karma,  List<LevelTaskDto> tasks)  $default,) {final _that = this;
switch (_that) {
case _UserLevelDto():
return $default(_that.name,_that.karma,_that.tasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  num karma,  List<LevelTaskDto> tasks)?  $default,) {final _that = this;
switch (_that) {
case _UserLevelDto() when $default != null:
return $default(_that.name,_that.karma,_that.tasks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserLevelDto extends UserLevelDto {
  const _UserLevelDto({required this.name, required this.karma, final  List<LevelTaskDto> tasks = const []}): _tasks = tasks,super._();
  factory _UserLevelDto.fromJson(Map<String, dynamic> json) => _$UserLevelDtoFromJson(json);

@override final  String name;
@override final  num karma;
 final  List<LevelTaskDto> _tasks;
@override@JsonKey() List<LevelTaskDto> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of UserLevelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserLevelDtoCopyWith<_UserLevelDto> get copyWith => __$UserLevelDtoCopyWithImpl<_UserLevelDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserLevelDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserLevelDto&&(identical(other.name, name) || other.name == name)&&(identical(other.karma, karma) || other.karma == karma)&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,karma,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'UserLevelDto(name: $name, karma: $karma, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class _$UserLevelDtoCopyWith<$Res> implements $UserLevelDtoCopyWith<$Res> {
  factory _$UserLevelDtoCopyWith(_UserLevelDto value, $Res Function(_UserLevelDto) _then) = __$UserLevelDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, num karma, List<LevelTaskDto> tasks
});




}
/// @nodoc
class __$UserLevelDtoCopyWithImpl<$Res>
    implements _$UserLevelDtoCopyWith<$Res> {
  __$UserLevelDtoCopyWithImpl(this._self, this._then);

  final _UserLevelDto _self;
  final $Res Function(_UserLevelDto) _then;

/// Create a copy of UserLevelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? karma = null,Object? tasks = null,}) {
  return _then(_UserLevelDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<LevelTaskDto>,
  ));
}


}

// dart format on
