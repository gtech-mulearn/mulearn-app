// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'district_location_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DistrictLocationDto {

 String get id; String get name; StateLocationDto get state;
/// Create a copy of DistrictLocationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DistrictLocationDtoCopyWith<DistrictLocationDto> get copyWith => _$DistrictLocationDtoCopyWithImpl<DistrictLocationDto>(this as DistrictLocationDto, _$identity);

  /// Serializes this DistrictLocationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DistrictLocationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,state);

@override
String toString() {
  return 'DistrictLocationDto(id: $id, name: $name, state: $state)';
}


}

/// @nodoc
abstract mixin class $DistrictLocationDtoCopyWith<$Res>  {
  factory $DistrictLocationDtoCopyWith(DistrictLocationDto value, $Res Function(DistrictLocationDto) _then) = _$DistrictLocationDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, StateLocationDto state
});


$StateLocationDtoCopyWith<$Res> get state;

}
/// @nodoc
class _$DistrictLocationDtoCopyWithImpl<$Res>
    implements $DistrictLocationDtoCopyWith<$Res> {
  _$DistrictLocationDtoCopyWithImpl(this._self, this._then);

  final DistrictLocationDto _self;
  final $Res Function(DistrictLocationDto) _then;

/// Create a copy of DistrictLocationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? state = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as StateLocationDto,
  ));
}
/// Create a copy of DistrictLocationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateLocationDtoCopyWith<$Res> get state {
  
  return $StateLocationDtoCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}


/// Adds pattern-matching-related methods to [DistrictLocationDto].
extension DistrictLocationDtoPatterns on DistrictLocationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DistrictLocationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DistrictLocationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DistrictLocationDto value)  $default,){
final _that = this;
switch (_that) {
case _DistrictLocationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DistrictLocationDto value)?  $default,){
final _that = this;
switch (_that) {
case _DistrictLocationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  StateLocationDto state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DistrictLocationDto() when $default != null:
return $default(_that.id,_that.name,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  StateLocationDto state)  $default,) {final _that = this;
switch (_that) {
case _DistrictLocationDto():
return $default(_that.id,_that.name,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  StateLocationDto state)?  $default,) {final _that = this;
switch (_that) {
case _DistrictLocationDto() when $default != null:
return $default(_that.id,_that.name,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DistrictLocationDto extends DistrictLocationDto {
  const _DistrictLocationDto({required this.id, required this.name, required this.state}): super._();
  factory _DistrictLocationDto.fromJson(Map<String, dynamic> json) => _$DistrictLocationDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  StateLocationDto state;

/// Create a copy of DistrictLocationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistrictLocationDtoCopyWith<_DistrictLocationDto> get copyWith => __$DistrictLocationDtoCopyWithImpl<_DistrictLocationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DistrictLocationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DistrictLocationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,state);

@override
String toString() {
  return 'DistrictLocationDto(id: $id, name: $name, state: $state)';
}


}

/// @nodoc
abstract mixin class _$DistrictLocationDtoCopyWith<$Res> implements $DistrictLocationDtoCopyWith<$Res> {
  factory _$DistrictLocationDtoCopyWith(_DistrictLocationDto value, $Res Function(_DistrictLocationDto) _then) = __$DistrictLocationDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, StateLocationDto state
});


@override $StateLocationDtoCopyWith<$Res> get state;

}
/// @nodoc
class __$DistrictLocationDtoCopyWithImpl<$Res>
    implements _$DistrictLocationDtoCopyWith<$Res> {
  __$DistrictLocationDtoCopyWithImpl(this._self, this._then);

  final _DistrictLocationDto _self;
  final $Res Function(_DistrictLocationDto) _then;

/// Create a copy of DistrictLocationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? state = null,}) {
  return _then(_DistrictLocationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as StateLocationDto,
  ));
}

/// Create a copy of DistrictLocationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateLocationDtoCopyWith<$Res> get state {
  
  return $StateLocationDtoCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

// dart format on
