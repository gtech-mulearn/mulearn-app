// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnnouncementDto {

 String get id; String get createdAt; String get expiresAt; String get title; String get description; String get targetType; String get source; String? get url; Map<String, dynamic>? get targetDetails; String? get createdByName;
/// Create a copy of AnnouncementDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementDtoCopyWith<AnnouncementDto> get copyWith => _$AnnouncementDtoCopyWithImpl<AnnouncementDto>(this as AnnouncementDto, _$identity);

  /// Serializes this AnnouncementDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AnnouncementDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.targetType, _this.targetType) || other.targetType == _this.targetType)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.url, _this.url) || other.url == _this.url)&&const DeepCollectionEquality().equals(other.targetDetails, _this.targetDetails)&&(identical(other.createdByName, _this.createdByName) || other.createdByName == _this.createdByName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AnnouncementDto;
  return Object.hash(runtimeType,_this.id,_this.createdAt,_this.expiresAt,_this.title,_this.description,_this.targetType,_this.source,_this.url,const DeepCollectionEquality().hash(_this.targetDetails),_this.createdByName);
}

@override
String toString() {
  final _this = this as AnnouncementDto;
  return 'AnnouncementDto(id: ${_this.id}, createdAt: ${_this.createdAt}, expiresAt: ${_this.expiresAt}, title: ${_this.title}, description: ${_this.description}, targetType: ${_this.targetType}, source: ${_this.source}, url: ${_this.url}, targetDetails: ${_this.targetDetails}, createdByName: ${_this.createdByName})';
}


}

/// @nodoc
abstract mixin class $AnnouncementDtoCopyWith<$Res>  {
  factory $AnnouncementDtoCopyWith(AnnouncementDto value, $Res Function(AnnouncementDto) _then) = _$AnnouncementDtoCopyWithImpl;
@useResult
$Res call({
 String id, String createdAt, String expiresAt, String title, String description, String targetType, String source, String? url, Map<String, dynamic>? targetDetails, String? createdByName
});




}
/// @nodoc
class _$AnnouncementDtoCopyWithImpl<$Res>
    implements $AnnouncementDtoCopyWith<$Res> {
  _$AnnouncementDtoCopyWithImpl(this._self, this._then);

  final AnnouncementDto _self;
  final $Res Function(AnnouncementDto) _then;

/// Create a copy of AnnouncementDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? expiresAt = null,Object? title = null,Object? description = null,Object? targetType = null,Object? source = null,Object? url = freezed,Object? targetDetails = freezed,Object? createdByName = freezed,}) {
  return _then(AnnouncementDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,targetDetails: freezed == targetDetails ? _self.targetDetails : targetDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementDto].
extension AnnouncementDtoPatterns on AnnouncementDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementDto value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementDto value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String createdAt,  String expiresAt,  String title,  String description,  String targetType,  String source,  String? url,  Map<String, dynamic>? targetDetails,  String? createdByName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.title,_that.description,_that.targetType,_that.source,_that.url,_that.targetDetails,_that.createdByName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String createdAt,  String expiresAt,  String title,  String description,  String targetType,  String source,  String? url,  Map<String, dynamic>? targetDetails,  String? createdByName)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementDto():
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.title,_that.description,_that.targetType,_that.source,_that.url,_that.targetDetails,_that.createdByName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String createdAt,  String expiresAt,  String title,  String description,  String targetType,  String source,  String? url,  Map<String, dynamic>? targetDetails,  String? createdByName)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.expiresAt,_that.title,_that.description,_that.targetType,_that.source,_that.url,_that.targetDetails,_that.createdByName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementDto extends AnnouncementDto {
  const _AnnouncementDto({required this.id, required this.createdAt, required this.expiresAt, this.title = '', this.description = '', this.targetType = 'global', this.source = 'system', this.url,  Map<String, dynamic>? targetDetails, this.createdByName}): _targetDetails = targetDetails,super._();
  factory _AnnouncementDto.fromJson(Map<String, dynamic> json) => _$AnnouncementDtoFromJson(json);

@override final  String id;
@override final  String createdAt;
@override final  String expiresAt;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String targetType;
@override@JsonKey() final  String source;
@override final  String? url;
 final  Map<String, dynamic>? _targetDetails;
@override Map<String, dynamic>? get targetDetails {
  final value = _targetDetails;
  if (value == null) return null;
  if (_targetDetails is EqualUnmodifiableMapView) return _targetDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? createdByName;

/// Create a copy of AnnouncementDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementDtoCopyWith<_AnnouncementDto> get copyWith => __$AnnouncementDtoCopyWithImpl<_AnnouncementDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementDto&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.source, source) || other.source == source)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.targetDetails, _targetDetails)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,expiresAt,title,description,targetType,source,url,const DeepCollectionEquality().hash(_targetDetails),createdByName);
}

@override
String toString() {
    return 'AnnouncementDto(id: $id, createdAt: $createdAt, expiresAt: $expiresAt, title: $title, description: $description, targetType: $targetType, source: $source, url: $url, targetDetails: $targetDetails, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementDtoCopyWith<$Res> implements $AnnouncementDtoCopyWith<$Res> {
  factory _$AnnouncementDtoCopyWith(_AnnouncementDto value, $Res Function(_AnnouncementDto) _then) = __$AnnouncementDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String createdAt, String expiresAt, String title, String description, String targetType, String source, String? url, Map<String, dynamic>? targetDetails, String? createdByName
});




}
/// @nodoc
class __$AnnouncementDtoCopyWithImpl<$Res>
    implements _$AnnouncementDtoCopyWith<$Res> {
  __$AnnouncementDtoCopyWithImpl(this._self, this._then);

  final _AnnouncementDto _self;
  final $Res Function(_AnnouncementDto) _then;

/// Create a copy of AnnouncementDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? expiresAt = null,Object? title = null,Object? description = null,Object? targetType = null,Object? source = null,Object? url = freezed,Object? targetDetails = freezed,Object? createdByName = freezed,}) {
  return _then(_AnnouncementDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,targetDetails: freezed == targetDetails ? _self._targetDetails : targetDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
