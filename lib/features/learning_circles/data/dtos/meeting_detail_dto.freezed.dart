// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingDetailDto {

 String get id; String get title; String get description; String get mode; String get meetPlace; String get meetTime; String get ig; String get createdById; bool get isStarted; bool get isEnded; bool get isMember; bool get isReportNeeded; int get duration; List<MeetingAttendeeDto> get attendees; String? get meetLink; String? get reportDescription; String? get meetCode; bool get isRecurring;
/// Create a copy of MeetingDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingDetailDtoCopyWith<MeetingDetailDto> get copyWith => _$MeetingDetailDtoCopyWithImpl<MeetingDetailDto>(this as MeetingDetailDto, _$identity);

  /// Serializes this MeetingDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetPlace, meetPlace) || other.meetPlace == meetPlace)&&(identical(other.meetTime, meetTime) || other.meetTime == meetTime)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.createdById, createdById) || other.createdById == createdById)&&(identical(other.isStarted, isStarted) || other.isStarted == isStarted)&&(identical(other.isEnded, isEnded) || other.isEnded == isEnded)&&(identical(other.isMember, isMember) || other.isMember == isMember)&&(identical(other.isReportNeeded, isReportNeeded) || other.isReportNeeded == isReportNeeded)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.attendees, attendees)&&(identical(other.meetLink, meetLink) || other.meetLink == meetLink)&&(identical(other.reportDescription, reportDescription) || other.reportDescription == reportDescription)&&(identical(other.meetCode, meetCode) || other.meetCode == meetCode)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,mode,meetPlace,meetTime,ig,createdById,isStarted,isEnded,isMember,isReportNeeded,duration,const DeepCollectionEquality().hash(attendees),meetLink,reportDescription,meetCode,isRecurring);

@override
String toString() {
  return 'MeetingDetailDto(id: $id, title: $title, description: $description, mode: $mode, meetPlace: $meetPlace, meetTime: $meetTime, ig: $ig, createdById: $createdById, isStarted: $isStarted, isEnded: $isEnded, isMember: $isMember, isReportNeeded: $isReportNeeded, duration: $duration, attendees: $attendees, meetLink: $meetLink, reportDescription: $reportDescription, meetCode: $meetCode, isRecurring: $isRecurring)';
}


}

