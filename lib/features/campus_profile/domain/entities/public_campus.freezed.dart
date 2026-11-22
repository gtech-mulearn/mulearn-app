// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_campus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampusPerson {

 String get muid; String get fullName; String? get profilePic; String? get role;
/// Create a copy of CampusPerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusPersonCopyWith<CampusPerson> get copyWith => _$CampusPersonCopyWithImpl<CampusPerson>(this as CampusPerson, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CampusPerson;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusPerson&&(identical(other.muid, _this.muid) || other.muid == _this.muid)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.profilePic, _this.profilePic) || other.profilePic == _this.profilePic)&&(identical(other.role, _this.role) || other.role == _this.role));
}


@override
int get hashCode {
  final _this = this as CampusPerson;
  return Object.hash(runtimeType,_this.muid,_this.fullName,_this.profilePic,_this.role);
}

@override
String toString() {
  final _this = this as CampusPerson;
  return 'CampusPerson(muid: ${_this.muid}, fullName: ${_this.fullName}, profilePic: ${_this.profilePic}, role: ${_this.role})';
}


}

/// @nodoc
abstract mixin class $CampusPersonCopyWith<$Res>  {
  factory $CampusPersonCopyWith(CampusPerson value, $Res Function(CampusPerson) _then) = _$CampusPersonCopyWithImpl;
@useResult
$Res call({
 String muid, String fullName, String? profilePic, String? role
});




}
/// @nodoc
class _$CampusPersonCopyWithImpl<$Res>
    implements $CampusPersonCopyWith<$Res> {
  _$CampusPersonCopyWithImpl(this._self, this._then);

  final CampusPerson _self;
  final $Res Function(CampusPerson) _then;

/// Create a copy of CampusPerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muid = null,Object? fullName = null,Object? profilePic = freezed,Object? role = freezed,}) {
  return _then(CampusPerson(
muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusPerson].
extension CampusPersonPatterns on CampusPerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusPerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusPerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusPerson value)  $default,){
final _that = this;
switch (_that) {
case _CampusPerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusPerson value)?  $default,){
final _that = this;
switch (_that) {
case _CampusPerson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String muid,  String fullName,  String? profilePic,  String? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusPerson() when $default != null:
return $default(_that.muid,_that.fullName,_that.profilePic,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String muid,  String fullName,  String? profilePic,  String? role)  $default,) {final _that = this;
switch (_that) {
case _CampusPerson():
return $default(_that.muid,_that.fullName,_that.profilePic,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String muid,  String fullName,  String? profilePic,  String? role)?  $default,) {final _that = this;
switch (_that) {
case _CampusPerson() when $default != null:
return $default(_that.muid,_that.fullName,_that.profilePic,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _CampusPerson implements CampusPerson {
  const _CampusPerson({required this.muid, required this.fullName, this.profilePic, this.role});
  

@override final  String muid;
@override final  String fullName;
@override final  String? profilePic;
@override final  String? role;

/// Create a copy of CampusPerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusPersonCopyWith<_CampusPerson> get copyWith => __$CampusPersonCopyWithImpl<_CampusPerson>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusPerson&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode {
    return Object.hash(runtimeType,muid,fullName,profilePic,role);
}

@override
String toString() {
    return 'CampusPerson(muid: $muid, fullName: $fullName, profilePic: $profilePic, role: $role)';
}


}

/// @nodoc
abstract mixin class _$CampusPersonCopyWith<$Res> implements $CampusPersonCopyWith<$Res> {
  factory _$CampusPersonCopyWith(_CampusPerson value, $Res Function(_CampusPerson) _then) = __$CampusPersonCopyWithImpl;
@override @useResult
$Res call({
 String muid, String fullName, String? profilePic, String? role
});




}
/// @nodoc
class __$CampusPersonCopyWithImpl<$Res>
    implements _$CampusPersonCopyWith<$Res> {
  __$CampusPersonCopyWithImpl(this._self, this._then);

  final _CampusPerson _self;
  final $Res Function(_CampusPerson) _then;

/// Create a copy of CampusPerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muid = null,Object? fullName = null,Object? profilePic = freezed,Object? role = freezed,}) {
  return _then(_CampusPerson(
muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CampusLeader {

 int get rank; String get muid; String get fullName; int get karma; String? get profilePic;
/// Create a copy of CampusLeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusLeaderCopyWith<CampusLeader> get copyWith => _$CampusLeaderCopyWithImpl<CampusLeader>(this as CampusLeader, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CampusLeader;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusLeader&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.muid, _this.muid) || other.muid == _this.muid)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.karma, _this.karma) || other.karma == _this.karma)&&(identical(other.profilePic, _this.profilePic) || other.profilePic == _this.profilePic));
}


@override
int get hashCode {
  final _this = this as CampusLeader;
  return Object.hash(runtimeType,_this.rank,_this.muid,_this.fullName,_this.karma,_this.profilePic);
}

@override
String toString() {
  final _this = this as CampusLeader;
  return 'CampusLeader(rank: ${_this.rank}, muid: ${_this.muid}, fullName: ${_this.fullName}, karma: ${_this.karma}, profilePic: ${_this.profilePic})';
}


}

/// @nodoc
abstract mixin class $CampusLeaderCopyWith<$Res>  {
  factory $CampusLeaderCopyWith(CampusLeader value, $Res Function(CampusLeader) _then) = _$CampusLeaderCopyWithImpl;
@useResult
$Res call({
 int rank, String muid, String fullName, int karma, String? profilePic
});




}
/// @nodoc
class _$CampusLeaderCopyWithImpl<$Res>
    implements $CampusLeaderCopyWith<$Res> {
  _$CampusLeaderCopyWithImpl(this._self, this._then);

  final CampusLeader _self;
  final $Res Function(CampusLeader) _then;

/// Create a copy of CampusLeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? muid = null,Object? fullName = null,Object? karma = null,Object? profilePic = freezed,}) {
  return _then(CampusLeader(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusLeader].
extension CampusLeaderPatterns on CampusLeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusLeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusLeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusLeader value)  $default,){
final _that = this;
switch (_that) {
case _CampusLeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusLeader value)?  $default,){
final _that = this;
switch (_that) {
case _CampusLeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rank,  String muid,  String fullName,  int karma,  String? profilePic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusLeader() when $default != null:
return $default(_that.rank,_that.muid,_that.fullName,_that.karma,_that.profilePic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rank,  String muid,  String fullName,  int karma,  String? profilePic)  $default,) {final _that = this;
switch (_that) {
case _CampusLeader():
return $default(_that.rank,_that.muid,_that.fullName,_that.karma,_that.profilePic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rank,  String muid,  String fullName,  int karma,  String? profilePic)?  $default,) {final _that = this;
switch (_that) {
case _CampusLeader() when $default != null:
return $default(_that.rank,_that.muid,_that.fullName,_that.karma,_that.profilePic);case _:
  return null;

}
}

}

/// @nodoc


class _CampusLeader implements CampusLeader {
  const _CampusLeader({required this.rank, required this.muid, required this.fullName, required this.karma, this.profilePic});
  

@override final  int rank;
@override final  String muid;
@override final  String fullName;
@override final  int karma;
@override final  String? profilePic;

/// Create a copy of CampusLeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusLeaderCopyWith<_CampusLeader> get copyWith => __$CampusLeaderCopyWithImpl<_CampusLeader>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusLeader&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}


@override
int get hashCode {
    return Object.hash(runtimeType,rank,muid,fullName,karma,profilePic);
}

@override
String toString() {
    return 'CampusLeader(rank: $rank, muid: $muid, fullName: $fullName, karma: $karma, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class _$CampusLeaderCopyWith<$Res> implements $CampusLeaderCopyWith<$Res> {
  factory _$CampusLeaderCopyWith(_CampusLeader value, $Res Function(_CampusLeader) _then) = __$CampusLeaderCopyWithImpl;
@override @useResult
$Res call({
 int rank, String muid, String fullName, int karma, String? profilePic
});




}
/// @nodoc
class __$CampusLeaderCopyWithImpl<$Res>
    implements _$CampusLeaderCopyWith<$Res> {
  __$CampusLeaderCopyWithImpl(this._self, this._then);

  final _CampusLeader _self;
  final $Res Function(_CampusLeader) _then;

/// Create a copy of CampusLeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? muid = null,Object? fullName = null,Object? karma = null,Object? profilePic = freezed,}) {
  return _then(_CampusLeader(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CampusChapter {

 String get name; String get code; int get members; String? get leadName;
/// Create a copy of CampusChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusChapterCopyWith<CampusChapter> get copyWith => _$CampusChapterCopyWithImpl<CampusChapter>(this as CampusChapter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CampusChapter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusChapter&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.members, _this.members) || other.members == _this.members)&&(identical(other.leadName, _this.leadName) || other.leadName == _this.leadName));
}


@override
int get hashCode {
  final _this = this as CampusChapter;
  return Object.hash(runtimeType,_this.name,_this.code,_this.members,_this.leadName);
}

@override
String toString() {
  final _this = this as CampusChapter;
  return 'CampusChapter(name: ${_this.name}, code: ${_this.code}, members: ${_this.members}, leadName: ${_this.leadName})';
}


}

/// @nodoc
abstract mixin class $CampusChapterCopyWith<$Res>  {
  factory $CampusChapterCopyWith(CampusChapter value, $Res Function(CampusChapter) _then) = _$CampusChapterCopyWithImpl;
@useResult
$Res call({
 String name, String code, int members, String? leadName
});




}
/// @nodoc
class _$CampusChapterCopyWithImpl<$Res>
    implements $CampusChapterCopyWith<$Res> {
  _$CampusChapterCopyWithImpl(this._self, this._then);

  final CampusChapter _self;
  final $Res Function(CampusChapter) _then;

/// Create a copy of CampusChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? code = null,Object? members = null,Object? leadName = freezed,}) {
  return _then(CampusChapter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,leadName: freezed == leadName ? _self.leadName : leadName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusChapter].
extension CampusChapterPatterns on CampusChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusChapter value)  $default,){
final _that = this;
switch (_that) {
case _CampusChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusChapter value)?  $default,){
final _that = this;
switch (_that) {
case _CampusChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String code,  int members,  String? leadName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusChapter() when $default != null:
return $default(_that.name,_that.code,_that.members,_that.leadName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String code,  int members,  String? leadName)  $default,) {final _that = this;
switch (_that) {
case _CampusChapter():
return $default(_that.name,_that.code,_that.members,_that.leadName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String code,  int members,  String? leadName)?  $default,) {final _that = this;
switch (_that) {
case _CampusChapter() when $default != null:
return $default(_that.name,_that.code,_that.members,_that.leadName);case _:
  return null;

}
}

}

/// @nodoc


class _CampusChapter implements CampusChapter {
  const _CampusChapter({required this.name, required this.code, required this.members, this.leadName});
  

@override final  String name;
@override final  String code;
@override final  int members;
@override final  String? leadName;

/// Create a copy of CampusChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusChapterCopyWith<_CampusChapter> get copyWith => __$CampusChapterCopyWithImpl<_CampusChapter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusChapter&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.members, members) || other.members == members)&&(identical(other.leadName, leadName) || other.leadName == leadName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,code,members,leadName);
}

@override
String toString() {
    return 'CampusChapter(name: $name, code: $code, members: $members, leadName: $leadName)';
}


}

/// @nodoc
abstract mixin class _$CampusChapterCopyWith<$Res> implements $CampusChapterCopyWith<$Res> {
  factory _$CampusChapterCopyWith(_CampusChapter value, $Res Function(_CampusChapter) _then) = __$CampusChapterCopyWithImpl;
@override @useResult
$Res call({
 String name, String code, int members, String? leadName
});




}
/// @nodoc
class __$CampusChapterCopyWithImpl<$Res>
    implements _$CampusChapterCopyWith<$Res> {
  __$CampusChapterCopyWithImpl(this._self, this._then);

  final _CampusChapter _self;
  final $Res Function(_CampusChapter) _then;

/// Create a copy of CampusChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? code = null,Object? members = null,Object? leadName = freezed,}) {
  return _then(_CampusChapter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,leadName: freezed == leadName ? _self.leadName : leadName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CampusCluster {

 String get cluster; int get karma; int get members;
/// Create a copy of CampusCluster
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusClusterCopyWith<CampusCluster> get copyWith => _$CampusClusterCopyWithImpl<CampusCluster>(this as CampusCluster, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CampusCluster;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusCluster&&(identical(other.cluster, _this.cluster) || other.cluster == _this.cluster)&&(identical(other.karma, _this.karma) || other.karma == _this.karma)&&(identical(other.members, _this.members) || other.members == _this.members));
}


@override
int get hashCode {
  final _this = this as CampusCluster;
  return Object.hash(runtimeType,_this.cluster,_this.karma,_this.members);
}

@override
String toString() {
  final _this = this as CampusCluster;
  return 'CampusCluster(cluster: ${_this.cluster}, karma: ${_this.karma}, members: ${_this.members})';
}


}

/// @nodoc
abstract mixin class $CampusClusterCopyWith<$Res>  {
  factory $CampusClusterCopyWith(CampusCluster value, $Res Function(CampusCluster) _then) = _$CampusClusterCopyWithImpl;
@useResult
$Res call({
 String cluster, int karma, int members
});




}
/// @nodoc
class _$CampusClusterCopyWithImpl<$Res>
    implements $CampusClusterCopyWith<$Res> {
  _$CampusClusterCopyWithImpl(this._self, this._then);

  final CampusCluster _self;
  final $Res Function(CampusCluster) _then;

/// Create a copy of CampusCluster
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cluster = null,Object? karma = null,Object? members = null,}) {
  return _then(CampusCluster(
cluster: null == cluster ? _self.cluster : cluster // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusCluster].
extension CampusClusterPatterns on CampusCluster {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusCluster value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusCluster() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusCluster value)  $default,){
final _that = this;
switch (_that) {
case _CampusCluster():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusCluster value)?  $default,){
final _that = this;
switch (_that) {
case _CampusCluster() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cluster,  int karma,  int members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusCluster() when $default != null:
return $default(_that.cluster,_that.karma,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cluster,  int karma,  int members)  $default,) {final _that = this;
switch (_that) {
case _CampusCluster():
return $default(_that.cluster,_that.karma,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cluster,  int karma,  int members)?  $default,) {final _that = this;
switch (_that) {
case _CampusCluster() when $default != null:
return $default(_that.cluster,_that.karma,_that.members);case _:
  return null;

}
}

}

/// @nodoc


class _CampusCluster implements CampusCluster {
  const _CampusCluster({required this.cluster, required this.karma, required this.members});
  

@override final  String cluster;
@override final  int karma;
@override final  int members;

/// Create a copy of CampusCluster
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusClusterCopyWith<_CampusCluster> get copyWith => __$CampusClusterCopyWithImpl<_CampusCluster>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusCluster&&(identical(other.cluster, cluster) || other.cluster == cluster)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.members, members) || other.members == members));
}


@override
int get hashCode {
    return Object.hash(runtimeType,cluster,karma,members);
}

@override
String toString() {
    return 'CampusCluster(cluster: $cluster, karma: $karma, members: $members)';
}


}

/// @nodoc
abstract mixin class _$CampusClusterCopyWith<$Res> implements $CampusClusterCopyWith<$Res> {
  factory _$CampusClusterCopyWith(_CampusCluster value, $Res Function(_CampusCluster) _then) = __$CampusClusterCopyWithImpl;
@override @useResult
$Res call({
 String cluster, int karma, int members
});




}
/// @nodoc
class __$CampusClusterCopyWithImpl<$Res>
    implements _$CampusClusterCopyWith<$Res> {
  __$CampusClusterCopyWithImpl(this._self, this._then);

  final _CampusCluster _self;
  final $Res Function(_CampusCluster) _then;

/// Create a copy of CampusCluster
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cluster = null,Object? karma = null,Object? members = null,}) {
  return _then(_CampusCluster(
cluster: null == cluster ? _self.cluster : cluster // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CampusLink {

 String get platform; String get url;
/// Create a copy of CampusLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusLinkCopyWith<CampusLink> get copyWith => _$CampusLinkCopyWithImpl<CampusLink>(this as CampusLink, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CampusLink;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusLink&&(identical(other.platform, _this.platform) || other.platform == _this.platform)&&(identical(other.url, _this.url) || other.url == _this.url));
}


@override
int get hashCode {
  final _this = this as CampusLink;
  return Object.hash(runtimeType,_this.platform,_this.url);
}

@override
String toString() {
  final _this = this as CampusLink;
  return 'CampusLink(platform: ${_this.platform}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $CampusLinkCopyWith<$Res>  {
  factory $CampusLinkCopyWith(CampusLink value, $Res Function(CampusLink) _then) = _$CampusLinkCopyWithImpl;
@useResult
$Res call({
 String platform, String url
});




}
/// @nodoc
class _$CampusLinkCopyWithImpl<$Res>
    implements $CampusLinkCopyWith<$Res> {
  _$CampusLinkCopyWithImpl(this._self, this._then);

  final CampusLink _self;
  final $Res Function(CampusLink) _then;

/// Create a copy of CampusLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platform = null,Object? url = null,}) {
  return _then(CampusLink(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusLink].
extension CampusLinkPatterns on CampusLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusLink value)  $default,){
final _that = this;
switch (_that) {
case _CampusLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusLink value)?  $default,){
final _that = this;
switch (_that) {
case _CampusLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String platform,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusLink() when $default != null:
return $default(_that.platform,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String platform,  String url)  $default,) {final _that = this;
switch (_that) {
case _CampusLink():
return $default(_that.platform,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String platform,  String url)?  $default,) {final _that = this;
switch (_that) {
case _CampusLink() when $default != null:
return $default(_that.platform,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _CampusLink implements CampusLink {
  const _CampusLink({required this.platform, required this.url});
  

@override final  String platform;
@override final  String url;

/// Create a copy of CampusLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusLinkCopyWith<_CampusLink> get copyWith => __$CampusLinkCopyWithImpl<_CampusLink>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusLink&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode {
    return Object.hash(runtimeType,platform,url);
}

@override
String toString() {
    return 'CampusLink(platform: $platform, url: $url)';
}


}

/// @nodoc
abstract mixin class _$CampusLinkCopyWith<$Res> implements $CampusLinkCopyWith<$Res> {
  factory _$CampusLinkCopyWith(_CampusLink value, $Res Function(_CampusLink) _then) = __$CampusLinkCopyWithImpl;
@override @useResult
$Res call({
 String platform, String url
});




}
/// @nodoc
class __$CampusLinkCopyWithImpl<$Res>
    implements _$CampusLinkCopyWith<$Res> {
  __$CampusLinkCopyWithImpl(this._self, this._then);

  final _CampusLink _self;
  final $Res Function(_CampusLink) _then;

/// Create a copy of CampusLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platform = null,Object? url = null,}) {
  return _then(_CampusLink(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PublicCampus {

 String get id; String get name; String get code; String get zone; int get totalKarma; int get members; int get activeMembers; int? get rank; CampusPerson? get lead; List<CampusPerson> get execom; List<CampusLeader> get topLearners; List<CampusChapter> get chapters; List<CampusCluster> get clusters; List<CampusLink> get links;
/// Create a copy of PublicCampus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicCampusCopyWith<PublicCampus> get copyWith => _$PublicCampusCopyWithImpl<PublicCampus>(this as PublicCampus, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PublicCampus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicCampus&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.zone, _this.zone) || other.zone == _this.zone)&&(identical(other.totalKarma, _this.totalKarma) || other.totalKarma == _this.totalKarma)&&(identical(other.members, _this.members) || other.members == _this.members)&&(identical(other.activeMembers, _this.activeMembers) || other.activeMembers == _this.activeMembers)&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.lead, _this.lead) || other.lead == _this.lead)&&const DeepCollectionEquality().equals(other.execom, _this.execom)&&const DeepCollectionEquality().equals(other.topLearners, _this.topLearners)&&const DeepCollectionEquality().equals(other.chapters, _this.chapters)&&const DeepCollectionEquality().equals(other.clusters, _this.clusters)&&const DeepCollectionEquality().equals(other.links, _this.links));
}


@override
int get hashCode {
  final _this = this as PublicCampus;
  return Object.hash(runtimeType,_this.id,_this.name,_this.code,_this.zone,_this.totalKarma,_this.members,_this.activeMembers,_this.rank,_this.lead,const DeepCollectionEquality().hash(_this.execom),const DeepCollectionEquality().hash(_this.topLearners),const DeepCollectionEquality().hash(_this.chapters),const DeepCollectionEquality().hash(_this.clusters),const DeepCollectionEquality().hash(_this.links));
}

@override
String toString() {
  final _this = this as PublicCampus;
  return 'PublicCampus(id: ${_this.id}, name: ${_this.name}, code: ${_this.code}, zone: ${_this.zone}, totalKarma: ${_this.totalKarma}, members: ${_this.members}, activeMembers: ${_this.activeMembers}, rank: ${_this.rank}, lead: ${_this.lead}, execom: ${_this.execom}, topLearners: ${_this.topLearners}, chapters: ${_this.chapters}, clusters: ${_this.clusters}, links: ${_this.links})';
}


}

/// @nodoc
abstract mixin class $PublicCampusCopyWith<$Res>  {
  factory $PublicCampusCopyWith(PublicCampus value, $Res Function(PublicCampus) _then) = _$PublicCampusCopyWithImpl;
@useResult
$Res call({
 String id, String name, String code, String zone, int totalKarma, int members, int activeMembers, int? rank, CampusPerson? lead, List<CampusPerson> execom, List<CampusLeader> topLearners, List<CampusChapter> chapters, List<CampusCluster> clusters, List<CampusLink> links
});


$CampusPersonCopyWith<$Res>? get lead;

}
/// @nodoc
class _$PublicCampusCopyWithImpl<$Res>
    implements $PublicCampusCopyWith<$Res> {
  _$PublicCampusCopyWithImpl(this._self, this._then);

  final PublicCampus _self;
  final $Res Function(PublicCampus) _then;

/// Create a copy of PublicCampus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = null,Object? zone = null,Object? totalKarma = null,Object? members = null,Object? activeMembers = null,Object? rank = freezed,Object? lead = freezed,Object? execom = null,Object? topLearners = null,Object? chapters = null,Object? clusters = null,Object? links = null,}) {
  return _then(PublicCampus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,activeMembers: null == activeMembers ? _self.activeMembers : activeMembers // ignore: cast_nullable_to_non_nullable
as int,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,lead: freezed == lead ? _self.lead : lead // ignore: cast_nullable_to_non_nullable
as CampusPerson?,execom: null == execom ? _self.execom : execom // ignore: cast_nullable_to_non_nullable
as List<CampusPerson>,topLearners: null == topLearners ? _self.topLearners : topLearners // ignore: cast_nullable_to_non_nullable
as List<CampusLeader>,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<CampusChapter>,clusters: null == clusters ? _self.clusters : clusters // ignore: cast_nullable_to_non_nullable
as List<CampusCluster>,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as List<CampusLink>,
  ));
}
/// Create a copy of PublicCampus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CampusPersonCopyWith<$Res>? get lead {
    if (_self.lead == null) {
    return null;
  }

  return $CampusPersonCopyWith<$Res>(_self.lead!, (value) {
    return _then(_self.copyWith(lead: value));
  });
}
}


/// Adds pattern-matching-related methods to [PublicCampus].
extension PublicCampusPatterns on PublicCampus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicCampus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicCampus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicCampus value)  $default,){
final _that = this;
switch (_that) {
case _PublicCampus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicCampus value)?  $default,){
final _that = this;
switch (_that) {
case _PublicCampus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String code,  String zone,  int totalKarma,  int members,  int activeMembers,  int? rank,  CampusPerson? lead,  List<CampusPerson> execom,  List<CampusLeader> topLearners,  List<CampusChapter> chapters,  List<CampusCluster> clusters,  List<CampusLink> links)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicCampus() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.zone,_that.totalKarma,_that.members,_that.activeMembers,_that.rank,_that.lead,_that.execom,_that.topLearners,_that.chapters,_that.clusters,_that.links);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String code,  String zone,  int totalKarma,  int members,  int activeMembers,  int? rank,  CampusPerson? lead,  List<CampusPerson> execom,  List<CampusLeader> topLearners,  List<CampusChapter> chapters,  List<CampusCluster> clusters,  List<CampusLink> links)  $default,) {final _that = this;
switch (_that) {
case _PublicCampus():
return $default(_that.id,_that.name,_that.code,_that.zone,_that.totalKarma,_that.members,_that.activeMembers,_that.rank,_that.lead,_that.execom,_that.topLearners,_that.chapters,_that.clusters,_that.links);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String code,  String zone,  int totalKarma,  int members,  int activeMembers,  int? rank,  CampusPerson? lead,  List<CampusPerson> execom,  List<CampusLeader> topLearners,  List<CampusChapter> chapters,  List<CampusCluster> clusters,  List<CampusLink> links)?  $default,) {final _that = this;
switch (_that) {
case _PublicCampus() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.zone,_that.totalKarma,_that.members,_that.activeMembers,_that.rank,_that.lead,_that.execom,_that.topLearners,_that.chapters,_that.clusters,_that.links);case _:
  return null;

}
}

}

/// @nodoc


class _PublicCampus implements PublicCampus {
  const _PublicCampus({required this.id, required this.name, required this.code, required this.zone, required this.totalKarma, required this.members, required this.activeMembers, this.rank, this.lead,  List<CampusPerson> execom = const <CampusPerson>[],  List<CampusLeader> topLearners = const <CampusLeader>[],  List<CampusChapter> chapters = const <CampusChapter>[],  List<CampusCluster> clusters = const <CampusCluster>[],  List<CampusLink> links = const <CampusLink>[]}): _execom = execom,_topLearners = topLearners,_chapters = chapters,_clusters = clusters,_links = links;
  

@override final  String id;
@override final  String name;
@override final  String code;
@override final  String zone;
@override final  int totalKarma;
@override final  int members;
@override final  int activeMembers;
@override final  int? rank;
@override final  CampusPerson? lead;
 final  List<CampusPerson> _execom;
@override@JsonKey() List<CampusPerson> get execom {
  if (_execom is EqualUnmodifiableListView) return _execom;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_execom);
}

 final  List<CampusLeader> _topLearners;
@override@JsonKey() List<CampusLeader> get topLearners {
  if (_topLearners is EqualUnmodifiableListView) return _topLearners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topLearners);
}

 final  List<CampusChapter> _chapters;
@override@JsonKey() List<CampusChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

 final  List<CampusCluster> _clusters;
@override@JsonKey() List<CampusCluster> get clusters {
  if (_clusters is EqualUnmodifiableListView) return _clusters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clusters);
}

 final  List<CampusLink> _links;
@override@JsonKey() List<CampusLink> get links {
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_links);
}


/// Create a copy of PublicCampus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicCampusCopyWith<_PublicCampus> get copyWith => __$PublicCampusCopyWithImpl<_PublicCampus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicCampus&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.members, members) || other.members == members)&&(identical(other.activeMembers, activeMembers) || other.activeMembers == activeMembers)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.lead, lead) || other.lead == lead)&&const DeepCollectionEquality().equals(other.execom, _execom)&&const DeepCollectionEquality().equals(other.topLearners, _topLearners)&&const DeepCollectionEquality().equals(other.chapters, _chapters)&&const DeepCollectionEquality().equals(other.clusters, _clusters)&&const DeepCollectionEquality().equals(other.links, _links));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,code,zone,totalKarma,members,activeMembers,rank,lead,const DeepCollectionEquality().hash(_execom),const DeepCollectionEquality().hash(_topLearners),const DeepCollectionEquality().hash(_chapters),const DeepCollectionEquality().hash(_clusters),const DeepCollectionEquality().hash(_links));
}

@override
String toString() {
    return 'PublicCampus(id: $id, name: $name, code: $code, zone: $zone, totalKarma: $totalKarma, members: $members, activeMembers: $activeMembers, rank: $rank, lead: $lead, execom: $execom, topLearners: $topLearners, chapters: $chapters, clusters: $clusters, links: $links)';
}


}

/// @nodoc
abstract mixin class _$PublicCampusCopyWith<$Res> implements $PublicCampusCopyWith<$Res> {
  factory _$PublicCampusCopyWith(_PublicCampus value, $Res Function(_PublicCampus) _then) = __$PublicCampusCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String code, String zone, int totalKarma, int members, int activeMembers, int? rank, CampusPerson? lead, List<CampusPerson> execom, List<CampusLeader> topLearners, List<CampusChapter> chapters, List<CampusCluster> clusters, List<CampusLink> links
});


