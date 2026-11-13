// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_analytics_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MentorAnalyticsDto {

 Map<String, dynamic> get sessions; num get karmaEarned; num get hoursContributed; Map<String, dynamic> get rating;
/// Create a copy of MentorAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorAnalyticsDtoCopyWith<MentorAnalyticsDto> get copyWith => _$MentorAnalyticsDtoCopyWithImpl<MentorAnalyticsDto>(this as MentorAnalyticsDto, _$identity);

  /// Serializes this MentorAnalyticsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorAnalyticsDto&&const DeepCollectionEquality().equals(other.sessions, sessions)&&(identical(other.karmaEarned, karmaEarned) || other.karmaEarned == karmaEarned)&&(identical(other.hoursContributed, hoursContributed) || other.hoursContributed == hoursContributed)&&const DeepCollectionEquality().equals(other.rating, rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sessions),karmaEarned,hoursContributed,const DeepCollectionEquality().hash(rating));

@override
String toString() {
  return 'MentorAnalyticsDto(sessions: $sessions, karmaEarned: $karmaEarned, hoursContributed: $hoursContributed, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $MentorAnalyticsDtoCopyWith<$Res>  {
  factory $MentorAnalyticsDtoCopyWith(MentorAnalyticsDto value, $Res Function(MentorAnalyticsDto) _then) = _$MentorAnalyticsDtoCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> sessions, num karmaEarned, num hoursContributed, Map<String, dynamic> rating
});




}
/// @nodoc
class _$MentorAnalyticsDtoCopyWithImpl<$Res>
    implements $MentorAnalyticsDtoCopyWith<$Res> {
  _$MentorAnalyticsDtoCopyWithImpl(this._self, this._then);

  final MentorAnalyticsDto _self;
  final $Res Function(MentorAnalyticsDto) _then;

/// Create a copy of MentorAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessions = null,Object? karmaEarned = null,Object? hoursContributed = null,Object? rating = null,}) {
  return _then(_self.copyWith(
sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,karmaEarned: null == karmaEarned ? _self.karmaEarned : karmaEarned // ignore: cast_nullable_to_non_nullable
as num,hoursContributed: null == hoursContributed ? _self.hoursContributed : hoursContributed // ignore: cast_nullable_to_non_nullable
as num,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorAnalyticsDto].
extension MentorAnalyticsDtoPatterns on MentorAnalyticsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorAnalyticsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorAnalyticsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorAnalyticsDto value)  $default,){
final _that = this;
switch (_that) {
case _MentorAnalyticsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorAnalyticsDto value)?  $default,){
final _that = this;
switch (_that) {
case _MentorAnalyticsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> sessions,  num karmaEarned,  num hoursContributed,  Map<String, dynamic> rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorAnalyticsDto() when $default != null:
return $default(_that.sessions,_that.karmaEarned,_that.hoursContributed,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> sessions,  num karmaEarned,  num hoursContributed,  Map<String, dynamic> rating)  $default,) {final _that = this;
switch (_that) {
case _MentorAnalyticsDto():
return $default(_that.sessions,_that.karmaEarned,_that.hoursContributed,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> sessions,  num karmaEarned,  num hoursContributed,  Map<String, dynamic> rating)?  $default,) {final _that = this;
switch (_that) {
case _MentorAnalyticsDto() when $default != null:
return $default(_that.sessions,_that.karmaEarned,_that.hoursContributed,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MentorAnalyticsDto extends MentorAnalyticsDto {
  const _MentorAnalyticsDto({final  Map<String, dynamic> sessions = const <String, dynamic>{}, this.karmaEarned = 0, this.hoursContributed = 0, final  Map<String, dynamic> rating = const <String, dynamic>{}}): _sessions = sessions,_rating = rating,super._();
  factory _MentorAnalyticsDto.fromJson(Map<String, dynamic> json) => _$MentorAnalyticsDtoFromJson(json);

 final  Map<String, dynamic> _sessions;
@override@JsonKey() Map<String, dynamic> get sessions {
  if (_sessions is EqualUnmodifiableMapView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sessions);
}

@override@JsonKey() final  num karmaEarned;
@override@JsonKey() final  num hoursContributed;
 final  Map<String, dynamic> _rating;
@override@JsonKey() Map<String, dynamic> get rating {
  if (_rating is EqualUnmodifiableMapView) return _rating;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rating);
}


/// Create a copy of MentorAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorAnalyticsDtoCopyWith<_MentorAnalyticsDto> get copyWith => __$MentorAnalyticsDtoCopyWithImpl<_MentorAnalyticsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MentorAnalyticsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorAnalyticsDto&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&(identical(other.karmaEarned, karmaEarned) || other.karmaEarned == karmaEarned)&&(identical(other.hoursContributed, hoursContributed) || other.hoursContributed == hoursContributed)&&const DeepCollectionEquality().equals(other._rating, _rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sessions),karmaEarned,hoursContributed,const DeepCollectionEquality().hash(_rating));

@override
String toString() {
  return 'MentorAnalyticsDto(sessions: $sessions, karmaEarned: $karmaEarned, hoursContributed: $hoursContributed, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$MentorAnalyticsDtoCopyWith<$Res> implements $MentorAnalyticsDtoCopyWith<$Res> {
  factory _$MentorAnalyticsDtoCopyWith(_MentorAnalyticsDto value, $Res Function(_MentorAnalyticsDto) _then) = __$MentorAnalyticsDtoCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> sessions, num karmaEarned, num hoursContributed, Map<String, dynamic> rating
});




}
/// @nodoc
class __$MentorAnalyticsDtoCopyWithImpl<$Res>
    implements _$MentorAnalyticsDtoCopyWith<$Res> {
  __$MentorAnalyticsDtoCopyWithImpl(this._self, this._then);

  final _MentorAnalyticsDto _self;
  final $Res Function(_MentorAnalyticsDto) _then;

/// Create a copy of MentorAnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessions = null,Object? karmaEarned = null,Object? hoursContributed = null,Object? rating = null,}) {
  return _then(_MentorAnalyticsDto(
sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,karmaEarned: null == karmaEarned ? _self.karmaEarned : karmaEarned // ignore: cast_nullable_to_non_nullable
as num,hoursContributed: null == hoursContributed ? _self.hoursContributed : hoursContributed // ignore: cast_nullable_to_non_nullable
as num,rating: null == rating ? _self._rating : rating // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