/// @nodoc
abstract mixin class $MeetingDetailDtoCopyWith<$Res>  {
  factory $MeetingDetailDtoCopyWith(MeetingDetailDto value, $Res Function(MeetingDetailDto) _then) = _$MeetingDetailDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String mode, String meetPlace, String meetTime, String ig, String createdById, bool isStarted, bool isEnded, bool isMember, bool isReportNeeded, int duration, List<MeetingAttendeeDto> attendees, String? meetLink, String? reportDescription, String? meetCode, bool isRecurring
});




}
/// @nodoc
class _$MeetingDetailDtoCopyWithImpl<$Res>
    implements $MeetingDetailDtoCopyWith<$Res> {
  _$MeetingDetailDtoCopyWithImpl(this._self, this._then);

  final MeetingDetailDto _self;
  final $Res Function(MeetingDetailDto) _then;

/// Create a copy of MeetingDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? mode = null,Object? meetPlace = null,Object? meetTime = null,Object? ig = null,Object? createdById = null,Object? isStarted = null,Object? isEnded = null,Object? isMember = null,Object? isReportNeeded = null,Object? duration = null,Object? attendees = null,Object? meetLink = freezed,Object? reportDescription = freezed,Object? meetCode = freezed,Object? isRecurring = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,meetPlace: null == meetPlace ? _self.meetPlace : meetPlace // ignore: cast_nullable_to_non_nullable
as String,meetTime: null == meetTime ? _self.meetTime : meetTime // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,createdById: null == createdById ? _self.createdById : createdById // ignore: cast_nullable_to_non_nullable
as String,isStarted: null == isStarted ? _self.isStarted : isStarted // ignore: cast_nullable_to_non_nullable
as bool,isEnded: null == isEnded ? _self.isEnded : isEnded // ignore: cast_nullable_to_non_nullable
as bool,isMember: null == isMember ? _self.isMember : isMember // ignore: cast_nullable_to_non_nullable
as bool,isReportNeeded: null == isReportNeeded ? _self.isReportNeeded : isReportNeeded // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,attendees: null == attendees ? _self.attendees : attendees // ignore: cast_nullable_to_non_nullable
as List<MeetingAttendeeDto>,meetLink: freezed == meetLink ? _self.meetLink : meetLink // ignore: cast_nullable_to_non_nullable
as String?,reportDescription: freezed == reportDescription ? _self.reportDescription : reportDescription // ignore: cast_nullable_to_non_nullable
as String?,meetCode: freezed == meetCode ? _self.meetCode : meetCode // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingDetailDto].
extension MeetingDetailDtoPatterns on MeetingDetailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingDetailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _MeetingDetailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingDetailDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String ig,  String createdById,  bool isStarted,  bool isEnded,  bool isMember,  bool isReportNeeded,  int duration,  List<MeetingAttendeeDto> attendees,  String? meetLink,  String? reportDescription,  String? meetCode,  bool isRecurring)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingDetailDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.ig,_that.createdById,_that.isStarted,_that.isEnded,_that.isMember,_that.isReportNeeded,_that.duration,_that.attendees,_that.meetLink,_that.reportDescription,_that.meetCode,_that.isRecurring);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String ig,  String createdById,  bool isStarted,  bool isEnded,  bool isMember,  bool isReportNeeded,  int duration,  List<MeetingAttendeeDto> attendees,  String? meetLink,  String? reportDescription,  String? meetCode,  bool isRecurring)  $default,) {final _that = this;
switch (_that) {
case _MeetingDetailDto():
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.ig,_that.createdById,_that.isStarted,_that.isEnded,_that.isMember,_that.isReportNeeded,_that.duration,_that.attendees,_that.meetLink,_that.reportDescription,_that.meetCode,_that.isRecurring);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String ig,  String createdById,  bool isStarted,  bool isEnded,  bool isMember,  bool isReportNeeded,  int duration,  List<MeetingAttendeeDto> attendees,  String? meetLink,  String? reportDescription,  String? meetCode,  bool isRecurring)?  $default,) {final _that = this;
switch (_that) {
case _MeetingDetailDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.ig,_that.createdById,_that.isStarted,_that.isEnded,_that.isMember,_that.isReportNeeded,_that.duration,_that.attendees,_that.meetLink,_that.reportDescription,_that.meetCode,_that.isRecurring);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingDetailDto extends MeetingDetailDto {
  const _MeetingDetailDto({required this.id, required this.title, required this.description, required this.mode, required this.meetPlace, required this.meetTime, required this.ig, required this.createdById, this.isStarted = false, this.isEnded = false, this.isMember = false, this.isReportNeeded = false, this.duration = 0, final  List<MeetingAttendeeDto> attendees = const [], this.meetLink, this.reportDescription, this.meetCode, this.isRecurring = false}): _attendees = attendees,super._();
  factory _MeetingDetailDto.fromJson(Map<String, dynamic> json) => _$MeetingDetailDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String mode;
@override final  String meetPlace;
@override final  String meetTime;
@override final  String ig;
@override final  String createdById;
@override@JsonKey() final  bool isStarted;
@override@JsonKey() final  bool isEnded;
@override@JsonKey() final  bool isMember;
@override@JsonKey() final  bool isReportNeeded;
@override@JsonKey() final  int duration;
 final  List<MeetingAttendeeDto> _attendees;
@override@JsonKey() List<MeetingAttendeeDto> get attendees {
  if (_attendees is EqualUnmodifiableListView) return _attendees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendees);
}

@override final  String? meetLink;
@override final  String? reportDescription;
@override final  String? meetCode;
@override@JsonKey() final  bool isRecurring;

/// Create a copy of MeetingDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingDetailDtoCopyWith<_MeetingDetailDto> get copyWith => __$MeetingDetailDtoCopyWithImpl<_MeetingDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetPlace, meetPlace) || other.meetPlace == meetPlace)&&(identical(other.meetTime, meetTime) || other.meetTime == meetTime)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.createdById, createdById) || other.createdById == createdById)&&(identical(other.isStarted, isStarted) || other.isStarted == isStarted)&&(identical(other.isEnded, isEnded) || other.isEnded == isEnded)&&(identical(other.isMember, isMember) || other.isMember == isMember)&&(identical(other.isReportNeeded, isReportNeeded) || other.isReportNeeded == isReportNeeded)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._attendees, _attendees)&&(identical(other.meetLink, meetLink) || other.meetLink == meetLink)&&(identical(other.reportDescription, reportDescription) || other.reportDescription == reportDescription)&&(identical(other.meetCode, meetCode) || other.meetCode == meetCode)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,mode,meetPlace,meetTime,ig,createdById,isStarted,isEnded,isMember,isReportNeeded,duration,const DeepCollectionEquality().hash(_attendees),meetLink,reportDescription,meetCode,isRecurring);

@override
String toString() {
  return 'MeetingDetailDto(id: $id, title: $title, description: $description, mode: $mode, meetPlace: $meetPlace, meetTime: $meetTime, ig: $ig, createdById: $createdById, isStarted: $isStarted, isEnded: $isEnded, isMember: $isMember, isReportNeeded: $isReportNeeded, duration: $duration, attendees: $attendees, meetLink: $meetLink, reportDescription: $reportDescription, meetCode: $meetCode, isRecurring: $isRecurring)';
}


}

