// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interest_group_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InterestGroupSummary {

 String get id; String get name; String get category; int get memberCount; List<IgPersonRef> get leads; List<IgPersonRef> get mentors; String? get about; String? get resource; String? get icon; String? get code; List<String> get prerequisites; List<String> get careerOpportunities;
/// Create a copy of InterestGroupSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterestGroupSummaryCopyWith<InterestGroupSummary> get copyWith => _$InterestGroupSummaryCopyWithImpl<InterestGroupSummary>(this as InterestGroupSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterestGroupSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other.leads, leads)&&const DeepCollectionEquality().equals(other.mentors, mentors)&&(identical(other.about, about) || other.about == about)&&(identical(other.resource, resource) || other.resource == resource)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.prerequisites, prerequisites)&&const DeepCollectionEquality().equals(other.careerOpportunities, careerOpportunities));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,category,memberCount,const DeepCollectionEquality().hash(leads),const DeepCollectionEquality().hash(mentors),about,resource,icon,code,const DeepCollectionEquality().hash(prerequisites),const DeepCollectionEquality().hash(careerOpportunities));

@override
String toString() {
  return 'InterestGroupSummary(id: $id, name: $name, category: $category, memberCount: $memberCount, leads: $leads, mentors: $mentors, about: $about, resource: $resource, icon: $icon, code: $code, prerequisites: $prerequisites, careerOpportunities: $careerOpportunities)';
}


}

/// @nodoc
abstract mixin class $InterestGroupSummaryCopyWith<$Res>  {
  factory $InterestGroupSummaryCopyWith(InterestGroupSummary value, $Res Function(InterestGroupSummary) _then) = _$InterestGroupSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, int memberCount, List<IgPersonRef> leads, List<IgPersonRef> mentors, String? about, String? resource, String? icon, String? code, List<String> prerequisites, List<String> careerOpportunities
});




}
/// @nodoc
class _$InterestGroupSummaryCopyWithImpl<$Res>
    implements $InterestGroupSummaryCopyWith<$Res> {
  _$InterestGroupSummaryCopyWithImpl(this._self, this._then);

  final InterestGroupSummary _self;
  final $Res Function(InterestGroupSummary) _then;

/// Create a copy of InterestGroupSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? memberCount = null,Object? leads = null,Object? mentors = null,Object? about = freezed,Object? resource = freezed,Object? icon = freezed,Object? code = freezed,Object? prerequisites = null,Object? careerOpportunities = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,leads: null == leads ? _self.leads : leads // ignore: cast_nullable_to_non_nullable
as List<IgPersonRef>,mentors: null == mentors ? _self.mentors : mentors // ignore: cast_nullable_to_non_nullable
as List<IgPersonRef>,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,resource: freezed == resource ? _self.resource : resource // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,prerequisites: null == prerequisites ? _self.prerequisites : prerequisites // ignore: cast_nullable_to_non_nullable
as List<String>,careerOpportunities: null == careerOpportunities ? _self.careerOpportunities : careerOpportunities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [InterestGroupSummary].
extension InterestGroupSummaryPatterns on InterestGroupSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterestGroupSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterestGroupSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterestGroupSummary value)  $default,){
final _that = this;
switch (_that) {
case _InterestGroupSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterestGroupSummary value)?  $default,){
final _that = this;
switch (_that) {
case _InterestGroupSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  int memberCount,  List<IgPersonRef> leads,  List<IgPersonRef> mentors,  String? about,  String? resource,  String? icon,  String? code,  List<String> prerequisites,  List<String> careerOpportunities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterestGroupSummary() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.memberCount,_that.leads,_that.mentors,_that.about,_that.resource,_that.icon,_that.code,_that.prerequisites,_that.careerOpportunities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  int memberCount,  List<IgPersonRef> leads,  List<IgPersonRef> mentors,  String? about,  String? resource,  String? icon,  String? code,  List<String> prerequisites,  List<String> careerOpportunities)  $default,) {final _that = this;
switch (_that) {
case _InterestGroupSummary():
return $default(_that.id,_that.name,_that.category,_that.memberCount,_that.leads,_that.mentors,_that.about,_that.resource,_that.icon,_that.code,_that.prerequisites,_that.careerOpportunities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  int memberCount,  List<IgPersonRef> leads,  List<IgPersonRef> mentors,  String? about,  String? resource,  String? icon,  String? code,  List<String> prerequisites,  List<String> careerOpportunities)?  $default,) {final _that = this;
switch (_that) {
case _InterestGroupSummary() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.memberCount,_that.leads,_that.mentors,_that.about,_that.resource,_that.icon,_that.code,_that.prerequisites,_that.careerOpportunities);case _:
  return null;

}
}

}

