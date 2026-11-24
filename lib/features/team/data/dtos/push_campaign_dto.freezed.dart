// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_campaign_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PushCampaignDto {

 String get id; String get createdAt; String get title; String get body; String get status; bool get respectQuietHours; int get targetCount; int get sentCount; int get skippedCount; int get failedCount; String? get route; Map<String, dynamic>? get audience; String? get scheduledAt; String? get sentAt; String? get createdBy;
/// Create a copy of PushCampaignDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushCampaignDtoCopyWith<PushCampaignDto> get copyWith => _$PushCampaignDtoCopyWithImpl<PushCampaignDto>(this as PushCampaignDto, _$identity);

  /// Serializes this PushCampaignDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PushCampaignDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushCampaignDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.respectQuietHours, _this.respectQuietHours) || other.respectQuietHours == _this.respectQuietHours)&&(identical(other.targetCount, _this.targetCount) || other.targetCount == _this.targetCount)&&(identical(other.sentCount, _this.sentCount) || other.sentCount == _this.sentCount)&&(identical(other.skippedCount, _this.skippedCount) || other.skippedCount == _this.skippedCount)&&(identical(other.failedCount, _this.failedCount) || other.failedCount == _this.failedCount)&&(identical(other.route, _this.route) || other.route == _this.route)&&const DeepCollectionEquality().equals(other.audience, _this.audience)&&(identical(other.scheduledAt, _this.scheduledAt) || other.scheduledAt == _this.scheduledAt)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PushCampaignDto;
  return Object.hash(runtimeType,_this.id,_this.createdAt,_this.title,_this.body,_this.status,_this.respectQuietHours,_this.targetCount,_this.sentCount,_this.skippedCount,_this.failedCount,_this.route,const DeepCollectionEquality().hash(_this.audience),_this.scheduledAt,_this.sentAt,_this.createdBy);
}

@override
String toString() {
  final _this = this as PushCampaignDto;
  return 'PushCampaignDto(id: ${_this.id}, createdAt: ${_this.createdAt}, title: ${_this.title}, body: ${_this.body}, status: ${_this.status}, respectQuietHours: ${_this.respectQuietHours}, targetCount: ${_this.targetCount}, sentCount: ${_this.sentCount}, skippedCount: ${_this.skippedCount}, failedCount: ${_this.failedCount}, route: ${_this.route}, audience: ${_this.audience}, scheduledAt: ${_this.scheduledAt}, sentAt: ${_this.sentAt}, createdBy: ${_this.createdBy})';
}


}

