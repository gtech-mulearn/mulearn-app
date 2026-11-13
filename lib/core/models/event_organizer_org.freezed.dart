// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_organizer_org.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventOrganizerOrg {

 String get id; String get title; String get orgType;
/// Create a copy of EventOrganizerOrg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventOrganizerOrgCopyWith<EventOrganizerOrg> get copyWith => _$EventOrganizerOrgCopyWithImpl<EventOrganizerOrg>(this as EventOrganizerOrg, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventOrganizerOrg&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,orgType);

@override
String toString() {
  return 'EventOrganizerOrg(id: $id, title: $title, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class $EventOrganizerOrgCopyWith<$Res>  {
  factory $EventOrganizerOrgCopyWith(EventOrganizerOrg value, $Res Function(EventOrganizerOrg) _then) = _$EventOrganizerOrgCopyWithImpl;
@useResult
$Res call({
 String id, String title, String orgType
});




}
/// @nodoc
class _$EventOrganizerOrgCopyWithImpl<$Res>
    implements $EventOrganizerOrgCopyWith<$Res> {
  _$EventOrganizerOrgCopyWithImpl(this._self, this._then);

  final EventOrganizerOrg _self;
  final $Res Function(EventOrganizerOrg) _then;

/// Create a copy of EventOrganizerOrg
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? orgType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EventOrganizerOrg].
extension EventOrganizerOrgPatterns on EventOrganizerOrg {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventOrganizerOrg value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventOrganizerOrg() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventOrganizerOrg value)  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerOrg():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventOrganizerOrg value)?  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerOrg() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String orgType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventOrganizerOrg() when $default != null:
return $default(_that.id,_that.title,_that.orgType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String orgType)  $default,) {final _that = this;
switch (_that) {
case _EventOrganizerOrg():
return $default(_that.id,_that.title,_that.orgType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String orgType)?  $default,) {final _that = this;
switch (_that) {
case _EventOrganizerOrg() when $default != null:
return $default(_that.id,_that.title,_that.orgType);case _:
  return null;

}
}

}

/// @nodoc


class _EventOrganizerOrg implements EventOrganizerOrg {
  const _EventOrganizerOrg({required this.id, required this.title, required this.orgType});
  

@override final  String id;
@override final  String title;
@override final  String orgType;

/// Create a copy of EventOrganizerOrg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventOrganizerOrgCopyWith<_EventOrganizerOrg> get copyWith => __$EventOrganizerOrgCopyWithImpl<_EventOrganizerOrg>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventOrganizerOrg&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,orgType);

@override
String toString() {
  return 'EventOrganizerOrg(id: $id, title: $title, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class _$EventOrganizerOrgCopyWith<$Res> implements $EventOrganizerOrgCopyWith<$Res> {
  factory _$EventOrganizerOrgCopyWith(_EventOrganizerOrg value, $Res Function(_EventOrganizerOrg) _then) = __$EventOrganizerOrgCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String orgType
});




}
/// @nodoc
class __$EventOrganizerOrgCopyWithImpl<$Res>
    implements _$EventOrganizerOrgCopyWith<$Res> {
  __$EventOrganizerOrgCopyWithImpl(this._self, this._then);

  final _EventOrganizerOrg _self;
  final $Res Function(_EventOrganizerOrg) _then;

/// Create a copy of EventOrganizerOrg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? orgType = null,}) {
  return _then(_EventOrganizerOrg(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