/// @nodoc


class _InterestGroupSummary implements InterestGroupSummary {
  const _InterestGroupSummary({required this.id, required this.name, required this.category, required this.memberCount, required final  List<IgPersonRef> leads, required final  List<IgPersonRef> mentors, this.about, this.resource, this.icon, this.code, final  List<String> prerequisites = const [], final  List<String> careerOpportunities = const []}): _leads = leads,_mentors = mentors,_prerequisites = prerequisites,_careerOpportunities = careerOpportunities;
  

@override final  String id;
@override final  String name;
@override final  String category;
@override final  int memberCount;
 final  List<IgPersonRef> _leads;
@override List<IgPersonRef> get leads {
  if (_leads is EqualUnmodifiableListView) return _leads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leads);
}

 final  List<IgPersonRef> _mentors;
@override List<IgPersonRef> get mentors {
  if (_mentors is EqualUnmodifiableListView) return _mentors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentors);
}

@override final  String? about;
@override final  String? resource;
@override final  String? icon;
@override final  String? code;
 final  List<String> _prerequisites;
@override@JsonKey() List<String> get prerequisites {
  if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prerequisites);
}

 final  List<String> _careerOpportunities;
@override@JsonKey() List<String> get careerOpportunities {
  if (_careerOpportunities is EqualUnmodifiableListView) return _careerOpportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_careerOpportunities);
}


/// Create a copy of InterestGroupSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterestGroupSummaryCopyWith<_InterestGroupSummary> get copyWith => __$InterestGroupSummaryCopyWithImpl<_InterestGroupSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterestGroupSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other._leads, _leads)&&const DeepCollectionEquality().equals(other._mentors, _mentors)&&(identical(other.about, about) || other.about == about)&&(identical(other.resource, resource) || other.resource == resource)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other._prerequisites, _prerequisites)&&const DeepCollectionEquality().equals(other._careerOpportunities, _careerOpportunities));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,category,memberCount,const DeepCollectionEquality().hash(_leads),const DeepCollectionEquality().hash(_mentors),about,resource,icon,code,const DeepCollectionEquality().hash(_prerequisites),const DeepCollectionEquality().hash(_careerOpportunities));

@override
String toString() {
  return 'InterestGroupSummary(id: $id, name: $name, category: $category, memberCount: $memberCount, leads: $leads, mentors: $mentors, about: $about, resource: $resource, icon: $icon, code: $code, prerequisites: $prerequisites, careerOpportunities: $careerOpportunities)';
}


}

/// @nodoc
abstract mixin class _$InterestGroupSummaryCopyWith<$Res> implements $InterestGroupSummaryCopyWith<$Res> {
  factory _$InterestGroupSummaryCopyWith(_InterestGroupSummary value, $Res Function(_InterestGroupSummary) _then) = __$InterestGroupSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, int memberCount, List<IgPersonRef> leads, List<IgPersonRef> mentors, String? about, String? resource, String? icon, String? code, List<String> prerequisites, List<String> careerOpportunities
});




}
/// @nodoc
class __$InterestGroupSummaryCopyWithImpl<$Res>
    implements _$InterestGroupSummaryCopyWith<$Res> {
  __$InterestGroupSummaryCopyWithImpl(this._self, this._then);

  final _InterestGroupSummary _self;
  final $Res Function(_InterestGroupSummary) _then;

/// Create a copy of InterestGroupSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? memberCount = null,Object? leads = null,Object? mentors = null,Object? about = freezed,Object? resource = freezed,Object? icon = freezed,Object? code = freezed,Object? prerequisites = null,Object? careerOpportunities = null,}) {
  return _then(_InterestGroupSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,leads: null == leads ? _self._leads : leads // ignore: cast_nullable_to_non_nullable
as List<IgPersonRef>,mentors: null == mentors ? _self._mentors : mentors // ignore: cast_nullable_to_non_nullable
as List<IgPersonRef>,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,resource: freezed == resource ? _self.resource : resource // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,prerequisites: null == prerequisites ? _self._prerequisites : prerequisites // ignore: cast_nullable_to_non_nullable
as List<String>,careerOpportunities: null == careerOpportunities ? _self._careerOpportunities : careerOpportunities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
