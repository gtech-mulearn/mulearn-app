// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issued_vc_subject_info_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IssuedVcSubjectInfoDto {

 String get courseName; String get credentialId; String get credentialType; String get did; String get fullName; String get s3Url; String get templateId; String get type; String? get completedDate; String? get description; String? get email;
/// Create a copy of IssuedVcSubjectInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IssuedVcSubjectInfoDtoCopyWith<IssuedVcSubjectInfoDto> get copyWith => _$IssuedVcSubjectInfoDtoCopyWithImpl<IssuedVcSubjectInfoDto>(this as IssuedVcSubjectInfoDto, _$identity);

  /// Serializes this IssuedVcSubjectInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IssuedVcSubjectInfoDto&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.credentialId, credentialId) || other.credentialId == credentialId)&&(identical(other.credentialType, credentialType) || other.credentialType == credentialType)&&(identical(other.did, did) || other.did == did)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.s3Url, s3Url) || other.s3Url == s3Url)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.type, type) || other.type == type)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseName,credentialId,credentialType,did,fullName,s3Url,templateId,type,completedDate,description,email);

@override
String toString() {
  return 'IssuedVcSubjectInfoDto(courseName: $courseName, credentialId: $credentialId, credentialType: $credentialType, did: $did, fullName: $fullName, s3Url: $s3Url, templateId: $templateId, type: $type, completedDate: $completedDate, description: $description, email: $email)';
}


}

