// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle_members.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CircleMembers {

 List<CircleMember> get members; CircleUserRef? get owner;
/// Create a copy of CircleMembers
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleMembersCopyWith<CircleMembers> get copyWith => _$CircleMembersCopyWithImpl<CircleMembers>(this as CircleMembers, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleMembers&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.owner, owner) || other.owner == owner));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(members),owner);

@override
String toString() {
  return 'CircleMembers(members: $members, owner: $owner)';
}


}

/// @nodoc
abstract mixin class $CircleMembersCopyWith<$Res>  {
  factory $CircleMembersCopyWith(CircleMembers value, $Res Function(CircleMembers) _then) = _$CircleMembersCopyWithImpl;
@useResult
$Res call({
 List<CircleMember> members, CircleUserRef? owner
});


$CircleUserRefCopyWith<$Res>? get owner;

}
/// @nodoc
class _$CircleMembersCopyWithImpl<$Res>
    implements $CircleMembersCopyWith<$Res> {
  _$CircleMembersCopyWithImpl(this._self, this._then);

  final CircleMembers _self;
  final $Res Function(CircleMembers) _then;

/// Create a copy of CircleMembers
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? members = null,Object? owner = freezed,}) {
  return _then(_self.copyWith(
members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<CircleMember>,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as CircleUserRef?,
  ));
}
/// Create a copy of CircleMembers
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleUserRefCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $CircleUserRefCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}


/// Adds pattern-matching-related methods to [CircleMembers].
extension CircleMembersPatterns on CircleMembers {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleMembers value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleMembers() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleMembers value)  $default,){
final _that = this;
switch (_that) {
case _CircleMembers():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleMembers value)?  $default,){
final _that = this;
switch (_that) {
case _CircleMembers() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CircleMember> members,  CircleUserRef? owner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleMembers() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CircleMember> members,  CircleUserRef? owner)  $default,) {final _that = this;
switch (_that) {
case _CircleMembers():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CircleMember> members,  CircleUserRef? owner)?  $default,) {final _that = this;
switch (_that) {
case _CircleMembers() when $default != null:
return $default(_that.members,_that.owner);case _:
  return null;

}
}

}

/// @nodoc


class _CircleMembers implements CircleMembers {
  const _CircleMembers({required final  List<CircleMember> members, this.owner}): _members = members;
  

 final  List<CircleMember> _members;
@override List<CircleMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override final  CircleUserRef? owner;

/// Create a copy of CircleMembers
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleMembersCopyWith<_CircleMembers> get copyWith => __$CircleMembersCopyWithImpl<_CircleMembers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleMembers&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.owner, owner) || other.owner == owner));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_members),owner);

@override
String toString() {
  return 'CircleMembers(members: $members, owner: $owner)';
}


}

/// @nodoc
abstract mixin class _$CircleMembersCopyWith<$Res> implements $CircleMembersCopyWith<$Res> {
  factory _$CircleMembersCopyWith(_CircleMembers value, $Res Function(_CircleMembers) _then) = __$CircleMembersCopyWithImpl;
@override @useResult
$Res call({
 List<CircleMember> members, CircleUserRef? owner
});


@override $CircleUserRefCopyWith<$Res>? get owner;

}
/// @nodoc
class __$CircleMembersCopyWithImpl<$Res>
    implements _$CircleMembersCopyWith<$Res> {
  __$CircleMembersCopyWithImpl(this._self, this._then);

  final _CircleMembers _self;
  final $Res Function(_CircleMembers) _then;

/// Create a copy of CircleMembers
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? members = null,Object? owner = freezed,}) {
  return _then(_CircleMembers(
members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<CircleMember>,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as CircleUserRef?,
  ));
}

/// Create a copy of CircleMembers
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleUserRefCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $CircleUserRefCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}

// dart format on
