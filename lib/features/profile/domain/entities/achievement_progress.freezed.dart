// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AchievementProgress {

 String get achievementId; String get name; bool get eligible; bool get claimed;/// e.g. "total_karma: 0/500".
 String? get reason; num? get current; num? get required;/// 0–100.
 int? get percentage;
/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementProgressCopyWith<AchievementProgress> get copyWith => _$AchievementProgressCopyWithImpl<AchievementProgress>(this as AchievementProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementProgress&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.name, name) || other.name == name)&&(identical(other.eligible, eligible) || other.eligible == eligible)&&(identical(other.claimed, claimed) || other.claimed == claimed)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.current, current) || other.current == current)&&(identical(other.required, required) || other.required == required)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}


@override
int get hashCode => Object.hash(runtimeType,achievementId,name,eligible,claimed,reason,current,required,percentage);

@override
String toString() {
  return 'AchievementProgress(achievementId: $achievementId, name: $name, eligible: $eligible, claimed: $claimed, reason: $reason, current: $current, required: $required, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $AchievementProgressCopyWith<$Res>  {
  factory $AchievementProgressCopyWith(AchievementProgress value, $Res Function(AchievementProgress) _then) = _$AchievementProgressCopyWithImpl;
@useResult
$Res call({
 String achievementId, String name, bool eligible, bool claimed, String? reason, num? current, num? required, int? percentage
});




}
/// @nodoc
class _$AchievementProgressCopyWithImpl<$Res>
    implements $AchievementProgressCopyWith<$Res> {
  _$AchievementProgressCopyWithImpl(this._self, this._then);

  final AchievementProgress _self;
  final $Res Function(AchievementProgress) _then;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? achievementId = null,Object? name = null,Object? eligible = null,Object? claimed = null,Object? reason = freezed,Object? current = freezed,Object? required = freezed,Object? percentage = freezed,}) {
  return _then(_self.copyWith(
achievementId: null == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as num?,required: freezed == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as num?,percentage: freezed == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementProgress].
extension AchievementProgressPatterns on AchievementProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementProgress value)  $default,){
final _that = this;
switch (_that) {
case _AchievementProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementProgress value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String achievementId,  String name,  bool eligible,  bool claimed,  String? reason,  num? current,  num? required,  int? percentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
return $default(_that.achievementId,_that.name,_that.eligible,_that.claimed,_that.reason,_that.current,_that.required,_that.percentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String achievementId,  String name,  bool eligible,  bool claimed,  String? reason,  num? current,  num? required,  int? percentage)  $default,) {final _that = this;
switch (_that) {
case _AchievementProgress():
return $default(_that.achievementId,_that.name,_that.eligible,_that.claimed,_that.reason,_that.current,_that.required,_that.percentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String achievementId,  String name,  bool eligible,  bool claimed,  String? reason,  num? current,  num? required,  int? percentage)?  $default,) {final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
return $default(_that.achievementId,_that.name,_that.eligible,_that.claimed,_that.reason,_that.current,_that.required,_that.percentage);case _:
  return null;

}
}

}

/// @nodoc


class _AchievementProgress implements AchievementProgress {
  const _AchievementProgress({required this.achievementId, required this.name, required this.eligible, this.claimed = false, this.reason, this.current, this.required, this.percentage});
  

@override final  String achievementId;
@override final  String name;
@override final  bool eligible;
@override@JsonKey() final  bool claimed;
/// e.g. "total_karma: 0/500".
@override final  String? reason;
@override final  num? current;
@override final  num? required;
/// 0–100.
@override final  int? percentage;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementProgressCopyWith<_AchievementProgress> get copyWith => __$AchievementProgressCopyWithImpl<_AchievementProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementProgress&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.name, name) || other.name == name)&&(identical(other.eligible, eligible) || other.eligible == eligible)&&(identical(other.claimed, claimed) || other.claimed == claimed)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.current, current) || other.current == current)&&(identical(other.required, required) || other.required == required)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}


@override
int get hashCode => Object.hash(runtimeType,achievementId,name,eligible,claimed,reason,current,required,percentage);

