// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentUserDto {

 String get muid; String get fullName; List<String> get roles; bool get existInGuild; String? get profilePic; String? get company;
/// Create a copy of CurrentUserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentUserDtoCopyWith<CurrentUserDto> get copyWith => _$CurrentUserDtoCopyWithImpl<CurrentUserDto>(this as CurrentUserDto, _$identity);

  /// Serializes this CurrentUserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentUserDto&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.existInGuild, existInGuild) || other.existInGuild == existInGuild)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.company, company) || other.company == company));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muid,fullName,const DeepCollectionEquality().hash(roles),existInGuild,profilePic,company);

@override
String toString() {
  return 'CurrentUserDto(muid: $muid, fullName: $fullName, roles: $roles, existInGuild: $existInGuild, profilePic: $profilePic, company: $company)';
}


}

/// @nodoc
abstract mixin class $CurrentUserDtoCopyWith<$Res>  {
  factory $CurrentUserDtoCopyWith(CurrentUserDto value, $Res Function(CurrentUserDto) _then) = _$CurrentUserDtoCopyWithImpl;
@useResult
$Res call({
 String muid, String fullName, List<String> roles, bool existInGuild, String? profilePic, String? company
});




}
/// @nodoc
class _$CurrentUserDtoCopyWithImpl<$Res>
    implements $CurrentUserDtoCopyWith<$Res> {
  _$CurrentUserDtoCopyWithImpl(this._self, this._then);

  final CurrentUserDto _self;
  final $Res Function(CurrentUserDto) _then;

/// Create a copy of CurrentUserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muid = null,Object? fullName = null,Object? roles = null,Object? existInGuild = null,Object? profilePic = freezed,Object? company = freezed,}) {
  return _then(_self.copyWith(
muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,existInGuild: null == existInGuild ? _self.existInGuild : existInGuild // ignore: cast_nullable_to_non_nullable
as bool,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentUserDto].
extension CurrentUserDtoPatterns on CurrentUserDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentUserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentUserDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentUserDto value)  $default,){
final _that = this;
switch (_that) {
case _CurrentUserDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentUserDto value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentUserDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String muid,  String fullName,  List<String> roles,  bool existInGuild,  String? profilePic,  String? company)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentUserDto() when $default != null:
return $default(_that.muid,_that.fullName,_that.roles,_that.existInGuild,_that.profilePic,_that.company);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String muid,  String fullName,  List<String> roles,  bool existInGuild,  String? profilePic,  String? company)  $default,) {final _that = this;
switch (_that) {
case _CurrentUserDto():
return $default(_that.muid,_that.fullName,_that.roles,_that.existInGuild,_that.profilePic,_that.company);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String muid,  String fullName,  List<String> roles,  bool existInGuild,  String? profilePic,  String? company)?  $default,) {final _that = this;
switch (_that) {
case _CurrentUserDto() when $default != null:
return $default(_that.muid,_that.fullName,_that.roles,_that.existInGuild,_that.profilePic,_that.company);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentUserDto extends CurrentUserDto {
  const _CurrentUserDto({required this.muid, required this.fullName, final  List<String> roles = const [], this.existInGuild = false, this.profilePic, this.company}): _roles = roles,super._();
  factory _CurrentUserDto.fromJson(Map<String, dynamic> json) => _$CurrentUserDtoFromJson(json);

@override final  String muid;
@override final  String fullName;
 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override@JsonKey() final  bool existInGuild;
@override final  String? profilePic;
@override final  String? company;

/// Create a copy of CurrentUserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentUserDtoCopyWith<_CurrentUserDto> get copyWith => __$CurrentUserDtoCopyWithImpl<_CurrentUserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentUserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentUserDto&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.existInGuild, existInGuild) || other.existInGuild == existInGuild)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.company, company) || other.company == company));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muid,fullName,const DeepCollectionEquality().hash(_roles),existInGuild,profilePic,company);

@override
String toString() {
  return 'CurrentUserDto(muid: $muid, fullName: $fullName, roles: $roles, existInGuild: $existInGuild, profilePic: $profilePic, company: $company)';
}


}

/// @nodoc
abstract mixin class _$CurrentUserDtoCopyWith<$Res> implements $CurrentUserDtoCopyWith<$Res> {
  factory _$CurrentUserDtoCopyWith(_CurrentUserDto value, $Res Function(_CurrentUserDto) _then) = __$CurrentUserDtoCopyWithImpl;
@override @useResult
$Res call({
 String muid, String fullName, List<String> roles, bool existInGuild, String? profilePic, String? company
});




}
/// @nodoc
class __$CurrentUserDtoCopyWithImpl<$Res>
    implements _$CurrentUserDtoCopyWith<$Res> {
  __$CurrentUserDtoCopyWithImpl(this._self, this._then);

  final _CurrentUserDto _self;
  final $Res Function(_CurrentUserDto) _then;

/// Create a copy of CurrentUserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muid = null,Object? fullName = null,Object? roles = null,Object? existInGuild = null,Object? profilePic = freezed,Object? company = freezed,}) {
  return _then(_CurrentUserDto(
muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,existInGuild: null == existInGuild ? _self.existInGuild : existInGuild // ignore: cast_nullable_to_non_nullable
as bool,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
