// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learner_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LearnerSummary {

 int get weeklyKarma; int get totalKarma; int get activeCircles; int get streakDays; NextMeeting? get nextMeeting;
/// Create a copy of LearnerSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnerSummaryCopyWith<LearnerSummary> get copyWith => _$LearnerSummaryCopyWithImpl<LearnerSummary>(this as LearnerSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnerSummary&&(identical(other.weeklyKarma, weeklyKarma) || other.weeklyKarma == weeklyKarma)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.activeCircles, activeCircles) || other.activeCircles == activeCircles)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.nextMeeting, nextMeeting) || other.nextMeeting == nextMeeting));
}


@override
int get hashCode => Object.hash(runtimeType,weeklyKarma,totalKarma,activeCircles,streakDays,nextMeeting);

@override
String toString() {
  return 'LearnerSummary(weeklyKarma: $weeklyKarma, totalKarma: $totalKarma, activeCircles: $activeCircles, streakDays: $streakDays, nextMeeting: $nextMeeting)';
}


}

/// @nodoc
abstract mixin class $LearnerSummaryCopyWith<$Res>  {
  factory $LearnerSummaryCopyWith(LearnerSummary value, $Res Function(LearnerSummary) _then) = _$LearnerSummaryCopyWithImpl;
@useResult
$Res call({
 int weeklyKarma, int totalKarma, int activeCircles, int streakDays, NextMeeting? nextMeeting
});


$NextMeetingCopyWith<$Res>? get nextMeeting;

}
/// @nodoc
class _$LearnerSummaryCopyWithImpl<$Res>
    implements $LearnerSummaryCopyWith<$Res> {
  _$LearnerSummaryCopyWithImpl(this._self, this._then);

  final LearnerSummary _self;
  final $Res Function(LearnerSummary) _then;

/// Create a copy of LearnerSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weeklyKarma = null,Object? totalKarma = null,Object? activeCircles = null,Object? streakDays = null,Object? nextMeeting = freezed,}) {
  return _then(_self.copyWith(
weeklyKarma: null == weeklyKarma ? _self.weeklyKarma : weeklyKarma // ignore: cast_nullable_to_non_nullable
as int,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as int,activeCircles: null == activeCircles ? _self.activeCircles : activeCircles // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,nextMeeting: freezed == nextMeeting ? _self.nextMeeting : nextMeeting // ignore: cast_nullable_to_non_nullable
as NextMeeting?,
  ));
}
/// Create a copy of LearnerSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NextMeetingCopyWith<$Res>? get nextMeeting {
    if (_self.nextMeeting == null) {
    return null;
  }

  return $NextMeetingCopyWith<$Res>(_self.nextMeeting!, (value) {
    return _then(_self.copyWith(nextMeeting: value));
  });
}
}


/// Adds pattern-matching-related methods to [LearnerSummary].
extension LearnerSummaryPatterns on LearnerSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearnerSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearnerSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearnerSummary value)  $default,){
final _that = this;
switch (_that) {
case _LearnerSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearnerSummary value)?  $default,){
final _that = this;
switch (_that) {
case _LearnerSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weeklyKarma,  int totalKarma,  int activeCircles,  int streakDays,  NextMeeting? nextMeeting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearnerSummary() when $default != null:
return $default(_that.weeklyKarma,_that.totalKarma,_that.activeCircles,_that.streakDays,_that.nextMeeting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weeklyKarma,  int totalKarma,  int activeCircles,  int streakDays,  NextMeeting? nextMeeting)  $default,) {final _that = this;
switch (_that) {
case _LearnerSummary():
return $default(_that.weeklyKarma,_that.totalKarma,_that.activeCircles,_that.streakDays,_that.nextMeeting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weeklyKarma,  int totalKarma,  int activeCircles,  int streakDays,  NextMeeting? nextMeeting)?  $default,) {final _that = this;
switch (_that) {
case _LearnerSummary() when $default != null:
return $default(_that.weeklyKarma,_that.totalKarma,_that.activeCircles,_that.streakDays,_that.nextMeeting);case _:
  return null;

}
}

}

/// @nodoc


class _LearnerSummary implements LearnerSummary {
  const _LearnerSummary({required this.weeklyKarma, required this.totalKarma, required this.activeCircles, required this.streakDays, this.nextMeeting});
  

@override final  int weeklyKarma;
@override final  int totalKarma;
@override final  int activeCircles;
@override final  int streakDays;
@override final  NextMeeting? nextMeeting;

/// Create a copy of LearnerSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearnerSummaryCopyWith<_LearnerSummary> get copyWith => __$LearnerSummaryCopyWithImpl<_LearnerSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearnerSummary&&(identical(other.weeklyKarma, weeklyKarma) || other.weeklyKarma == weeklyKarma)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.activeCircles, activeCircles) || other.activeCircles == activeCircles)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.nextMeeting, nextMeeting) || other.nextMeeting == nextMeeting));
}


@override
int get hashCode => Object.hash(runtimeType,weeklyKarma,totalKarma,activeCircles,streakDays,nextMeeting);

@override
String toString() {
  return 'LearnerSummary(weeklyKarma: $weeklyKarma, totalKarma: $totalKarma, activeCircles: $activeCircles, streakDays: $streakDays, nextMeeting: $nextMeeting)';
}


}

