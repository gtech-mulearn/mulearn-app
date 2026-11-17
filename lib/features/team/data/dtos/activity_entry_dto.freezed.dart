// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityEntryDto {

 String get id; String get action; String get createdAt; String get label; List<String> get roles; Map<String, dynamic>? get actor; String? get title; String? get entityName; String? get entityId; Map<String, dynamic>? get campaign; int? get audienceSize; String? get audienceLabel; Map<String, dynamic>? get oldData; Map<String, dynamic>? get newData;
/// Create a copy of ActivityEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityEntryDtoCopyWith<ActivityEntryDto> get copyWith => _$ActivityEntryDtoCopyWithImpl<ActivityEntryDto>(this as ActivityEntryDto, _$identity);

  /// Serializes this ActivityEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityEntryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityEntryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.label, _this.label) || other.label == _this.label)&&const DeepCollectionEquality().equals(other.roles, _this.roles)&&const DeepCollectionEquality().equals(other.actor, _this.actor)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.entityName, _this.entityName) || other.entityName == _this.entityName)&&(identical(other.entityId, _this.entityId) || other.entityId == _this.entityId)&&const DeepCollectionEquality().equals(other.campaign, _this.campaign)&&(identical(other.audienceSize, _this.audienceSize) || other.audienceSize == _this.audienceSize)&&(identical(other.audienceLabel, _this.audienceLabel) || other.audienceLabel == _this.audienceLabel)&&const DeepCollectionEquality().equals(other.oldData, _this.oldData)&&const DeepCollectionEquality().equals(other.newData, _this.newData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityEntryDto;
  return Object.hash(runtimeType,_this.id,_this.action,_this.createdAt,_this.label,const DeepCollectionEquality().hash(_this.roles),const DeepCollectionEquality().hash(_this.actor),_this.title,_this.entityName,_this.entityId,const DeepCollectionEquality().hash(_this.campaign),_this.audienceSize,_this.audienceLabel,const DeepCollectionEquality().hash(_this.oldData),const DeepCollectionEquality().hash(_this.newData));
}

@override
String toString() {
  final _this = this as ActivityEntryDto;
  return 'ActivityEntryDto(id: ${_this.id}, action: ${_this.action}, createdAt: ${_this.createdAt}, label: ${_this.label}, roles: ${_this.roles}, actor: ${_this.actor}, title: ${_this.title}, entityName: ${_this.entityName}, entityId: ${_this.entityId}, campaign: ${_this.campaign}, audienceSize: ${_this.audienceSize}, audienceLabel: ${_this.audienceLabel}, oldData: ${_this.oldData}, newData: ${_this.newData})';
}


}

