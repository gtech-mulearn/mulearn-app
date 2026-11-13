// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrgLinkRequest {

 String get id; String get fullName; String get muid; String get orgTitle; bool get isAlumni; DateTime? get requestedAt; String? get graduationYear;
/// Create a copy of OrgLinkRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgLinkRequestCopyWith<OrgLinkRequest> get copyWith => _$OrgLinkRequestCopyWithImpl<OrgLinkRequest>(this as OrgLinkRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgLinkRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.orgTitle, orgTitle) || other.orgTitle == orgTitle)&&(identical(other.isAlumni, isAlumni) || other.isAlumni == isAlumni)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.graduationYear, graduationYear) || other.graduationYear == graduationYear));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,muid,orgTitle,isAlumni,requestedAt,graduationYear);

@override
String toString() {
  return 'OrgLinkRequest(id: $id, fullName: $fullName, muid: $muid, orgTitle: $orgTitle, isAlumni: $isAlumni, requestedAt: $requestedAt, graduationYear: $graduationYear)';
}


}

/// @nodoc
abstract mixin class $OrgLinkRequestCopyWith<$Res>  {
  factory $OrgLinkRequestCopyWith(OrgLinkRequest value, $Res Function(OrgLinkRequest) _then) = _$OrgLinkRequestCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String muid, String orgTitle, bool isAlumni, DateTime? requestedAt, String? graduationYear
});




}
/// @nodoc
class _$OrgLinkRequestCopyWithImpl<$Res>
    implements $OrgLinkRequestCopyWith<$Res> {
  _$OrgLinkRequestCopyWithImpl(this._self, this._then);

  final OrgLinkRequest _self;
  final $Res Function(OrgLinkRequest) _then;

/// Create a copy of OrgLinkRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? orgTitle = null,Object? isAlumni = null,Object? requestedAt = freezed,Object? graduationYear = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,orgTitle: null == orgTitle ? _self.orgTitle : orgTitle // ignore: cast_nullable_to_non_nullable
as String,isAlumni: null == isAlumni ? _self.isAlumni : isAlumni // ignore: cast_nullable_to_non_nullable
as bool,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,graduationYear: freezed == graduationYear ? _self.graduationYear : graduationYear // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgLinkRequest].
extension OrgLinkRequestPatterns on OrgLinkRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgLinkRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgLinkRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgLinkRequest value)  $default,){
final _that = this;
switch (_that) {
case _OrgLinkRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgLinkRequest value)?  $default,){
final _that = this;
switch (_that) {
case _OrgLinkRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  String orgTitle,  bool isAlumni,  DateTime? requestedAt,  String? graduationYear)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgLinkRequest() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.orgTitle,_that.isAlumni,_that.requestedAt,_that.graduationYear);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  String orgTitle,  bool isAlumni,  DateTime? requestedAt,  String? graduationYear)  $default,) {final _that = this;
switch (_that) {
case _OrgLinkRequest():
return $default(_that.id,_that.fullName,_that.muid,_that.orgTitle,_that.isAlumni,_that.requestedAt,_that.graduationYear);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String muid,  String orgTitle,  bool isAlumni,  DateTime? requestedAt,  String? graduationYear)?  $default,) {final _that = this;
switch (_that) {
case _OrgLinkRequest() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.orgTitle,_that.isAlumni,_that.requestedAt,_that.graduationYear);case _:
  return null;

}
}

}

/// @nodoc


