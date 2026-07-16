// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle_members_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CircleMembersDto {

 List<CircleMemberDto>? get members; CircleUserRefDto? get owner;
/// Create a copy of CircleMembersDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleMembersDtoCopyWith<CircleMembersDto> get copyWith => _$CircleMembersDtoCopyWithImpl<CircleMembersDto>(this as CircleMembersDto, _$identity);

  /// Serializes this CircleMembersDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleMembersDto&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.owner, owner) || other.owner == owner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(members),owner);

@override
String toString() {
  return 'CircleMembersDto(members: $members, owner: $owner)';
}


}

/// @nodoc
abstract mixin class $CircleMembersDtoCopyWith<$Res>  {
  factory $CircleMembersDtoCopyWith(CircleMembersDto value, $Res Function(CircleMembersDto) _then) = _$CircleMembersDtoCopyWithImpl;
@useResult
$Res call({
 List<CircleMemberDto>? members, CircleUserRefDto? owner
});


$CircleUserRefDtoCopyWith<$Res>? get owner;

}
/// @nodoc
class _$CircleMembersDtoCopyWithImpl<$Res>
    implements $CircleMembersDtoCopyWith<$Res> {
  _$CircleMembersDtoCopyWithImpl(this._self, this._then);

  final CircleMembersDto _self;
  final $Res Function(CircleMembersDto) _then;

/// Create a copy of CircleMembersDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? members = freezed,Object? owner = freezed,}) {
  return _then(_self.copyWith(
members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<CircleMemberDto>?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as CircleUserRefDto?,
  ));
}
/// Create a copy of CircleMembersDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleUserRefDtoCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $CircleUserRefDtoCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}


/// Adds pattern-matching-related methods to [CircleMembersDto].
extension CircleMembersDtoPatterns on CircleMembersDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleMembersDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleMembersDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleMembersDto value)  $default,){
final _that = this;
switch (_that) {
case _CircleMembersDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleMembersDto value)?  $default,){
final _that = this;
switch (_that) {
case _CircleMembersDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CircleMemberDto>? members,  CircleUserRefDto? owner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleMembersDto() when $default != null:
return $default(_that.members,_that.owner);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CircleMemberDto>? members,  CircleUserRefDto? owner)  $default,) {final _that = this;
switch (_that) {
case _CircleMembersDto():
return $default(_that.members,_that.owner);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CircleMemberDto>? members,  CircleUserRefDto? owner)?  $default,) {final _that = this;
switch (_that) {
case _CircleMembersDto() when $default != null:
return $default(_that.members,_that.owner);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CircleMembersDto extends CircleMembersDto {
  const _CircleMembersDto({final  List<CircleMemberDto>? members, this.owner}): _members = members,super._();
  factory _CircleMembersDto.fromJson(Map<String, dynamic> json) => _$CircleMembersDtoFromJson(json);

 final  List<CircleMemberDto>? _members;
@override List<CircleMemberDto>? get members {
  final value = _members;
  if (value == null) return null;
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  CircleUserRefDto? owner;

/// Create a copy of CircleMembersDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleMembersDtoCopyWith<_CircleMembersDto> get copyWith => __$CircleMembersDtoCopyWithImpl<_CircleMembersDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CircleMembersDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleMembersDto&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.owner, owner) || other.owner == owner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_members),owner);

@override
String toString() {
  return 'CircleMembersDto(members: $members, owner: $owner)';
}


}

/// @nodoc
abstract mixin class _$CircleMembersDtoCopyWith<$Res> implements $CircleMembersDtoCopyWith<$Res> {
  factory _$CircleMembersDtoCopyWith(_CircleMembersDto value, $Res Function(_CircleMembersDto) _then) = __$CircleMembersDtoCopyWithImpl;
@override @useResult
$Res call({
 List<CircleMemberDto>? members, CircleUserRefDto? owner
});


@override $CircleUserRefDtoCopyWith<$Res>? get owner;

}
/// @nodoc
class __$CircleMembersDtoCopyWithImpl<$Res>
    implements _$CircleMembersDtoCopyWith<$Res> {
  __$CircleMembersDtoCopyWithImpl(this._self, this._then);

  final _CircleMembersDto _self;
  final $Res Function(_CircleMembersDto) _then;

/// Create a copy of CircleMembersDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? members = freezed,Object? owner = freezed,}) {
  return _then(_CircleMembersDto(
members: freezed == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<CircleMemberDto>?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as CircleUserRefDto?,
  ));
}

/// Create a copy of CircleMembersDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleUserRefDtoCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $CircleUserRefDtoCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}

// dart format on
