// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_campaign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PushCampaign {

 String get id; String get title; String get body; AudienceType get audienceType; List<String> get audienceIds; CampaignStatus get status; bool get respectQuietHours; int get targetCount; int get sentCount; int get skippedCount; int get failedCount; DateTime get createdAt; String? get route; DateTime? get scheduledAt; DateTime? get sentAt; String? get createdBy;
/// Create a copy of PushCampaign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushCampaignCopyWith<PushCampaign> get copyWith => _$PushCampaignCopyWithImpl<PushCampaign>(this as PushCampaign, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PushCampaign;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushCampaign&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.audienceType, _this.audienceType) || other.audienceType == _this.audienceType)&&const DeepCollectionEquality().equals(other.audienceIds, _this.audienceIds)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.respectQuietHours, _this.respectQuietHours) || other.respectQuietHours == _this.respectQuietHours)&&(identical(other.targetCount, _this.targetCount) || other.targetCount == _this.targetCount)&&(identical(other.sentCount, _this.sentCount) || other.sentCount == _this.sentCount)&&(identical(other.skippedCount, _this.skippedCount) || other.skippedCount == _this.skippedCount)&&(identical(other.failedCount, _this.failedCount) || other.failedCount == _this.failedCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.route, _this.route) || other.route == _this.route)&&(identical(other.scheduledAt, _this.scheduledAt) || other.scheduledAt == _this.scheduledAt)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy));
}


@override
int get hashCode {
  final _this = this as PushCampaign;
  return Object.hash(runtimeType,_this.id,_this.title,_this.body,_this.audienceType,const DeepCollectionEquality().hash(_this.audienceIds),_this.status,_this.respectQuietHours,_this.targetCount,_this.sentCount,_this.skippedCount,_this.failedCount,_this.createdAt,_this.route,_this.scheduledAt,_this.sentAt,_this.createdBy);
}

@override
String toString() {
  final _this = this as PushCampaign;
  return 'PushCampaign(id: ${_this.id}, title: ${_this.title}, body: ${_this.body}, audienceType: ${_this.audienceType}, audienceIds: ${_this.audienceIds}, status: ${_this.status}, respectQuietHours: ${_this.respectQuietHours}, targetCount: ${_this.targetCount}, sentCount: ${_this.sentCount}, skippedCount: ${_this.skippedCount}, failedCount: ${_this.failedCount}, createdAt: ${_this.createdAt}, route: ${_this.route}, scheduledAt: ${_this.scheduledAt}, sentAt: ${_this.sentAt}, createdBy: ${_this.createdBy})';
}


}