/// @nodoc
abstract mixin class _$LearnerSummaryCopyWith<$Res> implements $LearnerSummaryCopyWith<$Res> {
  factory _$LearnerSummaryCopyWith(_LearnerSummary value, $Res Function(_LearnerSummary) _then) = __$LearnerSummaryCopyWithImpl;
@override @useResult
$Res call({
 int weeklyKarma, int totalKarma, int activeCircles, int streakDays, NextMeeting? nextMeeting
});


@override $NextMeetingCopyWith<$Res>? get nextMeeting;

}
/// @nodoc
class __$LearnerSummaryCopyWithImpl<$Res>
    implements _$LearnerSummaryCopyWith<$Res> {
  __$LearnerSummaryCopyWithImpl(this._self, this._then);

  final _LearnerSummary _self;
  final $Res Function(_LearnerSummary) _then;

/// Create a copy of LearnerSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weeklyKarma = null,Object? totalKarma = null,Object? activeCircles = null,Object? streakDays = null,Object? nextMeeting = freezed,}) {
  return _then(_LearnerSummary(
weeklyKarma: null == weeklyKarma ? _self.weeklyKarma : weeklyKarma // ignore: cast_nullable_to_non_nullable
as int,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as int,activeCircles: null == activeCircles ? _self.activeCircles : activeCircles // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,nextMeeting: freezed == nextMeeting ? _self.nextMeeting : nextMeeting // ignore: cast_nullable_to_non_nullable
as NextMeeting?,
  ));
}

/// Create a copy of LearnerSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NextMeetingCopyWith<$Res>? get nextMeeting {
    if (_self.nextMeeting == null) {
    return null;
  }

  return $NextMeetingCopyWith<$Res>(_self.nextMeeting!, (value) {
    return _then(_self.copyWith(nextMeeting: value));
  });
}
}

/// @nodoc
mixin _$NextMeeting {

 String get id; String get circleId; String get circleName; String get title; DateTime get startsAt; int? get durationMinutes; String? get rsvpStatus;
/// Create a copy of NextMeeting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NextMeetingCopyWith<NextMeeting> get copyWith => _$NextMeetingCopyWithImpl<NextMeeting>(this as NextMeeting, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NextMeeting&&(identical(other.id, id) || other.id == id)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleName, circleName) || other.circleName == circleName)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.rsvpStatus, rsvpStatus) || other.rsvpStatus == rsvpStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,circleId,circleName,title,startsAt,durationMinutes,rsvpStatus);

@override
String toString() {
  return 'NextMeeting(id: $id, circleId: $circleId, circleName: $circleName, title: $title, startsAt: $startsAt, durationMinutes: $durationMinutes, rsvpStatus: $rsvpStatus)';
}


}

