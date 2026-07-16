// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_ig_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSearchIgDto {

 String get id; String get name;
/// Create a copy of UserSearchIgDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchIgDtoCopyWith<UserSearchIgDto> get copyWith => _$UserSearchIgDtoCopyWithImpl<UserSearchIgDto>(this as UserSearchIgDto, _$identity);

  /// Serializes this UserSearchIgDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchIgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'UserSearchIgDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $UserSearchIgDtoCopyWith<$Res>  {
  factory $UserSearchIgDtoCopyWith(UserSearchIgDto value, $Res Function(UserSearchIgDto) _then) = _$UserSearchIgDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$UserSearchIgDtoCopyWithImpl<$Res>
    implements $UserSearchIgDtoCopyWith<$Res> {
  _$UserSearchIgDtoCopyWithImpl(this._self, this._then);

  final UserSearchIgDto _self;
  final $Res Function(UserSearchIgDto) _then;

/// Create a copy of UserSearchIgDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchIgDto].
extension UserSearchIgDtoPatterns on UserSearchIgDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchIgDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchIgDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchIgDto value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchIgDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchIgDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchIgDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchIgDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _UserSearchIgDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchIgDto() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSearchIgDto implements UserSearchIgDto {
  const _UserSearchIgDto({required this.id, required this.name});
  factory _UserSearchIgDto.fromJson(Map<String, dynamic> json) => _$UserSearchIgDtoFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of UserSearchIgDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchIgDtoCopyWith<_UserSearchIgDto> get copyWith => __$UserSearchIgDtoCopyWithImpl<_UserSearchIgDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSearchIgDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchIgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'UserSearchIgDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$UserSearchIgDtoCopyWith<$Res> implements $UserSearchIgDtoCopyWith<$Res> {
  factory _$UserSearchIgDtoCopyWith(_UserSearchIgDto value, $Res Function(_UserSearchIgDto) _then) = __$UserSearchIgDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$UserSearchIgDtoCopyWithImpl<$Res>
    implements _$UserSearchIgDtoCopyWith<$Res> {
  __$UserSearchIgDtoCopyWithImpl(this._self, this._then);

  final _UserSearchIgDto _self;
  final $Res Function(_UserSearchIgDto) _then;

/// Create a copy of UserSearchIgDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_UserSearchIgDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
