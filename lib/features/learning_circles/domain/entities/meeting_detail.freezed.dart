// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeetingDetail {

 String get id; String get title; String get description; String get mode; String get meetPlace; String get meetTime; String get ig; bool get isStarted; bool get isEnded; bool get isMember; bool get isReportNeeded; int get duration; String get createdById; List<MeetingAttendee> get attendees; String? get meetLink; String? get reportDescription; String? get meetCode; bool get isRecurring;
/// Create a copy of MeetingDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingDetailCopyWith<MeetingDetail> get copyWith => _$MeetingDetailCopyWithImpl<MeetingDetail>(this as MeetingDetail, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MeetingDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.meetPlace, _this.meetPlace) || other.meetPlace == _this.meetPlace)&&(identical(other.meetTime, _this.meetTime) || other.meetTime == _this.meetTime)&&(identical(other.ig, _this.ig) || other.ig == _this.ig)&&(identical(other.isStarted, _this.isStarted) || other.isStarted == _this.isStarted)&&(identical(other.isEnded, _this.isEnded) || other.isEnded == _this.isEnded)&&(identical(other.isMember, _this.isMember) || other.isMember == _this.isMember)&&(identical(other.isReportNeeded, _this.isReportNeeded) || other.isReportNeeded == _this.isReportNeeded)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.createdById, _this.createdById) || other.createdById == _this.createdById)&&const DeepCollectionEquality().equals(other.attendees, _this.attendees)&&(identical(other.meetLink, _this.meetLink) || other.meetLink == _this.meetLink)&&(identical(other.reportDescription, _this.reportDescription) || other.reportDescription == _this.reportDescription)&&(identical(other.meetCode, _this.meetCode) || other.meetCode == _this.meetCode)&&(identical(other.isRecurring, _this.isRecurring) || other.isRecurring == _this.isRecurring));
}


@override
int get hashCode {
  final _this = this as MeetingDetail;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.mode,_this.meetPlace,_this.meetTime,_this.ig,_this.isStarted,_this.isEnded,_this.isMember,_this.isReportNeeded,_this.duration,_this.createdById,const DeepCollectionEquality().hash(_this.attendees),_this.meetLink,_this.reportDescription,_this.meetCode,_this.isRecurring);
}

@override
String toString() {
  final _this = this as MeetingDetail;
  return 'MeetingDetail(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, mode: ${_this.mode}, meetPlace: ${_this.meetPlace}, meetTime: ${_this.meetTime}, ig: ${_this.ig}, isStarted: ${_this.isStarted}, isEnded: ${_this.isEnded}, isMember: ${_this.isMember}, isReportNeeded: ${_this.isReportNeeded}, duration: ${_this.duration}, createdById: ${_this.createdById}, attendees: ${_this.attendees}, meetLink: ${_this.meetLink}, reportDescription: ${_this.reportDescription}, meetCode: ${_this.meetCode}, isRecurring: ${_this.isRecurring})';
}


}