@override $CampusPersonCopyWith<$Res>? get lead;

}
/// @nodoc
class __$PublicCampusCopyWithImpl<$Res>
    implements _$PublicCampusCopyWith<$Res> {
  __$PublicCampusCopyWithImpl(this._self, this._then);

  final _PublicCampus _self;
  final $Res Function(_PublicCampus) _then;

/// Create a copy of PublicCampus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = null,Object? zone = null,Object? totalKarma = null,Object? members = null,Object? activeMembers = null,Object? rank = freezed,Object? lead = freezed,Object? execom = null,Object? topLearners = null,Object? chapters = null,Object? clusters = null,Object? links = null,}) {
  return _then(_PublicCampus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int,activeMembers: null == activeMembers ? _self.activeMembers : activeMembers // ignore: cast_nullable_to_non_nullable
as int,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,lead: freezed == lead ? _self.lead : lead // ignore: cast_nullable_to_non_nullable
as CampusPerson?,execom: null == execom ? _self._execom : execom // ignore: cast_nullable_to_non_nullable
as List<CampusPerson>,topLearners: null == topLearners ? _self._topLearners : topLearners // ignore: cast_nullable_to_non_nullable
as List<CampusLeader>,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<CampusChapter>,clusters: null == clusters ? _self._clusters : clusters // ignore: cast_nullable_to_non_nullable
as List<CampusCluster>,links: null == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<CampusLink>,
  ));
}

/// Create a copy of PublicCampus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CampusPersonCopyWith<$Res>? get lead {
    if (_self.lead == null) {
    return null;
  }

  return $CampusPersonCopyWith<$Res>(_self.lead!, (value) {
    return _then(_self.copyWith(lead: value));
  });
}
}

// dart format on
