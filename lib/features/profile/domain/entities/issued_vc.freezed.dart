// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issued_vc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IssuedVc {

 String get message; IssuedVcSubjectInfo get subjectInfo;
/// Create a copy of IssuedVc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IssuedVcCopyWith<IssuedVc> get copyWith => _$IssuedVcCopyWithImpl<IssuedVc>(this as IssuedVc, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IssuedVc&&(identical(other.message, message) || other.message == message)&&(identical(other.subjectInfo, subjectInfo) || other.subjectInfo == subjectInfo));
}


@override
int get hashCode => Object.hash(runtimeType,message,subjectInfo);

@override
String toString() {
  return 'IssuedVc(message: $message, subjectInfo: $subjectInfo)';
}


}

/// @nodoc
abstract mixin class $IssuedVcCopyWith<$Res>  {
  factory $IssuedVcCopyWith(IssuedVc value, $Res Function(IssuedVc) _then) = _$IssuedVcCopyWithImpl;
@useResult
$Res call({
 String message, IssuedVcSubjectInfo subjectInfo
});


$IssuedVcSubjectInfoCopyWith<$Res> get subjectInfo;

}
/// @nodoc
class _$IssuedVcCopyWithImpl<$Res>
    implements $IssuedVcCopyWith<$Res> {
  _$IssuedVcCopyWithImpl(this._self, this._then);

  final IssuedVc _self;
  final $Res Function(IssuedVc) _then;

/// Create a copy of IssuedVc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? subjectInfo = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subjectInfo: null == subjectInfo ? _self.subjectInfo : subjectInfo // ignore: cast_nullable_to_non_nullable
as IssuedVcSubjectInfo,
  ));
}
/// Create a copy of IssuedVc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IssuedVcSubjectInfoCopyWith<$Res> get subjectInfo {
  
  return $IssuedVcSubjectInfoCopyWith<$Res>(_self.subjectInfo, (value) {
    return _then(_self.copyWith(subjectInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [IssuedVc].
extension IssuedVcPatterns on IssuedVc {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IssuedVc value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IssuedVc() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IssuedVc value)  $default,){
final _that = this;
switch (_that) {
case _IssuedVc():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IssuedVc value)?  $default,){
final _that = this;
switch (_that) {
case _IssuedVc() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  IssuedVcSubjectInfo subjectInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IssuedVc() when $default != null:
return $default(_that.message,_that.subjectInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  IssuedVcSubjectInfo subjectInfo)  $default,) {final _that = this;
switch (_that) {
case _IssuedVc():
return $default(_that.message,_that.subjectInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  IssuedVcSubjectInfo subjectInfo)?  $default,) {final _that = this;
switch (_that) {
case _IssuedVc() when $default != null:
return $default(_that.message,_that.subjectInfo);case _:
  return null;

}
}

}

/// @nodoc


class _IssuedVc implements IssuedVc {
  const _IssuedVc({required this.message, required this.subjectInfo});
  

@override final  String message;
@override final  IssuedVcSubjectInfo subjectInfo;

/// Create a copy of IssuedVc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IssuedVcCopyWith<_IssuedVc> get copyWith => __$IssuedVcCopyWithImpl<_IssuedVc>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IssuedVc&&(identical(other.message, message) || other.message == message)&&(identical(other.subjectInfo, subjectInfo) || other.subjectInfo == subjectInfo));
}


@override
int get hashCode => Object.hash(runtimeType,message,subjectInfo);

@override
String toString() {
  return 'IssuedVc(message: $message, subjectInfo: $subjectInfo)';
}


}

/// @nodoc
abstract mixin class _$IssuedVcCopyWith<$Res> implements $IssuedVcCopyWith<$Res> {
  factory _$IssuedVcCopyWith(_IssuedVc value, $Res Function(_IssuedVc) _then) = __$IssuedVcCopyWithImpl;
@override @useResult
$Res call({
 String message, IssuedVcSubjectInfo subjectInfo
});


@override $IssuedVcSubjectInfoCopyWith<$Res> get subjectInfo;

}
/// @nodoc
class __$IssuedVcCopyWithImpl<$Res>
    implements _$IssuedVcCopyWith<$Res> {
  __$IssuedVcCopyWithImpl(this._self, this._then);

  final _IssuedVc _self;
  final $Res Function(_IssuedVc) _then;

/// Create a copy of IssuedVc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? subjectInfo = null,}) {
  return _then(_IssuedVc(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subjectInfo: null == subjectInfo ? _self.subjectInfo : subjectInfo // ignore: cast_nullable_to_non_nullable
as IssuedVcSubjectInfo,
  ));
}

/// Create a copy of IssuedVc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IssuedVcSubjectInfoCopyWith<$Res> get subjectInfo {
  
  return $IssuedVcSubjectInfoCopyWith<$Res>(_self.subjectInfo, (value) {
    return _then(_self.copyWith(subjectInfo: value));
  });
}
}

// dart format on
