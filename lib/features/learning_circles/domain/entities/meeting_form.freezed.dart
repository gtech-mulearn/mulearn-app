// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeetingForm {

 String get title; String get description; String get mode; String get meetPlace; String get meetTime; int get duration; bool get isRecurring; bool get isReportNeeded; String? get platform; String? get meetLink; double? get coordX; double? get coordY; String? get recurrenceType; int? get recurrence; String? get reportDescription;
/// Create a copy of MeetingForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingFormCopyWith<MeetingForm> get copyWith => _$MeetingFormCopyWithImpl<MeetingForm>(this as MeetingForm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MeetingForm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingForm&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.meetPlace, _this.meetPlace) || other.meetPlace == _this.meetPlace)&&(identical(other.meetTime, _this.meetTime) || other.meetTime == _this.meetTime)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.isRecurring, _this.isRecurring) || other.isRecurring == _this.isRecurring)&&(identical(other.isReportNeeded, _this.isReportNeeded) || other.isReportNeeded == _this.isReportNeeded)&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.meetLink, _this.meetLink) || other.meetLink == _this.meetLink)&&(identical(other.coordX, _this.coordX) || other.coordX == _this.coordX)&&(identical(other.coordY, _this.coordY) || other.coordY == _this.coordY)&&(identical(other.recurrenceType, _this.recurrenceType) || other.recurrenceType == _this.recurrenceType)&&(identical(other.recurrence, _this.recurrence) || other.recurrence == _this.recurrence)&&(identical(other.reportDescription, _this.reportDescription) || other.reportDescription == _this.reportDescription));
}


@override
int get hashCode {
  final _this = this as MeetingForm;
  return Object.hash(runtimeType,_this.title,_this.description,_this.mode,_this.meetPlace,_this.meetTime,_this.duration,_this.isRecurring,_this.isReportNeeded,_this.platform,_this.meetLink,_this.coordX,_this.coordY,_this.recurrenceType,_this.recurrence,_this.reportDescription);
}

@override
String toString() {
  final _this = this as MeetingForm;
  return 'MeetingForm(title: ${_this.title}, description: ${_this.description}, mode: ${_this.mode}, meetPlace: ${_this.meetPlace}, meetTime: ${_this.meetTime}, duration: ${_this.duration}, isRecurring: ${_this.isRecurring}, isReportNeeded: ${_this.isReportNeeded}, platform: ${_this.platform}, meetLink: ${_this.meetLink}, coordX: ${_this.coordX}, coordY: ${_this.coordY}, recurrenceType: ${_this.recurrenceType}, recurrence: ${_this.recurrence}, reportDescription: ${_this.reportDescription})';
}


}

