// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issued_vc_subject_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IssuedVcSubjectInfo {

 String get courseName; String get credentialId; VcCredentialType get credentialType; String get did; String get fullName; String get s3Url; String get templateId; VcCredentialType get type; String? get completedDate; String? get description; String? get email;
/// Create a copy of IssuedVcSubjectInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IssuedVcSubjectInfoCopyWith<IssuedVcSubjectInfo> get copyWith => _$IssuedVcSubjectInfoCopyWithImpl<IssuedVcSubjectInfo>(this as IssuedVcSubjectInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IssuedVcSubjectInfo&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.credentialId, credentialId) || other.credentialId == credentialId)&&(identical(other.credentialType, credentialType) || other.credentialType == credentialType)&&(identical(other.did, did) || other.did == did)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.s3Url, s3Url) || other.s3Url == s3Url)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.type, type) || other.type == type)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,courseName,credentialId,credentialType,did,fullName,s3Url,templateId,type,completedDate,description,email);

@override
String toString() {
  return 'IssuedVcSubjectInfo(courseName: $courseName, credentialId: $credentialId, credentialType: $credentialType, did: $did, fullName: $fullName, s3Url: $s3Url, templateId: $templateId, type: $type, completedDate: $completedDate, description: $description, email: $email)';
}


}