/// @nodoc
abstract mixin class $PushCampaignCopyWith<$Res>  {
  factory $PushCampaignCopyWith(PushCampaign value, $Res Function(PushCampaign) _then) = _$PushCampaignCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, AudienceType audienceType, List<String> audienceIds, CampaignStatus status, bool respectQuietHours, int targetCount, int sentCount, int skippedCount, int failedCount, DateTime createdAt, String? route, DateTime? scheduledAt, DateTime? sentAt, String? createdBy
});




}
/// @nodoc
class _$PushCampaignCopyWithImpl<$Res>
    implements $PushCampaignCopyWith<$Res> {
  _$PushCampaignCopyWithImpl(this._self, this._then);

  final PushCampaign _self;
  final $Res Function(PushCampaign) _then;

/// Create a copy of PushCampaign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? audienceType = null,Object? audienceIds = null,Object? status = null,Object? respectQuietHours = null,Object? targetCount = null,Object? sentCount = null,Object? skippedCount = null,Object? failedCount = null,Object? createdAt = null,Object? route = freezed,Object? scheduledAt = freezed,Object? sentAt = freezed,Object? createdBy = freezed,}) {
  return _then(PushCampaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,audienceType: null == audienceType ? _self.audienceType : audienceType // ignore: cast_nullable_to_non_nullable
as AudienceType,audienceIds: null == audienceIds ? _self.audienceIds : audienceIds // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,respectQuietHours: null == respectQuietHours ? _self.respectQuietHours : respectQuietHours // ignore: cast_nullable_to_non_nullable
as bool,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PushCampaign].
extension PushCampaignPatterns on PushCampaign {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushCampaign value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushCampaign() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushCampaign value)  $default,){
final _that = this;
switch (_that) {
case _PushCampaign():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushCampaign value)?  $default,){
final _that = this;
switch (_that) {
case _PushCampaign() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  AudienceType audienceType,  List<String> audienceIds,  CampaignStatus status,  bool respectQuietHours,  int targetCount,  int sentCount,  int skippedCount,  int failedCount,  DateTime createdAt,  String? route,  DateTime? scheduledAt,  DateTime? sentAt,  String? createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushCampaign() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.audienceType,_that.audienceIds,_that.status,_that.respectQuietHours,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount,_that.createdAt,_that.route,_that.scheduledAt,_that.sentAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  AudienceType audienceType,  List<String> audienceIds,  CampaignStatus status,  bool respectQuietHours,  int targetCount,  int sentCount,  int skippedCount,  int failedCount,  DateTime createdAt,  String? route,  DateTime? scheduledAt,  DateTime? sentAt,  String? createdBy)  $default,) {final _that = this;
switch (_that) {
case _PushCampaign():
return $default(_that.id,_that.title,_that.body,_that.audienceType,_that.audienceIds,_that.status,_that.respectQuietHours,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount,_that.createdAt,_that.route,_that.scheduledAt,_that.sentAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  AudienceType audienceType,  List<String> audienceIds,  CampaignStatus status,  bool respectQuietHours,  int targetCount,  int sentCount,  int skippedCount,  int failedCount,  DateTime createdAt,  String? route,  DateTime? scheduledAt,  DateTime? sentAt,  String? createdBy)?  $default,) {final _that = this;
switch (_that) {
case _PushCampaign() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.audienceType,_that.audienceIds,_that.status,_that.respectQuietHours,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount,_that.createdAt,_that.route,_that.scheduledAt,_that.sentAt,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc


class _PushCampaign implements PushCampaign {
  const _PushCampaign({required this.id, required this.title, required this.body, required this.audienceType, required  List<String> audienceIds, required this.status, required this.respectQuietHours, required this.targetCount, required this.sentCount, required this.skippedCount, required this.failedCount, required this.createdAt, this.route, this.scheduledAt, this.sentAt, this.createdBy}): _audienceIds = audienceIds;
  

@override final  String id;
@override final  String title;
@override final  String body;
@override final  AudienceType audienceType;
 final  List<String> _audienceIds;
@override List<String> get audienceIds {
  if (_audienceIds is EqualUnmodifiableListView) return _audienceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_audienceIds);
}

@override final  CampaignStatus status;
@override final  bool respectQuietHours;
@override final  int targetCount;
@override final  int sentCount;
@override final  int skippedCount;
@override final  int failedCount;
@override final  DateTime createdAt;
@override final  String? route;
@override final  DateTime? scheduledAt;
@override final  DateTime? sentAt;
@override final  String? createdBy;

/// Create a copy of PushCampaign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushCampaignCopyWith<_PushCampaign> get copyWith => __$PushCampaignCopyWithImpl<_PushCampaign>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushCampaign&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.audienceType, audienceType) || other.audienceType == audienceType)&&const DeepCollectionEquality().equals(other.audienceIds, _audienceIds)&&(identical(other.status, status) || other.status == status)&&(identical(other.respectQuietHours, respectQuietHours) || other.respectQuietHours == respectQuietHours)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.sentCount, sentCount) || other.sentCount == sentCount)&&(identical(other.skippedCount, skippedCount) || other.skippedCount == skippedCount)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.route, route) || other.route == route)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,body,audienceType,const DeepCollectionEquality().hash(_audienceIds),status,respectQuietHours,targetCount,sentCount,skippedCount,failedCount,createdAt,route,scheduledAt,sentAt,createdBy);
}

@override
String toString() {
    return 'PushCampaign(id: $id, title: $title, body: $body, audienceType: $audienceType, audienceIds: $audienceIds, status: $status, respectQuietHours: $respectQuietHours, targetCount: $targetCount, sentCount: $sentCount, skippedCount: $skippedCount, failedCount: $failedCount, createdAt: $createdAt, route: $route, scheduledAt: $scheduledAt, sentAt: $sentAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$PushCampaignCopyWith<$Res> implements $PushCampaignCopyWith<$Res> {
  factory _$PushCampaignCopyWith(_PushCampaign value, $Res Function(_PushCampaign) _then) = __$PushCampaignCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, AudienceType audienceType, List<String> audienceIds, CampaignStatus status, bool respectQuietHours, int targetCount, int sentCount, int skippedCount, int failedCount, DateTime createdAt, String? route, DateTime? scheduledAt, DateTime? sentAt, String? createdBy
});




}
/// @nodoc
class __$PushCampaignCopyWithImpl<$Res>
    implements _$PushCampaignCopyWith<$Res> {
  __$PushCampaignCopyWithImpl(this._self, this._then);

  final _PushCampaign _self;
  final $Res Function(_PushCampaign) _then;

/// Create a copy of PushCampaign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? audienceType = null,Object? audienceIds = null,Object? status = null,Object? respectQuietHours = null,Object? targetCount = null,Object? sentCount = null,Object? skippedCount = null,Object? failedCount = null,Object? createdAt = null,Object? route = freezed,Object? scheduledAt = freezed,Object? sentAt = freezed,Object? createdBy = freezed,}) {
  return _then(_PushCampaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,audienceType: null == audienceType ? _self.audienceType : audienceType // ignore: cast_nullable_to_non_nullable
as AudienceType,audienceIds: null == audienceIds ? _self._audienceIds : audienceIds // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,respectQuietHours: null == respectQuietHours ? _self.respectQuietHours : respectQuietHours // ignore: cast_nullable_to_non_nullable
as bool,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
