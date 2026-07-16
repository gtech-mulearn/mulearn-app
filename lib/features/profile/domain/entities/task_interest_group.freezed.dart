// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_interest_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskInterestGroup {

 String? get id; String? get name;
/// Create a copy of TaskInterestGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskInterestGroupCopyWith<TaskInterestGroup> get copyWith => _$TaskInterestGroupCopyWithImpl<TaskInterestGroup>(this as TaskInterestGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskInterestGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TaskInterestGroup(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $TaskInterestGroupCopyWith<$Res>  {
  factory $TaskInterestGroupCopyWith(TaskInterestGroup value, $Res Function(TaskInterestGroup) _then) = _$TaskInterestGroupCopyWithImpl;
@useResult
$Res call({
 String? id, String? name
});




}
/// @nodoc
class _$TaskInterestGroupCopyWithImpl<$Res>
    implements $TaskInterestGroupCopyWith<$Res> {
  _$TaskInterestGroupCopyWithImpl(this._self, this._then);

  final TaskInterestGroup _self;
  final $Res Function(TaskInterestGroup) _then;

/// Create a copy of TaskInterestGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskInterestGroup].
extension TaskInterestGroupPatterns on TaskInterestGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskInterestGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskInterestGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskInterestGroup value)  $default,){
final _that = this;
switch (_that) {
case _TaskInterestGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskInterestGroup value)?  $default,){
final _that = this;
switch (_that) {
case _TaskInterestGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskInterestGroup() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name)  $default,) {final _that = this;
switch (_that) {
case _TaskInterestGroup():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _TaskInterestGroup() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _TaskInterestGroup implements TaskInterestGroup {
  const _TaskInterestGroup({this.id, this.name});
  

@override final  String? id;
@override final  String? name;

/// Create a copy of TaskInterestGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskInterestGroupCopyWith<_TaskInterestGroup> get copyWith => __$TaskInterestGroupCopyWithImpl<_TaskInterestGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskInterestGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TaskInterestGroup(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TaskInterestGroupCopyWith<$Res> implements $TaskInterestGroupCopyWith<$Res> {
  factory _$TaskInterestGroupCopyWith(_TaskInterestGroup value, $Res Function(_TaskInterestGroup) _then) = __$TaskInterestGroupCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name
});




}
/// @nodoc
class __$TaskInterestGroupCopyWithImpl<$Res>
    implements _$TaskInterestGroupCopyWith<$Res> {
  __$TaskInterestGroupCopyWithImpl(this._self, this._then);

  final _TaskInterestGroup _self;
  final $Res Function(_TaskInterestGroup) _then;

/// Create a copy of TaskInterestGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_TaskInterestGroup(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
