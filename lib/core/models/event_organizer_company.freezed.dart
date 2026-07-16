// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_organizer_company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventOrganizerCompany {

 String get id; String get title; String get orgType;
/// Create a copy of EventOrganizerCompany
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventOrganizerCompanyCopyWith<EventOrganizerCompany> get copyWith => _$EventOrganizerCompanyCopyWithImpl<EventOrganizerCompany>(this as EventOrganizerCompany, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventOrganizerCompany&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,orgType);

@override
String toString() {
  return 'EventOrganizerCompany(id: $id, title: $title, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class $EventOrganizerCompanyCopyWith<$Res>  {
  factory $EventOrganizerCompanyCopyWith(EventOrganizerCompany value, $Res Function(EventOrganizerCompany) _then) = _$EventOrganizerCompanyCopyWithImpl;
@useResult
$Res call({
 String id, String title, String orgType
});




}
/// @nodoc
class _$EventOrganizerCompanyCopyWithImpl<$Res>
    implements $EventOrganizerCompanyCopyWith<$Res> {
  _$EventOrganizerCompanyCopyWithImpl(this._self, this._then);

  final EventOrganizerCompany _self;
  final $Res Function(EventOrganizerCompany) _then;

/// Create a copy of EventOrganizerCompany
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


/// Adds pattern-matching-related methods to [EventOrganizerCompany].
extension EventOrganizerCompanyPatterns on EventOrganizerCompany {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventOrganizerCompany value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventOrganizerCompany() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventOrganizerCompany value)  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerCompany():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventOrganizerCompany value)?  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerCompany() when $default != null:
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
case _EventOrganizerCompany() when $default != null:
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
case _EventOrganizerCompany():
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
case _EventOrganizerCompany() when $default != null:
return $default(_that.id,_that.title,_that.orgType);case _:
  return null;

}
}

}

/// @nodoc


class _EventOrganizerCompany implements EventOrganizerCompany {
  const _EventOrganizerCompany({required this.id, required this.title, required this.orgType});
  

@override final  String id;
@override final  String title;
@override final  String orgType;

/// Create a copy of EventOrganizerCompany
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventOrganizerCompanyCopyWith<_EventOrganizerCompany> get copyWith => __$EventOrganizerCompanyCopyWithImpl<_EventOrganizerCompany>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventOrganizerCompany&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,orgType);

@override
String toString() {
  return 'EventOrganizerCompany(id: $id, title: $title, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class _$EventOrganizerCompanyCopyWith<$Res> implements $EventOrganizerCompanyCopyWith<$Res> {
  factory _$EventOrganizerCompanyCopyWith(_EventOrganizerCompany value, $Res Function(_EventOrganizerCompany) _then) = __$EventOrganizerCompanyCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String orgType
});




}
/// @nodoc
class __$EventOrganizerCompanyCopyWithImpl<$Res>
    implements _$EventOrganizerCompanyCopyWith<$Res> {
  __$EventOrganizerCompanyCopyWithImpl(this._self, this._then);

  final _EventOrganizerCompany _self;
  final $Res Function(_EventOrganizerCompany) _then;

/// Create a copy of EventOrganizerCompany
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? orgType = null,}) {
  return _then(_EventOrganizerCompany(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
