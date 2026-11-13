// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentActivity {

 String get id; String get taskName; int get karma; String get status; DateTime get createdAt; String? get igName;
/// Create a copy of StudentActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentActivityCopyWith<StudentActivity> get copyWith => _$StudentActivityCopyWithImpl<StudentActivity>(this as StudentActivity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.igName, igName) || other.igName == igName));
}


@override
int get hashCode => Object.hash(runtimeType,id,taskName,karma,status,createdAt,igName);

@override
String toString() {
  return 'StudentActivity(id: $id, taskName: $taskName, karma: $karma, status: $status, createdAt: $createdAt, igName: $igName)';
}


}

/// @nodoc
abstract mixin class $StudentActivityCopyWith<$Res>  {
  factory $StudentActivityCopyWith(StudentActivity value, $Res Function(StudentActivity) _then) = _$StudentActivityCopyWithImpl;
@useResult
$Res call({
 String id, String taskName, int karma, String status, DateTime createdAt, String? igName
});




}
/// @nodoc
class _$StudentActivityCopyWithImpl<$Res>
    implements $StudentActivityCopyWith<$Res> {
  _$StudentActivityCopyWithImpl(this._self, this._then);

  final StudentActivity _self;
  final $Res Function(StudentActivity) _then;

/// Create a copy of StudentActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskName = null,Object? karma = null,Object? status = null,Object? createdAt = null,Object? igName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentActivity].
extension StudentActivityPatterns on StudentActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentActivity value)  $default,){
final _that = this;
switch (_that) {
case _StudentActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentActivity value)?  $default,){
final _that = this;
switch (_that) {
case _StudentActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String taskName,  int karma,  String status,  DateTime createdAt,  String? igName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentActivity() when $default != null:
return $default(_that.id,_that.taskName,_that.karma,_that.status,_that.createdAt,_that.igName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String taskName,  int karma,  String status,  DateTime createdAt,  String? igName)  $default,) {final _that = this;
switch (_that) {
case _StudentActivity():
return $default(_that.id,_that.taskName,_that.karma,_that.status,_that.createdAt,_that.igName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String taskName,  int karma,  String status,  DateTime createdAt,  String? igName)?  $default,) {final _that = this;
switch (_that) {
case _StudentActivity() when $default != null:
return $default(_that.id,_that.taskName,_that.karma,_that.status,_that.createdAt,_that.igName);case _:
  return null;

}
}

}

/// @nodoc


class _StudentActivity implements StudentActivity {
  const _StudentActivity({required this.id, required this.taskName, required this.karma, required this.status, required this.createdAt, this.igName});
  

@override final  String id;
@override final  String taskName;
@override final  int karma;
@override final  String status;
@override final  DateTime createdAt;
@override final  String? igName;

/// Create a copy of StudentActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentActivityCopyWith<_StudentActivity> get copyWith => __$StudentActivityCopyWithImpl<_StudentActivity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.igName, igName) || other.igName == igName));
}


@override
int get hashCode => Object.hash(runtimeType,id,taskName,karma,status,createdAt,igName);

@override
String toString() {
  return 'StudentActivity(id: $id, taskName: $taskName, karma: $karma, status: $status, createdAt: $createdAt, igName: $igName)';
}


}

/// @nodoc
abstract mixin class _$StudentActivityCopyWith<$Res> implements $StudentActivityCopyWith<$Res> {
  factory _$StudentActivityCopyWith(_StudentActivity value, $Res Function(_StudentActivity) _then) = __$StudentActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String taskName, int karma, String status, DateTime createdAt, String? igName
});




}
/// @nodoc
class __$StudentActivityCopyWithImpl<$Res>
    implements _$StudentActivityCopyWith<$Res> {
  __$StudentActivityCopyWithImpl(this._self, this._then);

  final _StudentActivity _self;
  final $Res Function(_StudentActivity) _then;

/// Create a copy of StudentActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskName = null,Object? karma = null,Object? status = null,Object? createdAt = null,Object? igName = freezed,}) {
  return _then(_StudentActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
