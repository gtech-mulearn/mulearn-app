// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_groups.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampusCircle {

 String get id; String get name; String get igName; int get memberCount; int get meetingCount; DateTime? get lastMeetingTime;
/// Create a copy of CampusCircle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusCircleCopyWith<CampusCircle> get copyWith => _$CampusCircleCopyWithImpl<CampusCircle>(this as CampusCircle, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusCircle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.meetingCount, meetingCount) || other.meetingCount == meetingCount)&&(identical(other.lastMeetingTime, lastMeetingTime) || other.lastMeetingTime == lastMeetingTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,igName,memberCount,meetingCount,lastMeetingTime);

@override
String toString() {
  return 'CampusCircle(id: $id, name: $name, igName: $igName, memberCount: $memberCount, meetingCount: $meetingCount, lastMeetingTime: $lastMeetingTime)';
}


}

/// @nodoc
abstract mixin class $CampusCircleCopyWith<$Res>  {
  factory $CampusCircleCopyWith(CampusCircle value, $Res Function(CampusCircle) _then) = _$CampusCircleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String igName, int memberCount, int meetingCount, DateTime? lastMeetingTime
});




}
/// @nodoc
class _$CampusCircleCopyWithImpl<$Res>
    implements $CampusCircleCopyWith<$Res> {
  _$CampusCircleCopyWithImpl(this._self, this._then);

  final CampusCircle _self;
  final $Res Function(CampusCircle) _then;

/// Create a copy of CampusCircle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? igName = null,Object? memberCount = null,Object? meetingCount = null,Object? lastMeetingTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,igName: null == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,meetingCount: null == meetingCount ? _self.meetingCount : meetingCount // ignore: cast_nullable_to_non_nullable
as int,lastMeetingTime: freezed == lastMeetingTime ? _self.lastMeetingTime : lastMeetingTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusCircle].
extension CampusCirclePatterns on CampusCircle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusCircle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusCircle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusCircle value)  $default,){
final _that = this;
switch (_that) {
case _CampusCircle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusCircle value)?  $default,){
final _that = this;
switch (_that) {
case _CampusCircle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String igName,  int memberCount,  int meetingCount,  DateTime? lastMeetingTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusCircle() when $default != null:
return $default(_that.id,_that.name,_that.igName,_that.memberCount,_that.meetingCount,_that.lastMeetingTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String igName,  int memberCount,  int meetingCount,  DateTime? lastMeetingTime)  $default,) {final _that = this;
switch (_that) {
case _CampusCircle():
return $default(_that.id,_that.name,_that.igName,_that.memberCount,_that.meetingCount,_that.lastMeetingTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String igName,  int memberCount,  int meetingCount,  DateTime? lastMeetingTime)?  $default,) {final _that = this;
switch (_that) {
case _CampusCircle() when $default != null:
return $default(_that.id,_that.name,_that.igName,_that.memberCount,_that.meetingCount,_that.lastMeetingTime);case _:
  return null;

}
}

}

/// @nodoc


class _CampusCircle implements CampusCircle {
  const _CampusCircle({required this.id, required this.name, required this.igName, required this.memberCount, required this.meetingCount, this.lastMeetingTime});
  

@override final  String id;
@override final  String name;
@override final  String igName;
@override final  int memberCount;
@override final  int meetingCount;
@override final  DateTime? lastMeetingTime;

/// Create a copy of CampusCircle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusCircleCopyWith<_CampusCircle> get copyWith => __$CampusCircleCopyWithImpl<_CampusCircle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusCircle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.meetingCount, meetingCount) || other.meetingCount == meetingCount)&&(identical(other.lastMeetingTime, lastMeetingTime) || other.lastMeetingTime == lastMeetingTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,igName,memberCount,meetingCount,lastMeetingTime);

@override
String toString() {
  return 'CampusCircle(id: $id, name: $name, igName: $igName, memberCount: $memberCount, meetingCount: $meetingCount, lastMeetingTime: $lastMeetingTime)';
}


}

/// @nodoc
abstract mixin class _$CampusCircleCopyWith<$Res> implements $CampusCircleCopyWith<$Res> {
  factory _$CampusCircleCopyWith(_CampusCircle value, $Res Function(_CampusCircle) _then) = __$CampusCircleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String igName, int memberCount, int meetingCount, DateTime? lastMeetingTime
});




}
/// @nodoc
class __$CampusCircleCopyWithImpl<$Res>
    implements _$CampusCircleCopyWith<$Res> {
  __$CampusCircleCopyWithImpl(this._self, this._then);

  final _CampusCircle _self;
  final $Res Function(_CampusCircle) _then;

/// Create a copy of CampusCircle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? igName = null,Object? memberCount = null,Object? meetingCount = null,Object? lastMeetingTime = freezed,}) {
  return _then(_CampusCircle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,igName: null == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,meetingCount: null == meetingCount ? _self.meetingCount : meetingCount // ignore: cast_nullable_to_non_nullable
as int,lastMeetingTime: freezed == lastMeetingTime ? _self.lastMeetingTime : lastMeetingTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$CampusIg {

 String get id; String get name; String get code; int get campusMemberCount; String? get iconImage;
/// Create a copy of CampusIg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusIgCopyWith<CampusIg> get copyWith => _$CampusIgCopyWithImpl<CampusIg>(this as CampusIg, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusIg&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.campusMemberCount, campusMemberCount) || other.campusMemberCount == campusMemberCount)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,code,campusMemberCount,iconImage);

@override
String toString() {
  return 'CampusIg(id: $id, name: $name, code: $code, campusMemberCount: $campusMemberCount, iconImage: $iconImage)';
}


}

/// @nodoc
abstract mixin class $CampusIgCopyWith<$Res>  {
  factory $CampusIgCopyWith(CampusIg value, $Res Function(CampusIg) _then) = _$CampusIgCopyWithImpl;
@useResult
$Res call({
 String id, String name, String code, int campusMemberCount, String? iconImage
});




}
/// @nodoc
class _$CampusIgCopyWithImpl<$Res>
    implements $CampusIgCopyWith<$Res> {
  _$CampusIgCopyWithImpl(this._self, this._then);

  final CampusIg _self;
  final $Res Function(CampusIg) _then;

/// Create a copy of CampusIg
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = null,Object? campusMemberCount = null,Object? iconImage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,campusMemberCount: null == campusMemberCount ? _self.campusMemberCount : campusMemberCount // ignore: cast_nullable_to_non_nullable
as int,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusIg].
extension CampusIgPatterns on CampusIg {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusIg value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusIg() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusIg value)  $default,){
final _that = this;
switch (_that) {
case _CampusIg():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusIg value)?  $default,){
final _that = this;
switch (_that) {
case _CampusIg() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String code,  int campusMemberCount,  String? iconImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusIg() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.campusMemberCount,_that.iconImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String code,  int campusMemberCount,  String? iconImage)  $default,) {final _that = this;
switch (_that) {
case _CampusIg():
return $default(_that.id,_that.name,_that.code,_that.campusMemberCount,_that.iconImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String code,  int campusMemberCount,  String? iconImage)?  $default,) {final _that = this;
switch (_that) {
case _CampusIg() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.campusMemberCount,_that.iconImage);case _:
  return null;

}
}

}

