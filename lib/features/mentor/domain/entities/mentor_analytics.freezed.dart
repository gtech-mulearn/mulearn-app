// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MentorAnalytics {

 int get sessionsTotal; int get sessionsCompleted; int get sessionsUpcoming; int get sessionsCancelled; num get karmaEarned; num get hoursContributed; int get ratingCount; double? get ratingAverage;
/// Create a copy of MentorAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorAnalyticsCopyWith<MentorAnalytics> get copyWith => _$MentorAnalyticsCopyWithImpl<MentorAnalytics>(this as MentorAnalytics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorAnalytics&&(identical(other.sessionsTotal, sessionsTotal) || other.sessionsTotal == sessionsTotal)&&(identical(other.sessionsCompleted, sessionsCompleted) || other.sessionsCompleted == sessionsCompleted)&&(identical(other.sessionsUpcoming, sessionsUpcoming) || other.sessionsUpcoming == sessionsUpcoming)&&(identical(other.sessionsCancelled, sessionsCancelled) || other.sessionsCancelled == sessionsCancelled)&&(identical(other.karmaEarned, karmaEarned) || other.karmaEarned == karmaEarned)&&(identical(other.hoursContributed, hoursContributed) || other.hoursContributed == hoursContributed)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage));
}


@override
int get hashCode => Object.hash(runtimeType,sessionsTotal,sessionsCompleted,sessionsUpcoming,sessionsCancelled,karmaEarned,hoursContributed,ratingCount,ratingAverage);

@override
String toString() {
  return 'MentorAnalytics(sessionsTotal: $sessionsTotal, sessionsCompleted: $sessionsCompleted, sessionsUpcoming: $sessionsUpcoming, sessionsCancelled: $sessionsCancelled, karmaEarned: $karmaEarned, hoursContributed: $hoursContributed, ratingCount: $ratingCount, ratingAverage: $ratingAverage)';
}


}

/// @nodoc
abstract mixin class $MentorAnalyticsCopyWith<$Res>  {
  factory $MentorAnalyticsCopyWith(MentorAnalytics value, $Res Function(MentorAnalytics) _then) = _$MentorAnalyticsCopyWithImpl;
@useResult
$Res call({
 int sessionsTotal, int sessionsCompleted, int sessionsUpcoming, int sessionsCancelled, num karmaEarned, num hoursContributed, int ratingCount, double? ratingAverage
});




}
/// @nodoc
class _$MentorAnalyticsCopyWithImpl<$Res>
    implements $MentorAnalyticsCopyWith<$Res> {
  _$MentorAnalyticsCopyWithImpl(this._self, this._then);

  final MentorAnalytics _self;
  final $Res Function(MentorAnalytics) _then;

/// Create a copy of MentorAnalytics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionsTotal = null,Object? sessionsCompleted = null,Object? sessionsUpcoming = null,Object? sessionsCancelled = null,Object? karmaEarned = null,Object? hoursContributed = null,Object? ratingCount = null,Object? ratingAverage = freezed,}) {
  return _then(_self.copyWith(
sessionsTotal: null == sessionsTotal ? _self.sessionsTotal : sessionsTotal // ignore: cast_nullable_to_non_nullable
as int,sessionsCompleted: null == sessionsCompleted ? _self.sessionsCompleted : sessionsCompleted // ignore: cast_nullable_to_non_nullable
as int,sessionsUpcoming: null == sessionsUpcoming ? _self.sessionsUpcoming : sessionsUpcoming // ignore: cast_nullable_to_non_nullable
as int,sessionsCancelled: null == sessionsCancelled ? _self.sessionsCancelled : sessionsCancelled // ignore: cast_nullable_to_non_nullable
as int,karmaEarned: null == karmaEarned ? _self.karmaEarned : karmaEarned // ignore: cast_nullable_to_non_nullable
as num,hoursContributed: null == hoursContributed ? _self.hoursContributed : hoursContributed // ignore: cast_nullable_to_non_nullable
as num,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,ratingAverage: freezed == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorAnalytics].
extension MentorAnalyticsPatterns on MentorAnalytics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorAnalytics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _MentorAnalytics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _MentorAnalytics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionsTotal,  int sessionsCompleted,  int sessionsUpcoming,  int sessionsCancelled,  num karmaEarned,  num hoursContributed,  int ratingCount,  double? ratingAverage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorAnalytics() when $default != null:
return $default(_that.sessionsTotal,_that.sessionsCompleted,_that.sessionsUpcoming,_that.sessionsCancelled,_that.karmaEarned,_that.hoursContributed,_that.ratingCount,_that.ratingAverage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionsTotal,  int sessionsCompleted,  int sessionsUpcoming,  int sessionsCancelled,  num karmaEarned,  num hoursContributed,  int ratingCount,  double? ratingAverage)  $default,) {final _that = this;
switch (_that) {
case _MentorAnalytics():
return $default(_that.sessionsTotal,_that.sessionsCompleted,_that.sessionsUpcoming,_that.sessionsCancelled,_that.karmaEarned,_that.hoursContributed,_that.ratingCount,_that.ratingAverage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionsTotal,  int sessionsCompleted,  int sessionsUpcoming,  int sessionsCancelled,  num karmaEarned,  num hoursContributed,  int ratingCount,  double? ratingAverage)?  $default,) {final _that = this;
switch (_that) {
case _MentorAnalytics() when $default != null:
return $default(_that.sessionsTotal,_that.sessionsCompleted,_that.sessionsUpcoming,_that.sessionsCancelled,_that.karmaEarned,_that.hoursContributed,_that.ratingCount,_that.ratingAverage);case _:
  return null;

}
}

}

/// @nodoc


class _MentorAnalytics implements MentorAnalytics {
  const _MentorAnalytics({required this.sessionsTotal, required this.sessionsCompleted, required this.sessionsUpcoming, required this.sessionsCancelled, required this.karmaEarned, required this.hoursContributed, required this.ratingCount, this.ratingAverage});
  

@override final  int sessionsTotal;
@override final  int sessionsCompleted;
@override final  int sessionsUpcoming;
@override final  int sessionsCancelled;
@override final  num karmaEarned;
@override final  num hoursContributed;
@override final  int ratingCount;
@override final  double? ratingAverage;

/// Create a copy of MentorAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorAnalyticsCopyWith<_MentorAnalytics> get copyWith => __$MentorAnalyticsCopyWithImpl<_MentorAnalytics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorAnalytics&&(identical(other.sessionsTotal, sessionsTotal) || other.sessionsTotal == sessionsTotal)&&(identical(other.sessionsCompleted, sessionsCompleted) || other.sessionsCompleted == sessionsCompleted)&&(identical(other.sessionsUpcoming, sessionsUpcoming) || other.sessionsUpcoming == sessionsUpcoming)&&(identical(other.sessionsCancelled, sessionsCancelled) || other.sessionsCancelled == sessionsCancelled)&&(identical(other.karmaEarned, karmaEarned) || other.karmaEarned == karmaEarned)&&(identical(other.hoursContributed, hoursContributed) || other.hoursContributed == hoursContributed)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.ratingAverage, ratingAverage) || other.ratingAverage == ratingAverage));
}


@override
int get hashCode => Object.hash(runtimeType,sessionsTotal,sessionsCompleted,sessionsUpcoming,sessionsCancelled,karmaEarned,hoursContributed,ratingCount,ratingAverage);

@override
String toString() {
  return 'MentorAnalytics(sessionsTotal: $sessionsTotal, sessionsCompleted: $sessionsCompleted, sessionsUpcoming: $sessionsUpcoming, sessionsCancelled: $sessionsCancelled, karmaEarned: $karmaEarned, hoursContributed: $hoursContributed, ratingCount: $ratingCount, ratingAverage: $ratingAverage)';
}


}

