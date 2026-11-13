// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_linked_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventLinkedTask {

 String get id; String get title; String? get hashtag; String? get description; num? get karma; String? get igName;
/// Create a copy of EventLinkedTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventLinkedTaskCopyWith<EventLinkedTask> get copyWith => _$EventLinkedTaskCopyWithImpl<EventLinkedTask>(this as EventLinkedTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventLinkedTask&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.description, description) || other.description == description)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.igName, igName) || other.igName == igName));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,hashtag,description,karma,igName);

@override
String toString() {
  return 'EventLinkedTask(id: $id, title: $title, hashtag: $hashtag, description: $description, karma: $karma, igName: $igName)';
}


}

/// @nodoc
abstract mixin class $EventLinkedTaskCopyWith<$Res>  {
  factory $EventLinkedTaskCopyWith(EventLinkedTask value, $Res Function(EventLinkedTask) _then) = _$EventLinkedTaskCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? hashtag, String? description, num? karma, String? igName
});




}
/// @nodoc
class _$EventLinkedTaskCopyWithImpl<$Res>
    implements $EventLinkedTaskCopyWith<$Res> {
  _$EventLinkedTaskCopyWithImpl(this._self, this._then);

  final EventLinkedTask _self;
  final $Res Function(EventLinkedTask) _then;

/// Create a copy of EventLinkedTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? hashtag = freezed,Object? description = freezed,Object? karma = freezed,Object? igName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventLinkedTask].
extension EventLinkedTaskPatterns on EventLinkedTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventLinkedTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventLinkedTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventLinkedTask value)  $default,){
final _that = this;
switch (_that) {
case _EventLinkedTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventLinkedTask value)?  $default,){
final _that = this;
switch (_that) {
case _EventLinkedTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  String? igName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventLinkedTask() when $default != null:
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.igName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  String? igName)  $default,) {final _that = this;
switch (_that) {
case _EventLinkedTask():
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.igName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  String? igName)?  $default,) {final _that = this;
switch (_that) {
case _EventLinkedTask() when $default != null:
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.igName);case _:
  return null;

}
}

}

/// @nodoc


class _EventLinkedTask implements EventLinkedTask {
  const _EventLinkedTask({required this.id, required this.title, this.hashtag, this.description, this.karma, this.igName});
  

@override final  String id;
@override final  String title;
@override final  String? hashtag;
@override final  String? description;
@override final  num? karma;
@override final  String? igName;

/// Create a copy of EventLinkedTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventLinkedTaskCopyWith<_EventLinkedTask> get copyWith => __$EventLinkedTaskCopyWithImpl<_EventLinkedTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLinkedTask&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.description, description) || other.description == description)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.igName, igName) || other.igName == igName));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,hashtag,description,karma,igName);

@override
String toString() {
  return 'EventLinkedTask(id: $id, title: $title, hashtag: $hashtag, description: $description, karma: $karma, igName: $igName)';
}


}

/// @nodoc
abstract mixin class _$EventLinkedTaskCopyWith<$Res> implements $EventLinkedTaskCopyWith<$Res> {
  factory _$EventLinkedTaskCopyWith(_EventLinkedTask value, $Res Function(_EventLinkedTask) _then) = __$EventLinkedTaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? hashtag, String? description, num? karma, String? igName
});




}
/// @nodoc
class __$EventLinkedTaskCopyWithImpl<$Res>
    implements _$EventLinkedTaskCopyWith<$Res> {
  __$EventLinkedTaskCopyWithImpl(this._self, this._then);

  final _EventLinkedTask _self;
  final $Res Function(_EventLinkedTask) _then;

/// Create a copy of EventLinkedTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? hashtag = freezed,Object? description = freezed,Object? karma = freezed,Object? igName = freezed,}) {
  return _then(_EventLinkedTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
