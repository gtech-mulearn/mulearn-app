// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_result_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSearchResultDto {

 String get id; String get muid; String get fullName; String? get karma; String? get profilePic; List<UserSearchIgDto> get interestGroups; List<UserSearchOrgDto> get organizations;
/// Create a copy of UserSearchResultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchResultDtoCopyWith<UserSearchResultDto> get copyWith => _$UserSearchResultDtoCopyWithImpl<UserSearchResultDto>(this as UserSearchResultDto, _$identity);

  /// Serializes this UserSearchResultDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchResultDto&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&const DeepCollectionEquality().equals(other.interestGroups, interestGroups)&&const DeepCollectionEquality().equals(other.organizations, organizations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,muid,fullName,karma,profilePic,const DeepCollectionEquality().hash(interestGroups),const DeepCollectionEquality().hash(organizations));

@override
String toString() {
  return 'UserSearchResultDto(id: $id, muid: $muid, fullName: $fullName, karma: $karma, profilePic: $profilePic, interestGroups: $interestGroups, organizations: $organizations)';
}


}

/// @nodoc
abstract mixin class $UserSearchResultDtoCopyWith<$Res>  {
  factory $UserSearchResultDtoCopyWith(UserSearchResultDto value, $Res Function(UserSearchResultDto) _then) = _$UserSearchResultDtoCopyWithImpl;
@useResult
$Res call({
 String id, String muid, String fullName, String? karma, String? profilePic, List<UserSearchIgDto> interestGroups, List<UserSearchOrgDto> organizations
});




}
/// @nodoc
class _$UserSearchResultDtoCopyWithImpl<$Res>
    implements $UserSearchResultDtoCopyWith<$Res> {
  _$UserSearchResultDtoCopyWithImpl(this._self, this._then);

  final UserSearchResultDto _self;
  final $Res Function(UserSearchResultDto) _then;

/// Create a copy of UserSearchResultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? muid = null,Object? fullName = null,Object? karma = freezed,Object? profilePic = freezed,Object? interestGroups = null,Object? organizations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,interestGroups: null == interestGroups ? _self.interestGroups : interestGroups // ignore: cast_nullable_to_non_nullable
as List<UserSearchIgDto>,organizations: null == organizations ? _self.organizations : organizations // ignore: cast_nullable_to_non_nullable
as List<UserSearchOrgDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchResultDto].
extension UserSearchResultDtoPatterns on UserSearchResultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchResultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchResultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchResultDto value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchResultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchResultDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchResultDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String muid,  String fullName,  String? karma,  String? profilePic,  List<UserSearchIgDto> interestGroups,  List<UserSearchOrgDto> organizations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchResultDto() when $default != null:
return $default(_that.id,_that.muid,_that.fullName,_that.karma,_that.profilePic,_that.interestGroups,_that.organizations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String muid,  String fullName,  String? karma,  String? profilePic,  List<UserSearchIgDto> interestGroups,  List<UserSearchOrgDto> organizations)  $default,) {final _that = this;
switch (_that) {
case _UserSearchResultDto():
return $default(_that.id,_that.muid,_that.fullName,_that.karma,_that.profilePic,_that.interestGroups,_that.organizations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String muid,  String fullName,  String? karma,  String? profilePic,  List<UserSearchIgDto> interestGroups,  List<UserSearchOrgDto> organizations)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchResultDto() when $default != null:
return $default(_that.id,_that.muid,_that.fullName,_that.karma,_that.profilePic,_that.interestGroups,_that.organizations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSearchResultDto extends UserSearchResultDto {
  const _UserSearchResultDto({required this.id, required this.muid, required this.fullName, this.karma, this.profilePic, final  List<UserSearchIgDto> interestGroups = const [], final  List<UserSearchOrgDto> organizations = const []}): _interestGroups = interestGroups,_organizations = organizations,super._();
  factory _UserSearchResultDto.fromJson(Map<String, dynamic> json) => _$UserSearchResultDtoFromJson(json);

@override final  String id;
@override final  String muid;
@override final  String fullName;
@override final  String? karma;
@override final  String? profilePic;
 final  List<UserSearchIgDto> _interestGroups;
@override@JsonKey() List<UserSearchIgDto> get interestGroups {
  if (_interestGroups is EqualUnmodifiableListView) return _interestGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interestGroups);
}

 final  List<UserSearchOrgDto> _organizations;
@override@JsonKey() List<UserSearchOrgDto> get organizations {
  if (_organizations is EqualUnmodifiableListView) return _organizations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_organizations);
}


/// Create a copy of UserSearchResultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchResultDtoCopyWith<_UserSearchResultDto> get copyWith => __$UserSearchResultDtoCopyWithImpl<_UserSearchResultDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSearchResultDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchResultDto&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&const DeepCollectionEquality().equals(other._interestGroups, _interestGroups)&&const DeepCollectionEquality().equals(other._organizations, _organizations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,muid,fullName,karma,profilePic,const DeepCollectionEquality().hash(_interestGroups),const DeepCollectionEquality().hash(_organizations));

@override
String toString() {
  return 'UserSearchResultDto(id: $id, muid: $muid, fullName: $fullName, karma: $karma, profilePic: $profilePic, interestGroups: $interestGroups, organizations: $organizations)';
}


}

/// @nodoc
abstract mixin class _$UserSearchResultDtoCopyWith<$Res> implements $UserSearchResultDtoCopyWith<$Res> {
  factory _$UserSearchResultDtoCopyWith(_UserSearchResultDto value, $Res Function(_UserSearchResultDto) _then) = __$UserSearchResultDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String muid, String fullName, String? karma, String? profilePic, List<UserSearchIgDto> interestGroups, List<UserSearchOrgDto> organizations
});




}
/// @nodoc
class __$UserSearchResultDtoCopyWithImpl<$Res>
    implements _$UserSearchResultDtoCopyWith<$Res> {
  __$UserSearchResultDtoCopyWithImpl(this._self, this._then);

  final _UserSearchResultDto _self;
  final $Res Function(_UserSearchResultDto) _then;

/// Create a copy of UserSearchResultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? muid = null,Object? fullName = null,Object? karma = freezed,Object? profilePic = freezed,Object? interestGroups = null,Object? organizations = null,}) {
  return _then(_UserSearchResultDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,interestGroups: null == interestGroups ? _self._interestGroups : interestGroups // ignore: cast_nullable_to_non_nullable
as List<UserSearchIgDto>,organizations: null == organizations ? _self._organizations : organizations // ignore: cast_nullable_to_non_nullable
as List<UserSearchOrgDto>,
  ));
}


}

// dart format on
