// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {

 String get id; String get fullName; String get muid; int get karma; bool get isPublic; String get joined; String? get email; String? get mobile; String? get gender; String? get level; String? get profilePicUrl; String? get coverPicUrl; String? get collegeCode; String? get collegeId; String? get departmentId; String? get departmentName; String? get orgDistrictId; int? get rank; double? get percentile; List<String> get roles; List<RoleVerification> get roleVerification; bool? get isVerified; bool? get leadEnablerVerified; List<InterestGroup> get interestGroups; List<KarmaDistributionEntry> get karmaDistribution;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.joined, joined) || other.joined == joined)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.level, level) || other.level == level)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.coverPicUrl, coverPicUrl) || other.coverPicUrl == coverPicUrl)&&(identical(other.collegeCode, collegeCode) || other.collegeCode == collegeCode)&&(identical(other.collegeId, collegeId) || other.collegeId == collegeId)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.orgDistrictId, orgDistrictId) || other.orgDistrictId == orgDistrictId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.percentile, percentile) || other.percentile == percentile)&&const DeepCollectionEquality().equals(other.roles, roles)&&const DeepCollectionEquality().equals(other.roleVerification, roleVerification)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.leadEnablerVerified, leadEnablerVerified) || other.leadEnablerVerified == leadEnablerVerified)&&const DeepCollectionEquality().equals(other.interestGroups, interestGroups)&&const DeepCollectionEquality().equals(other.karmaDistribution, karmaDistribution));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,muid,karma,isPublic,joined,email,mobile,gender,level,profilePicUrl,coverPicUrl,collegeCode,collegeId,departmentId,departmentName,orgDistrictId,rank,percentile,const DeepCollectionEquality().hash(roles),const DeepCollectionEquality().hash(roleVerification),isVerified,leadEnablerVerified,const DeepCollectionEquality().hash(interestGroups),const DeepCollectionEquality().hash(karmaDistribution)]);