/// @nodoc
abstract mixin class $PushCampaignDtoCopyWith<$Res>  {
  factory $PushCampaignDtoCopyWith(PushCampaignDto value, $Res Function(PushCampaignDto) _then) = _$PushCampaignDtoCopyWithImpl;
@useResult
$Res call({
 String id, String createdAt, String title, String body, String status, bool respectQuietHours, int targetCount, int sentCount, int skippedCount, int failedCount, String? route, Map<String, dynamic>? audience, String? scheduledAt, String? sentAt, String? createdBy
});




}
/// @nodoc
class _$PushCampaignDtoCopyWithImpl<$Res>
    implements $PushCampaignDtoCopyWith<$Res> {
  _$PushCampaignDtoCopyWithImpl(this._self, this._then);

  final PushCampaignDto _self;
  final $Res Function(PushCampaignDto) _then;

/// Create a copy of PushCampaignDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? title = null,Object? body = null,Object? status = null,Object? respectQuietHours = null,Object? targetCount = null,Object? sentCount = null,Object? skippedCount = null,Object? failedCount = null,Object? route = freezed,Object? audience = freezed,Object? scheduledAt = freezed,Object? sentAt = freezed,Object? createdBy = freezed,}) {
  return _then(PushCampaignDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,respectQuietHours: null == respectQuietHours ? _self.respectQuietHours : respectQuietHours // ignore: cast_nullable_to_non_nullable
as bool,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,audience: freezed == audience ? _self.audience : audience // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PushCampaignDto].
extension PushCampaignDtoPatterns on PushCampaignDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushCampaignDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushCampaignDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushCampaignDto value)  $default,){
final _that = this;
switch (_that) {
case _PushCampaignDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushCampaignDto value)?  $default,){
final _that = this;
switch (_that) {
case _PushCampaignDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String createdAt,  String title,  String body,  String status,  bool respectQuietHours,  int targetCount,  int sentCount,  int skippedCount,  int failedCount,  String? route,  Map<String, dynamic>? audience,  String? scheduledAt,  String? sentAt,  String? createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushCampaignDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.title,_that.body,_that.status,_that.respectQuietHours,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount,_that.route,_that.audience,_that.scheduledAt,_that.sentAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String createdAt,  String title,  String body,  String status,  bool respectQuietHours,  int targetCount,  int sentCount,  int skippedCount,  int failedCount,  String? route,  Map<String, dynamic>? audience,  String? scheduledAt,  String? sentAt,  String? createdBy)  $default,) {final _that = this;
switch (_that) {
case _PushCampaignDto():
return $default(_that.id,_that.createdAt,_that.title,_that.body,_that.status,_that.respectQuietHours,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount,_that.route,_that.audience,_that.scheduledAt,_that.sentAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String createdAt,  String title,  String body,  String status,  bool respectQuietHours,  int targetCount,  int sentCount,  int skippedCount,  int failedCount,  String? route,  Map<String, dynamic>? audience,  String? scheduledAt,  String? sentAt,  String? createdBy)?  $default,) {final _that = this;
switch (_that) {
case _PushCampaignDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.title,_that.body,_that.status,_that.respectQuietHours,_that.targetCount,_that.sentCount,_that.skippedCount,_that.failedCount,_that.route,_that.audience,_that.scheduledAt,_that.sentAt,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PushCampaignDto extends PushCampaignDto {
  const _PushCampaignDto({required this.id, required this.createdAt, this.title = '', this.body = '', this.status = 'draft', this.respectQuietHours = true, this.targetCount = 0, this.sentCount = 0, this.skippedCount = 0, this.failedCount = 0, this.route,  Map<String, dynamic>? audience, this.scheduledAt, this.sentAt, this.createdBy}): _audience = audience,super._();
  factory _PushCampaignDto.fromJson(Map<String, dynamic> json) => _$PushCampaignDtoFromJson(json);

@override final  String id;
@override final  String createdAt;
@override@JsonKey() final  String title;
@override@JsonKey() final  String body;
@override@JsonKey() final  String status;
@override@JsonKey() final  bool respectQuietHours;
@override@JsonKey() final  int targetCount;
@override@JsonKey() final  int sentCount;
@override@JsonKey() final  int skippedCount;
@override@JsonKey() final  int failedCount;
@override final  String? route;
 final  Map<String, dynamic>? _audience;
@override Map<String, dynamic>? get audience {
  final value = _audience;
  if (value == null) return null;
  if (_audience is EqualUnmodifiableMapView) return _audience;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? scheduledAt;
@override final  String? sentAt;
@override final  String? createdBy;

/// Create a copy of PushCampaignDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushCampaignDtoCopyWith<_PushCampaignDto> get copyWith => __$PushCampaignDtoCopyWithImpl<_PushCampaignDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PushCampaignDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushCampaignDto&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.status, status) || other.status == status)&&(identical(other.respectQuietHours, respectQuietHours) || other.respectQuietHours == respectQuietHours)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.sentCount, sentCount) || other.sentCount == sentCount)&&(identical(other.skippedCount, skippedCount) || other.skippedCount == skippedCount)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other.audience, _audience)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,title,body,status,respectQuietHours,targetCount,sentCount,skippedCount,failedCount,route,const DeepCollectionEquality().hash(_audience),scheduledAt,sentAt,createdBy);
}

@override
String toString() {
    return 'PushCampaignDto(id: $id, createdAt: $createdAt, title: $title, body: $body, status: $status, respectQuietHours: $respectQuietHours, targetCount: $targetCount, sentCount: $sentCount, skippedCount: $skippedCount, failedCount: $failedCount, route: $route, audience: $audience, scheduledAt: $scheduledAt, sentAt: $sentAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$PushCampaignDtoCopyWith<$Res> implements $PushCampaignDtoCopyWith<$Res> {
  factory _$PushCampaignDtoCopyWith(_PushCampaignDto value, $Res Function(_PushCampaignDto) _then) = __$PushCampaignDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String createdAt, String title, String body, String status, bool respectQuietHours, int targetCount, int sentCount, int skippedCount, int failedCount, String? route, Map<String, dynamic>? audience, String? scheduledAt, String? sentAt, String? createdBy
});




}
/// @nodoc
class __$PushCampaignDtoCopyWithImpl<$Res>
    implements _$PushCampaignDtoCopyWith<$Res> {
  __$PushCampaignDtoCopyWithImpl(this._self, this._then);

  final _PushCampaignDto _self;
  final $Res Function(_PushCampaignDto) _then;

/// Create a copy of PushCampaignDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? title = null,Object? body = null,Object? status = null,Object? respectQuietHours = null,Object? targetCount = null,Object? sentCount = null,Object? skippedCount = null,Object? failedCount = null,Object? route = freezed,Object? audience = freezed,Object? scheduledAt = freezed,Object? sentAt = freezed,Object? createdBy = freezed,}) {
  return _then(_PushCampaignDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,respectQuietHours: null == respectQuietHours ? _self.respectQuietHours : respectQuietHours // ignore: cast_nullable_to_non_nullable
as bool,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,audience: freezed == audience ? _self._audience : audience // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
