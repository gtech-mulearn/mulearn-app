// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'persona.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Persona {

 bool get isMentor; MentorScopeType? get scopeType; String? get scopeId; String? get scopeName;
/// Create a copy of Persona
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonaCopyWith<Persona> get copyWith => _$PersonaCopyWithImpl<Persona>(this as Persona, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Persona&&(identical(other.isMentor, isMentor) || other.isMentor == isMentor)&&(identical(other.scopeType, scopeType) || other.scopeType == scopeType)&&(identical(other.scopeId, scopeId) || other.scopeId == scopeId)&&(identical(other.scopeName, scopeName) || other.scopeName == scopeName));
}


@override
int get hashCode => Object.hash(runtimeType,isMentor,scopeType,scopeId,scopeName);

@override
String toString() {
  return 'Persona(isMentor: $isMentor, scopeType: $scopeType, scopeId: $scopeId, scopeName: $scopeName)';
}


}

/// @nodoc
abstract mixin class $PersonaCopyWith<$Res>  {
  factory $PersonaCopyWith(Persona value, $Res Function(Persona) _then) = _$PersonaCopyWithImpl;
@useResult
$Res call({
 bool isMentor, MentorScopeType? scopeType, String? scopeId, String? scopeName
});




}
/// @nodoc
class _$PersonaCopyWithImpl<$Res>
    implements $PersonaCopyWith<$Res> {
  _$PersonaCopyWithImpl(this._self, this._then);

  final Persona _self;
  final $Res Function(Persona) _then;

/// Create a copy of Persona
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isMentor = null,Object? scopeType = freezed,Object? scopeId = freezed,Object? scopeName = freezed,}) {
  return _then(_self.copyWith(
isMentor: null == isMentor ? _self.isMentor : isMentor // ignore: cast_nullable_to_non_nullable
as bool,scopeType: freezed == scopeType ? _self.scopeType : scopeType // ignore: cast_nullable_to_non_nullable
as MentorScopeType?,scopeId: freezed == scopeId ? _self.scopeId : scopeId // ignore: cast_nullable_to_non_nullable
as String?,scopeName: freezed == scopeName ? _self.scopeName : scopeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Persona].
extension PersonaPatterns on Persona {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Persona value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Persona() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Persona value)  $default,){
final _that = this;
switch (_that) {
case _Persona():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Persona value)?  $default,){
final _that = this;
switch (_that) {
case _Persona() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isMentor,  MentorScopeType? scopeType,  String? scopeId,  String? scopeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Persona() when $default != null:
return $default(_that.isMentor,_that.scopeType,_that.scopeId,_that.scopeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isMentor,  MentorScopeType? scopeType,  String? scopeId,  String? scopeName)  $default,) {final _that = this;
switch (_that) {
case _Persona():
return $default(_that.isMentor,_that.scopeType,_that.scopeId,_that.scopeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isMentor,  MentorScopeType? scopeType,  String? scopeId,  String? scopeName)?  $default,) {final _that = this;
switch (_that) {
case _Persona() when $default != null:
return $default(_that.isMentor,_that.scopeType,_that.scopeId,_that.scopeName);case _:
  return null;

}
}

}

/// @nodoc


class _Persona implements Persona {
  const _Persona({required this.isMentor, this.scopeType, this.scopeId, this.scopeName});
  

@override final  bool isMentor;
@override final  MentorScopeType? scopeType;
@override final  String? scopeId;
@override final  String? scopeName;

/// Create a copy of Persona
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonaCopyWith<_Persona> get copyWith => __$PersonaCopyWithImpl<_Persona>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Persona&&(identical(other.isMentor, isMentor) || other.isMentor == isMentor)&&(identical(other.scopeType, scopeType) || other.scopeType == scopeType)&&(identical(other.scopeId, scopeId) || other.scopeId == scopeId)&&(identical(other.scopeName, scopeName) || other.scopeName == scopeName));
}


@override
int get hashCode => Object.hash(runtimeType,isMentor,scopeType,scopeId,scopeName);

@override
String toString() {
  return 'Persona(isMentor: $isMentor, scopeType: $scopeType, scopeId: $scopeId, scopeName: $scopeName)';
}


}

/// @nodoc
abstract mixin class _$PersonaCopyWith<$Res> implements $PersonaCopyWith<$Res> {
  factory _$PersonaCopyWith(_Persona value, $Res Function(_Persona) _then) = __$PersonaCopyWithImpl;
@override @useResult
$Res call({
 bool isMentor, MentorScopeType? scopeType, String? scopeId, String? scopeName
});




}
/// @nodoc
class __$PersonaCopyWithImpl<$Res>
    implements _$PersonaCopyWith<$Res> {
  __$PersonaCopyWithImpl(this._self, this._then);

  final _Persona _self;
  final $Res Function(_Persona) _then;

/// Create a copy of Persona
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isMentor = null,Object? scopeType = freezed,Object? scopeId = freezed,Object? scopeName = freezed,}) {
  return _then(_Persona(
isMentor: null == isMentor ? _self.isMentor : isMentor // ignore: cast_nullable_to_non_nullable
as bool,scopeType: freezed == scopeType ? _self.scopeType : scopeType // ignore: cast_nullable_to_non_nullable
as MentorScopeType?,scopeId: freezed == scopeId ? _self.scopeId : scopeId // ignore: cast_nullable_to_non_nullable
as String?,scopeName: freezed == scopeName ? _self.scopeName : scopeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