/// @nodoc
abstract mixin class $IssuedVcSubjectInfoDtoCopyWith<$Res>  {
  factory $IssuedVcSubjectInfoDtoCopyWith(IssuedVcSubjectInfoDto value, $Res Function(IssuedVcSubjectInfoDto) _then) = _$IssuedVcSubjectInfoDtoCopyWithImpl;
@useResult
$Res call({
 String courseName, String credentialId, String credentialType, String did, String fullName, String s3Url, String templateId, String type, String? completedDate, String? description, String? email
});




}
/// @nodoc
class _$IssuedVcSubjectInfoDtoCopyWithImpl<$Res>
    implements $IssuedVcSubjectInfoDtoCopyWith<$Res> {
  _$IssuedVcSubjectInfoDtoCopyWithImpl(this._self, this._then);

  final IssuedVcSubjectInfoDto _self;
  final $Res Function(IssuedVcSubjectInfoDto) _then;

/// Create a copy of IssuedVcSubjectInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseName = null,Object? credentialId = null,Object? credentialType = null,Object? did = null,Object? fullName = null,Object? s3Url = null,Object? templateId = null,Object? type = null,Object? completedDate = freezed,Object? description = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,credentialId: null == credentialId ? _self.credentialId : credentialId // ignore: cast_nullable_to_non_nullable
as String,credentialType: null == credentialType ? _self.credentialType : credentialType // ignore: cast_nullable_to_non_nullable
as String,did: null == did ? _self.did : did // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,s3Url: null == s3Url ? _self.s3Url : s3Url // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IssuedVcSubjectInfoDto].
extension IssuedVcSubjectInfoDtoPatterns on IssuedVcSubjectInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IssuedVcSubjectInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IssuedVcSubjectInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IssuedVcSubjectInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _IssuedVcSubjectInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IssuedVcSubjectInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _IssuedVcSubjectInfoDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseName,  String credentialId,  String credentialType,  String did,  String fullName,  String s3Url,  String templateId,  String type,  String? completedDate,  String? description,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IssuedVcSubjectInfoDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseName,  String credentialId,  String credentialType,  String did,  String fullName,  String s3Url,  String templateId,  String type,  String? completedDate,  String? description,  String? email)  $default,) {final _that = this;
switch (_that) {
case _IssuedVcSubjectInfoDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseName,  String credentialId,  String credentialType,  String did,  String fullName,  String s3Url,  String templateId,  String type,  String? completedDate,  String? description,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _IssuedVcSubjectInfoDto() when $default != null:
return $default(_that.courseName,_that.credentialId,_that.credentialType,_that.did,_that.fullName,_that.s3Url,_that.templateId,_that.type,_that.completedDate,_that.description,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IssuedVcSubjectInfoDto extends IssuedVcSubjectInfoDto {
  const _IssuedVcSubjectInfoDto({required this.courseName, required this.credentialId, required this.credentialType, required this.did, required this.fullName, required this.s3Url, required this.templateId, required this.type, this.completedDate, this.description, this.email}): super._();
  factory _IssuedVcSubjectInfoDto.fromJson(Map<String, dynamic> json) => _$IssuedVcSubjectInfoDtoFromJson(json);

@override final  String courseName;
@override final  String credentialId;
@override final  String credentialType;
@override final  String did;
@override final  String fullName;
@override final  String s3Url;
@override final  String templateId;
@override final  String type;
@override final  String? completedDate;
@override final  String? description;
@override final  String? email;

/// Create a copy of IssuedVcSubjectInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IssuedVcSubjectInfoDtoCopyWith<_IssuedVcSubjectInfoDto> get copyWith => __$IssuedVcSubjectInfoDtoCopyWithImpl<_IssuedVcSubjectInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IssuedVcSubjectInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IssuedVcSubjectInfoDto&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.credentialId, credentialId) || other.credentialId == credentialId)&&(identical(other.credentialType, credentialType) || other.credentialType == credentialType)&&(identical(other.did, did) || other.did == did)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.s3Url, s3Url) || other.s3Url == s3Url)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.type, type) || other.type == type)&&(identical(other.completedDate, completedDate) || other.completedDate == completedDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,courseName,credentialId,credentialType,did,fullName,s3Url,templateId,type,completedDate,description,email);

@override
String toString() {
  return 'IssuedVcSubjectInfoDto(courseName: $courseName, credentialId: $credentialId, credentialType: $credentialType, did: $did, fullName: $fullName, s3Url: $s3Url, templateId: $templateId, type: $type, completedDate: $completedDate, description: $description, email: $email)';
}


}

/// @nodoc
abstract mixin class _$IssuedVcSubjectInfoDtoCopyWith<$Res> implements $IssuedVcSubjectInfoDtoCopyWith<$Res> {
  factory _$IssuedVcSubjectInfoDtoCopyWith(_IssuedVcSubjectInfoDto value, $Res Function(_IssuedVcSubjectInfoDto) _then) = __$IssuedVcSubjectInfoDtoCopyWithImpl;
@override @useResult
$Res call({
 String courseName, String credentialId, String credentialType, String did, String fullName, String s3Url, String templateId, String type, String? completedDate, String? description, String? email
});




}
/// @nodoc
class __$IssuedVcSubjectInfoDtoCopyWithImpl<$Res>
    implements _$IssuedVcSubjectInfoDtoCopyWith<$Res> {
  __$IssuedVcSubjectInfoDtoCopyWithImpl(this._self, this._then);

  final _IssuedVcSubjectInfoDto _self;
  final $Res Function(_IssuedVcSubjectInfoDto) _then;

/// Create a copy of IssuedVcSubjectInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseName = null,Object? credentialId = null,Object? credentialType = null,Object? did = null,Object? fullName = null,Object? s3Url = null,Object? templateId = null,Object? type = null,Object? completedDate = freezed,Object? description = freezed,Object? email = freezed,}) {
  return _then(_IssuedVcSubjectInfoDto(
courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,credentialId: null == credentialId ? _self.credentialId : credentialId // ignore: cast_nullable_to_non_nullable
as String,credentialType: null == credentialType ? _self.credentialType : credentialType // ignore: cast_nullable_to_non_nullable
as String,did: null == did ? _self.did : did // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,s3Url: null == s3Url ? _self.s3Url : s3Url // ignore: cast_nullable_to_non_nullable
as String,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,completedDate: freezed == completedDate ? _self.completedDate : completedDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