/// @nodoc
abstract mixin class $ActivityEntryDtoCopyWith<$Res>  {
  factory $ActivityEntryDtoCopyWith(ActivityEntryDto value, $Res Function(ActivityEntryDto) _then) = _$ActivityEntryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String action, String createdAt, String label, List<String> roles, Map<String, dynamic>? actor, String? title, String? entityName, String? entityId, Map<String, dynamic>? campaign, int? audienceSize, String? audienceLabel, Map<String, dynamic>? oldData, Map<String, dynamic>? newData
});




}
/// @nodoc
class _$ActivityEntryDtoCopyWithImpl<$Res>
    implements $ActivityEntryDtoCopyWith<$Res> {
  _$ActivityEntryDtoCopyWithImpl(this._self, this._then);

  final ActivityEntryDto _self;
  final $Res Function(ActivityEntryDto) _then;

/// Create a copy of ActivityEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? action = null,Object? createdAt = null,Object? label = null,Object? roles = null,Object? actor = freezed,Object? title = freezed,Object? entityName = freezed,Object? entityId = freezed,Object? campaign = freezed,Object? audienceSize = freezed,Object? audienceLabel = freezed,Object? oldData = freezed,Object? newData = freezed,}) {
  return _then(ActivityEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,actor: freezed == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,entityName: freezed == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String?,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,audienceSize: freezed == audienceSize ? _self.audienceSize : audienceSize // ignore: cast_nullable_to_non_nullable
as int?,audienceLabel: freezed == audienceLabel ? _self.audienceLabel : audienceLabel // ignore: cast_nullable_to_non_nullable
as String?,oldData: freezed == oldData ? _self.oldData : oldData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,newData: freezed == newData ? _self.newData : newData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityEntryDto].
extension ActivityEntryDtoPatterns on ActivityEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _ActivityEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String action,  String createdAt,  String label,  List<String> roles,  Map<String, dynamic>? actor,  String? title,  String? entityName,  String? entityId,  Map<String, dynamic>? campaign,  int? audienceSize,  String? audienceLabel,  Map<String, dynamic>? oldData,  Map<String, dynamic>? newData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityEntryDto() when $default != null:
return $default(_that.id,_that.action,_that.createdAt,_that.label,_that.roles,_that.actor,_that.title,_that.entityName,_that.entityId,_that.campaign,_that.audienceSize,_that.audienceLabel,_that.oldData,_that.newData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String action,  String createdAt,  String label,  List<String> roles,  Map<String, dynamic>? actor,  String? title,  String? entityName,  String? entityId,  Map<String, dynamic>? campaign,  int? audienceSize,  String? audienceLabel,  Map<String, dynamic>? oldData,  Map<String, dynamic>? newData)  $default,) {final _that = this;
switch (_that) {
case _ActivityEntryDto():
return $default(_that.id,_that.action,_that.createdAt,_that.label,_that.roles,_that.actor,_that.title,_that.entityName,_that.entityId,_that.campaign,_that.audienceSize,_that.audienceLabel,_that.oldData,_that.newData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String action,  String createdAt,  String label,  List<String> roles,  Map<String, dynamic>? actor,  String? title,  String? entityName,  String? entityId,  Map<String, dynamic>? campaign,  int? audienceSize,  String? audienceLabel,  Map<String, dynamic>? oldData,  Map<String, dynamic>? newData)?  $default,) {final _that = this;
switch (_that) {
case _ActivityEntryDto() when $default != null:
return $default(_that.id,_that.action,_that.createdAt,_that.label,_that.roles,_that.actor,_that.title,_that.entityName,_that.entityId,_that.campaign,_that.audienceSize,_that.audienceLabel,_that.oldData,_that.newData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityEntryDto extends ActivityEntryDto {
  const _ActivityEntryDto({required this.id, required this.action, required this.createdAt, this.label = '',  List<String> roles = const <String>[],  Map<String, dynamic>? actor, this.title, this.entityName, this.entityId,  Map<String, dynamic>? campaign, this.audienceSize, this.audienceLabel,  Map<String, dynamic>? oldData,  Map<String, dynamic>? newData}): _roles = roles,_actor = actor,_campaign = campaign,_oldData = oldData,_newData = newData,super._();
  factory _ActivityEntryDto.fromJson(Map<String, dynamic> json) => _$ActivityEntryDtoFromJson(json);

@override final  String id;
@override final  String action;
@override final  String createdAt;
@override@JsonKey() final  String label;
 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

 final  Map<String, dynamic>? _actor;
@override Map<String, dynamic>? get actor {
  final value = _actor;
  if (value == null) return null;
  if (_actor is EqualUnmodifiableMapView) return _actor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? title;
@override final  String? entityName;
@override final  String? entityId;
 final  Map<String, dynamic>? _campaign;
@override Map<String, dynamic>? get campaign {
  final value = _campaign;
  if (value == null) return null;
  if (_campaign is EqualUnmodifiableMapView) return _campaign;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  int? audienceSize;
@override final  String? audienceLabel;
 final  Map<String, dynamic>? _oldData;
@override Map<String, dynamic>? get oldData {
  final value = _oldData;
  if (value == null) return null;
  if (_oldData is EqualUnmodifiableMapView) return _oldData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _newData;
@override Map<String, dynamic>? get newData {
  final value = _newData;
  if (value == null) return null;
  if (_newData is EqualUnmodifiableMapView) return _newData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ActivityEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityEntryDtoCopyWith<_ActivityEntryDto> get copyWith => __$ActivityEntryDtoCopyWithImpl<_ActivityEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.roles, _roles)&&const DeepCollectionEquality().equals(other.actor, _actor)&&(identical(other.title, title) || other.title == title)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other.campaign, _campaign)&&(identical(other.audienceSize, audienceSize) || other.audienceSize == audienceSize)&&(identical(other.audienceLabel, audienceLabel) || other.audienceLabel == audienceLabel)&&const DeepCollectionEquality().equals(other.oldData, _oldData)&&const DeepCollectionEquality().equals(other.newData, _newData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,action,createdAt,label,const DeepCollectionEquality().hash(_roles),const DeepCollectionEquality().hash(_actor),title,entityName,entityId,const DeepCollectionEquality().hash(_campaign),audienceSize,audienceLabel,const DeepCollectionEquality().hash(_oldData),const DeepCollectionEquality().hash(_newData));
}

@override
String toString() {
    return 'ActivityEntryDto(id: $id, action: $action, createdAt: $createdAt, label: $label, roles: $roles, actor: $actor, title: $title, entityName: $entityName, entityId: $entityId, campaign: $campaign, audienceSize: $audienceSize, audienceLabel: $audienceLabel, oldData: $oldData, newData: $newData)';
}


}

/// @nodoc
abstract mixin class _$ActivityEntryDtoCopyWith<$Res> implements $ActivityEntryDtoCopyWith<$Res> {
  factory _$ActivityEntryDtoCopyWith(_ActivityEntryDto value, $Res Function(_ActivityEntryDto) _then) = __$ActivityEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String action, String createdAt, String label, List<String> roles, Map<String, dynamic>? actor, String? title, String? entityName, String? entityId, Map<String, dynamic>? campaign, int? audienceSize, String? audienceLabel, Map<String, dynamic>? oldData, Map<String, dynamic>? newData
});




}
/// @nodoc
class __$ActivityEntryDtoCopyWithImpl<$Res>
    implements _$ActivityEntryDtoCopyWith<$Res> {
  __$ActivityEntryDtoCopyWithImpl(this._self, this._then);

  final _ActivityEntryDto _self;
  final $Res Function(_ActivityEntryDto) _then;

/// Create a copy of ActivityEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? action = null,Object? createdAt = null,Object? label = null,Object? roles = null,Object? actor = freezed,Object? title = freezed,Object? entityName = freezed,Object? entityId = freezed,Object? campaign = freezed,Object? audienceSize = freezed,Object? audienceLabel = freezed,Object? oldData = freezed,Object? newData = freezed,}) {
  return _then(_ActivityEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,actor: freezed == actor ? _self._actor : actor // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,entityName: freezed == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String?,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,campaign: freezed == campaign ? _self._campaign : campaign // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,audienceSize: freezed == audienceSize ? _self.audienceSize : audienceSize // ignore: cast_nullable_to_non_nullable
as int?,audienceLabel: freezed == audienceLabel ? _self.audienceLabel : audienceLabel // ignore: cast_nullable_to_non_nullable
as String?,oldData: freezed == oldData ? _self._oldData : oldData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,newData: freezed == newData ? _self._newData : newData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
