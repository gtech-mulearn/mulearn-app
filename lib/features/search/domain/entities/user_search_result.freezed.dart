// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSearchResult {

 String get id; String get muid; String get fullName; int get karma; String? get profilePicUrl; String? get organization; List<String> get interestGroupNames;
/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchResultCopyWith<UserSearchResult> get copyWith => _$UserSearchResultCopyWithImpl<UserSearchResult>(this as UserSearchResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserSearchResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchResult&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.muid, _this.muid) || other.muid == _this.muid)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.karma, _this.karma) || other.karma == _this.karma)&&(identical(other.profilePicUrl, _this.profilePicUrl) || other.profilePicUrl == _this.profilePicUrl)&&(identical(other.organization, _this.organization) || other.organization == _this.organization)&&const DeepCollectionEquality().equals(other.interestGroupNames, _this.interestGroupNames));
}


@override
int get hashCode {
  final _this = this as UserSearchResult;
  return Object.hash(runtimeType,_this.id,_this.muid,_this.fullName,_this.karma,_this.profilePicUrl,_this.organization,const DeepCollectionEquality().hash(_this.interestGroupNames));
}

@override
String toString() {
  final _this = this as UserSearchResult;
  return 'UserSearchResult(id: ${_this.id}, muid: ${_this.muid}, fullName: ${_this.fullName}, karma: ${_this.karma}, profilePicUrl: ${_this.profilePicUrl}, organization: ${_this.organization}, interestGroupNames: ${_this.interestGroupNames})';
}


}

/// @nodoc
abstract mixin class $UserSearchResultCopyWith<$Res>  {
  factory $UserSearchResultCopyWith(UserSearchResult value, $Res Function(UserSearchResult) _then) = _$UserSearchResultCopyWithImpl;
@useResult
$Res call({
 String id, String muid, String fullName, int karma, String? profilePicUrl, String? organization, List<String> interestGroupNames
});




}
/// @nodoc
class _$UserSearchResultCopyWithImpl<$Res>
    implements $UserSearchResultCopyWith<$Res> {
  _$UserSearchResultCopyWithImpl(this._self, this._then);

  final UserSearchResult _self;
  final $Res Function(UserSearchResult) _then;

/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? muid = null,Object? fullName = null,Object? karma = null,Object? profilePicUrl = freezed,Object? organization = freezed,Object? interestGroupNames = null,}) {
  return _then(UserSearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,interestGroupNames: null == interestGroupNames ? _self.interestGroupNames : interestGroupNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchResult].
extension UserSearchResultPatterns on UserSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String muid,  String fullName,  int karma,  String? profilePicUrl,  String? organization,  List<String> interestGroupNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchResult() when $default != null:
return $default(_that.id,_that.muid,_that.fullName,_that.karma,_that.profilePicUrl,_that.organization,_that.interestGroupNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String muid,  String fullName,  int karma,  String? profilePicUrl,  String? organization,  List<String> interestGroupNames)  $default,) {final _that = this;
switch (_that) {
case _UserSearchResult():
return $default(_that.id,_that.muid,_that.fullName,_that.karma,_that.profilePicUrl,_that.organization,_that.interestGroupNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String muid,  String fullName,  int karma,  String? profilePicUrl,  String? organization,  List<String> interestGroupNames)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchResult() when $default != null:
return $default(_that.id,_that.muid,_that.fullName,_that.karma,_that.profilePicUrl,_that.organization,_that.interestGroupNames);case _:
  return null;

}
}

}

/// @nodoc


class _UserSearchResult implements UserSearchResult {
  const _UserSearchResult({required this.id, required this.muid, required this.fullName, required this.karma, this.profilePicUrl, this.organization,  List<String> interestGroupNames = const []}): _interestGroupNames = interestGroupNames;
  

@override final  String id;
@override final  String muid;
@override final  String fullName;
@override final  int karma;
@override final  String? profilePicUrl;
@override final  String? organization;
 final  List<String> _interestGroupNames;
@override@JsonKey() List<String> get interestGroupNames {
  if (_interestGroupNames is EqualUnmodifiableListView) return _interestGroupNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interestGroupNames);
}


/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchResultCopyWith<_UserSearchResult> get copyWith => __$UserSearchResultCopyWithImpl<_UserSearchResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.organization, organization) || other.organization == organization)&&const DeepCollectionEquality().equals(other.interestGroupNames, _interestGroupNames));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,muid,fullName,karma,profilePicUrl,organization,const DeepCollectionEquality().hash(_interestGroupNames));
}

@override
String toString() {
    return 'UserSearchResult(id: $id, muid: $muid, fullName: $fullName, karma: $karma, profilePicUrl: $profilePicUrl, organization: $organization, interestGroupNames: $interestGroupNames)';
}


}

/// @nodoc
abstract mixin class _$UserSearchResultCopyWith<$Res> implements $UserSearchResultCopyWith<$Res> {
  factory _$UserSearchResultCopyWith(_UserSearchResult value, $Res Function(_UserSearchResult) _then) = __$UserSearchResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String muid, String fullName, int karma, String? profilePicUrl, String? organization, List<String> interestGroupNames
});




}
/// @nodoc
class __$UserSearchResultCopyWithImpl<$Res>
    implements _$UserSearchResultCopyWith<$Res> {
  __$UserSearchResultCopyWithImpl(this._self, this._then);

  final _UserSearchResult _self;
  final $Res Function(_UserSearchResult) _then;

/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? muid = null,Object? fullName = null,Object? karma = null,Object? profilePicUrl = freezed,Object? organization = freezed,Object? interestGroupNames = null,}) {
  return _then(_UserSearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,interestGroupNames: null == interestGroupNames ? _self._interestGroupNames : interestGroupNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
