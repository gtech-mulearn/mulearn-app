// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'karma_feed_top_college_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KarmaFeedTopCollegeDto {

 String get name; num get karma;
/// Create a copy of KarmaFeedTopCollegeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KarmaFeedTopCollegeDtoCopyWith<KarmaFeedTopCollegeDto> get copyWith => _$KarmaFeedTopCollegeDtoCopyWithImpl<KarmaFeedTopCollegeDto>(this as KarmaFeedTopCollegeDto, _$identity);

  /// Serializes this KarmaFeedTopCollegeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KarmaFeedTopCollegeDto&&(identical(other.name, name) || other.name == name)&&(identical(other.karma, karma) || other.karma == karma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,karma);

@override
String toString() {
  return 'KarmaFeedTopCollegeDto(name: $name, karma: $karma)';
}


}

/// @nodoc
abstract mixin class $KarmaFeedTopCollegeDtoCopyWith<$Res>  {
  factory $KarmaFeedTopCollegeDtoCopyWith(KarmaFeedTopCollegeDto value, $Res Function(KarmaFeedTopCollegeDto) _then) = _$KarmaFeedTopCollegeDtoCopyWithImpl;
@useResult
$Res call({
 String name, num karma
});




}
/// @nodoc
class _$KarmaFeedTopCollegeDtoCopyWithImpl<$Res>
    implements $KarmaFeedTopCollegeDtoCopyWith<$Res> {
  _$KarmaFeedTopCollegeDtoCopyWithImpl(this._self, this._then);

  final KarmaFeedTopCollegeDto _self;
  final $Res Function(KarmaFeedTopCollegeDto) _then;

/// Create a copy of KarmaFeedTopCollegeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? karma = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [KarmaFeedTopCollegeDto].
extension KarmaFeedTopCollegeDtoPatterns on KarmaFeedTopCollegeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KarmaFeedTopCollegeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KarmaFeedTopCollegeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KarmaFeedTopCollegeDto value)  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedTopCollegeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KarmaFeedTopCollegeDto value)?  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedTopCollegeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  num karma)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KarmaFeedTopCollegeDto() when $default != null:
return $default(_that.name,_that.karma);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  num karma)  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedTopCollegeDto():
return $default(_that.name,_that.karma);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  num karma)?  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedTopCollegeDto() when $default != null:
return $default(_that.name,_that.karma);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KarmaFeedTopCollegeDto extends KarmaFeedTopCollegeDto {
  const _KarmaFeedTopCollegeDto({required this.name, required this.karma}): super._();
  factory _KarmaFeedTopCollegeDto.fromJson(Map<String, dynamic> json) => _$KarmaFeedTopCollegeDtoFromJson(json);

@override final  String name;
@override final  num karma;

/// Create a copy of KarmaFeedTopCollegeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KarmaFeedTopCollegeDtoCopyWith<_KarmaFeedTopCollegeDto> get copyWith => __$KarmaFeedTopCollegeDtoCopyWithImpl<_KarmaFeedTopCollegeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KarmaFeedTopCollegeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KarmaFeedTopCollegeDto&&(identical(other.name, name) || other.name == name)&&(identical(other.karma, karma) || other.karma == karma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,karma);

@override
String toString() {
  return 'KarmaFeedTopCollegeDto(name: $name, karma: $karma)';
}


}

/// @nodoc
abstract mixin class _$KarmaFeedTopCollegeDtoCopyWith<$Res> implements $KarmaFeedTopCollegeDtoCopyWith<$Res> {
  factory _$KarmaFeedTopCollegeDtoCopyWith(_KarmaFeedTopCollegeDto value, $Res Function(_KarmaFeedTopCollegeDto) _then) = __$KarmaFeedTopCollegeDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, num karma
});




}
/// @nodoc
class __$KarmaFeedTopCollegeDtoCopyWithImpl<$Res>
    implements _$KarmaFeedTopCollegeDtoCopyWith<$Res> {
  __$KarmaFeedTopCollegeDtoCopyWithImpl(this._self, this._then);

  final _KarmaFeedTopCollegeDto _self;
  final $Res Function(_KarmaFeedTopCollegeDto) _then;

/// Create a copy of KarmaFeedTopCollegeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? karma = null,}) {
  return _then(_KarmaFeedTopCollegeDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
