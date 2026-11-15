// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_groups.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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
  final _this = this as CampusCircle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusCircle&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.igName, _this.igName) || other.igName == _this.igName)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.meetingCount, _this.meetingCount) || other.meetingCount == _this.meetingCount)&&(identical(other.lastMeetingTime, _this.lastMeetingTime) || other.lastMeetingTime == _this.lastMeetingTime));
}


@override
int get hashCode {
  final _this = this as CampusCircle;
  return Object.hash(runtimeType,_this.id,_this.name,_this.igName,_this.memberCount,_this.meetingCount,_this.lastMeetingTime);
}

@override
String toString() {
  final _this = this as CampusCircle;
  return 'CampusCircle(id: ${_this.id}, name: ${_this.name}, igName: ${_this.igName}, memberCount: ${_this.memberCount}, meetingCount: ${_this.meetingCount}, lastMeetingTime: ${_this.lastMeetingTime})';
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
  return _then(CampusCircle(
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
int get hashCode {
    return Object.hash(runtimeType,id,name,igName,memberCount,meetingCount,lastMeetingTime);
}

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

// dart format on
