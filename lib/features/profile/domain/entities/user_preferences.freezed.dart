// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserPreferences {

 bool get interestedInWork; bool get interestedInGigWork; List<String>? get domains; List<String>? get endgoals; List<OrgRef>? get orgs;
/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<UserPreferences> get copyWith => _$UserPreferencesCopyWithImpl<UserPreferences>(this as UserPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferences&&(identical(other.interestedInWork, interestedInWork) || other.interestedInWork == interestedInWork)&&(identical(other.interestedInGigWork, interestedInGigWork) || other.interestedInGigWork == interestedInGigWork)&&const DeepCollectionEquality().equals(other.domains, domains)&&const DeepCollectionEquality().equals(other.endgoals, endgoals)&&const DeepCollectionEquality().equals(other.orgs, orgs));
}


@override
int get hashCode => Object.hash(runtimeType,interestedInWork,interestedInGigWork,const DeepCollectionEquality().hash(domains),const DeepCollectionEquality().hash(endgoals),const DeepCollectionEquality().hash(orgs));

@override
String toString() {
  return 'UserPreferences(interestedInWork: $interestedInWork, interestedInGigWork: $interestedInGigWork, domains: $domains, endgoals: $endgoals, orgs: $orgs)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesCopyWith<$Res>  {
  factory $UserPreferencesCopyWith(UserPreferences value, $Res Function(UserPreferences) _then) = _$UserPreferencesCopyWithImpl;
@useResult
$Res call({
 bool interestedInWork, bool interestedInGigWork, List<String>? domains, List<String>? endgoals, List<OrgRef>? orgs
});




}
/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._self, this._then);

  final UserPreferences _self;
  final $Res Function(UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? interestedInWork = null,Object? interestedInGigWork = null,Object? domains = freezed,Object? endgoals = freezed,Object? orgs = freezed,}) {
  return _then(_self.copyWith(
interestedInWork: null == interestedInWork ? _self.interestedInWork : interestedInWork // ignore: cast_nullable_to_non_nullable
as bool,interestedInGigWork: null == interestedInGigWork ? _self.interestedInGigWork : interestedInGigWork // ignore: cast_nullable_to_non_nullable
as bool,domains: freezed == domains ? _self.domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>?,endgoals: freezed == endgoals ? _self.endgoals : endgoals // ignore: cast_nullable_to_non_nullable
as List<String>?,orgs: freezed == orgs ? _self.orgs : orgs // ignore: cast_nullable_to_non_nullable
as List<OrgRef>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferences].
extension UserPreferencesPatterns on UserPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferences value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool interestedInWork,  bool interestedInGigWork,  List<String>? domains,  List<String>? endgoals,  List<OrgRef>? orgs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool interestedInWork,  bool interestedInGigWork,  List<String>? domains,  List<String>? endgoals,  List<OrgRef>? orgs)  $default,) {final _that = this;
switch (_that) {
case _UserPreferences():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool interestedInWork,  bool interestedInGigWork,  List<String>? domains,  List<String>? endgoals,  List<OrgRef>? orgs)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.interestedInWork,_that.interestedInGigWork,_that.domains,_that.endgoals,_that.orgs);case _:
  return null;

}
}

}

/// @nodoc


class _UserPreferences implements UserPreferences {
  const _UserPreferences({required this.interestedInWork, required this.interestedInGigWork, final  List<String>? domains, final  List<String>? endgoals, final  List<OrgRef>? orgs}): _domains = domains,_endgoals = endgoals,_orgs = orgs;
  

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

 final  List<OrgRef>? _orgs;
@override List<OrgRef>? get orgs {
  final value = _orgs;
  if (value == null) return null;
  if (_orgs is EqualUnmodifiableListView) return _orgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesCopyWith<_UserPreferences> get copyWith => __$UserPreferencesCopyWithImpl<_UserPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferences&&(identical(other.interestedInWork, interestedInWork) || other.interestedInWork == interestedInWork)&&(identical(other.interestedInGigWork, interestedInGigWork) || other.interestedInGigWork == interestedInGigWork)&&const DeepCollectionEquality().equals(other._domains, _domains)&&const DeepCollectionEquality().equals(other._endgoals, _endgoals)&&const DeepCollectionEquality().equals(other._orgs, _orgs));
}


@override
int get hashCode => Object.hash(runtimeType,interestedInWork,interestedInGigWork,const DeepCollectionEquality().hash(_domains),const DeepCollectionEquality().hash(_endgoals),const DeepCollectionEquality().hash(_orgs));

@override
String toString() {
  return 'UserPreferences(interestedInWork: $interestedInWork, interestedInGigWork: $interestedInGigWork, domains: $domains, endgoals: $endgoals, orgs: $orgs)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesCopyWith<$Res> implements $UserPreferencesCopyWith<$Res> {
  factory _$UserPreferencesCopyWith(_UserPreferences value, $Res Function(_UserPreferences) _then) = __$UserPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool interestedInWork, bool interestedInGigWork, List<String>? domains, List<String>? endgoals, List<OrgRef>? orgs
});




}
/// @nodoc
class __$UserPreferencesCopyWithImpl<$Res>
    implements _$UserPreferencesCopyWith<$Res> {
  __$UserPreferencesCopyWithImpl(this._self, this._then);

  final _UserPreferences _self;
  final $Res Function(_UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? interestedInWork = null,Object? interestedInGigWork = null,Object? domains = freezed,Object? endgoals = freezed,Object? orgs = freezed,}) {
  return _then(_UserPreferences(
interestedInWork: null == interestedInWork ? _self.interestedInWork : interestedInWork // ignore: cast_nullable_to_non_nullable
as bool,interestedInGigWork: null == interestedInGigWork ? _self.interestedInGigWork : interestedInGigWork // ignore: cast_nullable_to_non_nullable
as bool,domains: freezed == domains ? _self._domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>?,endgoals: freezed == endgoals ? _self._endgoals : endgoals // ignore: cast_nullable_to_non_nullable
as List<String>?,orgs: freezed == orgs ? _self._orgs : orgs // ignore: cast_nullable_to_non_nullable
as List<OrgRef>?,
  ));
}


}

// dart format on