@override
String toString() {
  return 'AchievementProgress(achievementId: $achievementId, name: $name, eligible: $eligible, claimed: $claimed, reason: $reason, current: $current, required: $required, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class _$AchievementProgressCopyWith<$Res> implements $AchievementProgressCopyWith<$Res> {
  factory _$AchievementProgressCopyWith(_AchievementProgress value, $Res Function(_AchievementProgress) _then) = __$AchievementProgressCopyWithImpl;
@override @useResult
$Res call({
 String achievementId, String name, bool eligible, bool claimed, String? reason, num? current, num? required, int? percentage
});




}
/// @nodoc
class __$AchievementProgressCopyWithImpl<$Res>
    implements _$AchievementProgressCopyWith<$Res> {
  __$AchievementProgressCopyWithImpl(this._self, this._then);

  final _AchievementProgress _self;
  final $Res Function(_AchievementProgress) _then;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? achievementId = null,Object? name = null,Object? eligible = null,Object? claimed = null,Object? reason = freezed,Object? current = freezed,Object? required = freezed,Object? percentage = freezed,}) {
  return _then(_AchievementProgress(
achievementId: null == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as num?,required: freezed == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as num?,percentage: freezed == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$ClaimResult {

 String get achievementName; bool get vcPending; String get message;
/// Create a copy of ClaimResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimResultCopyWith<ClaimResult> get copyWith => _$ClaimResultCopyWithImpl<ClaimResult>(this as ClaimResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimResult&&(identical(other.achievementName, achievementName) || other.achievementName == achievementName)&&(identical(other.vcPending, vcPending) || other.vcPending == vcPending)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,achievementName,vcPending,message);

@override
String toString() {
  return 'ClaimResult(achievementName: $achievementName, vcPending: $vcPending, message: $message)';
}


}

/// @nodoc
abstract mixin class $ClaimResultCopyWith<$Res>  {
  factory $ClaimResultCopyWith(ClaimResult value, $Res Function(ClaimResult) _then) = _$ClaimResultCopyWithImpl;
@useResult
$Res call({
 String achievementName, bool vcPending, String message
});




}
/// @nodoc
class _$ClaimResultCopyWithImpl<$Res>
    implements $ClaimResultCopyWith<$Res> {
  _$ClaimResultCopyWithImpl(this._self, this._then);

  final ClaimResult _self;
  final $Res Function(ClaimResult) _then;

/// Create a copy of ClaimResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? achievementName = null,Object? vcPending = null,Object? message = null,}) {
  return _then(_self.copyWith(
achievementName: null == achievementName ? _self.achievementName : achievementName // ignore: cast_nullable_to_non_nullable
as String,vcPending: null == vcPending ? _self.vcPending : vcPending // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimResult].
extension ClaimResultPatterns on ClaimResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimResult value)  $default,){
final _that = this;
switch (_that) {
case _ClaimResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimResult value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String achievementName,  bool vcPending,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimResult() when $default != null:
return $default(_that.achievementName,_that.vcPending,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String achievementName,  bool vcPending,  String message)  $default,) {final _that = this;
switch (_that) {
case _ClaimResult():
return $default(_that.achievementName,_that.vcPending,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String achievementName,  bool vcPending,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ClaimResult() when $default != null:
return $default(_that.achievementName,_that.vcPending,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ClaimResult implements ClaimResult {
  const _ClaimResult({required this.achievementName, required this.vcPending, required this.message});
  

@override final  String achievementName;
@override final  bool vcPending;
@override final  String message;

/// Create a copy of ClaimResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimResultCopyWith<_ClaimResult> get copyWith => __$ClaimResultCopyWithImpl<_ClaimResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimResult&&(identical(other.achievementName, achievementName) || other.achievementName == achievementName)&&(identical(other.vcPending, vcPending) || other.vcPending == vcPending)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,achievementName,vcPending,message);

@override
String toString() {
  return 'ClaimResult(achievementName: $achievementName, vcPending: $vcPending, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ClaimResultCopyWith<$Res> implements $ClaimResultCopyWith<$Res> {
  factory _$ClaimResultCopyWith(_ClaimResult value, $Res Function(_ClaimResult) _then) = __$ClaimResultCopyWithImpl;
@override @useResult
$Res call({
 String achievementName, bool vcPending, String message
});




}
/// @nodoc
class __$ClaimResultCopyWithImpl<$Res>
    implements _$ClaimResultCopyWith<$Res> {
  __$ClaimResultCopyWithImpl(this._self, this._then);

  final _ClaimResult _self;
  final $Res Function(_ClaimResult) _then;

/// Create a copy of ClaimResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? achievementName = null,Object? vcPending = null,Object? message = null,}) {
  return _then(_ClaimResult(
achievementName: null == achievementName ? _self.achievementName : achievementName // ignore: cast_nullable_to_non_nullable
as String,vcPending: null == vcPending ? _self.vcPending : vcPending // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
