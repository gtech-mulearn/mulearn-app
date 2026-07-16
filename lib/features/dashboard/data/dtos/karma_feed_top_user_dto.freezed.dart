// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'karma_feed_top_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KarmaFeedTopUserDto {

 String get fullName; String get muid; num get karma;
/// Create a copy of KarmaFeedTopUserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KarmaFeedTopUserDtoCopyWith<KarmaFeedTopUserDto> get copyWith => _$KarmaFeedTopUserDtoCopyWithImpl<KarmaFeedTopUserDto>(this as KarmaFeedTopUserDto, _$identity);

  /// Serializes this KarmaFeedTopUserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KarmaFeedTopUserDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma);

@override
String toString() {
  return 'KarmaFeedTopUserDto(fullName: $fullName, muid: $muid, karma: $karma)';
}


}

/// @nodoc
abstract mixin class $KarmaFeedTopUserDtoCopyWith<$Res>  {
  factory $KarmaFeedTopUserDtoCopyWith(KarmaFeedTopUserDto value, $Res Function(KarmaFeedTopUserDto) _then) = _$KarmaFeedTopUserDtoCopyWithImpl;
@useResult
$Res call({
 String fullName, String muid, num karma
});




}
/// @nodoc
class _$KarmaFeedTopUserDtoCopyWithImpl<$Res>
    implements $KarmaFeedTopUserDtoCopyWith<$Res> {
  _$KarmaFeedTopUserDtoCopyWithImpl(this._self, this._then);

  final KarmaFeedTopUserDto _self;
  final $Res Function(KarmaFeedTopUserDto) _then;

/// Create a copy of KarmaFeedTopUserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [KarmaFeedTopUserDto].
extension KarmaFeedTopUserDtoPatterns on KarmaFeedTopUserDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KarmaFeedTopUserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KarmaFeedTopUserDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KarmaFeedTopUserDto value)  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedTopUserDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KarmaFeedTopUserDto value)?  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedTopUserDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String muid,  num karma)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KarmaFeedTopUserDto() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String muid,  num karma)  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedTopUserDto():
return $default(_that.fullName,_that.muid,_that.karma);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String muid,  num karma)?  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedTopUserDto() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KarmaFeedTopUserDto extends KarmaFeedTopUserDto {
  const _KarmaFeedTopUserDto({required this.fullName, required this.muid, required this.karma}): super._();
  factory _KarmaFeedTopUserDto.fromJson(Map<String, dynamic> json) => _$KarmaFeedTopUserDtoFromJson(json);

@override final  String fullName;
@override final  String muid;
@override final  num karma;

/// Create a copy of KarmaFeedTopUserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KarmaFeedTopUserDtoCopyWith<_KarmaFeedTopUserDto> get copyWith => __$KarmaFeedTopUserDtoCopyWithImpl<_KarmaFeedTopUserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KarmaFeedTopUserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KarmaFeedTopUserDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma);

@override
String toString() {
  return 'KarmaFeedTopUserDto(fullName: $fullName, muid: $muid, karma: $karma)';
}


}

/// @nodoc
abstract mixin class _$KarmaFeedTopUserDtoCopyWith<$Res> implements $KarmaFeedTopUserDtoCopyWith<$Res> {
  factory _$KarmaFeedTopUserDtoCopyWith(_KarmaFeedTopUserDto value, $Res Function(_KarmaFeedTopUserDto) _then) = __$KarmaFeedTopUserDtoCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String muid, num karma
});




}
/// @nodoc
class __$KarmaFeedTopUserDtoCopyWithImpl<$Res>
    implements _$KarmaFeedTopUserDtoCopyWith<$Res> {
  __$KarmaFeedTopUserDtoCopyWithImpl(this._self, this._then);

  final _KarmaFeedTopUserDto _self;
  final $Res Function(_KarmaFeedTopUserDto) _then;

/// Create a copy of KarmaFeedTopUserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,}) {
  return _then(_KarmaFeedTopUserDto(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
