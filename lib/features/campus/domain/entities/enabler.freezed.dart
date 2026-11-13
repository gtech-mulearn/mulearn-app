// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enabler.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EnablerCampus {

 String get id; String get collegeName; String get campusCode; String get zone; String get orgType;
/// Create a copy of EnablerCampus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnablerCampusCopyWith<EnablerCampus> get copyWith => _$EnablerCampusCopyWithImpl<EnablerCampus>(this as EnablerCampus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnablerCampus&&(identical(other.id, id) || other.id == id)&&(identical(other.collegeName, collegeName) || other.collegeName == collegeName)&&(identical(other.campusCode, campusCode) || other.campusCode == campusCode)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}


@override
int get hashCode => Object.hash(runtimeType,id,collegeName,campusCode,zone,orgType);

@override
String toString() {
  return 'EnablerCampus(id: $id, collegeName: $collegeName, campusCode: $campusCode, zone: $zone, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class $EnablerCampusCopyWith<$Res>  {
  factory $EnablerCampusCopyWith(EnablerCampus value, $Res Function(EnablerCampus) _then) = _$EnablerCampusCopyWithImpl;
@useResult
$Res call({
 String id, String collegeName, String campusCode, String zone, String orgType
});




}
/// @nodoc
class _$EnablerCampusCopyWithImpl<$Res>
    implements $EnablerCampusCopyWith<$Res> {
  _$EnablerCampusCopyWithImpl(this._self, this._then);

  final EnablerCampus _self;
  final $Res Function(EnablerCampus) _then;

/// Create a copy of EnablerCampus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? collegeName = null,Object? campusCode = null,Object? zone = null,Object? orgType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collegeName: null == collegeName ? _self.collegeName : collegeName // ignore: cast_nullable_to_non_nullable
as String,campusCode: null == campusCode ? _self.campusCode : campusCode // ignore: cast_nullable_to_non_nullable
as String,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EnablerCampus].
extension EnablerCampusPatterns on EnablerCampus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnablerCampus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnablerCampus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnablerCampus value)  $default,){
final _that = this;
switch (_that) {
case _EnablerCampus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnablerCampus value)?  $default,){
final _that = this;
switch (_that) {
case _EnablerCampus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String collegeName,  String campusCode,  String zone,  String orgType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnablerCampus() when $default != null:
return $default(_that.id,_that.collegeName,_that.campusCode,_that.zone,_that.orgType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String collegeName,  String campusCode,  String zone,  String orgType)  $default,) {final _that = this;
switch (_that) {
case _EnablerCampus():
return $default(_that.id,_that.collegeName,_that.campusCode,_that.zone,_that.orgType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String collegeName,  String campusCode,  String zone,  String orgType)?  $default,) {final _that = this;
switch (_that) {
case _EnablerCampus() when $default != null:
return $default(_that.id,_that.collegeName,_that.campusCode,_that.zone,_that.orgType);case _:
  return null;

}
}

}

/// @nodoc


class _EnablerCampus implements EnablerCampus {
  const _EnablerCampus({required this.id, required this.collegeName, required this.campusCode, required this.zone, required this.orgType});
  

@override final  String id;
@override final  String collegeName;
@override final  String campusCode;
@override final  String zone;
@override final  String orgType;

/// Create a copy of EnablerCampus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnablerCampusCopyWith<_EnablerCampus> get copyWith => __$EnablerCampusCopyWithImpl<_EnablerCampus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnablerCampus&&(identical(other.id, id) || other.id == id)&&(identical(other.collegeName, collegeName) || other.collegeName == collegeName)&&(identical(other.campusCode, campusCode) || other.campusCode == campusCode)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}


@override
int get hashCode => Object.hash(runtimeType,id,collegeName,campusCode,zone,orgType);

@override
String toString() {
  return 'EnablerCampus(id: $id, collegeName: $collegeName, campusCode: $campusCode, zone: $zone, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class _$EnablerCampusCopyWith<$Res> implements $EnablerCampusCopyWith<$Res> {
  factory _$EnablerCampusCopyWith(_EnablerCampus value, $Res Function(_EnablerCampus) _then) = __$EnablerCampusCopyWithImpl;
@override @useResult
$Res call({
 String id, String collegeName, String campusCode, String zone, String orgType
});




}
/// @nodoc
class __$EnablerCampusCopyWithImpl<$Res>
    implements _$EnablerCampusCopyWith<$Res> {
  __$EnablerCampusCopyWithImpl(this._self, this._then);

  final _EnablerCampus _self;
  final $Res Function(_EnablerCampus) _then;

/// Create a copy of EnablerCampus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? collegeName = null,Object? campusCode = null,Object? zone = null,Object? orgType = null,}) {
  return _then(_EnablerCampus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collegeName: null == collegeName ? _self.collegeName : collegeName // ignore: cast_nullable_to_non_nullable
as String,campusCode: null == campusCode ? _self.campusCode : campusCode // ignore: cast_nullable_to_non_nullable
as String,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CampusNote {

 String get id; String get note; String get priority; String get status; DateTime get createdAt; String? get author; DateTime? get followUp;
/// Create a copy of CampusNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusNoteCopyWith<CampusNote> get copyWith => _$CampusNoteCopyWithImpl<CampusNote>(this as CampusNote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusNote&&(identical(other.id, id) || other.id == id)&&(identical(other.note, note) || other.note == note)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.followUp, followUp) || other.followUp == followUp));
}


@override
int get hashCode => Object.hash(runtimeType,id,note,priority,status,createdAt,author,followUp);

@override
String toString() {
  return 'CampusNote(id: $id, note: $note, priority: $priority, status: $status, createdAt: $createdAt, author: $author, followUp: $followUp)';
}


}

/// @nodoc
abstract mixin class $CampusNoteCopyWith<$Res>  {
  factory $CampusNoteCopyWith(CampusNote value, $Res Function(CampusNote) _then) = _$CampusNoteCopyWithImpl;
@useResult
$Res call({
 String id, String note, String priority, String status, DateTime createdAt, String? author, DateTime? followUp
});




}
/// @nodoc
class _$CampusNoteCopyWithImpl<$Res>
    implements $CampusNoteCopyWith<$Res> {
  _$CampusNoteCopyWithImpl(this._self, this._then);

  final CampusNote _self;
  final $Res Function(CampusNote) _then;

/// Create a copy of CampusNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? note = null,Object? priority = null,Object? status = null,Object? createdAt = null,Object? author = freezed,Object? followUp = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,followUp: freezed == followUp ? _self.followUp : followUp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusNote].
extension CampusNotePatterns on CampusNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusNote value)  $default,){
final _that = this;
switch (_that) {
case _CampusNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusNote value)?  $default,){
final _that = this;
switch (_that) {
case _CampusNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String note,  String priority,  String status,  DateTime createdAt,  String? author,  DateTime? followUp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusNote() when $default != null:
return $default(_that.id,_that.note,_that.priority,_that.status,_that.createdAt,_that.author,_that.followUp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String note,  String priority,  String status,  DateTime createdAt,  String? author,  DateTime? followUp)  $default,) {final _that = this;
switch (_that) {
case _CampusNote():
return $default(_that.id,_that.note,_that.priority,_that.status,_that.createdAt,_that.author,_that.followUp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String note,  String priority,  String status,  DateTime createdAt,  String? author,  DateTime? followUp)?  $default,) {final _that = this;
switch (_that) {
case _CampusNote() when $default != null:
return $default(_that.id,_that.note,_that.priority,_that.status,_that.createdAt,_that.author,_that.followUp);case _:
  return null;

}
}

}

/// @nodoc


class _CampusNote implements CampusNote {
  const _CampusNote({required this.id, required this.note, required this.priority, required this.status, required this.createdAt, this.author, this.followUp});
  

@override final  String id;
@override final  String note;
@override final  String priority;
@override final  String status;
@override final  DateTime createdAt;
@override final  String? author;
@override final  DateTime? followUp;

/// Create a copy of CampusNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusNoteCopyWith<_CampusNote> get copyWith => __$CampusNoteCopyWithImpl<_CampusNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusNote&&(identical(other.id, id) || other.id == id)&&(identical(other.note, note) || other.note == note)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.followUp, followUp) || other.followUp == followUp));
}


@override
int get hashCode => Object.hash(runtimeType,id,note,priority,status,createdAt,author,followUp);

@override
String toString() {
  return 'CampusNote(id: $id, note: $note, priority: $priority, status: $status, createdAt: $createdAt, author: $author, followUp: $followUp)';
}


}

/// @nodoc
abstract mixin class _$CampusNoteCopyWith<$Res> implements $CampusNoteCopyWith<$Res> {
  factory _$CampusNoteCopyWith(_CampusNote value, $Res Function(_CampusNote) _then) = __$CampusNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String note, String priority, String status, DateTime createdAt, String? author, DateTime? followUp
});




}
/// @nodoc
class __$CampusNoteCopyWithImpl<$Res>
    implements _$CampusNoteCopyWith<$Res> {
  __$CampusNoteCopyWithImpl(this._self, this._then);

  final _CampusNote _self;
  final $Res Function(_CampusNote) _then;

/// Create a copy of CampusNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? note = null,Object? priority = null,Object? status = null,Object? createdAt = null,Object? author = freezed,Object? followUp = freezed,}) {
  return _then(_CampusNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,followUp: freezed == followUp ? _self.followUp : followUp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