class _OrgLinkRequest implements OrgLinkRequest {
  const _OrgLinkRequest({required this.id, required this.fullName, required this.muid, required this.orgTitle, required this.isAlumni, this.requestedAt, this.graduationYear});
  

@override final  String id;
@override final  String fullName;
@override final  String muid;
@override final  String orgTitle;
@override final  bool isAlumni;
@override final  DateTime? requestedAt;
@override final  String? graduationYear;

/// Create a copy of OrgLinkRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgLinkRequestCopyWith<_OrgLinkRequest> get copyWith => __$OrgLinkRequestCopyWithImpl<_OrgLinkRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgLinkRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.orgTitle, orgTitle) || other.orgTitle == orgTitle)&&(identical(other.isAlumni, isAlumni) || other.isAlumni == isAlumni)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.graduationYear, graduationYear) || other.graduationYear == graduationYear));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,muid,orgTitle,isAlumni,requestedAt,graduationYear);

@override
String toString() {
  return 'OrgLinkRequest(id: $id, fullName: $fullName, muid: $muid, orgTitle: $orgTitle, isAlumni: $isAlumni, requestedAt: $requestedAt, graduationYear: $graduationYear)';
}


}

/// @nodoc
abstract mixin class _$OrgLinkRequestCopyWith<$Res> implements $OrgLinkRequestCopyWith<$Res> {
  factory _$OrgLinkRequestCopyWith(_OrgLinkRequest value, $Res Function(_OrgLinkRequest) _then) = __$OrgLinkRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String muid, String orgTitle, bool isAlumni, DateTime? requestedAt, String? graduationYear
});




}
/// @nodoc
class __$OrgLinkRequestCopyWithImpl<$Res>
    implements _$OrgLinkRequestCopyWith<$Res> {
  __$OrgLinkRequestCopyWithImpl(this._self, this._then);

  final _OrgLinkRequest _self;
  final $Res Function(_OrgLinkRequest) _then;

/// Create a copy of OrgLinkRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? orgTitle = null,Object? isAlumni = null,Object? requestedAt = freezed,Object? graduationYear = freezed,}) {
  return _then(_OrgLinkRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,orgTitle: null == orgTitle ? _self.orgTitle : orgTitle // ignore: cast_nullable_to_non_nullable
as String,isAlumni: null == isAlumni ? _self.isAlumni : isAlumni // ignore: cast_nullable_to_non_nullable
as bool,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,graduationYear: freezed == graduationYear ? _self.graduationYear : graduationYear // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PendingCampusEvent {

 String get id; String get title; List<String> get tags; DateTime? get start; DateTime? get end; String? get venueCity;
/// Create a copy of PendingCampusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingCampusEventCopyWith<PendingCampusEvent> get copyWith => _$PendingCampusEventCopyWithImpl<PendingCampusEvent>(this as PendingCampusEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingCampusEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(tags),start,end,venueCity);

@override
String toString() {
  return 'PendingCampusEvent(id: $id, title: $title, tags: $tags, start: $start, end: $end, venueCity: $venueCity)';
}


}

/// @nodoc
abstract mixin class $PendingCampusEventCopyWith<$Res>  {
  factory $PendingCampusEventCopyWith(PendingCampusEvent value, $Res Function(PendingCampusEvent) _then) = _$PendingCampusEventCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<String> tags, DateTime? start, DateTime? end, String? venueCity
});




}
/// @nodoc
class _$PendingCampusEventCopyWithImpl<$Res>
    implements $PendingCampusEventCopyWith<$Res> {
  _$PendingCampusEventCopyWithImpl(this._self, this._then);

  final PendingCampusEvent _self;
  final $Res Function(PendingCampusEvent) _then;

/// Create a copy of PendingCampusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? tags = null,Object? start = freezed,Object? end = freezed,Object? venueCity = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime?,venueCity: freezed == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingCampusEvent].
extension PendingCampusEventPatterns on PendingCampusEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingCampusEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingCampusEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingCampusEvent value)  $default,){
final _that = this;
switch (_that) {
case _PendingCampusEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingCampusEvent value)?  $default,){
final _that = this;
switch (_that) {
case _PendingCampusEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<String> tags,  DateTime? start,  DateTime? end,  String? venueCity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingCampusEvent() when $default != null:
return $default(_that.id,_that.title,_that.tags,_that.start,_that.end,_that.venueCity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<String> tags,  DateTime? start,  DateTime? end,  String? venueCity)  $default,) {final _that = this;
switch (_that) {
case _PendingCampusEvent():
return $default(_that.id,_that.title,_that.tags,_that.start,_that.end,_that.venueCity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<String> tags,  DateTime? start,  DateTime? end,  String? venueCity)?  $default,) {final _that = this;
switch (_that) {
case _PendingCampusEvent() when $default != null:
return $default(_that.id,_that.title,_that.tags,_that.start,_that.end,_that.venueCity);case _:
  return null;

}
}

}

/// @nodoc


class _PendingCampusEvent implements PendingCampusEvent {
  const _PendingCampusEvent({required this.id, required this.title, required final  List<String> tags, this.start, this.end, this.venueCity}): _tags = tags;
  

@override final  String id;
@override final  String title;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime? start;
@override final  DateTime? end;
@override final  String? venueCity;

/// Create a copy of PendingCampusEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingCampusEventCopyWith<_PendingCampusEvent> get copyWith => __$PendingCampusEventCopyWithImpl<_PendingCampusEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingCampusEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_tags),start,end,venueCity);

@override
String toString() {
  return 'PendingCampusEvent(id: $id, title: $title, tags: $tags, start: $start, end: $end, venueCity: $venueCity)';
}


}

/// @nodoc
abstract mixin class _$PendingCampusEventCopyWith<$Res> implements $PendingCampusEventCopyWith<$Res> {
  factory _$PendingCampusEventCopyWith(_PendingCampusEvent value, $Res Function(_PendingCampusEvent) _then) = __$PendingCampusEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<String> tags, DateTime? start, DateTime? end, String? venueCity
});




}
/// @nodoc
class __$PendingCampusEventCopyWithImpl<$Res>
    implements _$PendingCampusEventCopyWith<$Res> {
  __$PendingCampusEventCopyWithImpl(this._self, this._then);

  final _PendingCampusEvent _self;
  final $Res Function(_PendingCampusEvent) _then;

/// Create a copy of PendingCampusEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? tags = null,Object? start = freezed,Object? end = freezed,Object? venueCity = freezed,}) {
  return _then(_PendingCampusEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime?,venueCity: freezed == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CollabInvite {

 String get id; String get eventId; String get eventTitle; String get roleLabel; String get entityName; DateTime? get eventStart;
/// Create a copy of CollabInvite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollabInviteCopyWith<CollabInvite> get copyWith => _$CollabInviteCopyWithImpl<CollabInvite>(this as CollabInvite, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollabInvite&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventTitle, eventTitle) || other.eventTitle == eventTitle)&&(identical(other.roleLabel, roleLabel) || other.roleLabel == roleLabel)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.eventStart, eventStart) || other.eventStart == eventStart));
}


@override
int get hashCode => Object.hash(runtimeType,id,eventId,eventTitle,roleLabel,entityName,eventStart);

@override
String toString() {
  return 'CollabInvite(id: $id, eventId: $eventId, eventTitle: $eventTitle, roleLabel: $roleLabel, entityName: $entityName, eventStart: $eventStart)';
}


}

/// @nodoc
abstract mixin class $CollabInviteCopyWith<$Res>  {
  factory $CollabInviteCopyWith(CollabInvite value, $Res Function(CollabInvite) _then) = _$CollabInviteCopyWithImpl;
@useResult
$Res call({
 String id, String eventId, String eventTitle, String roleLabel, String entityName, DateTime? eventStart
});




}
/// @nodoc
class _$CollabInviteCopyWithImpl<$Res>
    implements $CollabInviteCopyWith<$Res> {
  _$CollabInviteCopyWithImpl(this._self, this._then);

  final CollabInvite _self;
  final $Res Function(CollabInvite) _then;

/// Create a copy of CollabInvite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? eventTitle = null,Object? roleLabel = null,Object? entityName = null,Object? eventStart = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,eventTitle: null == eventTitle ? _self.eventTitle : eventTitle // ignore: cast_nullable_to_non_nullable
as String,roleLabel: null == roleLabel ? _self.roleLabel : roleLabel // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,eventStart: freezed == eventStart ? _self.eventStart : eventStart // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CollabInvite].
extension CollabInvitePatterns on CollabInvite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollabInvite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollabInvite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollabInvite value)  $default,){
final _that = this;
switch (_that) {
case _CollabInvite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollabInvite value)?  $default,){
final _that = this;
switch (_that) {
case _CollabInvite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eventId,  String eventTitle,  String roleLabel,  String entityName,  DateTime? eventStart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollabInvite() when $default != null:
return $default(_that.id,_that.eventId,_that.eventTitle,_that.roleLabel,_that.entityName,_that.eventStart);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eventId,  String eventTitle,  String roleLabel,  String entityName,  DateTime? eventStart)  $default,) {final _that = this;
switch (_that) {
case _CollabInvite():
return $default(_that.id,_that.eventId,_that.eventTitle,_that.roleLabel,_that.entityName,_that.eventStart);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eventId,  String eventTitle,  String roleLabel,  String entityName,  DateTime? eventStart)?  $default,) {final _that = this;
switch (_that) {
case _CollabInvite() when $default != null:
return $default(_that.id,_that.eventId,_that.eventTitle,_that.roleLabel,_that.entityName,_that.eventStart);case _:
  return null;

}
}

}