/// @nodoc


class _CampusIg implements CampusIg {
  const _CampusIg({required this.id, required this.name, required this.code, required this.campusMemberCount, this.iconImage});
  

@override final  String id;
@override final  String name;
@override final  String code;
@override final  int campusMemberCount;
@override final  String? iconImage;

/// Create a copy of CampusIg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusIgCopyWith<_CampusIg> get copyWith => __$CampusIgCopyWithImpl<_CampusIg>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusIg&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.campusMemberCount, campusMemberCount) || other.campusMemberCount == campusMemberCount)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,code,campusMemberCount,iconImage);

@override
String toString() {
  return 'CampusIg(id: $id, name: $name, code: $code, campusMemberCount: $campusMemberCount, iconImage: $iconImage)';
}


}

/// @nodoc
abstract mixin class _$CampusIgCopyWith<$Res> implements $CampusIgCopyWith<$Res> {
  factory _$CampusIgCopyWith(_CampusIg value, $Res Function(_CampusIg) _then) = __$CampusIgCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String code, int campusMemberCount, String? iconImage
});




}
/// @nodoc
class __$CampusIgCopyWithImpl<$Res>
    implements _$CampusIgCopyWith<$Res> {
  __$CampusIgCopyWithImpl(this._self, this._then);

  final _CampusIg _self;
  final $Res Function(_CampusIg) _then;

/// Create a copy of CampusIg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = null,Object? campusMemberCount = null,Object? iconImage = freezed,}) {
  return _then(_CampusIg(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,campusMemberCount: null == campusMemberCount ? _self.campusMemberCount : campusMemberCount // ignore: cast_nullable_to_non_nullable
as int,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
