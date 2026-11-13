// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MentorApplication {

 String get id; String get status; String get mentorTier;
/// Create a copy of MentorApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorApplicationCopyWith<MentorApplication> get copyWith => _$MentorApplicationCopyWithImpl<MentorApplication>(this as MentorApplication, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.mentorTier, mentorTier) || other.mentorTier == mentorTier));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,mentorTier);

@override
String toString() {
  return 'MentorApplication(id: $id, status: $status, mentorTier: $mentorTier)';
}


}

/// @nodoc
abstract mixin class $MentorApplicationCopyWith<$Res>  {
  factory $MentorApplicationCopyWith(MentorApplication value, $Res Function(MentorApplication) _then) = _$MentorApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String status, String mentorTier
});




}
/// @nodoc
class _$MentorApplicationCopyWithImpl<$Res>
    implements $MentorApplicationCopyWith<$Res> {
  _$MentorApplicationCopyWithImpl(this._self, this._then);

  final MentorApplication _self;
  final $Res Function(MentorApplication) _then;

/// Create a copy of MentorApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? mentorTier = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mentorTier: null == mentorTier ? _self.mentorTier : mentorTier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorApplication].
extension MentorApplicationPatterns on MentorApplication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorApplication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorApplication() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorApplication value)  $default,){
final _that = this;
switch (_that) {
case _MentorApplication():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorApplication value)?  $default,){
final _that = this;
switch (_that) {
case _MentorApplication() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  String mentorTier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorApplication() when $default != null:
return $default(_that.id,_that.status,_that.mentorTier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  String mentorTier)  $default,) {final _that = this;
switch (_that) {
case _MentorApplication():
return $default(_that.id,_that.status,_that.mentorTier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  String mentorTier)?  $default,) {final _that = this;
switch (_that) {
case _MentorApplication() when $default != null:
return $default(_that.id,_that.status,_that.mentorTier);case _:
  return null;

}
}

}

/// @nodoc


class _MentorApplication implements MentorApplication {
  const _MentorApplication({required this.id, required this.status, required this.mentorTier});
  

@override final  String id;
@override final  String status;
@override final  String mentorTier;

/// Create a copy of MentorApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorApplicationCopyWith<_MentorApplication> get copyWith => __$MentorApplicationCopyWithImpl<_MentorApplication>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.mentorTier, mentorTier) || other.mentorTier == mentorTier));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,mentorTier);

@override
String toString() {
  return 'MentorApplication(id: $id, status: $status, mentorTier: $mentorTier)';
}


}

/// @nodoc
abstract mixin class _$MentorApplicationCopyWith<$Res> implements $MentorApplicationCopyWith<$Res> {
  factory _$MentorApplicationCopyWith(_MentorApplication value, $Res Function(_MentorApplication) _then) = __$MentorApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, String mentorTier
});




}
/// @nodoc
class __$MentorApplicationCopyWithImpl<$Res>
    implements _$MentorApplicationCopyWith<$Res> {
  __$MentorApplicationCopyWithImpl(this._self, this._then);

  final _MentorApplication _self;
  final $Res Function(_MentorApplication) _then;

/// Create a copy of MentorApplication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? mentorTier = null,}) {
  return _then(_MentorApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mentorTier: null == mentorTier ? _self.mentorTier : mentorTier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