/// @nodoc


class _CollabInvite implements CollabInvite {
  const _CollabInvite({required this.id, required this.eventId, required this.eventTitle, required this.roleLabel, required this.entityName, this.eventStart});
  

@override final  String id;
@override final  String eventId;
@override final  String eventTitle;
@override final  String roleLabel;
@override final  String entityName;
@override final  DateTime? eventStart;

/// Create a copy of CollabInvite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollabInviteCopyWith<_CollabInvite> get copyWith => __$CollabInviteCopyWithImpl<_CollabInvite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollabInvite&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventTitle, eventTitle) || other.eventTitle == eventTitle)&&(identical(other.roleLabel, roleLabel) || other.roleLabel == roleLabel)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.eventStart, eventStart) || other.eventStart == eventStart));
}


@override
int get hashCode => Object.hash(runtimeType,id,eventId,eventTitle,roleLabel,entityName,eventStart);

@override
String toString() {
  return 'CollabInvite(id: $id, eventId: $eventId, eventTitle: $eventTitle, roleLabel: $roleLabel, entityName: $entityName, eventStart: $eventStart)';
}


}

/// @nodoc
abstract mixin class _$CollabInviteCopyWith<$Res> implements $CollabInviteCopyWith<$Res> {
  factory _$CollabInviteCopyWith(_CollabInvite value, $Res Function(_CollabInvite) _then) = __$CollabInviteCopyWithImpl;
@override @useResult
$Res call({
 String id, String eventId, String eventTitle, String roleLabel, String entityName, DateTime? eventStart
});




}
/// @nodoc
class __$CollabInviteCopyWithImpl<$Res>
    implements _$CollabInviteCopyWith<$Res> {
  __$CollabInviteCopyWithImpl(this._self, this._then);

  final _CollabInvite _self;
  final $Res Function(_CollabInvite) _then;

/// Create a copy of CollabInvite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? eventTitle = null,Object? roleLabel = null,Object? entityName = null,Object? eventStart = freezed,}) {
  return _then(_CollabInvite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,eventTitle: null == eventTitle ? _self.eventTitle : eventTitle // ignore: cast_nullable_to_non_nullable
as String,roleLabel: null == roleLabel ? _self.roleLabel : roleLabel // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,eventStart: freezed == eventStart ? _self.eventStart : eventStart // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
