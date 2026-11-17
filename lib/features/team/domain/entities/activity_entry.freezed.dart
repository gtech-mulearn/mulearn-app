// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivityEntry {

 String get id; String get action; String get label; String get actorName; String get actorMuid; List<String> get roles; DateTime get createdAt; String? get title; String? get entityName; String? get entityId; ActivityCampaign? get campaign; int? get audienceSize; String? get audienceLabel; Map<String, Object?>? get oldData; Map<String, Object?>? get newData;
/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityEntryCopyWith<ActivityEntry> get copyWith => _$ActivityEntryCopyWithImpl<ActivityEntry>(this as ActivityEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ActivityEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.actorName, _this.actorName) || other.actorName == _this.actorName)&&(identical(other.actorMuid, _this.actorMuid) || other.actorMuid == _this.actorMuid)&&const DeepCollectionEquality().equals(other.roles, _this.roles)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.entityName, _this.entityName) || other.entityName == _this.entityName)&&(identical(other.entityId, _this.entityId) || other.entityId == _this.entityId)&&(identical(other.campaign, _this.campaign) || other.campaign == _this.campaign)&&(identical(other.audienceSize, _this.audienceSize) || other.audienceSize == _this.audienceSize)&&(identical(other.audienceLabel, _this.audienceLabel) || other.audienceLabel == _this.audienceLabel)&&const DeepCollectionEquality().equals(other.oldData, _this.oldData)&&const DeepCollectionEquality().equals(other.newData, _this.newData));
}


@override
int get hashCode {
  final _this = this as ActivityEntry;
  return Object.hash(runtimeType,_this.id,_this.action,_this.label,_this.actorName,_this.actorMuid,const DeepCollectionEquality().hash(_this.roles),_this.createdAt,_this.title,_this.entityName,_this.entityId,_this.campaign,_this.audienceSize,_this.audienceLabel,const DeepCollectionEquality().hash(_this.oldData),const DeepCollectionEquality().hash(_this.newData));
}

@override
String toString() {
  final _this = this as ActivityEntry;
  return 'ActivityEntry(id: ${_this.id}, action: ${_this.action}, label: ${_this.label}, actorName: ${_this.actorName}, actorMuid: ${_this.actorMuid}, roles: ${_this.roles}, createdAt: ${_this.createdAt}, title: ${_this.title}, entityName: ${_this.entityName}, entityId: ${_this.entityId}, campaign: ${_this.campaign}, audienceSize: ${_this.audienceSize}, audienceLabel: ${_this.audienceLabel}, oldData: ${_this.oldData}, newData: ${_this.newData})';
}


}