/// @nodoc
abstract mixin class $MeetingFormCopyWith<$Res>  {
  factory $MeetingFormCopyWith(MeetingForm value, $Res Function(MeetingForm) _then) = _$MeetingFormCopyWithImpl;
@useResult
$Res call({
 String title, String description, String mode, String meetPlace, String meetTime, int duration, bool isRecurring, bool isReportNeeded, String? platform, String? meetLink, double? coordX, double? coordY, String? recurrenceType, int? recurrence, String? reportDescription
});




}
/// @nodoc
class _$MeetingFormCopyWithImpl<$Res>
    implements $MeetingFormCopyWith<$Res> {
  _$MeetingFormCopyWithImpl(this._self, this._then);

  final MeetingForm _self;
  final $Res Function(MeetingForm) _then;

/// Create a copy of MeetingForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? mode = null,Object? meetPlace = null,Object? meetTime = null,Object? duration = null,Object? isRecurring = null,Object? isReportNeeded = null,Object? platform = freezed,Object? meetLink = freezed,Object? coordX = freezed,Object? coordY = freezed,Object? recurrenceType = freezed,Object? recurrence = freezed,Object? reportDescription = freezed,}) {
  return _then(MeetingForm(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,meetPlace: null == meetPlace ? _self.meetPlace : meetPlace // ignore: cast_nullable_to_non_nullable
as String,meetTime: null == meetTime ? _self.meetTime : meetTime // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,isReportNeeded: null == isReportNeeded ? _self.isReportNeeded : isReportNeeded // ignore: cast_nullable_to_non_nullable
as bool,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,meetLink: freezed == meetLink ? _self.meetLink : meetLink // ignore: cast_nullable_to_non_nullable
as String?,coordX: freezed == coordX ? _self.coordX : coordX // ignore: cast_nullable_to_non_nullable
as double?,coordY: freezed == coordY ? _self.coordY : coordY // ignore: cast_nullable_to_non_nullable
as double?,recurrenceType: freezed == recurrenceType ? _self.recurrenceType : recurrenceType // ignore: cast_nullable_to_non_nullable
as String?,recurrence: freezed == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as int?,reportDescription: freezed == reportDescription ? _self.reportDescription : reportDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingForm].
extension MeetingFormPatterns on MeetingForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingForm value)  $default,){
final _that = this;
switch (_that) {
case _MeetingForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingForm value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String mode,  String meetPlace,  String meetTime,  int duration,  bool isRecurring,  bool isReportNeeded,  String? platform,  String? meetLink,  double? coordX,  double? coordY,  String? recurrenceType,  int? recurrence,  String? reportDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingForm() when $default != null:
return $default(_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.duration,_that.isRecurring,_that.isReportNeeded,_that.platform,_that.meetLink,_that.coordX,_that.coordY,_that.recurrenceType,_that.recurrence,_that.reportDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String mode,  String meetPlace,  String meetTime,  int duration,  bool isRecurring,  bool isReportNeeded,  String? platform,  String? meetLink,  double? coordX,  double? coordY,  String? recurrenceType,  int? recurrence,  String? reportDescription)  $default,) {final _that = this;
switch (_that) {
case _MeetingForm():
return $default(_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.duration,_that.isRecurring,_that.isReportNeeded,_that.platform,_that.meetLink,_that.coordX,_that.coordY,_that.recurrenceType,_that.recurrence,_that.reportDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String mode,  String meetPlace,  String meetTime,  int duration,  bool isRecurring,  bool isReportNeeded,  String? platform,  String? meetLink,  double? coordX,  double? coordY,  String? recurrenceType,  int? recurrence,  String? reportDescription)?  $default,) {final _that = this;
switch (_that) {
case _MeetingForm() when $default != null:
return $default(_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.duration,_that.isRecurring,_that.isReportNeeded,_that.platform,_that.meetLink,_that.coordX,_that.coordY,_that.recurrenceType,_that.recurrence,_that.reportDescription);case _:
  return null;

}
}

}

/// @nodoc


class _MeetingForm implements MeetingForm {
  const _MeetingForm({required this.title, required this.description, required this.mode, required this.meetPlace, required this.meetTime, required this.duration, required this.isRecurring, required this.isReportNeeded, this.platform, this.meetLink, this.coordX, this.coordY, this.recurrenceType, this.recurrence, this.reportDescription});
  

@override final  String title;
@override final  String description;
@override final  String mode;
@override final  String meetPlace;
@override final  String meetTime;
@override final  int duration;
@override final  bool isRecurring;
@override final  bool isReportNeeded;
@override final  String? platform;
@override final  String? meetLink;
@override final  double? coordX;
@override final  double? coordY;
@override final  String? recurrenceType;
@override final  int? recurrence;
@override final  String? reportDescription;

/// Create a copy of MeetingForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingFormCopyWith<_MeetingForm> get copyWith => __$MeetingFormCopyWithImpl<_MeetingForm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingForm&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetPlace, meetPlace) || other.meetPlace == meetPlace)&&(identical(other.meetTime, meetTime) || other.meetTime == meetTime)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.isReportNeeded, isReportNeeded) || other.isReportNeeded == isReportNeeded)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.meetLink, meetLink) || other.meetLink == meetLink)&&(identical(other.coordX, coordX) || other.coordX == coordX)&&(identical(other.coordY, coordY) || other.coordY == coordY)&&(identical(other.recurrenceType, recurrenceType) || other.recurrenceType == recurrenceType)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.reportDescription, reportDescription) || other.reportDescription == reportDescription));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,description,mode,meetPlace,meetTime,duration,isRecurring,isReportNeeded,platform,meetLink,coordX,coordY,recurrenceType,recurrence,reportDescription);
}

@override
String toString() {
    return 'MeetingForm(title: $title, description: $description, mode: $mode, meetPlace: $meetPlace, meetTime: $meetTime, duration: $duration, isRecurring: $isRecurring, isReportNeeded: $isReportNeeded, platform: $platform, meetLink: $meetLink, coordX: $coordX, coordY: $coordY, recurrenceType: $recurrenceType, recurrence: $recurrence, reportDescription: $reportDescription)';
}


}

/// @nodoc
abstract mixin class _$MeetingFormCopyWith<$Res> implements $MeetingFormCopyWith<$Res> {
  factory _$MeetingFormCopyWith(_MeetingForm value, $Res Function(_MeetingForm) _then) = __$MeetingFormCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String mode, String meetPlace, String meetTime, int duration, bool isRecurring, bool isReportNeeded, String? platform, String? meetLink, double? coordX, double? coordY, String? recurrenceType, int? recurrence, String? reportDescription
});




}
/// @nodoc
class __$MeetingFormCopyWithImpl<$Res>
    implements _$MeetingFormCopyWith<$Res> {
  __$MeetingFormCopyWithImpl(this._self, this._then);

  final _MeetingForm _self;
  final $Res Function(_MeetingForm) _then;

/// Create a copy of MeetingForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? mode = null,Object? meetPlace = null,Object? meetTime = null,Object? duration = null,Object? isRecurring = null,Object? isReportNeeded = null,Object? platform = freezed,Object? meetLink = freezed,Object? coordX = freezed,Object? coordY = freezed,Object? recurrenceType = freezed,Object? recurrence = freezed,Object? reportDescription = freezed,}) {
  return _then(_MeetingForm(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,meetPlace: null == meetPlace ? _self.meetPlace : meetPlace // ignore: cast_nullable_to_non_nullable
as String,meetTime: null == meetTime ? _self.meetTime : meetTime // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,isReportNeeded: null == isReportNeeded ? _self.isReportNeeded : isReportNeeded // ignore: cast_nullable_to_non_nullable
as bool,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,meetLink: freezed == meetLink ? _self.meetLink : meetLink // ignore: cast_nullable_to_non_nullable
as String?,coordX: freezed == coordX ? _self.coordX : coordX // ignore: cast_nullable_to_non_nullable
as double?,coordY: freezed == coordY ? _self.coordY : coordY // ignore: cast_nullable_to_non_nullable
as double?,recurrenceType: freezed == recurrenceType ? _self.recurrenceType : recurrenceType // ignore: cast_nullable_to_non_nullable
as String?,recurrence: freezed == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as int?,reportDescription: freezed == reportDescription ? _self.reportDescription : reportDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
