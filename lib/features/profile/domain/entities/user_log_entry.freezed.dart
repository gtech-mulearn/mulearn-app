// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_log_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserLogEntry {

 String get taskName; num get karma; String get createdDate;
/// Create a copy of UserLogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLogEntryCopyWith<UserLogEntry> get copyWith => _$UserLogEntryCopyWithImpl<UserLogEntry>(this as UserLogEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLogEntry&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}


@override
int get hashCode => Object.hash(runtimeType,taskName,karma,createdDate);

@override
String toString() {
  return 'UserLogEntry(taskName: $taskName, karma: $karma, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $UserLogEntryCopyWith<$Res>  {
  factory $UserLogEntryCopyWith(UserLogEntry value, $Res Function(UserLogEntry) _then) = _$UserLogEntryCopyWithImpl;
@useResult
$Res call({
 String taskName, num karma, String createdDate
});




}
/// @nodoc
class _$UserLogEntryCopyWithImpl<$Res>
    implements $UserLogEntryCopyWith<$Res> {
  _$UserLogEntryCopyWithImpl(this._self, this._then);

  final UserLogEntry _self;
  final $Res Function(UserLogEntry) _then;

/// Create a copy of UserLogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskName = null,Object? karma = null,Object? createdDate = null,}) {
  return _then(_self.copyWith(
taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserLogEntry].
extension UserLogEntryPatterns on UserLogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserLogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserLogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserLogEntry value)  $default,){
final _that = this;
switch (_that) {
case _UserLogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserLogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _UserLogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String taskName,  num karma,  String createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserLogEntry() when $default != null:
return $default(_that.taskName,_that.karma,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String taskName,  num karma,  String createdDate)  $default,) {final _that = this;
switch (_that) {
case _UserLogEntry():
return $default(_that.taskName,_that.karma,_that.createdDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String taskName,  num karma,  String createdDate)?  $default,) {final _that = this;
switch (_that) {
case _UserLogEntry() when $default != null:
return $default(_that.taskName,_that.karma,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc


class _UserLogEntry implements UserLogEntry {
  const _UserLogEntry({required this.taskName, required this.karma, required this.createdDate});
  

@override final  String taskName;
@override final  num karma;
@override final  String createdDate;

/// Create a copy of UserLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserLogEntryCopyWith<_UserLogEntry> get copyWith => __$UserLogEntryCopyWithImpl<_UserLogEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserLogEntry&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}


@override
int get hashCode => Object.hash(runtimeType,taskName,karma,createdDate);

@override
String toString() {
  return 'UserLogEntry(taskName: $taskName, karma: $karma, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$UserLogEntryCopyWith<$Res> implements $UserLogEntryCopyWith<$Res> {
  factory _$UserLogEntryCopyWith(_UserLogEntry value, $Res Function(_UserLogEntry) _then) = __$UserLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String taskName, num karma, String createdDate
});




}
/// @nodoc
class __$UserLogEntryCopyWithImpl<$Res>
    implements _$UserLogEntryCopyWith<$Res> {
  __$UserLogEntryCopyWithImpl(this._self, this._then);

  final _UserLogEntry _self;
  final $Res Function(_UserLogEntry) _then;

/// Create a copy of UserLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskName = null,Object? karma = null,Object? createdDate = null,}) {
  return _then(_UserLogEntry(
taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
