// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrgLinkRequestDto {

 String get id; String get fullName; String get muid; String get orgTitle; String? get graduationYear; bool get isAlumni; String? get linkCreatedAt;
/// Create a copy of OrgLinkRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgLinkRequestDtoCopyWith<OrgLinkRequestDto> get copyWith => _$OrgLinkRequestDtoCopyWithImpl<OrgLinkRequestDto>(this as OrgLinkRequestDto, _$identity);

  /// Serializes this OrgLinkRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgLinkRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.orgTitle, orgTitle) || other.orgTitle == orgTitle)&&(identical(other.graduationYear, graduationYear) || other.graduationYear == graduationYear)&&(identical(other.isAlumni, isAlumni) || other.isAlumni == isAlumni)&&(identical(other.linkCreatedAt, linkCreatedAt) || other.linkCreatedAt == linkCreatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,muid,orgTitle,graduationYear,isAlumni,linkCreatedAt);

@override
String toString() {
  return 'OrgLinkRequestDto(id: $id, fullName: $fullName, muid: $muid, orgTitle: $orgTitle, graduationYear: $graduationYear, isAlumni: $isAlumni, linkCreatedAt: $linkCreatedAt)';
}


}

/// @nodoc
abstract mixin class $OrgLinkRequestDtoCopyWith<$Res>  {
  factory $OrgLinkRequestDtoCopyWith(OrgLinkRequestDto value, $Res Function(OrgLinkRequestDto) _then) = _$OrgLinkRequestDtoCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String muid, String orgTitle, String? graduationYear, bool isAlumni, String? linkCreatedAt
});




}
/// @nodoc
class _$OrgLinkRequestDtoCopyWithImpl<$Res>
    implements $OrgLinkRequestDtoCopyWith<$Res> {
  _$OrgLinkRequestDtoCopyWithImpl(this._self, this._then);

  final OrgLinkRequestDto _self;
  final $Res Function(OrgLinkRequestDto) _then;

/// Create a copy of OrgLinkRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? orgTitle = null,Object? graduationYear = freezed,Object? isAlumni = null,Object? linkCreatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,orgTitle: null == orgTitle ? _self.orgTitle : orgTitle // ignore: cast_nullable_to_non_nullable
as String,graduationYear: freezed == graduationYear ? _self.graduationYear : graduationYear // ignore: cast_nullable_to_non_nullable
as String?,isAlumni: null == isAlumni ? _self.isAlumni : isAlumni // ignore: cast_nullable_to_non_nullable
as bool,linkCreatedAt: freezed == linkCreatedAt ? _self.linkCreatedAt : linkCreatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgLinkRequestDto].
extension OrgLinkRequestDtoPatterns on OrgLinkRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgLinkRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgLinkRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgLinkRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _OrgLinkRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgLinkRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrgLinkRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  String orgTitle,  String? graduationYear,  bool isAlumni,  String? linkCreatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgLinkRequestDto() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.orgTitle,_that.graduationYear,_that.isAlumni,_that.linkCreatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  String orgTitle,  String? graduationYear,  bool isAlumni,  String? linkCreatedAt)  $default,) {final _that = this;
switch (_that) {
case _OrgLinkRequestDto():
return $default(_that.id,_that.fullName,_that.muid,_that.orgTitle,_that.graduationYear,_that.isAlumni,_that.linkCreatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String muid,  String orgTitle,  String? graduationYear,  bool isAlumni,  String? linkCreatedAt)?  $default,) {final _that = this;
switch (_that) {
case _OrgLinkRequestDto() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.orgTitle,_that.graduationYear,_that.isAlumni,_that.linkCreatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrgLinkRequestDto extends OrgLinkRequestDto {
  const _OrgLinkRequestDto({required this.id, this.fullName = '', this.muid = '', this.orgTitle = '', this.graduationYear, this.isAlumni = false, this.linkCreatedAt}): super._();
  factory _OrgLinkRequestDto.fromJson(Map<String, dynamic> json) => _$OrgLinkRequestDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String fullName;
@override@JsonKey() final  String muid;
@override@JsonKey() final  String orgTitle;
@override final  String? graduationYear;
@override@JsonKey() final  bool isAlumni;
@override final  String? linkCreatedAt;

/// Create a copy of OrgLinkRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgLinkRequestDtoCopyWith<_OrgLinkRequestDto> get copyWith => __$OrgLinkRequestDtoCopyWithImpl<_OrgLinkRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrgLinkRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgLinkRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.orgTitle, orgTitle) || other.orgTitle == orgTitle)&&(identical(other.graduationYear, graduationYear) || other.graduationYear == graduationYear)&&(identical(other.isAlumni, isAlumni) || other.isAlumni == isAlumni)&&(identical(other.linkCreatedAt, linkCreatedAt) || other.linkCreatedAt == linkCreatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,muid,orgTitle,graduationYear,isAlumni,linkCreatedAt);

@override
String toString() {
  return 'OrgLinkRequestDto(id: $id, fullName: $fullName, muid: $muid, orgTitle: $orgTitle, graduationYear: $graduationYear, isAlumni: $isAlumni, linkCreatedAt: $linkCreatedAt)';
}


}

/// @nodoc
abstract mixin class _$OrgLinkRequestDtoCopyWith<$Res> implements $OrgLinkRequestDtoCopyWith<$Res> {
  factory _$OrgLinkRequestDtoCopyWith(_OrgLinkRequestDto value, $Res Function(_OrgLinkRequestDto) _then) = __$OrgLinkRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String muid, String orgTitle, String? graduationYear, bool isAlumni, String? linkCreatedAt
});




}
/// @nodoc
class __$OrgLinkRequestDtoCopyWithImpl<$Res>
    implements _$OrgLinkRequestDtoCopyWith<$Res> {
  __$OrgLinkRequestDtoCopyWithImpl(this._self, this._then);

  final _OrgLinkRequestDto _self;
  final $Res Function(_OrgLinkRequestDto) _then;

/// Create a copy of OrgLinkRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? orgTitle = null,Object? graduationYear = freezed,Object? isAlumni = null,Object? linkCreatedAt = freezed,}) {
  return _then(_OrgLinkRequestDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,orgTitle: null == orgTitle ? _self.orgTitle : orgTitle // ignore: cast_nullable_to_non_nullable
as String,graduationYear: freezed == graduationYear ? _self.graduationYear : graduationYear // ignore: cast_nullable_to_non_nullable
as String?,isAlumni: null == isAlumni ? _self.isAlumni : isAlumni // ignore: cast_nullable_to_non_nullable
as bool,linkCreatedAt: freezed == linkCreatedAt ? _self.linkCreatedAt : linkCreatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PendingCampusEventDto {

 String get id; String get title; String? get startDatetime; String? get endDatetime; String? get venueCity; List<String> get tags;
/// Create a copy of PendingCampusEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingCampusEventDtoCopyWith<PendingCampusEventDto> get copyWith => _$PendingCampusEventDtoCopyWithImpl<PendingCampusEventDto>(this as PendingCampusEventDto, _$identity);

  /// Serializes this PendingCampusEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingCampusEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startDatetime, startDatetime) || other.startDatetime == startDatetime)&&(identical(other.endDatetime, endDatetime) || other.endDatetime == endDatetime)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startDatetime,endDatetime,venueCity,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'PendingCampusEventDto(id: $id, title: $title, startDatetime: $startDatetime, endDatetime: $endDatetime, venueCity: $venueCity, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $PendingCampusEventDtoCopyWith<$Res>  {
  factory $PendingCampusEventDtoCopyWith(PendingCampusEventDto value, $Res Function(PendingCampusEventDto) _then) = _$PendingCampusEventDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? startDatetime, String? endDatetime, String? venueCity, List<String> tags
});




}
/// @nodoc
class _$PendingCampusEventDtoCopyWithImpl<$Res>
    implements $PendingCampusEventDtoCopyWith<$Res> {
  _$PendingCampusEventDtoCopyWithImpl(this._self, this._then);

  final PendingCampusEventDto _self;
  final $Res Function(PendingCampusEventDto) _then;

/// Create a copy of PendingCampusEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startDatetime = freezed,Object? endDatetime = freezed,Object? venueCity = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDatetime: freezed == startDatetime ? _self.startDatetime : startDatetime // ignore: cast_nullable_to_non_nullable
as String?,endDatetime: freezed == endDatetime ? _self.endDatetime : endDatetime // ignore: cast_nullable_to_non_nullable
as String?,venueCity: freezed == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingCampusEventDto].
extension PendingCampusEventDtoPatterns on PendingCampusEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingCampusEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingCampusEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingCampusEventDto value)  $default,){
final _that = this;
switch (_that) {
case _PendingCampusEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingCampusEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _PendingCampusEventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? startDatetime,  String? endDatetime,  String? venueCity,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingCampusEventDto() when $default != null:
return $default(_that.id,_that.title,_that.startDatetime,_that.endDatetime,_that.venueCity,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? startDatetime,  String? endDatetime,  String? venueCity,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _PendingCampusEventDto():
return $default(_that.id,_that.title,_that.startDatetime,_that.endDatetime,_that.venueCity,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? startDatetime,  String? endDatetime,  String? venueCity,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _PendingCampusEventDto() when $default != null:
return $default(_that.id,_that.title,_that.startDatetime,_that.endDatetime,_that.venueCity,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingCampusEventDto extends PendingCampusEventDto {
  const _PendingCampusEventDto({required this.id, this.title = '', this.startDatetime, this.endDatetime, this.venueCity, final  List<String> tags = const <String>[]}): _tags = tags,super._();
  factory _PendingCampusEventDto.fromJson(Map<String, dynamic> json) => _$PendingCampusEventDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String title;
@override final  String? startDatetime;
@override final  String? endDatetime;
@override final  String? venueCity;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of PendingCampusEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingCampusEventDtoCopyWith<_PendingCampusEventDto> get copyWith => __$PendingCampusEventDtoCopyWithImpl<_PendingCampusEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingCampusEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingCampusEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startDatetime, startDatetime) || other.startDatetime == startDatetime)&&(identical(other.endDatetime, endDatetime) || other.endDatetime == endDatetime)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startDatetime,endDatetime,venueCity,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'PendingCampusEventDto(id: $id, title: $title, startDatetime: $startDatetime, endDatetime: $endDatetime, venueCity: $venueCity, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$PendingCampusEventDtoCopyWith<$Res> implements $PendingCampusEventDtoCopyWith<$Res> {
  factory _$PendingCampusEventDtoCopyWith(_PendingCampusEventDto value, $Res Function(_PendingCampusEventDto) _then) = __$PendingCampusEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? startDatetime, String? endDatetime, String? venueCity, List<String> tags
});




}
/// @nodoc
class __$PendingCampusEventDtoCopyWithImpl<$Res>
    implements _$PendingCampusEventDtoCopyWith<$Res> {
  __$PendingCampusEventDtoCopyWithImpl(this._self, this._then);

  final _PendingCampusEventDto _self;
  final $Res Function(_PendingCampusEventDto) _then;

/// Create a copy of PendingCampusEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startDatetime = freezed,Object? endDatetime = freezed,Object? venueCity = freezed,Object? tags = null,}) {
  return _then(_PendingCampusEventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDatetime: freezed == startDatetime ? _self.startDatetime : startDatetime // ignore: cast_nullable_to_non_nullable
as String?,endDatetime: freezed == endDatetime ? _self.endDatetime : endDatetime // ignore: cast_nullable_to_non_nullable
as String?,venueCity: freezed == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$CollabInviteDto {

 String get id; String get eventId; String get eventTitle; String? get eventStartDatetime; String get roleLabel; Map<String, dynamic>? get entityDetail;
/// Create a copy of CollabInviteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollabInviteDtoCopyWith<CollabInviteDto> get copyWith => _$CollabInviteDtoCopyWithImpl<CollabInviteDto>(this as CollabInviteDto, _$identity);

  /// Serializes this CollabInviteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollabInviteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventTitle, eventTitle) || other.eventTitle == eventTitle)&&(identical(other.eventStartDatetime, eventStartDatetime) || other.eventStartDatetime == eventStartDatetime)&&(identical(other.roleLabel, roleLabel) || other.roleLabel == roleLabel)&&const DeepCollectionEquality().equals(other.entityDetail, entityDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,eventTitle,eventStartDatetime,roleLabel,const DeepCollectionEquality().hash(entityDetail));

@override
String toString() {
  return 'CollabInviteDto(id: $id, eventId: $eventId, eventTitle: $eventTitle, eventStartDatetime: $eventStartDatetime, roleLabel: $roleLabel, entityDetail: $entityDetail)';
}


}

/// @nodoc
abstract mixin class $CollabInviteDtoCopyWith<$Res>  {
  factory $CollabInviteDtoCopyWith(CollabInviteDto value, $Res Function(CollabInviteDto) _then) = _$CollabInviteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String eventId, String eventTitle, String? eventStartDatetime, String roleLabel, Map<String, dynamic>? entityDetail
});




}
/// @nodoc
class _$CollabInviteDtoCopyWithImpl<$Res>
    implements $CollabInviteDtoCopyWith<$Res> {
  _$CollabInviteDtoCopyWithImpl(this._self, this._then);

  final CollabInviteDto _self;
  final $Res Function(CollabInviteDto) _then;

/// Create a copy of CollabInviteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? eventTitle = null,Object? eventStartDatetime = freezed,Object? roleLabel = null,Object? entityDetail = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,eventTitle: null == eventTitle ? _self.eventTitle : eventTitle // ignore: cast_nullable_to_non_nullable
as String,eventStartDatetime: freezed == eventStartDatetime ? _self.eventStartDatetime : eventStartDatetime // ignore: cast_nullable_to_non_nullable
as String?,roleLabel: null == roleLabel ? _self.roleLabel : roleLabel // ignore: cast_nullable_to_non_nullable
as String,entityDetail: freezed == entityDetail ? _self.entityDetail : entityDetail // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CollabInviteDto].
extension CollabInviteDtoPatterns on CollabInviteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollabInviteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollabInviteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollabInviteDto value)  $default,){
final _that = this;
switch (_that) {
case _CollabInviteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollabInviteDto value)?  $default,){
final _that = this;
switch (_that) {
case _CollabInviteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eventId,  String eventTitle,  String? eventStartDatetime,  String roleLabel,  Map<String, dynamic>? entityDetail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollabInviteDto() when $default != null:
return $default(_that.id,_that.eventId,_that.eventTitle,_that.eventStartDatetime,_that.roleLabel,_that.entityDetail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eventId,  String eventTitle,  String? eventStartDatetime,  String roleLabel,  Map<String, dynamic>? entityDetail)  $default,) {final _that = this;
switch (_that) {
case _CollabInviteDto():
return $default(_that.id,_that.eventId,_that.eventTitle,_that.eventStartDatetime,_that.roleLabel,_that.entityDetail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eventId,  String eventTitle,  String? eventStartDatetime,  String roleLabel,  Map<String, dynamic>? entityDetail)?  $default,) {final _that = this;
switch (_that) {
case _CollabInviteDto() when $default != null:
return $default(_that.id,_that.eventId,_that.eventTitle,_that.eventStartDatetime,_that.roleLabel,_that.entityDetail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollabInviteDto extends CollabInviteDto {
  const _CollabInviteDto({required this.id, required this.eventId, this.eventTitle = '', this.eventStartDatetime, this.roleLabel = '', final  Map<String, dynamic>? entityDetail}): _entityDetail = entityDetail,super._();
  factory _CollabInviteDto.fromJson(Map<String, dynamic> json) => _$CollabInviteDtoFromJson(json);

@override final  String id;
@override final  String eventId;
@override@JsonKey() final  String eventTitle;
@override final  String? eventStartDatetime;
@override@JsonKey() final  String roleLabel;
 final  Map<String, dynamic>? _entityDetail;
@override Map<String, dynamic>? get entityDetail {
  final value = _entityDetail;
  if (value == null) return null;
  if (_entityDetail is EqualUnmodifiableMapView) return _entityDetail;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of CollabInviteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollabInviteDtoCopyWith<_CollabInviteDto> get copyWith => __$CollabInviteDtoCopyWithImpl<_CollabInviteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollabInviteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollabInviteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventTitle, eventTitle) || other.eventTitle == eventTitle)&&(identical(other.eventStartDatetime, eventStartDatetime) || other.eventStartDatetime == eventStartDatetime)&&(identical(other.roleLabel, roleLabel) || other.roleLabel == roleLabel)&&const DeepCollectionEquality().equals(other._entityDetail, _entityDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,eventTitle,eventStartDatetime,roleLabel,const DeepCollectionEquality().hash(_entityDetail));

@override
String toString() {
  return 'CollabInviteDto(id: $id, eventId: $eventId, eventTitle: $eventTitle, eventStartDatetime: $eventStartDatetime, roleLabel: $roleLabel, entityDetail: $entityDetail)';
}


}

/// @nodoc
abstract mixin class _$CollabInviteDtoCopyWith<$Res> implements $CollabInviteDtoCopyWith<$Res> {
  factory _$CollabInviteDtoCopyWith(_CollabInviteDto value, $Res Function(_CollabInviteDto) _then) = __$CollabInviteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String eventId, String eventTitle, String? eventStartDatetime, String roleLabel, Map<String, dynamic>? entityDetail
});




}
/// @nodoc
class __$CollabInviteDtoCopyWithImpl<$Res>
    implements _$CollabInviteDtoCopyWith<$Res> {
  __$CollabInviteDtoCopyWithImpl(this._self, this._then);

  final _CollabInviteDto _self;
  final $Res Function(_CollabInviteDto) _then;

/// Create a copy of CollabInviteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? eventTitle = null,Object? eventStartDatetime = freezed,Object? roleLabel = null,Object? entityDetail = freezed,}) {
  return _then(_CollabInviteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,eventTitle: null == eventTitle ? _self.eventTitle : eventTitle // ignore: cast_nullable_to_non_nullable
as String,eventStartDatetime: freezed == eventStartDatetime ? _self.eventStartDatetime : eventStartDatetime // ignore: cast_nullable_to_non_nullable
as String?,roleLabel: null == roleLabel ? _self.roleLabel : roleLabel // ignore: cast_nullable_to_non_nullable
as String,entityDetail: freezed == entityDetail ? _self._entityDetail : entityDetail // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
