// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ig_person_ref_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IgPersonRefDto {

 String get muid; String? get fullName; String? get profilePic;
/// Create a copy of IgPersonRefDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IgPersonRefDtoCopyWith<IgPersonRefDto> get copyWith => _$IgPersonRefDtoCopyWithImpl<IgPersonRefDto>(this as IgPersonRefDto, _$identity);

  /// Serializes this IgPersonRefDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IgPersonRefDto&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muid,fullName,profilePic);

@override
String toString() {
  return 'IgPersonRefDto(muid: $muid, fullName: $fullName, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class $IgPersonRefDtoCopyWith<$Res>  {
  factory $IgPersonRefDtoCopyWith(IgPersonRefDto value, $Res Function(IgPersonRefDto) _then) = _$IgPersonRefDtoCopyWithImpl;
@useResult
$Res call({
 String muid, String? fullName, String? profilePic
});




}
/// @nodoc
class _$IgPersonRefDtoCopyWithImpl<$Res>
    implements $IgPersonRefDtoCopyWith<$Res> {
  _$IgPersonRefDtoCopyWithImpl(this._self, this._then);

  final IgPersonRefDto _self;
  final $Res Function(IgPersonRefDto) _then;

/// Create a copy of IgPersonRefDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muid = null,Object? fullName = freezed,Object? profilePic = freezed,}) {
  return _then(_self.copyWith(
muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IgPersonRefDto].
extension IgPersonRefDtoPatterns on IgPersonRefDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IgPersonRefDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IgPersonRefDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IgPersonRefDto value)  $default,){
final _that = this;
switch (_that) {
case _IgPersonRefDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IgPersonRefDto value)?  $default,){
final _that = this;
switch (_that) {
case _IgPersonRefDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String muid,  String? fullName,  String? profilePic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IgPersonRefDto() when $default != null:
return $default(_that.muid,_that.fullName,_that.profilePic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String muid,  String? fullName,  String? profilePic)  $default,) {final _that = this;
switch (_that) {
case _IgPersonRefDto():
return $default(_that.muid,_that.fullName,_that.profilePic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String muid,  String? fullName,  String? profilePic)?  $default,) {final _that = this;
switch (_that) {
case _IgPersonRefDto() when $default != null:
return $default(_that.muid,_that.fullName,_that.profilePic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IgPersonRefDto extends IgPersonRefDto {
  const _IgPersonRefDto({required this.muid, this.fullName, this.profilePic}): super._();
  factory _IgPersonRefDto.fromJson(Map<String, dynamic> json) => _$IgPersonRefDtoFromJson(json);

@override final  String muid;
@override final  String? fullName;
@override final  String? profilePic;

/// Create a copy of IgPersonRefDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IgPersonRefDtoCopyWith<_IgPersonRefDto> get copyWith => __$IgPersonRefDtoCopyWithImpl<_IgPersonRefDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IgPersonRefDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IgPersonRefDto&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muid,fullName,profilePic);

@override
String toString() {
  return 'IgPersonRefDto(muid: $muid, fullName: $fullName, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class _$IgPersonRefDtoCopyWith<$Res> implements $IgPersonRefDtoCopyWith<$Res> {
  factory _$IgPersonRefDtoCopyWith(_IgPersonRefDto value, $Res Function(_IgPersonRefDto) _then) = __$IgPersonRefDtoCopyWithImpl;
@override @useResult
$Res call({
 String muid, String? fullName, String? profilePic
});




}
/// @nodoc
class __$IgPersonRefDtoCopyWithImpl<$Res>
    implements _$IgPersonRefDtoCopyWith<$Res> {
  __$IgPersonRefDtoCopyWithImpl(this._self, this._then);

  final _IgPersonRefDto _self;
  final $Res Function(_IgPersonRefDto) _then;

/// Create a copy of IgPersonRefDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muid = null,Object? fullName = freezed,Object? profilePic = freezed,}) {
  return _then(_IgPersonRefDto(
muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
