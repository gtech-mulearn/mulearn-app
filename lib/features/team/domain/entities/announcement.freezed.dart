// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Announcement {

 String get id; String get title; String get description; String get targetType; AnnouncementSource get source; DateTime get createdAt; DateTime get expiresAt; String? get url; String? get targetName; String? get createdByName;
/// Create a copy of Announcement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementCopyWith<Announcement> get copyWith => _$AnnouncementCopyWithImpl<Announcement>(this as Announcement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Announcement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Announcement&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.targetType, _this.targetType) || other.targetType == _this.targetType)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.targetName, _this.targetName) || other.targetName == _this.targetName)&&(identical(other.createdByName, _this.createdByName) || other.createdByName == _this.createdByName));
}


@override
int get hashCode {
  final _this = this as Announcement;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.targetType,_this.source,_this.createdAt,_this.expiresAt,_this.url,_this.targetName,_this.createdByName);
}

@override
String toString() {
  final _this = this as Announcement;
  return 'Announcement(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, targetType: ${_this.targetType}, source: ${_this.source}, createdAt: ${_this.createdAt}, expiresAt: ${_this.expiresAt}, url: ${_this.url}, targetName: ${_this.targetName}, createdByName: ${_this.createdByName})';
}


}

/// @nodoc
abstract mixin class $AnnouncementCopyWith<$Res>  {
  factory $AnnouncementCopyWith(Announcement value, $Res Function(Announcement) _then) = _$AnnouncementCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String targetType, AnnouncementSource source, DateTime createdAt, DateTime expiresAt, String? url, String? targetName, String? createdByName
});




}
/// @nodoc
class _$AnnouncementCopyWithImpl<$Res>
    implements $AnnouncementCopyWith<$Res> {
  _$AnnouncementCopyWithImpl(this._self, this._then);

  final Announcement _self;
  final $Res Function(Announcement) _then;

/// Create a copy of Announcement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? targetType = null,Object? source = null,Object? createdAt = null,Object? expiresAt = null,Object? url = freezed,Object? targetName = freezed,Object? createdByName = freezed,}) {
  return _then(Announcement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as AnnouncementSource,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,targetName: freezed == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Announcement].
extension AnnouncementPatterns on Announcement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Announcement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Announcement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Announcement value)  $default,){
final _that = this;
switch (_that) {
case _Announcement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Announcement value)?  $default,){
final _that = this;
switch (_that) {
case _Announcement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String targetType,  AnnouncementSource source,  DateTime createdAt,  DateTime expiresAt,  String? url,  String? targetName,  String? createdByName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Announcement() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.targetType,_that.source,_that.createdAt,_that.expiresAt,_that.url,_that.targetName,_that.createdByName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String targetType,  AnnouncementSource source,  DateTime createdAt,  DateTime expiresAt,  String? url,  String? targetName,  String? createdByName)  $default,) {final _that = this;
switch (_that) {
case _Announcement():
return $default(_that.id,_that.title,_that.description,_that.targetType,_that.source,_that.createdAt,_that.expiresAt,_that.url,_that.targetName,_that.createdByName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String targetType,  AnnouncementSource source,  DateTime createdAt,  DateTime expiresAt,  String? url,  String? targetName,  String? createdByName)?  $default,) {final _that = this;
switch (_that) {
case _Announcement() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.targetType,_that.source,_that.createdAt,_that.expiresAt,_that.url,_that.targetName,_that.createdByName);case _:
  return null;

}
}

}

/// @nodoc


class _Announcement implements Announcement {
  const _Announcement({required this.id, required this.title, required this.description, required this.targetType, required this.source, required this.createdAt, required this.expiresAt, this.url, this.targetName, this.createdByName});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String targetType;
@override final  AnnouncementSource source;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;
@override final  String? url;
@override final  String? targetName;
@override final  String? createdByName;

/// Create a copy of Announcement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementCopyWith<_Announcement> get copyWith => __$AnnouncementCopyWithImpl<_Announcement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Announcement&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.source, source) || other.source == source)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.url, url) || other.url == url)&&(identical(other.targetName, targetName) || other.targetName == targetName)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,targetType,source,createdAt,expiresAt,url,targetName,createdByName);
}

@override
String toString() {
    return 'Announcement(id: $id, title: $title, description: $description, targetType: $targetType, source: $source, createdAt: $createdAt, expiresAt: $expiresAt, url: $url, targetName: $targetName, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementCopyWith<$Res> implements $AnnouncementCopyWith<$Res> {
  factory _$AnnouncementCopyWith(_Announcement value, $Res Function(_Announcement) _then) = __$AnnouncementCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String targetType, AnnouncementSource source, DateTime createdAt, DateTime expiresAt, String? url, String? targetName, String? createdByName
});




}
/// @nodoc
class __$AnnouncementCopyWithImpl<$Res>
    implements _$AnnouncementCopyWith<$Res> {
  __$AnnouncementCopyWithImpl(this._self, this._then);

  final _Announcement _self;
  final $Res Function(_Announcement) _then;

/// Create a copy of Announcement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? targetType = null,Object? source = null,Object? createdAt = null,Object? expiresAt = null,Object? url = freezed,Object? targetName = freezed,Object? createdByName = freezed,}) {
  return _then(_Announcement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as AnnouncementSource,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,targetName: freezed == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String?,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