@override
String toString() {
  return 'UserProfile(id: $id, fullName: $fullName, muid: $muid, karma: $karma, isPublic: $isPublic, joined: $joined, email: $email, mobile: $mobile, gender: $gender, level: $level, profilePicUrl: $profilePicUrl, coverPicUrl: $coverPicUrl, collegeCode: $collegeCode, collegeId: $collegeId, departmentId: $departmentId, departmentName: $departmentName, orgDistrictId: $orgDistrictId, rank: $rank, percentile: $percentile, roles: $roles, roleVerification: $roleVerification, isVerified: $isVerified, leadEnablerVerified: $leadEnablerVerified, interestGroups: $interestGroups, karmaDistribution: $karmaDistribution)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String muid, int karma, bool isPublic, String joined, String? email, String? mobile, String? gender, String? level, String? profilePicUrl, String? coverPicUrl, String? collegeCode, String? collegeId, String? departmentId, String? departmentName, String? orgDistrictId, int? rank, double? percentile, List<String> roles, List<RoleVerification> roleVerification, bool? isVerified, bool? leadEnablerVerified, List<InterestGroup> interestGroups, List<KarmaDistributionEntry> karmaDistribution
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? karma = null,Object? isPublic = null,Object? joined = null,Object? email = freezed,Object? mobile = freezed,Object? gender = freezed,Object? level = freezed,Object? profilePicUrl = freezed,Object? coverPicUrl = freezed,Object? collegeCode = freezed,Object? collegeId = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? orgDistrictId = freezed,Object? rank = freezed,Object? percentile = freezed,Object? roles = null,Object? roleVerification = null,Object? isVerified = freezed,Object? leadEnablerVerified = freezed,Object? interestGroups = null,Object? karmaDistribution = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,coverPicUrl: freezed == coverPicUrl ? _self.coverPicUrl : coverPicUrl // ignore: cast_nullable_to_non_nullable
as String?,collegeCode: freezed == collegeCode ? _self.collegeCode : collegeCode // ignore: cast_nullable_to_non_nullable
as String?,collegeId: freezed == collegeId ? _self.collegeId : collegeId // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,orgDistrictId: freezed == orgDistrictId ? _self.orgDistrictId : orgDistrictId // ignore: cast_nullable_to_non_nullable
as String?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as double?,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,roleVerification: null == roleVerification ? _self.roleVerification : roleVerification // ignore: cast_nullable_to_non_nullable
as List<RoleVerification>,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,leadEnablerVerified: freezed == leadEnablerVerified ? _self.leadEnablerVerified : leadEnablerVerified // ignore: cast_nullable_to_non_nullable
as bool?,interestGroups: null == interestGroups ? _self.interestGroups : interestGroups // ignore: cast_nullable_to_non_nullable
as List<InterestGroup>,karmaDistribution: null == karmaDistribution ? _self.karmaDistribution : karmaDistribution // ignore: cast_nullable_to_non_nullable
as List<KarmaDistributionEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  int karma,  bool isPublic,  String joined,  String? email,  String? mobile,  String? gender,  String? level,  String? profilePicUrl,  String? coverPicUrl,  String? collegeCode,  String? collegeId,  String? departmentId,  String? departmentName,  String? orgDistrictId,  int? rank,  double? percentile,  List<String> roles,  List<RoleVerification> roleVerification,  bool? isVerified,  bool? leadEnablerVerified,  List<InterestGroup> interestGroups,  List<KarmaDistributionEntry> karmaDistribution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.karma,_that.isPublic,_that.joined,_that.email,_that.mobile,_that.gender,_that.level,_that.profilePicUrl,_that.coverPicUrl,_that.collegeCode,_that.collegeId,_that.departmentId,_that.departmentName,_that.orgDistrictId,_that.rank,_that.percentile,_that.roles,_that.roleVerification,_that.isVerified,_that.leadEnablerVerified,_that.interestGroups,_that.karmaDistribution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  int karma,  bool isPublic,  String joined,  String? email,  String? mobile,  String? gender,  String? level,  String? profilePicUrl,  String? coverPicUrl,  String? collegeCode,  String? collegeId,  String? departmentId,  String? departmentName,  String? orgDistrictId,  int? rank,  double? percentile,  List<String> roles,  List<RoleVerification> roleVerification,  bool? isVerified,  bool? leadEnablerVerified,  List<InterestGroup> interestGroups,  List<KarmaDistributionEntry> karmaDistribution)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.fullName,_that.muid,_that.karma,_that.isPublic,_that.joined,_that.email,_that.mobile,_that.gender,_that.level,_that.profilePicUrl,_that.coverPicUrl,_that.collegeCode,_that.collegeId,_that.departmentId,_that.departmentName,_that.orgDistrictId,_that.rank,_that.percentile,_that.roles,_that.roleVerification,_that.isVerified,_that.leadEnablerVerified,_that.interestGroups,_that.karmaDistribution);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String muid,  int karma,  bool isPublic,  String joined,  String? email,  String? mobile,  String? gender,  String? level,  String? profilePicUrl,  String? coverPicUrl,  String? collegeCode,  String? collegeId,  String? departmentId,  String? departmentName,  String? orgDistrictId,  int? rank,  double? percentile,  List<String> roles,  List<RoleVerification> roleVerification,  bool? isVerified,  bool? leadEnablerVerified,  List<InterestGroup> interestGroups,  List<KarmaDistributionEntry> karmaDistribution)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.karma,_that.isPublic,_that.joined,_that.email,_that.mobile,_that.gender,_that.level,_that.profilePicUrl,_that.coverPicUrl,_that.collegeCode,_that.collegeId,_that.departmentId,_that.departmentName,_that.orgDistrictId,_that.rank,_that.percentile,_that.roles,_that.roleVerification,_that.isVerified,_that.leadEnablerVerified,_that.interestGroups,_that.karmaDistribution);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, required this.fullName, required this.muid, required this.karma, required this.isPublic, required this.joined, this.email, this.mobile, this.gender, this.level, this.profilePicUrl, this.coverPicUrl, this.collegeCode, this.collegeId, this.departmentId, this.departmentName, this.orgDistrictId, this.rank, this.percentile, final  List<String> roles = const [], final  List<RoleVerification> roleVerification = const [], this.isVerified, this.leadEnablerVerified, final  List<InterestGroup> interestGroups = const [], final  List<KarmaDistributionEntry> karmaDistribution = const []}): _roles = roles,_roleVerification = roleVerification,_interestGroups = interestGroups,_karmaDistribution = karmaDistribution;
  

@override final  String id;
@override final  String fullName;
@override final  String muid;
@override final  int karma;
@override final  bool isPublic;
@override final  String joined;
@override final  String? email;
@override final  String? mobile;
@override final  String? gender;
@override final  String? level;
@override final  String? profilePicUrl;
@override final  String? coverPicUrl;
@override final  String? collegeCode;
@override final  String? collegeId;
@override final  String? departmentId;
@override final  String? departmentName;
@override final  String? orgDistrictId;
@override final  int? rank;
@override final  double? percentile;
 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

 final  List<RoleVerification> _roleVerification;
@override@JsonKey() List<RoleVerification> get roleVerification {
  if (_roleVerification is EqualUnmodifiableListView) return _roleVerification;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roleVerification);
}

@override final  bool? isVerified;
@override final  bool? leadEnablerVerified;
 final  List<InterestGroup> _interestGroups;
@override@JsonKey() List<InterestGroup> get interestGroups {
  if (_interestGroups is EqualUnmodifiableListView) return _interestGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interestGroups);
}

 final  List<KarmaDistributionEntry> _karmaDistribution;
@override@JsonKey() List<KarmaDistributionEntry> get karmaDistribution {
  if (_karmaDistribution is EqualUnmodifiableListView) return _karmaDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_karmaDistribution);
}


