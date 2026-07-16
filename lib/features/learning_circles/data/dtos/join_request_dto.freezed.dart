// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JoinRequestDto {

 String get linkId; String get userId; String get fullName; String get muid; String? get profilePic; String? get requestedAt;
/// Create a copy of JoinRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinRequestDtoCopyWith<JoinRequestDto> get copyWith => _$JoinRequestDtoCopyWithImpl<JoinRequestDto>(this as JoinRequestDto, _$identity);

  /// Serializes this JoinRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinRequestDto&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,linkId,userId,fullName,muid,profilePic,requestedAt);

@override
String toString() {
  return 'JoinRequestDto(linkId: $linkId, userId: $userId, fullName: $fullName, muid: $muid, profilePic: $profilePic, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class $JoinRequestDtoCopyWith<$Res>  {
  factory $JoinRequestDtoCopyWith(JoinRequestDto value, $Res Function(JoinRequestDto) _then) = _$JoinRequestDtoCopyWithImpl;
@useResult
$Res call({
 String linkId, String userId, String fullName, String muid, String? profilePic, String? requestedAt
});




}
/// @nodoc
class _$JoinRequestDtoCopyWithImpl<$Res>
    implements $JoinRequestDtoCopyWith<$Res> {
  _$JoinRequestDtoCopyWithImpl(this._self, this._then);

  final JoinRequestDto _self;
  final $Res Function(JoinRequestDto) _then;

/// Create a copy of JoinRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? linkId = null,Object? userId = null,Object? fullName = null,Object? muid = null,Object? profilePic = freezed,Object? requestedAt = freezed,}) {
  return _then(_self.copyWith(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JoinRequestDto].
extension JoinRequestDtoPatterns on JoinRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _JoinRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _JoinRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String linkId,  String userId,  String fullName,  String muid,  String? profilePic,  String? requestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinRequestDto() when $default != null:
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.profilePic,_that.requestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String linkId,  String userId,  String fullName,  String muid,  String? profilePic,  String? requestedAt)  $default,) {final _that = this;
switch (_that) {
case _JoinRequestDto():
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.profilePic,_that.requestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String linkId,  String userId,  String fullName,  String muid,  String? profilePic,  String? requestedAt)?  $default,) {final _that = this;
switch (_that) {
case _JoinRequestDto() when $default != null:
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.profilePic,_that.requestedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JoinRequestDto extends JoinRequestDto {
  const _JoinRequestDto({required this.linkId, required this.userId, required this.fullName, required this.muid, this.profilePic, this.requestedAt}): super._();
  factory _JoinRequestDto.fromJson(Map<String, dynamic> json) => _$JoinRequestDtoFromJson(json);

@override final  String linkId;
@override final  String userId;
@override final  String fullName;
@override final  String muid;
@override final  String? profilePic;
@override final  String? requestedAt;

/// Create a copy of JoinRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinRequestDtoCopyWith<_JoinRequestDto> get copyWith => __$JoinRequestDtoCopyWithImpl<_JoinRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinRequestDto&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,linkId,userId,fullName,muid,profilePic,requestedAt);

@override
String toString() {
  return 'JoinRequestDto(linkId: $linkId, userId: $userId, fullName: $fullName, muid: $muid, profilePic: $profilePic, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class _$JoinRequestDtoCopyWith<$Res> implements $JoinRequestDtoCopyWith<$Res> {
  factory _$JoinRequestDtoCopyWith(_JoinRequestDto value, $Res Function(_JoinRequestDto) _then) = __$JoinRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String linkId, String userId, String fullName, String muid, String? profilePic, String? requestedAt
});




}
/// @nodoc
class __$JoinRequestDtoCopyWithImpl<$Res>
    implements _$JoinRequestDtoCopyWith<$Res> {
  __$JoinRequestDtoCopyWithImpl(this._self, this._then);

  final _JoinRequestDto _self;
  final $Res Function(_JoinRequestDto) _then;

/// Create a copy of JoinRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? linkId = null,Object? userId = null,Object? fullName = null,Object? muid = null,Object? profilePic = freezed,Object? requestedAt = freezed,}) {
  return _then(_JoinRequestDto(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
