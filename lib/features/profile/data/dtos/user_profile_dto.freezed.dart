// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDto {

 String get id; String get fullName; String get muid; String get joined; String? get email; String? get mobile; String? get gender; String? get level; String? get profilePic; String? get coverPic; String? get collegeCode; String? get collegeId; String? get departmentId; String? get departmentName; String? get orgDistrictId; bool? get isPublic; num? get karma; num? get rank; num? get percentile; List<String> get roles; List<RoleVerificationDto> get roleVerification; bool? get isVerified; bool? get leadEnablerVerified; List<InterestGroupDto> get interestGroups; List<KarmaDistributionEntryDto> get karmaDistribution;
/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDtoCopyWith<UserProfileDto> get copyWith => _$UserProfileDtoCopyWithImpl<UserProfileDto>(this as UserProfileDto, _$identity);

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.joined, joined) || other.joined == joined)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.level, level) || other.level == level)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.coverPic, coverPic) || other.coverPic == coverPic)&&(identical(other.collegeCode, collegeCode) || other.collegeCode == collegeCode)&&(identical(other.collegeId, collegeId) || other.collegeId == collegeId)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.orgDistrictId, orgDistrictId) || other.orgDistrictId == orgDistrictId)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.percentile, percentile) || other.percentile == percentile)&&const DeepCollectionEquality().equals(other.roles, roles)&&const DeepCollectionEquality().equals(other.roleVerification, roleVerification)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.leadEnablerVerified, leadEnablerVerified) || other.leadEnablerVerified == leadEnablerVerified)&&const DeepCollectionEquality().equals(other.interestGroups, interestGroups)&&const DeepCollectionEquality().equals(other.karmaDistribution, karmaDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,muid,joined,email,mobile,gender,level,profilePic,coverPic,collegeCode,collegeId,departmentId,departmentName,orgDistrictId,isPublic,karma,rank,percentile,const DeepCollectionEquality().hash(roles),const DeepCollectionEquality().hash(roleVerification),isVerified,leadEnablerVerified,const DeepCollectionEquality().hash(interestGroups),const DeepCollectionEquality().hash(karmaDistribution)]);

@override
String toString() {
  return 'UserProfileDto(id: $id, fullName: $fullName, muid: $muid, joined: $joined, email: $email, mobile: $mobile, gender: $gender, level: $level, profilePic: $profilePic, coverPic: $coverPic, collegeCode: $collegeCode, collegeId: $collegeId, departmentId: $departmentId, departmentName: $departmentName, orgDistrictId: $orgDistrictId, isPublic: $isPublic, karma: $karma, rank: $rank, percentile: $percentile, roles: $roles, roleVerification: $roleVerification, isVerified: $isVerified, leadEnablerVerified: $leadEnablerVerified, interestGroups: $interestGroups, karmaDistribution: $karmaDistribution)';
}


}

