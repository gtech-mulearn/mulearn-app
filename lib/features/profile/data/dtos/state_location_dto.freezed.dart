// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_location_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StateLocationDto {

 String get id; String get name; CountryLocationDto get country;
/// Create a copy of StateLocationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StateLocationDtoCopyWith<StateLocationDto> get copyWith => _$StateLocationDtoCopyWithImpl<StateLocationDto>(this as StateLocationDto, _$identity);

  /// Serializes this StateLocationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StateLocationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,country);

@override
String toString() {
  return 'StateLocationDto(id: $id, name: $name, country: $country)';
}


}

/// @nodoc
abstract mixin class $StateLocationDtoCopyWith<$Res>  {
  factory $StateLocationDtoCopyWith(StateLocationDto value, $Res Function(StateLocationDto) _then) = _$StateLocationDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, CountryLocationDto country
});


$CountryLocationDtoCopyWith<$Res> get country;

}
/// @nodoc
class _$StateLocationDtoCopyWithImpl<$Res>
    implements $StateLocationDtoCopyWith<$Res> {
  _$StateLocationDtoCopyWithImpl(this._self, this._then);

  final StateLocationDto _self;
  final $Res Function(StateLocationDto) _then;

/// Create a copy of StateLocationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? country = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as CountryLocationDto,
  ));
}
/// Create a copy of StateLocationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountryLocationDtoCopyWith<$Res> get country {
  
  return $CountryLocationDtoCopyWith<$Res>(_self.country, (value) {
    return _then(_self.copyWith(country: value));
  });
}
}


/// Adds pattern-matching-related methods to [StateLocationDto].
extension StateLocationDtoPatterns on StateLocationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StateLocationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StateLocationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StateLocationDto value)  $default,){
final _that = this;
switch (_that) {
case _StateLocationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StateLocationDto value)?  $default,){
final _that = this;
switch (_that) {
case _StateLocationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  CountryLocationDto country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StateLocationDto() when $default != null:
return $default(_that.id,_that.name,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  CountryLocationDto country)  $default,) {final _that = this;
switch (_that) {
case _StateLocationDto():
return $default(_that.id,_that.name,_that.country);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  CountryLocationDto country)?  $default,) {final _that = this;
switch (_that) {
case _StateLocationDto() when $default != null:
return $default(_that.id,_that.name,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StateLocationDto extends StateLocationDto {
  const _StateLocationDto({required this.id, required this.name, required this.country}): super._();
  factory _StateLocationDto.fromJson(Map<String, dynamic> json) => _$StateLocationDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  CountryLocationDto country;

/// Create a copy of StateLocationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateLocationDtoCopyWith<_StateLocationDto> get copyWith => __$StateLocationDtoCopyWithImpl<_StateLocationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StateLocationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateLocationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,country);

@override
String toString() {
  return 'StateLocationDto(id: $id, name: $name, country: $country)';
}


}

/// @nodoc
abstract mixin class _$StateLocationDtoCopyWith<$Res> implements $StateLocationDtoCopyWith<$Res> {
  factory _$StateLocationDtoCopyWith(_StateLocationDto value, $Res Function(_StateLocationDto) _then) = __$StateLocationDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, CountryLocationDto country
});


@override $CountryLocationDtoCopyWith<$Res> get country;

}
/// @nodoc
class __$StateLocationDtoCopyWithImpl<$Res>
    implements _$StateLocationDtoCopyWith<$Res> {
  __$StateLocationDtoCopyWithImpl(this._self, this._then);

  final _StateLocationDto _self;
  final $Res Function(_StateLocationDto) _then;

/// Create a copy of StateLocationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? country = null,}) {
  return _then(_StateLocationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as CountryLocationDto,
  ));
}

/// Create a copy of StateLocationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountryLocationDtoCopyWith<$Res> get country {
  
  return $CountryLocationDtoCopyWith<$Res>(_self.country, (value) {
    return _then(_self.copyWith(country: value));
  });
}
}

// dart format on
