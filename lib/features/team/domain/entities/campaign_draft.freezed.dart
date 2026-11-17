// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampaignDraft {

 String get title; String get body; AudienceType get audienceType; String? get route; List<String> get audienceIds; DateTime? get scheduledAt; bool get respectQuietHours;
/// Create a copy of CampaignDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignDraftCopyWith<CampaignDraft> get copyWith => _$CampaignDraftCopyWithImpl<CampaignDraft>(this as CampaignDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CampaignDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignDraft&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.audienceType, _this.audienceType) || other.audienceType == _this.audienceType)&&(identical(other.route, _this.route) || other.route == _this.route)&&const DeepCollectionEquality().equals(other.audienceIds, _this.audienceIds)&&(identical(other.scheduledAt, _this.scheduledAt) || other.scheduledAt == _this.scheduledAt)&&(identical(other.respectQuietHours, _this.respectQuietHours) || other.respectQuietHours == _this.respectQuietHours));
}


@override
int get hashCode {
  final _this = this as CampaignDraft;
  return Object.hash(runtimeType,_this.title,_this.body,_this.audienceType,_this.route,const DeepCollectionEquality().hash(_this.audienceIds),_this.scheduledAt,_this.respectQuietHours);
}

@override
String toString() {
  final _this = this as CampaignDraft;
  return 'CampaignDraft(title: ${_this.title}, body: ${_this.body}, audienceType: ${_this.audienceType}, route: ${_this.route}, audienceIds: ${_this.audienceIds}, scheduledAt: ${_this.scheduledAt}, respectQuietHours: ${_this.respectQuietHours})';
}


}

/// @nodoc
abstract mixin class $CampaignDraftCopyWith<$Res>  {
  factory $CampaignDraftCopyWith(CampaignDraft value, $Res Function(CampaignDraft) _then) = _$CampaignDraftCopyWithImpl;
@useResult
$Res call({
 String title, String body, AudienceType audienceType, String? route, List<String> audienceIds, DateTime? scheduledAt, bool respectQuietHours
});




}
/// @nodoc
class _$CampaignDraftCopyWithImpl<$Res>
    implements $CampaignDraftCopyWith<$Res> {
  _$CampaignDraftCopyWithImpl(this._self, this._then);

  final CampaignDraft _self;
  final $Res Function(CampaignDraft) _then;

/// Create a copy of CampaignDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? body = null,Object? audienceType = null,Object? route = freezed,Object? audienceIds = null,Object? scheduledAt = freezed,Object? respectQuietHours = null,}) {
  return _then(CampaignDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,audienceType: null == audienceType ? _self.audienceType : audienceType // ignore: cast_nullable_to_non_nullable
as AudienceType,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,audienceIds: null == audienceIds ? _self.audienceIds : audienceIds // ignore: cast_nullable_to_non_nullable
as List<String>,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,respectQuietHours: null == respectQuietHours ? _self.respectQuietHours : respectQuietHours // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignDraft].
extension CampaignDraftPatterns on CampaignDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignDraft value)  $default,){
final _that = this;
switch (_that) {
case _CampaignDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignDraft value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String body,  AudienceType audienceType,  String? route,  List<String> audienceIds,  DateTime? scheduledAt,  bool respectQuietHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignDraft() when $default != null:
return $default(_that.title,_that.body,_that.audienceType,_that.route,_that.audienceIds,_that.scheduledAt,_that.respectQuietHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String body,  AudienceType audienceType,  String? route,  List<String> audienceIds,  DateTime? scheduledAt,  bool respectQuietHours)  $default,) {final _that = this;
switch (_that) {
case _CampaignDraft():
return $default(_that.title,_that.body,_that.audienceType,_that.route,_that.audienceIds,_that.scheduledAt,_that.respectQuietHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String body,  AudienceType audienceType,  String? route,  List<String> audienceIds,  DateTime? scheduledAt,  bool respectQuietHours)?  $default,) {final _that = this;
switch (_that) {
case _CampaignDraft() when $default != null:
return $default(_that.title,_that.body,_that.audienceType,_that.route,_that.audienceIds,_that.scheduledAt,_that.respectQuietHours);case _:
  return null;

}
}

}

/// @nodoc


class _CampaignDraft implements CampaignDraft {
  const _CampaignDraft({required this.title, required this.body, required this.audienceType, this.route,  List<String> audienceIds = const <String>[], this.scheduledAt, this.respectQuietHours = true}): _audienceIds = audienceIds;
  

@override final  String title;
@override final  String body;
@override final  AudienceType audienceType;
@override final  String? route;
 final  List<String> _audienceIds;
@override@JsonKey() List<String> get audienceIds {
  if (_audienceIds is EqualUnmodifiableListView) return _audienceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_audienceIds);
}

@override final  DateTime? scheduledAt;
@override@JsonKey() final  bool respectQuietHours;

/// Create a copy of CampaignDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignDraftCopyWith<_CampaignDraft> get copyWith => __$CampaignDraftCopyWithImpl<_CampaignDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.audienceType, audienceType) || other.audienceType == audienceType)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other.audienceIds, _audienceIds)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.respectQuietHours, respectQuietHours) || other.respectQuietHours == respectQuietHours));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,body,audienceType,route,const DeepCollectionEquality().hash(_audienceIds),scheduledAt,respectQuietHours);
}

@override
String toString() {
    return 'CampaignDraft(title: $title, body: $body, audienceType: $audienceType, route: $route, audienceIds: $audienceIds, scheduledAt: $scheduledAt, respectQuietHours: $respectQuietHours)';
}


}

/// @nodoc
abstract mixin class _$CampaignDraftCopyWith<$Res> implements $CampaignDraftCopyWith<$Res> {
  factory _$CampaignDraftCopyWith(_CampaignDraft value, $Res Function(_CampaignDraft) _then) = __$CampaignDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, String body, AudienceType audienceType, String? route, List<String> audienceIds, DateTime? scheduledAt, bool respectQuietHours
});




}
/// @nodoc
class __$CampaignDraftCopyWithImpl<$Res>
    implements _$CampaignDraftCopyWith<$Res> {
  __$CampaignDraftCopyWithImpl(this._self, this._then);

  final _CampaignDraft _self;
  final $Res Function(_CampaignDraft) _then;

/// Create a copy of CampaignDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? body = null,Object? audienceType = null,Object? route = freezed,Object? audienceIds = null,Object? scheduledAt = freezed,Object? respectQuietHours = null,}) {
  return _then(_CampaignDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,audienceType: null == audienceType ? _self.audienceType : audienceType // ignore: cast_nullable_to_non_nullable
as AudienceType,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,audienceIds: null == audienceIds ? _self._audienceIds : audienceIds // ignore: cast_nullable_to_non_nullable
as List<String>,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,respectQuietHours: null == respectQuietHours ? _self.respectQuietHours : respectQuietHours // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