/// @nodoc
abstract mixin class $UserProfileDtoCopyWith<$Res>  {
  factory $UserProfileDtoCopyWith(UserProfileDto value, $Res Function(UserProfileDto) _then) = _$UserProfileDtoCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String muid, String joined, String? email, String? mobile, String? gender, String? level, String? profilePic, String? coverPic, String? collegeCode, String? collegeId, String? departmentId, String? departmentName, String? orgDistrictId, bool? isPublic, num? karma, num? rank, num? percentile, List<String> roles, List<RoleVerificationDto> roleVerification, bool? isVerified, bool? leadEnablerVerified, List<InterestGroupDto> interestGroups, List<KarmaDistributionEntryDto> karmaDistribution
});




}
/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._self, this._then);

  final UserProfileDto _self;
  final $Res Function(UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? joined = null,Object? email = freezed,Object? mobile = freezed,Object? gender = freezed,Object? level = freezed,Object? profilePic = freezed,Object? coverPic = freezed,Object? collegeCode = freezed,Object? collegeId = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? orgDistrictId = freezed,Object? isPublic = freezed,Object? karma = freezed,Object? rank = freezed,Object? percentile = freezed,Object? roles = null,Object? roleVerification = null,Object? isVerified = freezed,Object? leadEnablerVerified = freezed,Object? interestGroups = null,Object? karmaDistribution = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,coverPic: freezed == coverPic ? _self.coverPic : coverPic // ignore: cast_nullable_to_non_nullable
as String?,collegeCode: freezed == collegeCode ? _self.collegeCode : collegeCode // ignore: cast_nullable_to_non_nullable
as String?,collegeId: freezed == collegeId ? _self.collegeId : collegeId // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,orgDistrictId: freezed == orgDistrictId ? _self.orgDistrictId : orgDistrictId // ignore: cast_nullable_to_non_nullable
as String?,isPublic: freezed == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool?,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as num?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as num?,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,roleVerification: null == roleVerification ? _self.roleVerification : roleVerification // ignore: cast_nullable_to_non_nullable
as List<RoleVerificationDto>,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,leadEnablerVerified: freezed == leadEnablerVerified ? _self.leadEnablerVerified : leadEnablerVerified // ignore: cast_nullable_to_non_nullable
as bool?,interestGroups: null == interestGroups ? _self.interestGroups : interestGroups // ignore: cast_nullable_to_non_nullable
as List<InterestGroupDto>,karmaDistribution: null == karmaDistribution ? _self.karmaDistribution : karmaDistribution // ignore: cast_nullable_to_non_nullable
as List<KarmaDistributionEntryDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileDto].
extension UserProfileDtoPatterns on UserProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  String joined,  String? email,  String? mobile,  String? gender,  String? level,  String? profilePic,  String? coverPic,  String? collegeCode,  String? collegeId,  String? departmentId,  String? departmentName,  String? orgDistrictId,  bool? isPublic,  num? karma,  num? rank,  num? percentile,  List<String> roles,  List<RoleVerificationDto> roleVerification,  bool? isVerified,  bool? leadEnablerVerified,  List<InterestGroupDto> interestGroups,  List<KarmaDistributionEntryDto> karmaDistribution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.joined,_that.email,_that.mobile,_that.gender,_that.level,_that.profilePic,_that.coverPic,_that.collegeCode,_that.collegeId,_that.departmentId,_that.departmentName,_that.orgDistrictId,_that.isPublic,_that.karma,_that.rank,_that.percentile,_that.roles,_that.roleVerification,_that.isVerified,_that.leadEnablerVerified,_that.interestGroups,_that.karmaDistribution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  String joined,  String? email,  String? mobile,  String? gender,  String? level,  String? profilePic,  String? coverPic,  String? collegeCode,  String? collegeId,  String? departmentId,  String? departmentName,  String? orgDistrictId,  bool? isPublic,  num? karma,  num? rank,  num? percentile,  List<String> roles,  List<RoleVerificationDto> roleVerification,  bool? isVerified,  bool? leadEnablerVerified,  List<InterestGroupDto> interestGroups,  List<KarmaDistributionEntryDto> karmaDistribution)  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto():
return $default(_that.id,_that.fullName,_that.muid,_that.joined,_that.email,_that.mobile,_that.gender,_that.level,_that.profilePic,_that.coverPic,_that.collegeCode,_that.collegeId,_that.departmentId,_that.departmentName,_that.orgDistrictId,_that.isPublic,_that.karma,_that.rank,_that.percentile,_that.roles,_that.roleVerification,_that.isVerified,_that.leadEnablerVerified,_that.interestGroups,_that.karmaDistribution);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String muid,  String joined,  String? email,  String? mobile,  String? gender,  String? level,  String? profilePic,  String? coverPic,  String? collegeCode,  String? collegeId,  String? departmentId,  String? departmentName,  String? orgDistrictId,  bool? isPublic,  num? karma,  num? rank,  num? percentile,  List<String> roles,  List<RoleVerificationDto> roleVerification,  bool? isVerified,  bool? leadEnablerVerified,  List<InterestGroupDto> interestGroups,  List<KarmaDistributionEntryDto> karmaDistribution)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.joined,_that.email,_that.mobile,_that.gender,_that.level,_that.profilePic,_that.coverPic,_that.collegeCode,_that.collegeId,_that.departmentId,_that.departmentName,_that.orgDistrictId,_that.isPublic,_that.karma,_that.rank,_that.percentile,_that.roles,_that.roleVerification,_that.isVerified,_that.leadEnablerVerified,_that.interestGroups,_that.karmaDistribution);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileDto extends UserProfileDto {
  const _UserProfileDto({required this.id, required this.fullName, required this.muid, required this.joined, this.email, this.mobile, this.gender, this.level, this.profilePic, this.coverPic, this.collegeCode, this.collegeId, this.departmentId, this.departmentName, this.orgDistrictId, this.isPublic, this.karma, this.rank, this.percentile, final  List<String> roles = const [], final  List<RoleVerificationDto> roleVerification = const [], this.isVerified, this.leadEnablerVerified, final  List<InterestGroupDto> interestGroups = const [], final  List<KarmaDistributionEntryDto> karmaDistribution = const []}): _roles = roles,_roleVerification = roleVerification,_interestGroups = interestGroups,_karmaDistribution = karmaDistribution,super._();
  factory _UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String muid;
@override final  String joined;
@override final  String? email;
@override final  String? mobile;
@override final  String? gender;
@override final  String? level;
@override final  String? profilePic;
@override final  String? coverPic;
@override final  String? collegeCode;
@override final  String? collegeId;
@override final  String? departmentId;
@override final  String? departmentName;
@override final  String? orgDistrictId;
@override final  bool? isPublic;
@override final  num? karma;
@override final  num? rank;
@override final  num? percentile;
 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

 final  List<RoleVerificationDto> _roleVerification;
@override@JsonKey() List<RoleVerificationDto> get roleVerification {
  if (_roleVerification is EqualUnmodifiableListView) return _roleVerification;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roleVerification);
}

