// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learner_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LearnerSummaryDto {

 LearnerStatsDto get stats; NextMeetingDto? get nextMeeting;
/// Create a copy of LearnerSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnerSummaryDtoCopyWith<LearnerSummaryDto> get copyWith => _$LearnerSummaryDtoCopyWithImpl<LearnerSummaryDto>(this as LearnerSummaryDto, _$identity);

  /// Serializes this LearnerSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnerSummaryDto&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.nextMeeting, nextMeeting) || other.nextMeeting == nextMeeting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stats,nextMeeting);

@override
String toString() {
  return 'LearnerSummaryDto(stats: $stats, nextMeeting: $nextMeeting)';
}


}

/// @nodoc
abstract mixin class $LearnerSummaryDtoCopyWith<$Res>  {
  factory $LearnerSummaryDtoCopyWith(LearnerSummaryDto value, $Res Function(LearnerSummaryDto) _then) = _$LearnerSummaryDtoCopyWithImpl;
@useResult
$Res call({
 LearnerStatsDto stats, NextMeetingDto? nextMeeting
});


$LearnerStatsDtoCopyWith<$Res> get stats;$NextMeetingDtoCopyWith<$Res>? get nextMeeting;

}
/// @nodoc
class _$LearnerSummaryDtoCopyWithImpl<$Res>
    implements $LearnerSummaryDtoCopyWith<$Res> {
  _$LearnerSummaryDtoCopyWithImpl(this._self, this._then);

  final LearnerSummaryDto _self;
  final $Res Function(LearnerSummaryDto) _then;

/// Create a copy of LearnerSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stats = null,Object? nextMeeting = freezed,}) {
  return _then(_self.copyWith(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as LearnerStatsDto,nextMeeting: freezed == nextMeeting ? _self.nextMeeting : nextMeeting // ignore: cast_nullable_to_non_nullable
as NextMeetingDto?,
  ));
}
/// Create a copy of LearnerSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LearnerStatsDtoCopyWith<$Res> get stats {
  
  return $LearnerStatsDtoCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of LearnerSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NextMeetingDtoCopyWith<$Res>? get nextMeeting {
    if (_self.nextMeeting == null) {
    return null;
  }

  return $NextMeetingDtoCopyWith<$Res>(_self.nextMeeting!, (value) {
    return _then(_self.copyWith(nextMeeting: value));
  });
}
}


/// Adds pattern-matching-related methods to [LearnerSummaryDto].
extension LearnerSummaryDtoPatterns on LearnerSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearnerSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearnerSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearnerSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _LearnerSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearnerSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _LearnerSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LearnerStatsDto stats,  NextMeetingDto? nextMeeting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearnerSummaryDto() when $default != null:
return $default(_that.stats,_that.nextMeeting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LearnerStatsDto stats,  NextMeetingDto? nextMeeting)  $default,) {final _that = this;
switch (_that) {
case _LearnerSummaryDto():
return $default(_that.stats,_that.nextMeeting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LearnerStatsDto stats,  NextMeetingDto? nextMeeting)?  $default,) {final _that = this;
switch (_that) {
case _LearnerSummaryDto() when $default != null:
return $default(_that.stats,_that.nextMeeting);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LearnerSummaryDto extends LearnerSummaryDto {
  const _LearnerSummaryDto({required this.stats, this.nextMeeting}): super._();
  factory _LearnerSummaryDto.fromJson(Map<String, dynamic> json) => _$LearnerSummaryDtoFromJson(json);

@override final  LearnerStatsDto stats;
@override final  NextMeetingDto? nextMeeting;

/// Create a copy of LearnerSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearnerSummaryDtoCopyWith<_LearnerSummaryDto> get copyWith => __$LearnerSummaryDtoCopyWithImpl<_LearnerSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearnerSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearnerSummaryDto&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.nextMeeting, nextMeeting) || other.nextMeeting == nextMeeting));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stats,nextMeeting);

@override
String toString() {
  return 'LearnerSummaryDto(stats: $stats, nextMeeting: $nextMeeting)';
}


}

/// @nodoc
abstract mixin class _$LearnerSummaryDtoCopyWith<$Res> implements $LearnerSummaryDtoCopyWith<$Res> {
  factory _$LearnerSummaryDtoCopyWith(_LearnerSummaryDto value, $Res Function(_LearnerSummaryDto) _then) = __$LearnerSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 LearnerStatsDto stats, NextMeetingDto? nextMeeting
});


@override $LearnerStatsDtoCopyWith<$Res> get stats;@override $NextMeetingDtoCopyWith<$Res>? get nextMeeting;

}
/// @nodoc
class __$LearnerSummaryDtoCopyWithImpl<$Res>
    implements _$LearnerSummaryDtoCopyWith<$Res> {
  __$LearnerSummaryDtoCopyWithImpl(this._self, this._then);

  final _LearnerSummaryDto _self;
  final $Res Function(_LearnerSummaryDto) _then;

/// Create a copy of LearnerSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stats = null,Object? nextMeeting = freezed,}) {
  return _then(_LearnerSummaryDto(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as LearnerStatsDto,nextMeeting: freezed == nextMeeting ? _self.nextMeeting : nextMeeting // ignore: cast_nullable_to_non_nullable
as NextMeetingDto?,
  ));
}

/// Create a copy of LearnerSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LearnerStatsDtoCopyWith<$Res> get stats {
  
  return $LearnerStatsDtoCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of LearnerSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NextMeetingDtoCopyWith<$Res>? get nextMeeting {
    if (_self.nextMeeting == null) {
    return null;
  }

  return $NextMeetingDtoCopyWith<$Res>(_self.nextMeeting!, (value) {
    return _then(_self.copyWith(nextMeeting: value));
  });
}
}


