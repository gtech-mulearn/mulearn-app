// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'karma_feed_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KarmaFeedDto {

 KarmaFeedTopUserDto? get topUser; KarmaFeedTopCollegeDto? get topCollege;
/// Create a copy of KarmaFeedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KarmaFeedDtoCopyWith<KarmaFeedDto> get copyWith => _$KarmaFeedDtoCopyWithImpl<KarmaFeedDto>(this as KarmaFeedDto, _$identity);

  /// Serializes this KarmaFeedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KarmaFeedDto&&(identical(other.topUser, topUser) || other.topUser == topUser)&&(identical(other.topCollege, topCollege) || other.topCollege == topCollege));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topUser,topCollege);

@override
String toString() {
  return 'KarmaFeedDto(topUser: $topUser, topCollege: $topCollege)';
}


}

/// @nodoc
abstract mixin class $KarmaFeedDtoCopyWith<$Res>  {
  factory $KarmaFeedDtoCopyWith(KarmaFeedDto value, $Res Function(KarmaFeedDto) _then) = _$KarmaFeedDtoCopyWithImpl;
@useResult
$Res call({
 KarmaFeedTopUserDto? topUser, KarmaFeedTopCollegeDto? topCollege
});


$KarmaFeedTopUserDtoCopyWith<$Res>? get topUser;$KarmaFeedTopCollegeDtoCopyWith<$Res>? get topCollege;

}
/// @nodoc
class _$KarmaFeedDtoCopyWithImpl<$Res>
    implements $KarmaFeedDtoCopyWith<$Res> {
  _$KarmaFeedDtoCopyWithImpl(this._self, this._then);

  final KarmaFeedDto _self;
  final $Res Function(KarmaFeedDto) _then;

/// Create a copy of KarmaFeedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topUser = freezed,Object? topCollege = freezed,}) {
  return _then(_self.copyWith(
topUser: freezed == topUser ? _self.topUser : topUser // ignore: cast_nullable_to_non_nullable
as KarmaFeedTopUserDto?,topCollege: freezed == topCollege ? _self.topCollege : topCollege // ignore: cast_nullable_to_non_nullable
as KarmaFeedTopCollegeDto?,
  ));
}
/// Create a copy of KarmaFeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KarmaFeedTopUserDtoCopyWith<$Res>? get topUser {
    if (_self.topUser == null) {
    return null;
  }

  return $KarmaFeedTopUserDtoCopyWith<$Res>(_self.topUser!, (value) {
    return _then(_self.copyWith(topUser: value));
  });
}/// Create a copy of KarmaFeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KarmaFeedTopCollegeDtoCopyWith<$Res>? get topCollege {
    if (_self.topCollege == null) {
    return null;
  }

  return $KarmaFeedTopCollegeDtoCopyWith<$Res>(_self.topCollege!, (value) {
    return _then(_self.copyWith(topCollege: value));
  });
}
}


/// Adds pattern-matching-related methods to [KarmaFeedDto].
extension KarmaFeedDtoPatterns on KarmaFeedDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KarmaFeedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KarmaFeedDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KarmaFeedDto value)  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KarmaFeedDto value)?  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KarmaFeedTopUserDto? topUser,  KarmaFeedTopCollegeDto? topCollege)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KarmaFeedDto() when $default != null:
return $default(_that.topUser,_that.topCollege);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KarmaFeedTopUserDto? topUser,  KarmaFeedTopCollegeDto? topCollege)  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedDto():
return $default(_that.topUser,_that.topCollege);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KarmaFeedTopUserDto? topUser,  KarmaFeedTopCollegeDto? topCollege)?  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedDto() when $default != null:
return $default(_that.topUser,_that.topCollege);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KarmaFeedDto extends KarmaFeedDto {
  const _KarmaFeedDto({this.topUser, this.topCollege}): super._();
  factory _KarmaFeedDto.fromJson(Map<String, dynamic> json) => _$KarmaFeedDtoFromJson(json);

@override final  KarmaFeedTopUserDto? topUser;
@override final  KarmaFeedTopCollegeDto? topCollege;

/// Create a copy of KarmaFeedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KarmaFeedDtoCopyWith<_KarmaFeedDto> get copyWith => __$KarmaFeedDtoCopyWithImpl<_KarmaFeedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KarmaFeedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KarmaFeedDto&&(identical(other.topUser, topUser) || other.topUser == topUser)&&(identical(other.topCollege, topCollege) || other.topCollege == topCollege));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topUser,topCollege);

@override
String toString() {
  return 'KarmaFeedDto(topUser: $topUser, topCollege: $topCollege)';
}


}

/// @nodoc
abstract mixin class _$KarmaFeedDtoCopyWith<$Res> implements $KarmaFeedDtoCopyWith<$Res> {
  factory _$KarmaFeedDtoCopyWith(_KarmaFeedDto value, $Res Function(_KarmaFeedDto) _then) = __$KarmaFeedDtoCopyWithImpl;
@override @useResult
$Res call({
 KarmaFeedTopUserDto? topUser, KarmaFeedTopCollegeDto? topCollege
});


@override $KarmaFeedTopUserDtoCopyWith<$Res>? get topUser;@override $KarmaFeedTopCollegeDtoCopyWith<$Res>? get topCollege;

}
/// @nodoc
class __$KarmaFeedDtoCopyWithImpl<$Res>
    implements _$KarmaFeedDtoCopyWith<$Res> {
  __$KarmaFeedDtoCopyWithImpl(this._self, this._then);

  final _KarmaFeedDto _self;
  final $Res Function(_KarmaFeedDto) _then;

/// Create a copy of KarmaFeedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topUser = freezed,Object? topCollege = freezed,}) {
  return _then(_KarmaFeedDto(
topUser: freezed == topUser ? _self.topUser : topUser // ignore: cast_nullable_to_non_nullable
as KarmaFeedTopUserDto?,topCollege: freezed == topCollege ? _self.topCollege : topCollege // ignore: cast_nullable_to_non_nullable
as KarmaFeedTopCollegeDto?,
  ));
}

/// Create a copy of KarmaFeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KarmaFeedTopUserDtoCopyWith<$Res>? get topUser {
    if (_self.topUser == null) {
    return null;
  }

  return $KarmaFeedTopUserDtoCopyWith<$Res>(_self.topUser!, (value) {
    return _then(_self.copyWith(topUser: value));
  });
}/// Create a copy of KarmaFeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KarmaFeedTopCollegeDtoCopyWith<$Res>? get topCollege {
    if (_self.topCollege == null) {
    return null;
  }

  return $KarmaFeedTopCollegeDtoCopyWith<$Res>(_self.topCollege!, (value) {
    return _then(_self.copyWith(topCollege: value));
  });
}
}

// dart format on
