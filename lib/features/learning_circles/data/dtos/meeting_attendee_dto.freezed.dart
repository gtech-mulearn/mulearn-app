// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_attendee_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingAttendeeDto {

 String get userId; String get fullName; bool get isJoined; bool get isReportSubmitted; String? get profilePic; bool? get isSameOrg;
/// Create a copy of MeetingAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingAttendeeDtoCopyWith<MeetingAttendeeDto> get copyWith => _$MeetingAttendeeDtoCopyWithImpl<MeetingAttendeeDto>(this as MeetingAttendeeDto, _$identity);

  /// Serializes this MeetingAttendeeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingAttendeeDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.isJoined, isJoined) || other.isJoined == isJoined)&&(identical(other.isReportSubmitted, isReportSubmitted) || other.isReportSubmitted == isReportSubmitted)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.isSameOrg, isSameOrg) || other.isSameOrg == isSameOrg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,fullName,isJoined,isReportSubmitted,profilePic,isSameOrg);

@override
String toString() {
  return 'MeetingAttendeeDto(userId: $userId, fullName: $fullName, isJoined: $isJoined, isReportSubmitted: $isReportSubmitted, profilePic: $profilePic, isSameOrg: $isSameOrg)';
}


}

/// @nodoc
abstract mixin class $MeetingAttendeeDtoCopyWith<$Res>  {
  factory $MeetingAttendeeDtoCopyWith(MeetingAttendeeDto value, $Res Function(MeetingAttendeeDto) _then) = _$MeetingAttendeeDtoCopyWithImpl;
@useResult
$Res call({
 String userId, String fullName, bool isJoined, bool isReportSubmitted, String? profilePic, bool? isSameOrg
});




}
/// @nodoc
class _$MeetingAttendeeDtoCopyWithImpl<$Res>
    implements $MeetingAttendeeDtoCopyWith<$Res> {
  _$MeetingAttendeeDtoCopyWithImpl(this._self, this._then);

  final MeetingAttendeeDto _self;
  final $Res Function(MeetingAttendeeDto) _then;

/// Create a copy of MeetingAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? fullName = null,Object? isJoined = null,Object? isReportSubmitted = null,Object? profilePic = freezed,Object? isSameOrg = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,isJoined: null == isJoined ? _self.isJoined : isJoined // ignore: cast_nullable_to_non_nullable
as bool,isReportSubmitted: null == isReportSubmitted ? _self.isReportSubmitted : isReportSubmitted // ignore: cast_nullable_to_non_nullable
as bool,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,isSameOrg: freezed == isSameOrg ? _self.isSameOrg : isSameOrg // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingAttendeeDto].
extension MeetingAttendeeDtoPatterns on MeetingAttendeeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingAttendeeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingAttendeeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingAttendeeDto value)  $default,){
final _that = this;
switch (_that) {
case _MeetingAttendeeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingAttendeeDto value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingAttendeeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String fullName,  bool isJoined,  bool isReportSubmitted,  String? profilePic,  bool? isSameOrg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingAttendeeDto() when $default != null:
return $default(_that.userId,_that.fullName,_that.isJoined,_that.isReportSubmitted,_that.profilePic,_that.isSameOrg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String fullName,  bool isJoined,  bool isReportSubmitted,  String? profilePic,  bool? isSameOrg)  $default,) {final _that = this;
switch (_that) {
case _MeetingAttendeeDto():
return $default(_that.userId,_that.fullName,_that.isJoined,_that.isReportSubmitted,_that.profilePic,_that.isSameOrg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String fullName,  bool isJoined,  bool isReportSubmitted,  String? profilePic,  bool? isSameOrg)?  $default,) {final _that = this;
switch (_that) {
case _MeetingAttendeeDto() when $default != null:
return $default(_that.userId,_that.fullName,_that.isJoined,_that.isReportSubmitted,_that.profilePic,_that.isSameOrg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingAttendeeDto extends MeetingAttendeeDto {
  const _MeetingAttendeeDto({required this.userId, required this.fullName, this.isJoined = false, this.isReportSubmitted = false, this.profilePic, this.isSameOrg}): super._();
  factory _MeetingAttendeeDto.fromJson(Map<String, dynamic> json) => _$MeetingAttendeeDtoFromJson(json);

@override final  String userId;
@override final  String fullName;
@override@JsonKey() final  bool isJoined;
@override@JsonKey() final  bool isReportSubmitted;
@override final  String? profilePic;
@override final  bool? isSameOrg;

/// Create a copy of MeetingAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingAttendeeDtoCopyWith<_MeetingAttendeeDto> get copyWith => __$MeetingAttendeeDtoCopyWithImpl<_MeetingAttendeeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingAttendeeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingAttendeeDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.isJoined, isJoined) || other.isJoined == isJoined)&&(identical(other.isReportSubmitted, isReportSubmitted) || other.isReportSubmitted == isReportSubmitted)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.isSameOrg, isSameOrg) || other.isSameOrg == isSameOrg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,fullName,isJoined,isReportSubmitted,profilePic,isSameOrg);

@override
String toString() {
  return 'MeetingAttendeeDto(userId: $userId, fullName: $fullName, isJoined: $isJoined, isReportSubmitted: $isReportSubmitted, profilePic: $profilePic, isSameOrg: $isSameOrg)';
}


}

/// @nodoc
abstract mixin class _$MeetingAttendeeDtoCopyWith<$Res> implements $MeetingAttendeeDtoCopyWith<$Res> {
  factory _$MeetingAttendeeDtoCopyWith(_MeetingAttendeeDto value, $Res Function(_MeetingAttendeeDto) _then) = __$MeetingAttendeeDtoCopyWithImpl;
@override @useResult
$Res call({
 String userId, String fullName, bool isJoined, bool isReportSubmitted, String? profilePic, bool? isSameOrg
});




}
/// @nodoc
class __$MeetingAttendeeDtoCopyWithImpl<$Res>
    implements _$MeetingAttendeeDtoCopyWith<$Res> {
  __$MeetingAttendeeDtoCopyWithImpl(this._self, this._then);

  final _MeetingAttendeeDto _self;
  final $Res Function(_MeetingAttendeeDto) _then;

/// Create a copy of MeetingAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? fullName = null,Object? isJoined = null,Object? isReportSubmitted = null,Object? profilePic = freezed,Object? isSameOrg = freezed,}) {
  return _then(_MeetingAttendeeDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,isJoined: null == isJoined ? _self.isJoined : isJoined // ignore: cast_nullable_to_non_nullable
as bool,isReportSubmitted: null == isReportSubmitted ? _self.isReportSubmitted : isReportSubmitted // ignore: cast_nullable_to_non_nullable
as bool,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,isSameOrg: freezed == isSameOrg ? _self.isSameOrg : isSameOrg // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
