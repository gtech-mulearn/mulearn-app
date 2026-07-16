// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interest_group_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterestGroupSummaryDto {

 String get id; String get name; String? get category; int? get members; List<IgPersonRefDto>? get leads; List<IgPersonRefDto>? get mentors; String? get about; String? get resource; String? get icon; String? get code;@JsonKey(fromJson: _stringListFromJson) List<String>? get prerequisites;@JsonKey(fromJson: _stringListFromJson) List<String>? get careerOpportunities;
/// Create a copy of InterestGroupSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterestGroupSummaryDtoCopyWith<InterestGroupSummaryDto> get copyWith => _$InterestGroupSummaryDtoCopyWithImpl<InterestGroupSummaryDto>(this as InterestGroupSummaryDto, _$identity);

  /// Serializes this InterestGroupSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterestGroupSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.members, members) || other.members == members)&&const DeepCollectionEquality().equals(other.leads, leads)&&const DeepCollectionEquality().equals(other.mentors, mentors)&&(identical(other.about, about) || other.about == about)&&(identical(other.resource, resource) || other.resource == resource)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.prerequisites, prerequisites)&&const DeepCollectionEquality().equals(other.careerOpportunities, careerOpportunities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,members,const DeepCollectionEquality().hash(leads),const DeepCollectionEquality().hash(mentors),about,resource,icon,code,const DeepCollectionEquality().hash(prerequisites),const DeepCollectionEquality().hash(careerOpportunities));

@override
String toString() {
  return 'InterestGroupSummaryDto(id: $id, name: $name, category: $category, members: $members, leads: $leads, mentors: $mentors, about: $about, resource: $resource, icon: $icon, code: $code, prerequisites: $prerequisites, careerOpportunities: $careerOpportunities)';
}


}

