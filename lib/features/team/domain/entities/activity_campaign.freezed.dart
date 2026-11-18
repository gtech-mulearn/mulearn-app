// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_campaign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivityCampaign {

 CampaignStatus get status; int get targetCount; int get sentCount; int get skippedCount; int get failedCount;
/// Create a copy of ActivityCampaign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityCampaignCopyWith<ActivityCampaign> get copyWith => _$ActivityCampaignCopyWithImpl<ActivityCampaign>(this as ActivityCampaign, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ActivityCampaign;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityCampaign&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.targetCount, _this.targetCount) || other.targetCount == _this.targetCount)&&(identical(other.sentCount, _this.sentCount) || other.sentCount == _this.sentCount)&&(identical(other.skippedCount, _this.skippedCount) || other.skippedCount == _this.skippedCount)&&(identical(other.failedCount, _this.failedCount) || other.failedCount == _this.failedCount));
}


@override
int get hashCode {
  final _this = this as ActivityCampaign;
  return Object.hash(runtimeType,_this.status,_this.targetCount,_this.sentCount,_this.skippedCount,_this.failedCount);
}

@override
String toString() {
  final _this = this as ActivityCampaign;
  return 'ActivityCampaign(status: ${_this.status}, targetCount: ${_this.targetCount}, sentCount: ${_this.sentCount}, skippedCount: ${_this.skippedCount}, failedCount: ${_this.failedCount})';
}


}

/// @nodoc
abstract mixin class $ActivityCampaignCopyWith<$Res>  {
  factory $ActivityCampaignCopyWith(ActivityCampaign value, $Res Function(ActivityCampaign) _then) = _$ActivityCampaignCopyWithImpl;
@useResult
$Res call({
 CampaignStatus status, int targetCount, int sentCount, int skippedCount, int failedCount
});




}
/// @nodoc
class _$ActivityCampaignCopyWithImpl<$Res>
    implements $ActivityCampaignCopyWith<$Res> {
  _$ActivityCampaignCopyWithImpl(this._self, this._then);

  final ActivityCampaign _self;
  final $Res Function(ActivityCampaign) _then;

/// Create a copy of ActivityCampaign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? targetCount = null,Object? sentCount = null,Object? skippedCount = null,Object? failedCount = null,}) {
  return _then(ActivityCampaign(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityCampaign].
extension ActivityCampaignPatterns on ActivityCampaign {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityCampaign value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityCampaign() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityCampaign value)  $default,){
final _that = this;
switch (_that) {
case _ActivityCampaign():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityCampaign value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityCampaign() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CampaignStatus status,  int targetCount,  int sentCount,  int skippedCount,  int failedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityCampaign() when $default != null:
return $default(_that.status,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CampaignStatus status,  int targetCount,  int sentCount,  int skippedCount,  int failedCount)  $default,) {final _that = this;
switch (_that) {
case _ActivityCampaign():
return $default(_that.status,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CampaignStatus status,  int targetCount,  int sentCount,  int skippedCount,  int failedCount)?  $default,) {final _that = this;
switch (_that) {
case _ActivityCampaign() when $default != null:
return $default(_that.status,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount);case _:
  return null;

}
}

}

/// @nodoc


class _ActivityCampaign implements ActivityCampaign {
  const _ActivityCampaign({required this.status, required this.targetCount, required this.sentCount, required this.skippedCount, required this.failedCount});
  

@override final  CampaignStatus status;
@override final  int targetCount;
@override final  int sentCount;
@override final  int skippedCount;
@override final  int failedCount;

/// Create a copy of ActivityCampaign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityCampaignCopyWith<_ActivityCampaign> get copyWith => __$ActivityCampaignCopyWithImpl<_ActivityCampaign>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityCampaign&&(identical(other.status, status) || other.status == status)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.sentCount, sentCount) || other.sentCount == sentCount)&&(identical(other.skippedCount, skippedCount) || other.skippedCount == skippedCount)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,targetCount,sentCount,skippedCount,failedCount);
}

@override
String toString() {
    return 'ActivityCampaign(status: $status, targetCount: $targetCount, sentCount: $sentCount, skippedCount: $skippedCount, failedCount: $failedCount)';
}


}

/// @nodoc
abstract mixin class _$ActivityCampaignCopyWith<$Res> implements $ActivityCampaignCopyWith<$Res> {
  factory _$ActivityCampaignCopyWith(_ActivityCampaign value, $Res Function(_ActivityCampaign) _then) = __$ActivityCampaignCopyWithImpl;
@override @useResult
$Res call({
 CampaignStatus status, int targetCount, int sentCount, int skippedCount, int failedCount
});




}
/// @nodoc
class __$ActivityCampaignCopyWithImpl<$Res>
    implements _$ActivityCampaignCopyWith<$Res> {
  __$ActivityCampaignCopyWithImpl(this._self, this._then);

  final _ActivityCampaign _self;
  final $Res Function(_ActivityCampaign) _then;

/// Create a copy of ActivityCampaign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? targetCount = null,Object? sentCount = null,Object? skippedCount = null,Object? failedCount = null,}) {
  return _then(_ActivityCampaign(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
