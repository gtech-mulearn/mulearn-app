// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPreferencesDto {

 bool get interestedInWork; bool get interestedInGigWork; List<String>? get domains; List<String>? get endgoals; List<OrgRefDto>? get orgs;
/// Create a copy of UserPreferencesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesDtoCopyWith<UserPreferencesDto> get copyWith => _$UserPreferencesDtoCopyWithImpl<UserPreferencesDto>(this as UserPreferencesDto, _$identity);

  /// Serializes this UserPreferencesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferencesDto&&(identical(other.interestedInWork, interestedInWork) || other.interestedInWork == interestedInWork)&&(identical(other.interestedInGigWork, interestedInGigWork) || other.interestedInGigWork == interestedInGigWork)&&const DeepCollectionEquality().equals(other.domains, domains)&&const DeepCollectionEquality().equals(other.endgoals, endgoals)&&const DeepCollectionEquality().equals(other.orgs, orgs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,interestedInWork,interestedInGigWork,const DeepCollectionEquality().hash(domains),const DeepCollectionEquality().hash(endgoals),const DeepCollectionEquality().hash(orgs));

@override
String toString() {
  return 'UserPreferencesDto(interestedInWork: $interestedInWork, interestedInGigWork: $interestedInGigWork, domains: $domains, endgoals: $endgoals, orgs: $orgs)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesDtoCopyWith<$Res>  {
  factory $UserPreferencesDtoCopyWith(UserPreferencesDto value, $Res Function(UserPreferencesDto) _then) = _$UserPreferencesDtoCopyWithImpl;
@useResult
$Res call({
 bool interestedInWork, bool interestedInGigWork, List<String>? domains, List<String>? endgoals, List<OrgRefDto>? orgs
});




}
/// @nodoc
class _$UserPreferencesDtoCopyWithImpl<$Res>
    implements $UserPreferencesDtoCopyWith<$Res> {
  _$UserPreferencesDtoCopyWithImpl(this._self, this._then);

  final UserPreferencesDto _self;
  final $Res Function(UserPreferencesDto) _then;

/// Create a copy of UserPreferencesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? interestedInWork = null,Object? interestedInGigWork = null,Object? domains = freezed,Object? endgoals = freezed,Object? orgs = freezed,}) {
  return _then(_self.copyWith(
interestedInWork: null == interestedInWork ? _self.interestedInWork : interestedInWork // ignore: cast_nullable_to_non_nullable
as bool,interestedInGigWork: null == interestedInGigWork ? _self.interestedInGigWork : interestedInGigWork // ignore: cast_nullable_to_non_nullable
as bool,domains: freezed == domains ? _self.domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>?,endgoals: freezed == endgoals ? _self.endgoals : endgoals // ignore: cast_nullable_to_non_nullable
as List<String>?,orgs: freezed == orgs ? _self.orgs : orgs // ignore: cast_nullable_to_non_nullable
as List<OrgRefDto>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferencesDto].
extension UserPreferencesDtoPatterns on UserPreferencesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferencesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferencesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferencesDto value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferencesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferencesDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferencesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool interestedInWork,  bool interestedInGigWork,  List<String>? domains,  List<String>? endgoals,  List<OrgRefDto>? orgs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferencesDto() when $default != null:
return $default(_that.interestedInWork,_that.interestedInGigWork,_that.domains,_that.endgoals,_that.orgs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool interestedInWork,  bool interestedInGigWork,  List<String>? domains,  List<String>? endgoals,  List<OrgRefDto>? orgs)  $default,) {final _that = this;
switch (_that) {
case _UserPreferencesDto():
return $default(_that.interestedInWork,_that.interestedInGigWork,_that.domains,_that.endgoals,_that.orgs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool interestedInWork,  bool interestedInGigWork,  List<String>? domains,  List<String>? endgoals,  List<OrgRefDto>? orgs)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferencesDto() when $default != null:
return $default(_that.interestedInWork,_that.interestedInGigWork,_that.domains,_that.endgoals,_that.orgs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPreferencesDto extends UserPreferencesDto {
  const _UserPreferencesDto({required this.interestedInWork, required this.interestedInGigWork, final  List<String>? domains, final  List<String>? endgoals, final  List<OrgRefDto>? orgs}): _domains = domains,_endgoals = endgoals,_orgs = orgs,super._();
  factory _UserPreferencesDto.fromJson(Map<String, dynamic> json) => _$UserPreferencesDtoFromJson(json);

@override final  bool interestedInWork;
@override final  bool interestedInGigWork;
 final  List<String>? _domains;
@override List<String>? get domains {
  final value = _domains;
  if (value == null) return null;
  if (_domains is EqualUnmodifiableListView) return _domains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _endgoals;
@override List<String>? get endgoals {
  final value = _endgoals;
  if (value == null) return null;
  if (_endgoals is EqualUnmodifiableListView) return _endgoals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<OrgRefDto>? _orgs;
@override List<OrgRefDto>? get orgs {
  final value = _orgs;
  if (value == null) return null;
  if (_orgs is EqualUnmodifiableListView) return _orgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UserPreferencesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesDtoCopyWith<_UserPreferencesDto> get copyWith => __$UserPreferencesDtoCopyWithImpl<_UserPreferencesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPreferencesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferencesDto&&(identical(other.interestedInWork, interestedInWork) || other.interestedInWork == interestedInWork)&&(identical(other.interestedInGigWork, interestedInGigWork) || other.interestedInGigWork == interestedInGigWork)&&const DeepCollectionEquality().equals(other._domains, _domains)&&const DeepCollectionEquality().equals(other._endgoals, _endgoals)&&const DeepCollectionEquality().equals(other._orgs, _orgs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,interestedInWork,interestedInGigWork,const DeepCollectionEquality().hash(_domains),const DeepCollectionEquality().hash(_endgoals),const DeepCollectionEquality().hash(_orgs));

@override
String toString() {
  return 'UserPreferencesDto(interestedInWork: $interestedInWork, interestedInGigWork: $interestedInGigWork, domains: $domains, endgoals: $endgoals, orgs: $orgs)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesDtoCopyWith<$Res> implements $UserPreferencesDtoCopyWith<$Res> {
  factory _$UserPreferencesDtoCopyWith(_UserPreferencesDto value, $Res Function(_UserPreferencesDto) _then) = __$UserPreferencesDtoCopyWithImpl;
@override @useResult
$Res call({
 bool interestedInWork, bool interestedInGigWork, List<String>? domains, List<String>? endgoals, List<OrgRefDto>? orgs
});




}
/// @nodoc
class __$UserPreferencesDtoCopyWithImpl<$Res>
    implements _$UserPreferencesDtoCopyWith<$Res> {
  __$UserPreferencesDtoCopyWithImpl(this._self, this._then);

  final _UserPreferencesDto _self;
  final $Res Function(_UserPreferencesDto) _then;

/// Create a copy of UserPreferencesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? interestedInWork = null,Object? interestedInGigWork = null,Object? domains = freezed,Object? endgoals = freezed,Object? orgs = freezed,}) {
  return _then(_UserPreferencesDto(
interestedInWork: null == interestedInWork ? _self.interestedInWork : interestedInWork // ignore: cast_nullable_to_non_nullable
as bool,interestedInGigWork: null == interestedInGigWork ? _self.interestedInGigWork : interestedInGigWork // ignore: cast_nullable_to_non_nullable
as bool,domains: freezed == domains ? _self._domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>?,endgoals: freezed == endgoals ? _self._endgoals : endgoals // ignore: cast_nullable_to_non_nullable
as List<String>?,orgs: freezed == orgs ? _self._orgs : orgs // ignore: cast_nullable_to_non_nullable
as List<OrgRefDto>?,
  ));
}


}

// dart format on