/// @nodoc
abstract mixin class _$MentorAnalyticsCopyWith<$Res> implements $MentorAnalyticsCopyWith<$Res> {
  factory _$MentorAnalyticsCopyWith(_MentorAnalytics value, $Res Function(_MentorAnalytics) _then) = __$MentorAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 int sessionsTotal, int sessionsCompleted, int sessionsUpcoming, int sessionsCancelled, num karmaEarned, num hoursContributed, int ratingCount, double? ratingAverage
});




}
/// @nodoc
class __$MentorAnalyticsCopyWithImpl<$Res>
    implements _$MentorAnalyticsCopyWith<$Res> {
  __$MentorAnalyticsCopyWithImpl(this._self, this._then);

  final _MentorAnalytics _self;
  final $Res Function(_MentorAnalytics) _then;

/// Create a copy of MentorAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionsTotal = null,Object? sessionsCompleted = null,Object? sessionsUpcoming = null,Object? sessionsCancelled = null,Object? karmaEarned = null,Object? hoursContributed = null,Object? ratingCount = null,Object? ratingAverage = freezed,}) {
  return _then(_MentorAnalytics(
sessionsTotal: null == sessionsTotal ? _self.sessionsTotal : sessionsTotal // ignore: cast_nullable_to_non_nullable
as int,sessionsCompleted: null == sessionsCompleted ? _self.sessionsCompleted : sessionsCompleted // ignore: cast_nullable_to_non_nullable
as int,sessionsUpcoming: null == sessionsUpcoming ? _self.sessionsUpcoming : sessionsUpcoming // ignore: cast_nullable_to_non_nullable
as int,sessionsCancelled: null == sessionsCancelled ? _self.sessionsCancelled : sessionsCancelled // ignore: cast_nullable_to_non_nullable
as int,karmaEarned: null == karmaEarned ? _self.karmaEarned : karmaEarned // ignore: cast_nullable_to_non_nullable
as num,hoursContributed: null == hoursContributed ? _self.hoursContributed : hoursContributed // ignore: cast_nullable_to_non_nullable
as num,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,ratingAverage: freezed == ratingAverage ? _self.ratingAverage : ratingAverage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
