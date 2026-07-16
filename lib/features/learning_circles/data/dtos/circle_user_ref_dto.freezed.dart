// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle_user_ref_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CircleUserRefDto {

 String? get fullName; String? get id; String? get muid; String? get profilePic;
/// Create a copy of CircleUserRefDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleUserRefDtoCopyWith<CircleUserRefDto> get copyWith => _$CircleUserRefDtoCopyWithImpl<CircleUserRefDto>(this as CircleUserRefDto, _$identity);

  /// Serializes this CircleUserRefDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleUserRefDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,id,muid,profilePic);

@override
String toString() {
  return 'CircleUserRefDto(fullName: $fullName, id: $id, muid: $muid, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class $CircleUserRefDtoCopyWith<$Res>  {
  factory $CircleUserRefDtoCopyWith(CircleUserRefDto value, $Res Function(CircleUserRefDto) _then) = _$CircleUserRefDtoCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? id, String? muid, String? profilePic
});




}
/// @nodoc
class _$CircleUserRefDtoCopyWithImpl<$Res>
    implements $CircleUserRefDtoCopyWith<$Res> {
  _$CircleUserRefDtoCopyWithImpl(this._self, this._then);

  final CircleUserRefDto _self;
  final $Res Function(CircleUserRefDto) _then;

/// Create a copy of CircleUserRefDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? id = freezed,Object? muid = freezed,Object? profilePic = freezed,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,muid: freezed == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CircleUserRefDto].
extension CircleUserRefDtoPatterns on CircleUserRefDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleUserRefDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleUserRefDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleUserRefDto value)  $default,){
final _that = this;
switch (_that) {
case _CircleUserRefDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleUserRefDto value)?  $default,){
final _that = this;
switch (_that) {
case _CircleUserRefDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? id,  String? muid,  String? profilePic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleUserRefDto() when $default != null:
return $default(_that.fullName,_that.id,_that.muid,_that.profilePic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? id,  String? muid,  String? profilePic)  $default,) {final _that = this;
switch (_that) {
case _CircleUserRefDto():
return $default(_that.fullName,_that.id,_that.muid,_that.profilePic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? id,  String? muid,  String? profilePic)?  $default,) {final _that = this;
switch (_that) {
case _CircleUserRefDto() when $default != null:
return $default(_that.fullName,_that.id,_that.muid,_that.profilePic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CircleUserRefDto extends CircleUserRefDto {
  const _CircleUserRefDto({this.fullName, this.id, this.muid, this.profilePic}): super._();
  factory _CircleUserRefDto.fromJson(Map<String, dynamic> json) => _$CircleUserRefDtoFromJson(json);

@override final  String? fullName;
@override final  String? id;
@override final  String? muid;
@override final  String? profilePic;

/// Create a copy of CircleUserRefDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleUserRefDtoCopyWith<_CircleUserRefDto> get copyWith => __$CircleUserRefDtoCopyWithImpl<_CircleUserRefDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CircleUserRefDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleUserRefDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,id,muid,profilePic);

@override
String toString() {
  return 'CircleUserRefDto(fullName: $fullName, id: $id, muid: $muid, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class _$CircleUserRefDtoCopyWith<$Res> implements $CircleUserRefDtoCopyWith<$Res> {
  factory _$CircleUserRefDtoCopyWith(_CircleUserRefDto value, $Res Function(_CircleUserRefDto) _then) = __$CircleUserRefDtoCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? id, String? muid, String? profilePic
});




}
/// @nodoc
class __$CircleUserRefDtoCopyWithImpl<$Res>
    implements _$CircleUserRefDtoCopyWith<$Res> {
  __$CircleUserRefDtoCopyWithImpl(this._self, this._then);

  final _CircleUserRefDto _self;
  final $Res Function(_CircleUserRefDto) _then;

/// Create a copy of CircleUserRefDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? id = freezed,Object? muid = freezed,Object? profilePic = freezed,}) {
  return _then(_CircleUserRefDto(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,muid: freezed == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