/// @nodoc
abstract mixin class $MeetingDetailCopyWith<$Res>  {
  factory $MeetingDetailCopyWith(MeetingDetail value, $Res Function(MeetingDetail) _then) = _$MeetingDetailCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String mode, String meetPlace, String meetTime, String ig, bool isStarted, bool isEnded, bool isMember, bool isReportNeeded, int duration, String createdById, List<MeetingAttendee> attendees, String? meetLink, String? reportDescription, String? meetCode, bool isRecurring
});




}
/// @nodoc
class _$MeetingDetailCopyWithImpl<$Res>
    implements $MeetingDetailCopyWith<$Res> {
  _$MeetingDetailCopyWithImpl(this._self, this._then);

  final MeetingDetail _self;
  final $Res Function(MeetingDetail) _then;

/// Create a copy of MeetingDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? mode = null,Object? meetPlace = null,Object? meetTime = null,Object? ig = null,Object? isStarted = null,Object? isEnded = null,Object? isMember = null,Object? isReportNeeded = null,Object? duration = null,Object? createdById = null,Object? attendees = null,Object? meetLink = freezed,Object? reportDescription = freezed,Object? meetCode = freezed,Object? isRecurring = null,}) {
  return _then(MeetingDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,meetPlace: null == meetPlace ? _self.meetPlace : meetPlace // ignore: cast_nullable_to_non_nullable
as String,meetTime: null == meetTime ? _self.meetTime : meetTime // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,isStarted: null == isStarted ? _self.isStarted : isStarted // ignore: cast_nullable_to_non_nullable
as bool,isEnded: null == isEnded ? _self.isEnded : isEnded // ignore: cast_nullable_to_non_nullable
as bool,isMember: null == isMember ? _self.isMember : isMember // ignore: cast_nullable_to_non_nullable
as bool,isReportNeeded: null == isReportNeeded ? _self.isReportNeeded : isReportNeeded // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,createdById: null == createdById ? _self.createdById : createdById // ignore: cast_nullable_to_non_nullable
as String,attendees: null == attendees ? _self.attendees : attendees // ignore: cast_nullable_to_non_nullable
as List<MeetingAttendee>,meetLink: freezed == meetLink ? _self.meetLink : meetLink // ignore: cast_nullable_to_non_nullable
as String?,reportDescription: freezed == reportDescription ? _self.reportDescription : reportDescription // ignore: cast_nullable_to_non_nullable
as String?,meetCode: freezed == meetCode ? _self.meetCode : meetCode // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingDetail].
extension MeetingDetailPatterns on MeetingDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingDetail value)  $default,){
final _that = this;
switch (_that) {
case _MeetingDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingDetail value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String ig,  bool isStarted,  bool isEnded,  bool isMember,  bool isReportNeeded,  int duration,  String createdById,  List<MeetingAttendee> attendees,  String? meetLink,  String? reportDescription,  String? meetCode,  bool isRecurring)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingDetail() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.ig,_that.isStarted,_that.isEnded,_that.isMember,_that.isReportNeeded,_that.duration,_that.createdById,_that.attendees,_that.meetLink,_that.reportDescription,_that.meetCode,_that.isRecurring);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String ig,  bool isStarted,  bool isEnded,  bool isMember,  bool isReportNeeded,  int duration,  String createdById,  List<MeetingAttendee> attendees,  String? meetLink,  String? reportDescription,  String? meetCode,  bool isRecurring)  $default,) {final _that = this;
switch (_that) {
case _MeetingDetail():
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.ig,_that.isStarted,_that.isEnded,_that.isMember,_that.isReportNeeded,_that.duration,_that.createdById,_that.attendees,_that.meetLink,_that.reportDescription,_that.meetCode,_that.isRecurring);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String ig,  bool isStarted,  bool isEnded,  bool isMember,  bool isReportNeeded,  int duration,  String createdById,  List<MeetingAttendee> attendees,  String? meetLink,  String? reportDescription,  String? meetCode,  bool isRecurring)?  $default,) {final _that = this;
switch (_that) {
case _MeetingDetail() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.ig,_that.isStarted,_that.isEnded,_that.isMember,_that.isReportNeeded,_that.duration,_that.createdById,_that.attendees,_that.meetLink,_that.reportDescription,_that.meetCode,_that.isRecurring);case _:
  return null;

}
}

}

/// @nodoc


class _MeetingDetail implements MeetingDetail {
  const _MeetingDetail({required this.id, required this.title, required this.description, required this.mode, required this.meetPlace, required this.meetTime, required this.ig, required this.isStarted, required this.isEnded, required this.isMember, required this.isReportNeeded, required this.duration, required this.createdById, required  List<MeetingAttendee> attendees, this.meetLink, this.reportDescription, this.meetCode, this.isRecurring = false}): _attendees = attendees;
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String mode;
@override final  String meetPlace;
@override final  String meetTime;
@override final  String ig;
@override final  bool isStarted;
@override final  bool isEnded;
@override final  bool isMember;
@override final  bool isReportNeeded;
@override final  int duration;
@override final  String createdById;
 final  List<MeetingAttendee> _attendees;
@override List<MeetingAttendee> get attendees {
  if (_attendees is EqualUnmodifiableListView) return _attendees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendees);
}

@override final  String? meetLink;
@override final  String? reportDescription;
@override final  String? meetCode;
@override@JsonKey() final  bool isRecurring;