/// @nodoc
abstract mixin class _$MeetingDetailDtoCopyWith<$Res> implements $MeetingDetailDtoCopyWith<$Res> {
  factory _$MeetingDetailDtoCopyWith(_MeetingDetailDto value, $Res Function(_MeetingDetailDto) _then) = __$MeetingDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String mode, String meetPlace, String meetTime, String ig, String createdById, bool isStarted, bool isEnded, bool isMember, bool isReportNeeded, int duration, List<MeetingAttendeeDto> attendees, String? meetLink, String? reportDescription, String? meetCode, bool isRecurring
});




}
/// @nodoc
class __$MeetingDetailDtoCopyWithImpl<$Res>
    implements _$MeetingDetailDtoCopyWith<$Res> {
  __$MeetingDetailDtoCopyWithImpl(this._self, this._then);

  final _MeetingDetailDto _self;
  final $Res Function(_MeetingDetailDto) _then;

/// Create a copy of MeetingDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? mode = null,Object? meetPlace = null,Object? meetTime = null,Object? ig = null,Object? createdById = null,Object? isStarted = null,Object? isEnded = null,Object? isMember = null,Object? isReportNeeded = null,Object? duration = null,Object? attendees = null,Object? meetLink = freezed,Object? reportDescription = freezed,Object? meetCode = freezed,Object? isRecurring = null,}) {
  return _then(_MeetingDetailDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,meetPlace: null == meetPlace ? _self.meetPlace : meetPlace // ignore: cast_nullable_to_non_nullable
as String,meetTime: null == meetTime ? _self.meetTime : meetTime // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,createdById: null == createdById ? _self.createdById : createdById // ignore: cast_nullable_to_non_nullable
as String,isStarted: null == isStarted ? _self.isStarted : isStarted // ignore: cast_nullable_to_non_nullable
as bool,isEnded: null == isEnded ? _self.isEnded : isEnded // ignore: cast_nullable_to_non_nullable
as bool,isMember: null == isMember ? _self.isMember : isMember // ignore: cast_nullable_to_non_nullable
as bool,isReportNeeded: null == isReportNeeded ? _self.isReportNeeded : isReportNeeded // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,attendees: null == attendees ? _self._attendees : attendees // ignore: cast_nullable_to_non_nullable
as List<MeetingAttendeeDto>,meetLink: freezed == meetLink ? _self.meetLink : meetLink // ignore: cast_nullable_to_non_nullable
as String?,reportDescription: freezed == reportDescription ? _self.reportDescription : reportDescription // ignore: cast_nullable_to_non_nullable
as String?,meetCode: freezed == meetCode ? _self.meetCode : meetCode // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
