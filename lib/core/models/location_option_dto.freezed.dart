// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_option_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationOptionDto {

 String get id; String get name;
/// Create a copy of LocationOptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationOptionDtoCopyWith<LocationOptionDto> get copyWith => _$LocationOptionDtoCopyWithImpl<LocationOptionDto>(this as LocationOptionDto, _$identity);

  /// Serializes this LocationOptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'LocationOptionDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $LocationOptionDtoCopyWith<$Res>  {
  factory $LocationOptionDtoCopyWith(LocationOptionDto value, $Res Function(LocationOptionDto) _then) = _$LocationOptionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$LocationOptionDtoCopyWithImpl<$Res>
    implements $LocationOptionDtoCopyWith<$Res> {
  _$LocationOptionDtoCopyWithImpl(this._self, this._then);

  final LocationOptionDto _self;
  final $Res Function(LocationOptionDto) _then;

/// Create a copy of LocationOptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationOptionDto].
extension LocationOptionDtoPatterns on LocationOptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationOptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationOptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationOptionDto value)  $default,){
final _that = this;
switch (_that) {
case _LocationOptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationOptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _LocationOptionDto() when $default != null:
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
case _LocationOptionDto() when $default != null:
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
case _LocationOptionDto():
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
case _LocationOptionDto() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationOptionDto extends LocationOptionDto {
  const _LocationOptionDto({required this.id, required this.name}): super._();
  factory _LocationOptionDto.fromJson(Map<String, dynamic> json) => _$LocationOptionDtoFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of LocationOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationOptionDtoCopyWith<_LocationOptionDto> get copyWith => __$LocationOptionDtoCopyWithImpl<_LocationOptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationOptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'LocationOptionDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$LocationOptionDtoCopyWith<$Res> implements $LocationOptionDtoCopyWith<$Res> {
  factory _$LocationOptionDtoCopyWith(_LocationOptionDto value, $Res Function(_LocationOptionDto) _then) = __$LocationOptionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$LocationOptionDtoCopyWithImpl<$Res>
    implements _$LocationOptionDtoCopyWith<$Res> {
  __$LocationOptionDtoCopyWithImpl(this._self, this._then);

  final _LocationOptionDto _self;
  final $Res Function(_LocationOptionDto) _then;

/// Create a copy of LocationOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_LocationOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
