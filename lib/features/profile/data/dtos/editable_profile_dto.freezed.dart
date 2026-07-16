// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editable_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditableProfileDto {

 String? get fullName; String? get email; String? get mobile; String? get gender; String? get dob; DistrictLocationDto? get district; List<String> get communities;
/// Create a copy of EditableProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditableProfileDtoCopyWith<EditableProfileDto> get copyWith => _$EditableProfileDtoCopyWithImpl<EditableProfileDto>(this as EditableProfileDto, _$identity);

  /// Serializes this EditableProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditableProfileDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.district, district) || other.district == district)&&const DeepCollectionEquality().equals(other.communities, communities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,mobile,gender,dob,district,const DeepCollectionEquality().hash(communities));

@override
String toString() {
  return 'EditableProfileDto(fullName: $fullName, email: $email, mobile: $mobile, gender: $gender, dob: $dob, district: $district, communities: $communities)';
}


}

/// @nodoc
abstract mixin class $EditableProfileDtoCopyWith<$Res>  {
  factory $EditableProfileDtoCopyWith(EditableProfileDto value, $Res Function(EditableProfileDto) _then) = _$EditableProfileDtoCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? email, String? mobile, String? gender, String? dob, DistrictLocationDto? district, List<String> communities
});


$DistrictLocationDtoCopyWith<$Res>? get district;

}
/// @nodoc
class _$EditableProfileDtoCopyWithImpl<$Res>
    implements $EditableProfileDtoCopyWith<$Res> {
  _$EditableProfileDtoCopyWithImpl(this._self, this._then);

  final EditableProfileDto _self;
  final $Res Function(EditableProfileDto) _then;

/// Create a copy of EditableProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? email = freezed,Object? mobile = freezed,Object? gender = freezed,Object? dob = freezed,Object? district = freezed,Object? communities = null,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as DistrictLocationDto?,communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of EditableProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistrictLocationDtoCopyWith<$Res>? get district {
    if (_self.district == null) {
    return null;
  }

  return $DistrictLocationDtoCopyWith<$Res>(_self.district!, (value) {
    return _then(_self.copyWith(district: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditableProfileDto].
extension EditableProfileDtoPatterns on EditableProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditableProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditableProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditableProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _EditableProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditableProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _EditableProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? mobile,  String? gender,  String? dob,  DistrictLocationDto? district,  List<String> communities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditableProfileDto() when $default != null:
return $default(_that.fullName,_that.email,_that.mobile,_that.gender,_that.dob,_that.district,_that.communities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? mobile,  String? gender,  String? dob,  DistrictLocationDto? district,  List<String> communities)  $default,) {final _that = this;
switch (_that) {
case _EditableProfileDto():
return $default(_that.fullName,_that.email,_that.mobile,_that.gender,_that.dob,_that.district,_that.communities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? email,  String? mobile,  String? gender,  String? dob,  DistrictLocationDto? district,  List<String> communities)?  $default,) {final _that = this;
switch (_that) {
case _EditableProfileDto() when $default != null:
return $default(_that.fullName,_that.email,_that.mobile,_that.gender,_that.dob,_that.district,_that.communities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EditableProfileDto extends EditableProfileDto {
  const _EditableProfileDto({this.fullName, this.email, this.mobile, this.gender, this.dob, this.district, final  List<String> communities = const []}): _communities = communities,super._();
  factory _EditableProfileDto.fromJson(Map<String, dynamic> json) => _$EditableProfileDtoFromJson(json);

@override final  String? fullName;
@override final  String? email;
@override final  String? mobile;
@override final  String? gender;
@override final  String? dob;
@override final  DistrictLocationDto? district;
 final  List<String> _communities;
@override@JsonKey() List<String> get communities {
  if (_communities is EqualUnmodifiableListView) return _communities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communities);
}


/// Create a copy of EditableProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditableProfileDtoCopyWith<_EditableProfileDto> get copyWith => __$EditableProfileDtoCopyWithImpl<_EditableProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EditableProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditableProfileDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.district, district) || other.district == district)&&const DeepCollectionEquality().equals(other._communities, _communities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,mobile,gender,dob,district,const DeepCollectionEquality().hash(_communities));

@override
String toString() {
  return 'EditableProfileDto(fullName: $fullName, email: $email, mobile: $mobile, gender: $gender, dob: $dob, district: $district, communities: $communities)';
}


}

/// @nodoc
abstract mixin class _$EditableProfileDtoCopyWith<$Res> implements $EditableProfileDtoCopyWith<$Res> {
  factory _$EditableProfileDtoCopyWith(_EditableProfileDto value, $Res Function(_EditableProfileDto) _then) = __$EditableProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? email, String? mobile, String? gender, String? dob, DistrictLocationDto? district, List<String> communities
});


@override $DistrictLocationDtoCopyWith<$Res>? get district;

}
/// @nodoc
class __$EditableProfileDtoCopyWithImpl<$Res>
    implements _$EditableProfileDtoCopyWith<$Res> {
  __$EditableProfileDtoCopyWithImpl(this._self, this._then);

  final _EditableProfileDto _self;
  final $Res Function(_EditableProfileDto) _then;

/// Create a copy of EditableProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? email = freezed,Object? mobile = freezed,Object? gender = freezed,Object? dob = freezed,Object? district = freezed,Object? communities = null,}) {
  return _then(_EditableProfileDto(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as DistrictLocationDto?,communities: null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of EditableProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistrictLocationDtoCopyWith<$Res>? get district {
    if (_self.district == null) {
    return null;
  }

  return $DistrictLocationDtoCopyWith<$Res>(_self.district!, (value) {
    return _then(_self.copyWith(district: value));
  });
}
}

// dart format on