/// @nodoc
abstract mixin class $InterestGroupSummaryDtoCopyWith<$Res>  {
  factory $InterestGroupSummaryDtoCopyWith(InterestGroupSummaryDto value, $Res Function(InterestGroupSummaryDto) _then) = _$InterestGroupSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? category, int? members, List<IgPersonRefDto>? leads, List<IgPersonRefDto>? mentors, String? about, String? resource, String? icon, String? code,@JsonKey(fromJson: _stringListFromJson) List<String>? prerequisites,@JsonKey(fromJson: _stringListFromJson) List<String>? careerOpportunities
});




}
/// @nodoc
class _$InterestGroupSummaryDtoCopyWithImpl<$Res>
    implements $InterestGroupSummaryDtoCopyWith<$Res> {
  _$InterestGroupSummaryDtoCopyWithImpl(this._self, this._then);

  final InterestGroupSummaryDto _self;
  final $Res Function(InterestGroupSummaryDto) _then;

/// Create a copy of InterestGroupSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = freezed,Object? members = freezed,Object? leads = freezed,Object? mentors = freezed,Object? about = freezed,Object? resource = freezed,Object? icon = freezed,Object? code = freezed,Object? prerequisites = freezed,Object? careerOpportunities = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int?,leads: freezed == leads ? _self.leads : leads // ignore: cast_nullable_to_non_nullable
as List<IgPersonRefDto>?,mentors: freezed == mentors ? _self.mentors : mentors // ignore: cast_nullable_to_non_nullable
as List<IgPersonRefDto>?,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,resource: freezed == resource ? _self.resource : resource // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,prerequisites: freezed == prerequisites ? _self.prerequisites : prerequisites // ignore: cast_nullable_to_non_nullable
as List<String>?,careerOpportunities: freezed == careerOpportunities ? _self.careerOpportunities : careerOpportunities // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [InterestGroupSummaryDto].
extension InterestGroupSummaryDtoPatterns on InterestGroupSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterestGroupSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterestGroupSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterestGroupSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _InterestGroupSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterestGroupSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _InterestGroupSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? category,  int? members,  List<IgPersonRefDto>? leads,  List<IgPersonRefDto>? mentors,  String? about,  String? resource,  String? icon,  String? code, @JsonKey(fromJson: _stringListFromJson)  List<String>? prerequisites, @JsonKey(fromJson: _stringListFromJson)  List<String>? careerOpportunities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterestGroupSummaryDto() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.members,_that.leads,_that.mentors,_that.about,_that.resource,_that.icon,_that.code,_that.prerequisites,_that.careerOpportunities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? category,  int? members,  List<IgPersonRefDto>? leads,  List<IgPersonRefDto>? mentors,  String? about,  String? resource,  String? icon,  String? code, @JsonKey(fromJson: _stringListFromJson)  List<String>? prerequisites, @JsonKey(fromJson: _stringListFromJson)  List<String>? careerOpportunities)  $default,) {final _that = this;
switch (_that) {
case _InterestGroupSummaryDto():
return $default(_that.id,_that.name,_that.category,_that.members,_that.leads,_that.mentors,_that.about,_that.resource,_that.icon,_that.code,_that.prerequisites,_that.careerOpportunities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? category,  int? members,  List<IgPersonRefDto>? leads,  List<IgPersonRefDto>? mentors,  String? about,  String? resource,  String? icon,  String? code, @JsonKey(fromJson: _stringListFromJson)  List<String>? prerequisites, @JsonKey(fromJson: _stringListFromJson)  List<String>? careerOpportunities)?  $default,) {final _that = this;
switch (_that) {
case _InterestGroupSummaryDto() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.members,_that.leads,_that.mentors,_that.about,_that.resource,_that.icon,_that.code,_that.prerequisites,_that.careerOpportunities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterestGroupSummaryDto extends InterestGroupSummaryDto {
  const _InterestGroupSummaryDto({required this.id, required this.name, this.category, this.members, final  List<IgPersonRefDto>? leads, final  List<IgPersonRefDto>? mentors, this.about, this.resource, this.icon, this.code, @JsonKey(fromJson: _stringListFromJson) final  List<String>? prerequisites, @JsonKey(fromJson: _stringListFromJson) final  List<String>? careerOpportunities}): _leads = leads,_mentors = mentors,_prerequisites = prerequisites,_careerOpportunities = careerOpportunities,super._();
  factory _InterestGroupSummaryDto.fromJson(Map<String, dynamic> json) => _$InterestGroupSummaryDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? category;
@override final  int? members;
 final  List<IgPersonRefDto>? _leads;
@override List<IgPersonRefDto>? get leads {
  final value = _leads;
  if (value == null) return null;
  if (_leads is EqualUnmodifiableListView) return _leads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<IgPersonRefDto>? _mentors;
@override List<IgPersonRefDto>? get mentors {
  final value = _mentors;
  if (value == null) return null;
  if (_mentors is EqualUnmodifiableListView) return _mentors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? about;
@override final  String? resource;
@override final  String? icon;
@override final  String? code;
 final  List<String>? _prerequisites;
@override@JsonKey(fromJson: _stringListFromJson) List<String>? get prerequisites {
  final value = _prerequisites;
  if (value == null) return null;
  if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _careerOpportunities;
@override@JsonKey(fromJson: _stringListFromJson) List<String>? get careerOpportunities {
  final value = _careerOpportunities;
  if (value == null) return null;
  if (_careerOpportunities is EqualUnmodifiableListView) return _careerOpportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of InterestGroupSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterestGroupSummaryDtoCopyWith<_InterestGroupSummaryDto> get copyWith => __$InterestGroupSummaryDtoCopyWithImpl<_InterestGroupSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterestGroupSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterestGroupSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.members, members) || other.members == members)&&const DeepCollectionEquality().equals(other._leads, _leads)&&const DeepCollectionEquality().equals(other._mentors, _mentors)&&(identical(other.about, about) || other.about == about)&&(identical(other.resource, resource) || other.resource == resource)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other._prerequisites, _prerequisites)&&const DeepCollectionEquality().equals(other._careerOpportunities, _careerOpportunities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,members,const DeepCollectionEquality().hash(_leads),const DeepCollectionEquality().hash(_mentors),about,resource,icon,code,const DeepCollectionEquality().hash(_prerequisites),const DeepCollectionEquality().hash(_careerOpportunities));

@override
String toString() {
  return 'InterestGroupSummaryDto(id: $id, name: $name, category: $category, members: $members, leads: $leads, mentors: $mentors, about: $about, resource: $resource, icon: $icon, code: $code, prerequisites: $prerequisites, careerOpportunities: $careerOpportunities)';
}


}

/// @nodoc
abstract mixin class _$InterestGroupSummaryDtoCopyWith<$Res> implements $InterestGroupSummaryDtoCopyWith<$Res> {
  factory _$InterestGroupSummaryDtoCopyWith(_InterestGroupSummaryDto value, $Res Function(_InterestGroupSummaryDto) _then) = __$InterestGroupSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? category, int? members, List<IgPersonRefDto>? leads, List<IgPersonRefDto>? mentors, String? about, String? resource, String? icon, String? code,@JsonKey(fromJson: _stringListFromJson) List<String>? prerequisites,@JsonKey(fromJson: _stringListFromJson) List<String>? careerOpportunities
});




}
/// @nodoc
class __$InterestGroupSummaryDtoCopyWithImpl<$Res>
    implements _$InterestGroupSummaryDtoCopyWith<$Res> {
  __$InterestGroupSummaryDtoCopyWithImpl(this._self, this._then);

  final _InterestGroupSummaryDto _self;
  final $Res Function(_InterestGroupSummaryDto) _then;

/// Create a copy of InterestGroupSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = freezed,Object? members = freezed,Object? leads = freezed,Object? mentors = freezed,Object? about = freezed,Object? resource = freezed,Object? icon = freezed,Object? code = freezed,Object? prerequisites = freezed,Object? careerOpportunities = freezed,}) {
  return _then(_InterestGroupSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as int?,leads: freezed == leads ? _self._leads : leads // ignore: cast_nullable_to_non_nullable
as List<IgPersonRefDto>?,mentors: freezed == mentors ? _self._mentors : mentors // ignore: cast_nullable_to_non_nullable
as List<IgPersonRefDto>?,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,resource: freezed == resource ? _self.resource : resource // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,prerequisites: freezed == prerequisites ? _self._prerequisites : prerequisites // ignore: cast_nullable_to_non_nullable
as List<String>?,careerOpportunities: freezed == careerOpportunities ? _self._careerOpportunities : careerOpportunities // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