/// Create a copy of MeetingDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingDetailCopyWith<_MeetingDetail> get copyWith => __$MeetingDetailCopyWithImpl<_MeetingDetail>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetPlace, meetPlace) || other.meetPlace == meetPlace)&&(identical(other.meetTime, meetTime) || other.meetTime == meetTime)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.isStarted, isStarted) || other.isStarted == isStarted)&&(identical(other.isEnded, isEnded) || other.isEnded == isEnded)&&(identical(other.isMember, isMember) || other.isMember == isMember)&&(identical(other.isReportNeeded, isReportNeeded) || other.isReportNeeded == isReportNeeded)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.createdById, createdById) || other.createdById == createdById)&&const DeepCollectionEquality().equals(other.attendees, _attendees)&&(identical(other.meetLink, meetLink) || other.meetLink == meetLink)&&(identical(other.reportDescription, reportDescription) || other.reportDescription == reportDescription)&&(identical(other.meetCode, meetCode) || other.meetCode == meetCode)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,mode,meetPlace,meetTime,ig,isStarted,isEnded,isMember,isReportNeeded,duration,createdById,const DeepCollectionEquality().hash(_attendees),meetLink,reportDescription,meetCode,isRecurring);
}

@override
String toString() {
    return 'MeetingDetail(id: $id, title: $title, description: $description, mode: $mode, meetPlace: $meetPlace, meetTime: $meetTime, ig: $ig, isStarted: $isStarted, isEnded: $isEnded, isMember: $isMember, isReportNeeded: $isReportNeeded, duration: $duration, createdById: $createdById, attendees: $attendees, meetLink: $meetLink, reportDescription: $reportDescription, meetCode: $meetCode, isRecurring: $isRecurring)';
}


}

/// @nodoc
abstract mixin class _$MeetingDetailCopyWith<$Res> implements $MeetingDetailCopyWith<$Res> {
  factory _$MeetingDetailCopyWith(_MeetingDetail value, $Res Function(_MeetingDetail) _then) = __$MeetingDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String mode, String meetPlace, String meetTime, String ig, bool isStarted, bool isEnded, bool isMember, bool isReportNeeded, int duration, String createdById, List<MeetingAttendee> attendees, String? meetLink, String? reportDescription, String? meetCode, bool isRecurring
});




}
/// @nodoc
class __$MeetingDetailCopyWithImpl<$Res>
    implements _$MeetingDetailCopyWith<$Res> {
  __$MeetingDetailCopyWithImpl(this._self, this._then);

  final _MeetingDetail _self;
  final $Res Function(_MeetingDetail) _then;

/// Create a copy of MeetingDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? mode = null,Object? meetPlace = null,Object? meetTime = null,Object? ig = null,Object? isStarted = null,Object? isEnded = null,Object? isMember = null,Object? isReportNeeded = null,Object? duration = null,Object? createdById = null,Object? attendees = null,Object? meetLink = freezed,Object? reportDescription = freezed,Object? meetCode = freezed,Object? isRecurring = null,}) {
  return _then(_MeetingDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,meetPlace: null == meetPlace ? _self.meetPlace : meetPlace // ignore: cast_nullable_to_non_nullable
as String,meetTime: null == meetTime ? _self.meetTime : meetTime // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,isStarted: null == isStarted ? _self.isStarted : isStarted // ignore: cast_nullable_to_non_nullable
as bool,isEnded: null == isEnded ? _self.isEnded : isEnded // ignore: cast_nullable_to_non_nullable
as bool,isMember: null == isMember ? _self.isMember : isMember // ignore: cast_nullable_to_non_nullable
as bool,isReportNeeded: null == isReportNeeded ? _self.isReportNeeded : isReportNeeded // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,createdById: null == createdById ? _self.createdById : createdById // ignore: cast_nullable_to_non_nullable
as String,attendees: null == attendees ? _self._attendees : attendees // ignore: cast_nullable_to_non_nullable
as List<MeetingAttendee>,meetLink: freezed == meetLink ? _self.meetLink : meetLink // ignore: cast_nullable_to_non_nullable
as String?,reportDescription: freezed == reportDescription ? _self.reportDescription : reportDescription // ignore: cast_nullable_to_non_nullable
as String?,meetCode: freezed == meetCode ? _self.meetCode : meetCode // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
