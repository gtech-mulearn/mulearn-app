// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'org_ref_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrgRefDto {

 String get id; String get name;
/// Create a copy of OrgRefDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgRefDtoCopyWith<OrgRefDto> get copyWith => _$OrgRefDtoCopyWithImpl<OrgRefDto>(this as OrgRefDto, _$identity);

  /// Serializes this OrgRefDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgRefDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'OrgRefDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $OrgRefDtoCopyWith<$Res>  {
  factory $OrgRefDtoCopyWith(OrgRefDto value, $Res Function(OrgRefDto) _then) = _$OrgRefDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$OrgRefDtoCopyWithImpl<$Res>
    implements $OrgRefDtoCopyWith<$Res> {
  _$OrgRefDtoCopyWithImpl(this._self, this._then);

  final OrgRefDto _self;
  final $Res Function(OrgRefDto) _then;

/// Create a copy of OrgRefDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgRefDto].
extension OrgRefDtoPatterns on OrgRefDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgRefDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgRefDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgRefDto value)  $default,){
final _that = this;
switch (_that) {
case _OrgRefDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgRefDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrgRefDto() when $default != null:
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
case _OrgRefDto() when $default != null:
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
case _OrgRefDto():
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
case _OrgRefDto() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrgRefDto extends OrgRefDto {
  const _OrgRefDto({required this.id, required this.name}): super._();
  factory _OrgRefDto.fromJson(Map<String, dynamic> json) => _$OrgRefDtoFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of OrgRefDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgRefDtoCopyWith<_OrgRefDto> get copyWith => __$OrgRefDtoCopyWithImpl<_OrgRefDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrgRefDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgRefDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'OrgRefDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$OrgRefDtoCopyWith<$Res> implements $OrgRefDtoCopyWith<$Res> {
  factory _$OrgRefDtoCopyWith(_OrgRefDto value, $Res Function(_OrgRefDto) _then) = __$OrgRefDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$OrgRefDtoCopyWithImpl<$Res>
    implements _$OrgRefDtoCopyWith<$Res> {
  __$OrgRefDtoCopyWithImpl(this._self, this._then);

  final _OrgRefDto _self;
  final $Res Function(_OrgRefDto) _then;

/// Create a copy of OrgRefDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_OrgRefDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