@override final  bool? isVerified;
@override final  bool? leadEnablerVerified;
 final  List<InterestGroupDto> _interestGroups;
@override@JsonKey() List<InterestGroupDto> get interestGroups {
  if (_interestGroups is EqualUnmodifiableListView) return _interestGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interestGroups);
}

 final  List<KarmaDistributionEntryDto> _karmaDistribution;
@override@JsonKey() List<KarmaDistributionEntryDto> get karmaDistribution {
  if (_karmaDistribution is EqualUnmodifiableListView) return _karmaDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_karmaDistribution);
}


/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDtoCopyWith<_UserProfileDto> get copyWith => __$UserProfileDtoCopyWithImpl<_UserProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.joined, joined) || other.joined == joined)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.level, level) || other.level == level)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.coverPic, coverPic) || other.coverPic == coverPic)&&(identical(other.collegeCode, collegeCode) || other.collegeCode == collegeCode)&&(identical(other.collegeId, collegeId) || other.collegeId == collegeId)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.orgDistrictId, orgDistrictId) || other.orgDistrictId == orgDistrictId)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.percentile, percentile) || other.percentile == percentile)&&const DeepCollectionEquality().equals(other._roles, _roles)&&const DeepCollectionEquality().equals(other._roleVerification, _roleVerification)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.leadEnablerVerified, leadEnablerVerified) || other.leadEnablerVerified == leadEnablerVerified)&&const DeepCollectionEquality().equals(other._interestGroups, _interestGroups)&&const DeepCollectionEquality().equals(other._karmaDistribution, _karmaDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,muid,joined,email,mobile,gender,level,profilePic,coverPic,collegeCode,collegeId,departmentId,departmentName,orgDistrictId,isPublic,karma,rank,percentile,const DeepCollectionEquality().hash(_roles),const DeepCollectionEquality().hash(_roleVerification),isVerified,leadEnablerVerified,const DeepCollectionEquality().hash(_interestGroups),const DeepCollectionEquality().hash(_karmaDistribution)]);

