// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_progress_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AchievementProgressDto {

 String get achievementId; String get achievementName; bool get eligible; bool get claimed; String? get reason; Map<String, dynamic>? get progress;
/// Create a copy of AchievementProgressDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementProgressDtoCopyWith<AchievementProgressDto> get copyWith => _$AchievementProgressDtoCopyWithImpl<AchievementProgressDto>(this as AchievementProgressDto, _$identity);

  /// Serializes this AchievementProgressDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementProgressDto&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.achievementName, achievementName) || other.achievementName == achievementName)&&(identical(other.eligible, eligible) || other.eligible == eligible)&&(identical(other.claimed, claimed) || other.claimed == claimed)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.progress, progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,achievementId,achievementName,eligible,claimed,reason,const DeepCollectionEquality().hash(progress));

@override
String toString() {
  return 'AchievementProgressDto(achievementId: $achievementId, achievementName: $achievementName, eligible: $eligible, claimed: $claimed, reason: $reason, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $AchievementProgressDtoCopyWith<$Res>  {
  factory $AchievementProgressDtoCopyWith(AchievementProgressDto value, $Res Function(AchievementProgressDto) _then) = _$AchievementProgressDtoCopyWithImpl;
@useResult
$Res call({
 String achievementId, String achievementName, bool eligible, bool claimed, String? reason, Map<String, dynamic>? progress
});




}
/// @nodoc
class _$AchievementProgressDtoCopyWithImpl<$Res>
    implements $AchievementProgressDtoCopyWith<$Res> {
  _$AchievementProgressDtoCopyWithImpl(this._self, this._then);

  final AchievementProgressDto _self;
  final $Res Function(AchievementProgressDto) _then;

/// Create a copy of AchievementProgressDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? achievementId = null,Object? achievementName = null,Object? eligible = null,Object? claimed = null,Object? reason = freezed,Object? progress = freezed,}) {
  return _then(_self.copyWith(
achievementId: null == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String,achievementName: null == achievementName ? _self.achievementName : achievementName // ignore: cast_nullable_to_non_nullable
as String,eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementProgressDto].
extension AchievementProgressDtoPatterns on AchievementProgressDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementProgressDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementProgressDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementProgressDto value)  $default,){
final _that = this;
switch (_that) {
case _AchievementProgressDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementProgressDto value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementProgressDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String achievementId,  String achievementName,  bool eligible,  bool claimed,  String? reason,  Map<String, dynamic>? progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementProgressDto() when $default != null:
return $default(_that.achievementId,_that.achievementName,_that.eligible,_that.claimed,_that.reason,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String achievementId,  String achievementName,  bool eligible,  bool claimed,  String? reason,  Map<String, dynamic>? progress)  $default,) {final _that = this;
switch (_that) {
case _AchievementProgressDto():
return $default(_that.achievementId,_that.achievementName,_that.eligible,_that.claimed,_that.reason,_that.progress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String achievementId,  String achievementName,  bool eligible,  bool claimed,  String? reason,  Map<String, dynamic>? progress)?  $default,) {final _that = this;
switch (_that) {
case _AchievementProgressDto() when $default != null:
return $default(_that.achievementId,_that.achievementName,_that.eligible,_that.claimed,_that.reason,_that.progress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AchievementProgressDto extends AchievementProgressDto {
  const _AchievementProgressDto({required this.achievementId, this.achievementName = '', this.eligible = false, this.claimed = false, this.reason, final  Map<String, dynamic>? progress}): _progress = progress,super._();
  factory _AchievementProgressDto.fromJson(Map<String, dynamic> json) => _$AchievementProgressDtoFromJson(json);

@override final  String achievementId;
@override@JsonKey() final  String achievementName;
@override@JsonKey() final  bool eligible;
@override@JsonKey() final  bool claimed;
@override final  String? reason;
 final  Map<String, dynamic>? _progress;
@override Map<String, dynamic>? get progress {
  final value = _progress;
  if (value == null) return null;
  if (_progress is EqualUnmodifiableMapView) return _progress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AchievementProgressDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementProgressDtoCopyWith<_AchievementProgressDto> get copyWith => __$AchievementProgressDtoCopyWithImpl<_AchievementProgressDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchievementProgressDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementProgressDto&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.achievementName, achievementName) || other.achievementName == achievementName)&&(identical(other.eligible, eligible) || other.eligible == eligible)&&(identical(other.claimed, claimed) || other.claimed == claimed)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other._progress, _progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,achievementId,achievementName,eligible,claimed,reason,const DeepCollectionEquality().hash(_progress));

@override
String toString() {
  return 'AchievementProgressDto(achievementId: $achievementId, achievementName: $achievementName, eligible: $eligible, claimed: $claimed, reason: $reason, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$AchievementProgressDtoCopyWith<$Res> implements $AchievementProgressDtoCopyWith<$Res> {
  factory _$AchievementProgressDtoCopyWith(_AchievementProgressDto value, $Res Function(_AchievementProgressDto) _then) = __$AchievementProgressDtoCopyWithImpl;
@override @useResult
$Res call({
 String achievementId, String achievementName, bool eligible, bool claimed, String? reason, Map<String, dynamic>? progress
});




}
/// @nodoc
class __$AchievementProgressDtoCopyWithImpl<$Res>
    implements _$AchievementProgressDtoCopyWith<$Res> {
  __$AchievementProgressDtoCopyWithImpl(this._self, this._then);

  final _AchievementProgressDto _self;
  final $Res Function(_AchievementProgressDto) _then;

/// Create a copy of AchievementProgressDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? achievementId = null,Object? achievementName = null,Object? eligible = null,Object? claimed = null,Object? reason = freezed,Object? progress = freezed,}) {
  return _then(_AchievementProgressDto(
achievementId: null == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String,achievementName: null == achievementName ? _self.achievementName : achievementName // ignore: cast_nullable_to_non_nullable
as String,eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self._progress : progress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
