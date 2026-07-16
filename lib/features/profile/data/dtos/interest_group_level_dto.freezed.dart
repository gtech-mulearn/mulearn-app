// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interest_group_level_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterestGroupLevelDto {

 String get unit; int get count;
/// Create a copy of InterestGroupLevelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterestGroupLevelDtoCopyWith<InterestGroupLevelDto> get copyWith => _$InterestGroupLevelDtoCopyWithImpl<InterestGroupLevelDto>(this as InterestGroupLevelDto, _$identity);

  /// Serializes this InterestGroupLevelDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterestGroupLevelDto&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unit,count);

@override
String toString() {
  return 'InterestGroupLevelDto(unit: $unit, count: $count)';
}


}

/// @nodoc
abstract mixin class $InterestGroupLevelDtoCopyWith<$Res>  {
  factory $InterestGroupLevelDtoCopyWith(InterestGroupLevelDto value, $Res Function(InterestGroupLevelDto) _then) = _$InterestGroupLevelDtoCopyWithImpl;
@useResult
$Res call({
 String unit, int count
});




}
/// @nodoc
class _$InterestGroupLevelDtoCopyWithImpl<$Res>
    implements $InterestGroupLevelDtoCopyWith<$Res> {
  _$InterestGroupLevelDtoCopyWithImpl(this._self, this._then);

  final InterestGroupLevelDto _self;
  final $Res Function(InterestGroupLevelDto) _then;

/// Create a copy of InterestGroupLevelDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unit = null,Object? count = null,}) {
  return _then(_self.copyWith(
unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InterestGroupLevelDto].
extension InterestGroupLevelDtoPatterns on InterestGroupLevelDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterestGroupLevelDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterestGroupLevelDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterestGroupLevelDto value)  $default,){
final _that = this;
switch (_that) {
case _InterestGroupLevelDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterestGroupLevelDto value)?  $default,){
final _that = this;
switch (_that) {
case _InterestGroupLevelDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String unit,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterestGroupLevelDto() when $default != null:
return $default(_that.unit,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String unit,  int count)  $default,) {final _that = this;
switch (_that) {
case _InterestGroupLevelDto():
return $default(_that.unit,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String unit,  int count)?  $default,) {final _that = this;
switch (_that) {
case _InterestGroupLevelDto() when $default != null:
return $default(_that.unit,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterestGroupLevelDto extends InterestGroupLevelDto {
  const _InterestGroupLevelDto({required this.unit, required this.count}): super._();
  factory _InterestGroupLevelDto.fromJson(Map<String, dynamic> json) => _$InterestGroupLevelDtoFromJson(json);

@override final  String unit;
@override final  int count;

/// Create a copy of InterestGroupLevelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterestGroupLevelDtoCopyWith<_InterestGroupLevelDto> get copyWith => __$InterestGroupLevelDtoCopyWithImpl<_InterestGroupLevelDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterestGroupLevelDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterestGroupLevelDto&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unit,count);

@override
String toString() {
  return 'InterestGroupLevelDto(unit: $unit, count: $count)';
}


}

/// @nodoc
abstract mixin class _$InterestGroupLevelDtoCopyWith<$Res> implements $InterestGroupLevelDtoCopyWith<$Res> {
  factory _$InterestGroupLevelDtoCopyWith(_InterestGroupLevelDto value, $Res Function(_InterestGroupLevelDto) _then) = __$InterestGroupLevelDtoCopyWithImpl;
@override @useResult
$Res call({
 String unit, int count
});




}
/// @nodoc
class __$InterestGroupLevelDtoCopyWithImpl<$Res>
    implements _$InterestGroupLevelDtoCopyWith<$Res> {
  __$InterestGroupLevelDtoCopyWithImpl(this._self, this._then);

  final _InterestGroupLevelDto _self;
  final $Res Function(_InterestGroupLevelDto) _then;

/// Create a copy of InterestGroupLevelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unit = null,Object? count = null,}) {
  return _then(_InterestGroupLevelDto(
unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