/// @nodoc
abstract mixin class $NextMeetingCopyWith<$Res>  {
  factory $NextMeetingCopyWith(NextMeeting value, $Res Function(NextMeeting) _then) = _$NextMeetingCopyWithImpl;
@useResult
$Res call({
 String id, String circleId, String circleName, String title, DateTime startsAt, int? durationMinutes, String? rsvpStatus
});




}
/// @nodoc
class _$NextMeetingCopyWithImpl<$Res>
    implements $NextMeetingCopyWith<$Res> {
  _$NextMeetingCopyWithImpl(this._self, this._then);

  final NextMeeting _self;
  final $Res Function(NextMeeting) _then;

/// Create a copy of NextMeeting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? circleId = null,Object? circleName = null,Object? title = null,Object? startsAt = null,Object? durationMinutes = freezed,Object? rsvpStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,circleName: null == circleName ? _self.circleName : circleName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,rsvpStatus: freezed == rsvpStatus ? _self.rsvpStatus : rsvpStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NextMeeting].
extension NextMeetingPatterns on NextMeeting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NextMeeting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NextMeeting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NextMeeting value)  $default,){
final _that = this;
switch (_that) {
case _NextMeeting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NextMeeting value)?  $default,){
final _that = this;
switch (_that) {
case _NextMeeting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String circleId,  String circleName,  String title,  DateTime startsAt,  int? durationMinutes,  String? rsvpStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NextMeeting() when $default != null:
return $default(_that.id,_that.circleId,_that.circleName,_that.title,_that.startsAt,_that.durationMinutes,_that.rsvpStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String circleId,  String circleName,  String title,  DateTime startsAt,  int? durationMinutes,  String? rsvpStatus)  $default,) {final _that = this;
switch (_that) {
case _NextMeeting():
return $default(_that.id,_that.circleId,_that.circleName,_that.title,_that.startsAt,_that.durationMinutes,_that.rsvpStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String circleId,  String circleName,  String title,  DateTime startsAt,  int? durationMinutes,  String? rsvpStatus)?  $default,) {final _that = this;
switch (_that) {
case _NextMeeting() when $default != null:
return $default(_that.id,_that.circleId,_that.circleName,_that.title,_that.startsAt,_that.durationMinutes,_that.rsvpStatus);case _:
  return null;

}
}

}

/// @nodoc


class _NextMeeting implements NextMeeting {
  const _NextMeeting({required this.id, required this.circleId, required this.circleName, required this.title, required this.startsAt, this.durationMinutes, this.rsvpStatus});
  

@override final  String id;
@override final  String circleId;
@override final  String circleName;
@override final  String title;
@override final  DateTime startsAt;
@override final  int? durationMinutes;
@override final  String? rsvpStatus;

/// Create a copy of NextMeeting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NextMeetingCopyWith<_NextMeeting> get copyWith => __$NextMeetingCopyWithImpl<_NextMeeting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextMeeting&&(identical(other.id, id) || other.id == id)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleName, circleName) || other.circleName == circleName)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.rsvpStatus, rsvpStatus) || other.rsvpStatus == rsvpStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,circleId,circleName,title,startsAt,durationMinutes,rsvpStatus);

@override
String toString() {
  return 'NextMeeting(id: $id, circleId: $circleId, circleName: $circleName, title: $title, startsAt: $startsAt, durationMinutes: $durationMinutes, rsvpStatus: $rsvpStatus)';
}


}

/// @nodoc
abstract mixin class _$NextMeetingCopyWith<$Res> implements $NextMeetingCopyWith<$Res> {
  factory _$NextMeetingCopyWith(_NextMeeting value, $Res Function(_NextMeeting) _then) = __$NextMeetingCopyWithImpl;
@override @useResult
$Res call({
 String id, String circleId, String circleName, String title, DateTime startsAt, int? durationMinutes, String? rsvpStatus
});




}
/// @nodoc
class __$NextMeetingCopyWithImpl<$Res>
    implements _$NextMeetingCopyWith<$Res> {
  __$NextMeetingCopyWithImpl(this._self, this._then);

  final _NextMeeting _self;
  final $Res Function(_NextMeeting) _then;

/// Create a copy of NextMeeting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? circleId = null,Object? circleName = null,Object? title = null,Object? startsAt = null,Object? durationMinutes = freezed,Object? rsvpStatus = freezed,}) {
  return _then(_NextMeeting(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,circleName: null == circleName ? _self.circleName : circleName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,rsvpStatus: freezed == rsvpStatus ? _self.rsvpStatus : rsvpStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
