// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_report_attendee_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingReportAttendeeDto {

 String get userId; String get fullName; String get muid; bool get isLcApproved; String? get report; String? get reportLink;
/// Create a copy of MeetingReportAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingReportAttendeeDtoCopyWith<MeetingReportAttendeeDto> get copyWith => _$MeetingReportAttendeeDtoCopyWithImpl<MeetingReportAttendeeDto>(this as MeetingReportAttendeeDto, _$identity);

  /// Serializes this MeetingReportAttendeeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingReportAttendeeDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.isLcApproved, isLcApproved) || other.isLcApproved == isLcApproved)&&(identical(other.report, report) || other.report == report)&&(identical(other.reportLink, reportLink) || other.reportLink == reportLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,fullName,muid,isLcApproved,report,reportLink);

@override
String toString() {
  return 'MeetingReportAttendeeDto(userId: $userId, fullName: $fullName, muid: $muid, isLcApproved: $isLcApproved, report: $report, reportLink: $reportLink)';
}


}

/// @nodoc
abstract mixin class $MeetingReportAttendeeDtoCopyWith<$Res>  {
  factory $MeetingReportAttendeeDtoCopyWith(MeetingReportAttendeeDto value, $Res Function(MeetingReportAttendeeDto) _then) = _$MeetingReportAttendeeDtoCopyWithImpl;
@useResult
$Res call({
 String userId, String fullName, String muid, bool isLcApproved, String? report, String? reportLink
});




}
/// @nodoc
class _$MeetingReportAttendeeDtoCopyWithImpl<$Res>
    implements $MeetingReportAttendeeDtoCopyWith<$Res> {
  _$MeetingReportAttendeeDtoCopyWithImpl(this._self, this._then);

  final MeetingReportAttendeeDto _self;
  final $Res Function(MeetingReportAttendeeDto) _then;

/// Create a copy of MeetingReportAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? fullName = null,Object? muid = null,Object? isLcApproved = null,Object? report = freezed,Object? reportLink = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,isLcApproved: null == isLcApproved ? _self.isLcApproved : isLcApproved // ignore: cast_nullable_to_non_nullable
as bool,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as String?,reportLink: freezed == reportLink ? _self.reportLink : reportLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingReportAttendeeDto].
extension MeetingReportAttendeeDtoPatterns on MeetingReportAttendeeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingReportAttendeeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingReportAttendeeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingReportAttendeeDto value)  $default,){
final _that = this;
switch (_that) {
case _MeetingReportAttendeeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingReportAttendeeDto value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingReportAttendeeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String fullName,  String muid,  bool isLcApproved,  String? report,  String? reportLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingReportAttendeeDto() when $default != null:
return $default(_that.userId,_that.fullName,_that.muid,_that.isLcApproved,_that.report,_that.reportLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String fullName,  String muid,  bool isLcApproved,  String? report,  String? reportLink)  $default,) {final _that = this;
switch (_that) {
case _MeetingReportAttendeeDto():
return $default(_that.userId,_that.fullName,_that.muid,_that.isLcApproved,_that.report,_that.reportLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String fullName,  String muid,  bool isLcApproved,  String? report,  String? reportLink)?  $default,) {final _that = this;
switch (_that) {
case _MeetingReportAttendeeDto() when $default != null:
return $default(_that.userId,_that.fullName,_that.muid,_that.isLcApproved,_that.report,_that.reportLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingReportAttendeeDto extends MeetingReportAttendeeDto {
  const _MeetingReportAttendeeDto({required this.userId, required this.fullName, required this.muid, this.isLcApproved = false, this.report, this.reportLink}): super._();
  factory _MeetingReportAttendeeDto.fromJson(Map<String, dynamic> json) => _$MeetingReportAttendeeDtoFromJson(json);

@override final  String userId;
@override final  String fullName;
@override final  String muid;
@override@JsonKey() final  bool isLcApproved;
@override final  String? report;
@override final  String? reportLink;

/// Create a copy of MeetingReportAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingReportAttendeeDtoCopyWith<_MeetingReportAttendeeDto> get copyWith => __$MeetingReportAttendeeDtoCopyWithImpl<_MeetingReportAttendeeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingReportAttendeeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingReportAttendeeDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.isLcApproved, isLcApproved) || other.isLcApproved == isLcApproved)&&(identical(other.report, report) || other.report == report)&&(identical(other.reportLink, reportLink) || other.reportLink == reportLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,fullName,muid,isLcApproved,report,reportLink);

@override
String toString() {
  return 'MeetingReportAttendeeDto(userId: $userId, fullName: $fullName, muid: $muid, isLcApproved: $isLcApproved, report: $report, reportLink: $reportLink)';
}


}

/// @nodoc
abstract mixin class _$MeetingReportAttendeeDtoCopyWith<$Res> implements $MeetingReportAttendeeDtoCopyWith<$Res> {
  factory _$MeetingReportAttendeeDtoCopyWith(_MeetingReportAttendeeDto value, $Res Function(_MeetingReportAttendeeDto) _then) = __$MeetingReportAttendeeDtoCopyWithImpl;
@override @useResult
$Res call({
 String userId, String fullName, String muid, bool isLcApproved, String? report, String? reportLink
});




}
/// @nodoc
class __$MeetingReportAttendeeDtoCopyWithImpl<$Res>
    implements _$MeetingReportAttendeeDtoCopyWith<$Res> {
  __$MeetingReportAttendeeDtoCopyWithImpl(this._self, this._then);

  final _MeetingReportAttendeeDto _self;
  final $Res Function(_MeetingReportAttendeeDto) _then;

/// Create a copy of MeetingReportAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? fullName = null,Object? muid = null,Object? isLcApproved = null,Object? report = freezed,Object? reportLink = freezed,}) {
  return _then(_MeetingReportAttendeeDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,isLcApproved: null == isLcApproved ? _self.isLcApproved : isLcApproved // ignore: cast_nullable_to_non_nullable
as bool,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as String?,reportLink: freezed == reportLink ? _self.reportLink : reportLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
