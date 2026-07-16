// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_org_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSearchOrgDto {

 String get id; String get title; String? get code; String? get orgType;
/// Create a copy of UserSearchOrgDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchOrgDtoCopyWith<UserSearchOrgDto> get copyWith => _$UserSearchOrgDtoCopyWithImpl<UserSearchOrgDto>(this as UserSearchOrgDto, _$identity);

  /// Serializes this UserSearchOrgDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchOrgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,code,orgType);

@override
String toString() {
  return 'UserSearchOrgDto(id: $id, title: $title, code: $code, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class $UserSearchOrgDtoCopyWith<$Res>  {
  factory $UserSearchOrgDtoCopyWith(UserSearchOrgDto value, $Res Function(UserSearchOrgDto) _then) = _$UserSearchOrgDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? code, String? orgType
});




}
/// @nodoc
class _$UserSearchOrgDtoCopyWithImpl<$Res>
    implements $UserSearchOrgDtoCopyWith<$Res> {
  _$UserSearchOrgDtoCopyWithImpl(this._self, this._then);

  final UserSearchOrgDto _self;
  final $Res Function(UserSearchOrgDto) _then;

/// Create a copy of UserSearchOrgDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? code = freezed,Object? orgType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,orgType: freezed == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchOrgDto].
extension UserSearchOrgDtoPatterns on UserSearchOrgDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchOrgDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchOrgDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchOrgDto value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchOrgDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchOrgDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchOrgDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? code,  String? orgType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchOrgDto() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.orgType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? code,  String? orgType)  $default,) {final _that = this;
switch (_that) {
case _UserSearchOrgDto():
return $default(_that.id,_that.title,_that.code,_that.orgType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? code,  String? orgType)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchOrgDto() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.orgType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSearchOrgDto implements UserSearchOrgDto {
  const _UserSearchOrgDto({required this.id, required this.title, this.code, this.orgType});
  factory _UserSearchOrgDto.fromJson(Map<String, dynamic> json) => _$UserSearchOrgDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? code;
@override final  String? orgType;

/// Create a copy of UserSearchOrgDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchOrgDtoCopyWith<_UserSearchOrgDto> get copyWith => __$UserSearchOrgDtoCopyWithImpl<_UserSearchOrgDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSearchOrgDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchOrgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,code,orgType);

@override
String toString() {
  return 'UserSearchOrgDto(id: $id, title: $title, code: $code, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class _$UserSearchOrgDtoCopyWith<$Res> implements $UserSearchOrgDtoCopyWith<$Res> {
  factory _$UserSearchOrgDtoCopyWith(_UserSearchOrgDto value, $Res Function(_UserSearchOrgDto) _then) = __$UserSearchOrgDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? code, String? orgType
});




}
/// @nodoc
class __$UserSearchOrgDtoCopyWithImpl<$Res>
    implements _$UserSearchOrgDtoCopyWith<$Res> {
  __$UserSearchOrgDtoCopyWithImpl(this._self, this._then);

  final _UserSearchOrgDto _self;
  final $Res Function(_UserSearchOrgDto) _then;

/// Create a copy of UserSearchOrgDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? code = freezed,Object? orgType = freezed,}) {
  return _then(_UserSearchOrgDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,orgType: freezed == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