/// @nodoc
mixin _$LearnerStatsDto {

 num get weeklyKarma; num get totalKarma; num get activeCircles; num get streakDays;
/// Create a copy of LearnerStatsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnerStatsDtoCopyWith<LearnerStatsDto> get copyWith => _$LearnerStatsDtoCopyWithImpl<LearnerStatsDto>(this as LearnerStatsDto, _$identity);

  /// Serializes this LearnerStatsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnerStatsDto&&(identical(other.weeklyKarma, weeklyKarma) || other.weeklyKarma == weeklyKarma)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.activeCircles, activeCircles) || other.activeCircles == activeCircles)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weeklyKarma,totalKarma,activeCircles,streakDays);

@override
String toString() {
  return 'LearnerStatsDto(weeklyKarma: $weeklyKarma, totalKarma: $totalKarma, activeCircles: $activeCircles, streakDays: $streakDays)';
}


}

/// @nodoc
abstract mixin class $LearnerStatsDtoCopyWith<$Res>  {
  factory $LearnerStatsDtoCopyWith(LearnerStatsDto value, $Res Function(LearnerStatsDto) _then) = _$LearnerStatsDtoCopyWithImpl;
@useResult
$Res call({
 num weeklyKarma, num totalKarma, num activeCircles, num streakDays
});




}
/// @nodoc
class _$LearnerStatsDtoCopyWithImpl<$Res>
    implements $LearnerStatsDtoCopyWith<$Res> {
  _$LearnerStatsDtoCopyWithImpl(this._self, this._then);

  final LearnerStatsDto _self;
  final $Res Function(LearnerStatsDto) _then;

/// Create a copy of LearnerStatsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weeklyKarma = null,Object? totalKarma = null,Object? activeCircles = null,Object? streakDays = null,}) {
  return _then(_self.copyWith(
weeklyKarma: null == weeklyKarma ? _self.weeklyKarma : weeklyKarma // ignore: cast_nullable_to_non_nullable
as num,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as num,activeCircles: null == activeCircles ? _self.activeCircles : activeCircles // ignore: cast_nullable_to_non_nullable
as num,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [LearnerStatsDto].
extension LearnerStatsDtoPatterns on LearnerStatsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearnerStatsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearnerStatsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearnerStatsDto value)  $default,){
final _that = this;
switch (_that) {
case _LearnerStatsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearnerStatsDto value)?  $default,){
final _that = this;
switch (_that) {
case _LearnerStatsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num weeklyKarma,  num totalKarma,  num activeCircles,  num streakDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearnerStatsDto() when $default != null:
return $default(_that.weeklyKarma,_that.totalKarma,_that.activeCircles,_that.streakDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num weeklyKarma,  num totalKarma,  num activeCircles,  num streakDays)  $default,) {final _that = this;
switch (_that) {
case _LearnerStatsDto():
return $default(_that.weeklyKarma,_that.totalKarma,_that.activeCircles,_that.streakDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num weeklyKarma,  num totalKarma,  num activeCircles,  num streakDays)?  $default,) {final _that = this;
switch (_that) {
case _LearnerStatsDto() when $default != null:
return $default(_that.weeklyKarma,_that.totalKarma,_that.activeCircles,_that.streakDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LearnerStatsDto implements LearnerStatsDto {
  const _LearnerStatsDto({this.weeklyKarma = 0, this.totalKarma = 0, this.activeCircles = 0, this.streakDays = 0});
  factory _LearnerStatsDto.fromJson(Map<String, dynamic> json) => _$LearnerStatsDtoFromJson(json);

@override@JsonKey() final  num weeklyKarma;
@override@JsonKey() final  num totalKarma;
@override@JsonKey() final  num activeCircles;
@override@JsonKey() final  num streakDays;

/// Create a copy of LearnerStatsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearnerStatsDtoCopyWith<_LearnerStatsDto> get copyWith => __$LearnerStatsDtoCopyWithImpl<_LearnerStatsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearnerStatsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearnerStatsDto&&(identical(other.weeklyKarma, weeklyKarma) || other.weeklyKarma == weeklyKarma)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.activeCircles, activeCircles) || other.activeCircles == activeCircles)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weeklyKarma,totalKarma,activeCircles,streakDays);

@override
String toString() {
  return 'LearnerStatsDto(weeklyKarma: $weeklyKarma, totalKarma: $totalKarma, activeCircles: $activeCircles, streakDays: $streakDays)';
}


}

/// @nodoc
abstract mixin class _$LearnerStatsDtoCopyWith<$Res> implements $LearnerStatsDtoCopyWith<$Res> {
  factory _$LearnerStatsDtoCopyWith(_LearnerStatsDto value, $Res Function(_LearnerStatsDto) _then) = __$LearnerStatsDtoCopyWithImpl;
@override @useResult
$Res call({
 num weeklyKarma, num totalKarma, num activeCircles, num streakDays
});




}
/// @nodoc
class __$LearnerStatsDtoCopyWithImpl<$Res>
    implements _$LearnerStatsDtoCopyWith<$Res> {
  __$LearnerStatsDtoCopyWithImpl(this._self, this._then);

  final _LearnerStatsDto _self;
  final $Res Function(_LearnerStatsDto) _then;

/// Create a copy of LearnerStatsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weeklyKarma = null,Object? totalKarma = null,Object? activeCircles = null,Object? streakDays = null,}) {
  return _then(_LearnerStatsDto(
weeklyKarma: null == weeklyKarma ? _self.weeklyKarma : weeklyKarma // ignore: cast_nullable_to_non_nullable
as num,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as num,activeCircles: null == activeCircles ? _self.activeCircles : activeCircles // ignore: cast_nullable_to_non_nullable
as num,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$NextMeetingDto {

 String get id; String get circleId; String get startsAt; String get circleName; String get title; num? get durationMinutes; String? get rsvpStatus;
/// Create a copy of NextMeetingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NextMeetingDtoCopyWith<NextMeetingDto> get copyWith => _$NextMeetingDtoCopyWithImpl<NextMeetingDto>(this as NextMeetingDto, _$identity);

  /// Serializes this NextMeetingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NextMeetingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.circleName, circleName) || other.circleName == circleName)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.rsvpStatus, rsvpStatus) || other.rsvpStatus == rsvpStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,circleId,startsAt,circleName,title,durationMinutes,rsvpStatus);

@override
String toString() {
  return 'NextMeetingDto(id: $id, circleId: $circleId, startsAt: $startsAt, circleName: $circleName, title: $title, durationMinutes: $durationMinutes, rsvpStatus: $rsvpStatus)';
}


}

/// @nodoc
abstract mixin class $NextMeetingDtoCopyWith<$Res>  {
  factory $NextMeetingDtoCopyWith(NextMeetingDto value, $Res Function(NextMeetingDto) _then) = _$NextMeetingDtoCopyWithImpl;
@useResult
$Res call({
 String id, String circleId, String startsAt, String circleName, String title, num? durationMinutes, String? rsvpStatus
});




}
/// @nodoc
class _$NextMeetingDtoCopyWithImpl<$Res>
    implements $NextMeetingDtoCopyWith<$Res> {
  _$NextMeetingDtoCopyWithImpl(this._self, this._then);

  final NextMeetingDto _self;
  final $Res Function(NextMeetingDto) _then;

/// Create a copy of NextMeetingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? circleId = null,Object? startsAt = null,Object? circleName = null,Object? title = null,Object? durationMinutes = freezed,Object? rsvpStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,circleName: null == circleName ? _self.circleName : circleName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as num?,rsvpStatus: freezed == rsvpStatus ? _self.rsvpStatus : rsvpStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NextMeetingDto].
extension NextMeetingDtoPatterns on NextMeetingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NextMeetingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NextMeetingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NextMeetingDto value)  $default,){
final _that = this;
switch (_that) {
case _NextMeetingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NextMeetingDto value)?  $default,){
final _that = this;
switch (_that) {
case _NextMeetingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String circleId,  String startsAt,  String circleName,  String title,  num? durationMinutes,  String? rsvpStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NextMeetingDto() when $default != null:
return $default(_that.id,_that.circleId,_that.startsAt,_that.circleName,_that.title,_that.durationMinutes,_that.rsvpStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String circleId,  String startsAt,  String circleName,  String title,  num? durationMinutes,  String? rsvpStatus)  $default,) {final _that = this;
switch (_that) {
case _NextMeetingDto():
return $default(_that.id,_that.circleId,_that.startsAt,_that.circleName,_that.title,_that.durationMinutes,_that.rsvpStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String circleId,  String startsAt,  String circleName,  String title,  num? durationMinutes,  String? rsvpStatus)?  $default,) {final _that = this;
switch (_that) {
case _NextMeetingDto() when $default != null:
return $default(_that.id,_that.circleId,_that.startsAt,_that.circleName,_that.title,_that.durationMinutes,_that.rsvpStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NextMeetingDto extends NextMeetingDto {
  const _NextMeetingDto({required this.id, required this.circleId, required this.startsAt, this.circleName = '', this.title = '', this.durationMinutes, this.rsvpStatus}): super._();
  factory _NextMeetingDto.fromJson(Map<String, dynamic> json) => _$NextMeetingDtoFromJson(json);

@override final  String id;
@override final  String circleId;
@override final  String startsAt;
@override@JsonKey() final  String circleName;
@override@JsonKey() final  String title;
@override final  num? durationMinutes;
@override final  String? rsvpStatus;

/// Create a copy of NextMeetingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NextMeetingDtoCopyWith<_NextMeetingDto> get copyWith => __$NextMeetingDtoCopyWithImpl<_NextMeetingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NextMeetingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextMeetingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.circleName, circleName) || other.circleName == circleName)&&(identical(other.title, title) || other.title == title)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.rsvpStatus, rsvpStatus) || other.rsvpStatus == rsvpStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,circleId,startsAt,circleName,title,durationMinutes,rsvpStatus);

@override
String toString() {
  return 'NextMeetingDto(id: $id, circleId: $circleId, startsAt: $startsAt, circleName: $circleName, title: $title, durationMinutes: $durationMinutes, rsvpStatus: $rsvpStatus)';
}


}

/// @nodoc
abstract mixin class _$NextMeetingDtoCopyWith<$Res> implements $NextMeetingDtoCopyWith<$Res> {
  factory _$NextMeetingDtoCopyWith(_NextMeetingDto value, $Res Function(_NextMeetingDto) _then) = __$NextMeetingDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String circleId, String startsAt, String circleName, String title, num? durationMinutes, String? rsvpStatus
});




}
/// @nodoc
class __$NextMeetingDtoCopyWithImpl<$Res>
    implements _$NextMeetingDtoCopyWith<$Res> {
  __$NextMeetingDtoCopyWithImpl(this._self, this._then);

  final _NextMeetingDto _self;
  final $Res Function(_NextMeetingDto) _then;

/// Create a copy of NextMeetingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? circleId = null,Object? startsAt = null,Object? circleName = null,Object? title = null,Object? durationMinutes = freezed,Object? rsvpStatus = freezed,}) {
  return _then(_NextMeetingDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,circleName: null == circleName ? _self.circleName : circleName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as num?,rsvpStatus: freezed == rsvpStatus ? _self.rsvpStatus : rsvpStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