/// @nodoc
abstract mixin class $ActivityEntryCopyWith<$Res>  {
  factory $ActivityEntryCopyWith(ActivityEntry value, $Res Function(ActivityEntry) _then) = _$ActivityEntryCopyWithImpl;
@useResult
$Res call({
 String id, String action, String label, String actorName, String actorMuid, List<String> roles, DateTime createdAt, String? title, String? entityName, String? entityId, ActivityCampaign? campaign, int? audienceSize, String? audienceLabel, Map<String, Object?>? oldData, Map<String, Object?>? newData
});


$ActivityCampaignCopyWith<$Res>? get campaign;

}
/// @nodoc
class _$ActivityEntryCopyWithImpl<$Res>
    implements $ActivityEntryCopyWith<$Res> {
  _$ActivityEntryCopyWithImpl(this._self, this._then);

  final ActivityEntry _self;
  final $Res Function(ActivityEntry) _then;

/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? action = null,Object? label = null,Object? actorName = null,Object? actorMuid = null,Object? roles = null,Object? createdAt = null,Object? title = freezed,Object? entityName = freezed,Object? entityId = freezed,Object? campaign = freezed,Object? audienceSize = freezed,Object? audienceLabel = freezed,Object? oldData = freezed,Object? newData = freezed,}) {
  return _then(ActivityEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,actorMuid: null == actorMuid ? _self.actorMuid : actorMuid // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,entityName: freezed == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String?,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as ActivityCampaign?,audienceSize: freezed == audienceSize ? _self.audienceSize : audienceSize // ignore: cast_nullable_to_non_nullable
as int?,audienceLabel: freezed == audienceLabel ? _self.audienceLabel : audienceLabel // ignore: cast_nullable_to_non_nullable
as String?,oldData: freezed == oldData ? _self.oldData : oldData // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,newData: freezed == newData ? _self.newData : newData // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,
  ));
}
/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCampaignCopyWith<$Res>? get campaign {
    if (_self.campaign == null) {
    return null;
  }

  return $ActivityCampaignCopyWith<$Res>(_self.campaign!, (value) {
    return _then(_self.copyWith(campaign: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActivityEntry].
extension ActivityEntryPatterns on ActivityEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityEntry value)  $default,){
final _that = this;
switch (_that) {
case _ActivityEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String action,  String label,  String actorName,  String actorMuid,  List<String> roles,  DateTime createdAt,  String? title,  String? entityName,  String? entityId,  ActivityCampaign? campaign,  int? audienceSize,  String? audienceLabel,  Map<String, Object?>? oldData,  Map<String, Object?>? newData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
return $default(_that.id,_that.action,_that.label,_that.actorName,_that.actorMuid,_that.roles,_that.createdAt,_that.title,_that.entityName,_that.entityId,_that.campaign,_that.audienceSize,_that.audienceLabel,_that.oldData,_that.newData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String action,  String label,  String actorName,  String actorMuid,  List<String> roles,  DateTime createdAt,  String? title,  String? entityName,  String? entityId,  ActivityCampaign? campaign,  int? audienceSize,  String? audienceLabel,  Map<String, Object?>? oldData,  Map<String, Object?>? newData)  $default,) {final _that = this;
switch (_that) {
case _ActivityEntry():
return $default(_that.id,_that.action,_that.label,_that.actorName,_that.actorMuid,_that.roles,_that.createdAt,_that.title,_that.entityName,_that.entityId,_that.campaign,_that.audienceSize,_that.audienceLabel,_that.oldData,_that.newData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String action,  String label,  String actorName,  String actorMuid,  List<String> roles,  DateTime createdAt,  String? title,  String? entityName,  String? entityId,  ActivityCampaign? campaign,  int? audienceSize,  String? audienceLabel,  Map<String, Object?>? oldData,  Map<String, Object?>? newData)?  $default,) {final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
return $default(_that.id,_that.action,_that.label,_that.actorName,_that.actorMuid,_that.roles,_that.createdAt,_that.title,_that.entityName,_that.entityId,_that.campaign,_that.audienceSize,_that.audienceLabel,_that.oldData,_that.newData);case _:
  return null;

}
}

}

/// @nodoc


class _ActivityEntry implements ActivityEntry {
  const _ActivityEntry({required this.id, required this.action, required this.label, required this.actorName, required this.actorMuid, required  List<String> roles, required this.createdAt, this.title, this.entityName, this.entityId, this.campaign, this.audienceSize, this.audienceLabel,  Map<String, Object?>? oldData,  Map<String, Object?>? newData}): _roles = roles,_oldData = oldData,_newData = newData;
  

@override final  String id;
@override final  String action;
@override final  String label;
@override final  String actorName;
@override final  String actorMuid;
 final  List<String> _roles;
@override List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override final  DateTime createdAt;
@override final  String? title;
@override final  String? entityName;
@override final  String? entityId;
@override final  ActivityCampaign? campaign;
@override final  int? audienceSize;
@override final  String? audienceLabel;
 final  Map<String, Object?>? _oldData;
@override Map<String, Object?>? get oldData {
  final value = _oldData;
  if (value == null) return null;
  if (_oldData is EqualUnmodifiableMapView) return _oldData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, Object?>? _newData;
@override Map<String, Object?>? get newData {
  final value = _newData;
  if (value == null) return null;
  if (_newData is EqualUnmodifiableMapView) return _newData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityEntryCopyWith<_ActivityEntry> get copyWith => __$ActivityEntryCopyWithImpl<_ActivityEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.label, label) || other.label == label)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorMuid, actorMuid) || other.actorMuid == actorMuid)&&const DeepCollectionEquality().equals(other.roles, _roles)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.audienceSize, audienceSize) || other.audienceSize == audienceSize)&&(identical(other.audienceLabel, audienceLabel) || other.audienceLabel == audienceLabel)&&const DeepCollectionEquality().equals(other.oldData, _oldData)&&const DeepCollectionEquality().equals(other.newData, _newData));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,action,label,actorName,actorMuid,const DeepCollectionEquality().hash(_roles),createdAt,title,entityName,entityId,campaign,audienceSize,audienceLabel,const DeepCollectionEquality().hash(_oldData),const DeepCollectionEquality().hash(_newData));
}

@override
String toString() {
    return 'ActivityEntry(id: $id, action: $action, label: $label, actorName: $actorName, actorMuid: $actorMuid, roles: $roles, createdAt: $createdAt, title: $title, entityName: $entityName, entityId: $entityId, campaign: $campaign, audienceSize: $audienceSize, audienceLabel: $audienceLabel, oldData: $oldData, newData: $newData)';
}


}

/// @nodoc
abstract mixin class _$ActivityEntryCopyWith<$Res> implements $ActivityEntryCopyWith<$Res> {
  factory _$ActivityEntryCopyWith(_ActivityEntry value, $Res Function(_ActivityEntry) _then) = __$ActivityEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String action, String label, String actorName, String actorMuid, List<String> roles, DateTime createdAt, String? title, String? entityName, String? entityId, ActivityCampaign? campaign, int? audienceSize, String? audienceLabel, Map<String, Object?>? oldData, Map<String, Object?>? newData
});


@override $ActivityCampaignCopyWith<$Res>? get campaign;

}
/// @nodoc
class __$ActivityEntryCopyWithImpl<$Res>
    implements _$ActivityEntryCopyWith<$Res> {
  __$ActivityEntryCopyWithImpl(this._self, this._then);

  final _ActivityEntry _self;
  final $Res Function(_ActivityEntry) _then;

/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? action = null,Object? label = null,Object? actorName = null,Object? actorMuid = null,Object? roles = null,Object? createdAt = null,Object? title = freezed,Object? entityName = freezed,Object? entityId = freezed,Object? campaign = freezed,Object? audienceSize = freezed,Object? audienceLabel = freezed,Object? oldData = freezed,Object? newData = freezed,}) {
  return _then(_ActivityEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,actorMuid: null == actorMuid ? _self.actorMuid : actorMuid // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,entityName: freezed == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String?,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as ActivityCampaign?,audienceSize: freezed == audienceSize ? _self.audienceSize : audienceSize // ignore: cast_nullable_to_non_nullable
as int?,audienceLabel: freezed == audienceLabel ? _self.audienceLabel : audienceLabel // ignore: cast_nullable_to_non_nullable
as String?,oldData: freezed == oldData ? _self._oldData : oldData // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,newData: freezed == newData ? _self._newData : newData // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,
  ));
}

/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCampaignCopyWith<$Res>? get campaign {
    if (_self.campaign == null) {
    return null;
  }

  return $ActivityCampaignCopyWith<$Res>(_self.campaign!, (value) {
    return _then(_self.copyWith(campaign: value));
  });
}
}

// dart format on