/// @nodoc
abstract mixin class $IssuedVcSubjectInfoCopyWith<$Res>  {
  factory $IssuedVcSubjectInfoCopyWith(IssuedVcSubjectInfo value, $Res Function(IssuedVcSubjectInfo) _then) = _$IssuedVcSubjectInfoCopyWithImpl;
@useResult
$Res call({
 String courseName, String credentialId, VcCredentialType credentialType, String did, String fullName, String s3Url, String templateId, VcCredentialType type, String? completedDate, String? description, String? email
});




}
/// @nodoc
class _$IssuedVcSubjectInfoCopyWithImpl<$Res>
    implements $IssuedVcSubjectInfoCopyWith<$Res> {
  _$IssuedVcSubjectInfoCopyWithImpl(this._self, this._then);

  final IssuedVcSubjectInfo _self;
  final $Res Function(IssuedVcSubjectInfo) _then;

/// Create a copy of IssuedVcSubjectInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseName = null,Object? credentialId = null,Object? credentialType = null,Object? did = null,Object? fullName = null,Object? s3Url = null,Object? templateId = null,Object? type = null,Object? completedDate = freezed,Object? description = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,credentialId: null == credentialId ? _self.credentialId : credentialId // ignore: cast_nullable_to_non_nullable
as String,credentialType: null == credentialType ? _self.credentialType : credentialType // ignore: cast_nullable_to_non_nullable
as VcCredentialType,did: null == did ? _self.did : did // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,s3Url: null == s3Url ? _self.s3Url : s3Url // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as VcCredentialType,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IssuedVcSubjectInfo].
extension IssuedVcSubjectInfoPatterns on IssuedVcSubjectInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IssuedVcSubjectInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IssuedVcSubjectInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IssuedVcSubjectInfo value)  $default,){
final _that = this;
switch (_that) {
case _IssuedVcSubjectInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IssuedVcSubjectInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IssuedVcSubjectInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseName,  String credentialId,  VcCredentialType credentialType,  String did,  String fullName,  String s3Url,  String templateId,  VcCredentialType type,  String? completedDate,  String? description,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IssuedVcSubjectInfo() when $default != null:
return $default(_that.courseName,_that.credentialId,_that.credentialType,_that.did,_that.fullName,_that.s3Url,_that.templateId,_that.type,_that.completedDate,_that.description,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseName,  String credentialId,  VcCredentialType credentialType,  String did,  String fullName,  String s3Url,  String templateId,  VcCredentialType type,  String? completedDate,  String? description,  String? email)  $default,) {final _that = this;
switch (_that) {
case _IssuedVcSubjectInfo():
return $default(_that.courseName,_that.credentialId,_that.credentialType,_that.did,_that.fullName,_that.s3Url,_that.templateId,_that.type,_that.completedDate,_that.description,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseName,  String credentialId,  VcCredentialType credentialType,  String did,  String fullName,  String s3Url,  String templateId,  VcCredentialType type,  String? completedDate,  String? description,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _IssuedVcSubjectInfo() when $default != null:
return $default(_that.courseName,_that.credentialId,_that.credentialType,_that.did,_that.fullName,_that.s3Url,_that.templateId,_that.type,_that.completedDate,_that.description,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _IssuedVcSubjectInfo implements IssuedVcSubjectInfo {
  const _IssuedVcSubjectInfo({required this.courseName, required this.credentialId, required this.credentialType, required this.did, required this.fullName, required this.s3Url, required this.templateId, required this.type, this.completedDate, this.description, this.email});
  

@override final  String courseName;
@override final  String credentialId;
@override final  VcCredentialType credentialType;
@override final  String did;
@override final  String fullName;
@override final  String s3Url;
@override final  String templateId;
@override final  VcCredentialType type;
@override final  String? completedDate;
@override final  String? description;
@override final  String? email;

/// Create a copy of IssuedVcSubjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IssuedVcSubjectInfoCopyWith<_IssuedVcSubjectInfo> get copyWith => __$IssuedVcSubjectInfoCopyWithImpl<_IssuedVcSubjectInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IssuedVcSubjectInfo&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.credentialId, credentialId) || other.credentialId == credentialId)&&(identical(other.credentialType, credentialType) || other.credentialType == credentialType)&&(identical(other.did, did) || other.did == did)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.s3Url, s3Url) || other.s3Url == s3Url)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.type, type) || other.type == type)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,courseName,credentialId,credentialType,did,fullName,s3Url,templateId,type,completedDate,description,email);

@override
String toString() {
  return 'IssuedVcSubjectInfo(courseName: $courseName, credentialId: $credentialId, credentialType: $credentialType, did: $did, fullName: $fullName, s3Url: $s3Url, templateId: $templateId, type: $type, completedDate: $completedDate, description: $description, email: $email)';
}


}

/// @nodoc
abstract mixin class _$IssuedVcSubjectInfoCopyWith<$Res> implements $IssuedVcSubjectInfoCopyWith<$Res> {
  factory _$IssuedVcSubjectInfoCopyWith(_IssuedVcSubjectInfo value, $Res Function(_IssuedVcSubjectInfo) _then) = __$IssuedVcSubjectInfoCopyWithImpl;
@override @useResult
$Res call({
 String courseName, String credentialId, VcCredentialType credentialType, String did, String fullName, String s3Url, String templateId, VcCredentialType type, String? completedDate, String? description, String? email
});




}
/// @nodoc
class __$IssuedVcSubjectInfoCopyWithImpl<$Res>
    implements _$IssuedVcSubjectInfoCopyWith<$Res> {
  __$IssuedVcSubjectInfoCopyWithImpl(this._self, this._then);

  final _IssuedVcSubjectInfo _self;
  final $Res Function(_IssuedVcSubjectInfo) _then;

/// Create a copy of IssuedVcSubjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseName = null,Object? credentialId = null,Object? credentialType = null,Object? did = null,Object? fullName = null,Object? s3Url = null,Object? templateId = null,Object? type = null,Object? completedDate = freezed,Object? description = freezed,Object? email = freezed,}) {
  return _then(_IssuedVcSubjectInfo(
courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,credentialId: null == credentialId ? _self.credentialId : credentialId // ignore: cast_nullable_to_non_nullable
as String,credentialType: null == credentialType ? _self.credentialType : credentialType // ignore: cast_nullable_to_non_nullable
as VcCredentialType,did: null == did ? _self.did : did // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,s3Url: null == s3Url ? _self.s3Url : s3Url // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as VcCredentialType,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