@override
String toString() {
  return 'UserProfileDto(id: $id, fullName: $fullName, muid: $muid, joined: $joined, email: $email, mobile: $mobile, gender: $gender, level: $level, profilePic: $profilePic, coverPic: $coverPic, collegeCode: $collegeCode, collegeId: $collegeId, departmentId: $departmentId, departmentName: $departmentName, orgDistrictId: $orgDistrictId, isPublic: $isPublic, karma: $karma, rank: $rank, percentile: $percentile, roles: $roles, roleVerification: $roleVerification, isVerified: $isVerified, leadEnablerVerified: $leadEnablerVerified, interestGroups: $interestGroups, karmaDistribution: $karmaDistribution)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDtoCopyWith<$Res> implements $UserProfileDtoCopyWith<$Res> {
  factory _$UserProfileDtoCopyWith(_UserProfileDto value, $Res Function(_UserProfileDto) _then) = __$UserProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String muid, String joined, String? email, String? mobile, String? gender, String? level, String? profilePic, String? coverPic, String? collegeCode, String? collegeId, String? departmentId, String? departmentName, String? orgDistrictId, bool? isPublic, num? karma, num? rank, num? percentile, List<String> roles, List<RoleVerificationDto> roleVerification, bool? isVerified, bool? leadEnablerVerified, List<InterestGroupDto> interestGroups, List<KarmaDistributionEntryDto> karmaDistribution
});




}
/// @nodoc
class __$UserProfileDtoCopyWithImpl<$Res>
    implements _$UserProfileDtoCopyWith<$Res> {
  __$UserProfileDtoCopyWithImpl(this._self, this._then);

  final _UserProfileDto _self;
  final $Res Function(_UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? joined = null,Object? email = freezed,Object? mobile = freezed,Object? gender = freezed,Object? level = freezed,Object? profilePic = freezed,Object? coverPic = freezed,Object? collegeCode = freezed,Object? collegeId = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? orgDistrictId = freezed,Object? isPublic = freezed,Object? karma = freezed,Object? rank = freezed,Object? percentile = freezed,Object? roles = null,Object? roleVerification = null,Object? isVerified = freezed,Object? leadEnablerVerified = freezed,Object? interestGroups = null,Object? karmaDistribution = null,}) {
  return _then(_UserProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,coverPic: freezed == coverPic ? _self.coverPic : coverPic // ignore: cast_nullable_to_non_nullable
as String?,collegeCode: freezed == collegeCode ? _self.collegeCode : collegeCode // ignore: cast_nullable_to_non_nullable
as String?,collegeId: freezed == collegeId ? _self.collegeId : collegeId // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,orgDistrictId: freezed == orgDistrictId ? _self.orgDistrictId : orgDistrictId // ignore: cast_nullable_to_non_nullable
as String?,isPublic: freezed == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool?,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as num?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as num?,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,roleVerification: null == roleVerification ? _self._roleVerification : roleVerification // ignore: cast_nullable_to_non_nullable
as List<RoleVerificationDto>,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,leadEnablerVerified: freezed == leadEnablerVerified ? _self.leadEnablerVerified : leadEnablerVerified // ignore: cast_nullable_to_non_nullable
as bool?,interestGroups: null == interestGroups ? _self._interestGroups : interestGroups // ignore: cast_nullable_to_non_nullable
as List<InterestGroupDto>,karmaDistribution: null == karmaDistribution ? _self._karmaDistribution : karmaDistribution // ignore: cast_nullable_to_non_nullable
as List<KarmaDistributionEntryDto>,
  ));
}


}

// dart format on