/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.joined, joined) || other.joined == joined)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.level, level) || other.level == level)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.coverPicUrl, coverPicUrl) || other.coverPicUrl == coverPicUrl)&&(identical(other.collegeCode, collegeCode) || other.collegeCode == collegeCode)&&(identical(other.collegeId, collegeId) || other.collegeId == collegeId)&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.departmentName, departmentName) || other.departmentName == departmentName)&&(identical(other.orgDistrictId, orgDistrictId) || other.orgDistrictId == orgDistrictId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.percentile, percentile) || other.percentile == percentile)&&const DeepCollectionEquality().equals(other._roles, _roles)&&const DeepCollectionEquality().equals(other._roleVerification, _roleVerification)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.leadEnablerVerified, leadEnablerVerified) || other.leadEnablerVerified == leadEnablerVerified)&&const DeepCollectionEquality().equals(other._interestGroups, _interestGroups)&&const DeepCollectionEquality().equals(other._karmaDistribution, _karmaDistribution));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,fullName,muid,karma,isPublic,joined,email,mobile,gender,level,profilePicUrl,coverPicUrl,collegeCode,collegeId,departmentId,departmentName,orgDistrictId,rank,percentile,const DeepCollectionEquality().hash(_roles),const DeepCollectionEquality().hash(_roleVerification),isVerified,leadEnablerVerified,const DeepCollectionEquality().hash(_interestGroups),const DeepCollectionEquality().hash(_karmaDistribution)]);

@override
String toString() {
  return 'UserProfile(id: $id, fullName: $fullName, muid: $muid, karma: $karma, isPublic: $isPublic, joined: $joined, email: $email, mobile: $mobile, gender: $gender, level: $level, profilePicUrl: $profilePicUrl, coverPicUrl: $coverPicUrl, collegeCode: $collegeCode, collegeId: $collegeId, departmentId: $departmentId, departmentName: $departmentName, orgDistrictId: $orgDistrictId, rank: $rank, percentile: $percentile, roles: $roles, roleVerification: $roleVerification, isVerified: $isVerified, leadEnablerVerified: $leadEnablerVerified, interestGroups: $interestGroups, karmaDistribution: $karmaDistribution)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String muid, int karma, bool isPublic, String joined, String? email, String? mobile, String? gender, String? level, String? profilePicUrl, String? coverPicUrl, String? collegeCode, String? collegeId, String? departmentId, String? departmentName, String? orgDistrictId, int? rank, double? percentile, List<String> roles, List<RoleVerification> roleVerification, bool? isVerified, bool? leadEnablerVerified, List<InterestGroup> interestGroups, List<KarmaDistributionEntry> karmaDistribution
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? karma = null,Object? isPublic = null,Object? joined = null,Object? email = freezed,Object? mobile = freezed,Object? gender = freezed,Object? level = freezed,Object? profilePicUrl = freezed,Object? coverPicUrl = freezed,Object? collegeCode = freezed,Object? collegeId = freezed,Object? departmentId = freezed,Object? departmentName = freezed,Object? orgDistrictId = freezed,Object? rank = freezed,Object? percentile = freezed,Object? roles = null,Object? roleVerification = null,Object? isVerified = freezed,Object? leadEnablerVerified = freezed,Object? interestGroups = null,Object? karmaDistribution = null,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,coverPicUrl: freezed == coverPicUrl ? _self.coverPicUrl : coverPicUrl // ignore: cast_nullable_to_non_nullable
as String?,collegeCode: freezed == collegeCode ? _self.collegeCode : collegeCode // ignore: cast_nullable_to_non_nullable
as String?,collegeId: freezed == collegeId ? _self.collegeId : collegeId // ignore: cast_nullable_to_non_nullable
as String?,departmentId: freezed == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as String?,departmentName: freezed == departmentName ? _self.departmentName : departmentName // ignore: cast_nullable_to_non_nullable
as String?,orgDistrictId: freezed == orgDistrictId ? _self.orgDistrictId : orgDistrictId // ignore: cast_nullable_to_non_nullable
as String?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as double?,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,roleVerification: null == roleVerification ? _self._roleVerification : roleVerification // ignore: cast_nullable_to_non_nullable
as List<RoleVerification>,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,leadEnablerVerified: freezed == leadEnablerVerified ? _self.leadEnablerVerified : leadEnablerVerified // ignore: cast_nullable_to_non_nullable
as bool?,interestGroups: null == interestGroups ? _self._interestGroups : interestGroups // ignore: cast_nullable_to_non_nullable
as List<InterestGroup>,karmaDistribution: null == karmaDistribution ? _self._karmaDistribution : karmaDistribution // ignore: cast_nullable_to_non_nullable
as List<KarmaDistributionEntry>,
  ));
}


}

// dart format on
