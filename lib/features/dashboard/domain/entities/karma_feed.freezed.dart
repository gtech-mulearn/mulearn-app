// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'karma_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KarmaFeed {

 KarmaFeedTopUser? get topUser; KarmaFeedTopCollege? get topCollege;
/// Create a copy of KarmaFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KarmaFeedCopyWith<KarmaFeed> get copyWith => _$KarmaFeedCopyWithImpl<KarmaFeed>(this as KarmaFeed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KarmaFeed&&(identical(other.topUser, topUser) || other.topUser == topUser)&&(identical(other.topCollege, topCollege) || other.topCollege == topCollege));
}


@override
int get hashCode => Object.hash(runtimeType,topUser,topCollege);

@override
String toString() {
  return 'KarmaFeed(topUser: $topUser, topCollege: $topCollege)';
}


}

/// @nodoc
abstract mixin class $KarmaFeedCopyWith<$Res>  {
  factory $KarmaFeedCopyWith(KarmaFeed value, $Res Function(KarmaFeed) _then) = _$KarmaFeedCopyWithImpl;
@useResult
$Res call({
 KarmaFeedTopUser? topUser, KarmaFeedTopCollege? topCollege
});


$KarmaFeedTopUserCopyWith<$Res>? get topUser;$KarmaFeedTopCollegeCopyWith<$Res>? get topCollege;

}
/// @nodoc
class _$KarmaFeedCopyWithImpl<$Res>
    implements $KarmaFeedCopyWith<$Res> {
  _$KarmaFeedCopyWithImpl(this._self, this._then);

  final KarmaFeed _self;
  final $Res Function(KarmaFeed) _then;

/// Create a copy of KarmaFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topUser = freezed,Object? topCollege = freezed,}) {
  return _then(_self.copyWith(
topUser: freezed == topUser ? _self.topUser : topUser // ignore: cast_nullable_to_non_nullable
as KarmaFeedTopUser?,topCollege: freezed == topCollege ? _self.topCollege : topCollege // ignore: cast_nullable_to_non_nullable
as KarmaFeedTopCollege?,
  ));
}
/// Create a copy of KarmaFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KarmaFeedTopUserCopyWith<$Res>? get topUser {
    if (_self.topUser == null) {
    return null;
  }

  return $KarmaFeedTopUserCopyWith<$Res>(_self.topUser!, (value) {
    return _then(_self.copyWith(topUser: value));
  });
}/// Create a copy of KarmaFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KarmaFeedTopCollegeCopyWith<$Res>? get topCollege {
    if (_self.topCollege == null) {
    return null;
  }

  return $KarmaFeedTopCollegeCopyWith<$Res>(_self.topCollege!, (value) {
    return _then(_self.copyWith(topCollege: value));
  });
}
}


/// Adds pattern-matching-related methods to [KarmaFeed].
extension KarmaFeedPatterns on KarmaFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KarmaFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KarmaFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KarmaFeed value)  $default,){
final _that = this;
switch (_that) {
case _KarmaFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KarmaFeed value)?  $default,){
final _that = this;
switch (_that) {
case _KarmaFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KarmaFeedTopUser? topUser,  KarmaFeedTopCollege? topCollege)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KarmaFeed() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KarmaFeedTopUser? topUser,  KarmaFeedTopCollege? topCollege)  $default,) {final _that = this;
switch (_that) {
case _KarmaFeed():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KarmaFeedTopUser? topUser,  KarmaFeedTopCollege? topCollege)?  $default,) {final _that = this;
switch (_that) {
case _KarmaFeed() when $default != null:
return $default(_that.topUser,_that.topCollege);case _:
  return null;

}
}

}

/// @nodoc


class _KarmaFeed implements KarmaFeed {
  const _KarmaFeed({this.topUser, this.topCollege});
  

@override final  KarmaFeedTopUser? topUser;
@override final  KarmaFeedTopCollege? topCollege;

/// Create a copy of KarmaFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KarmaFeedCopyWith<_KarmaFeed> get copyWith => __$KarmaFeedCopyWithImpl<_KarmaFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KarmaFeed&&(identical(other.topUser, topUser) || other.topUser == topUser)&&(identical(other.topCollege, topCollege) || other.topCollege == topCollege));
}


@override
int get hashCode => Object.hash(runtimeType,topUser,topCollege);

@override
String toString() {
  return 'KarmaFeed(topUser: $topUser, topCollege: $topCollege)';
}


}

/// @nodoc
abstract mixin class _$KarmaFeedCopyWith<$Res> implements $KarmaFeedCopyWith<$Res> {
  factory _$KarmaFeedCopyWith(_KarmaFeed value, $Res Function(_KarmaFeed) _then) = __$KarmaFeedCopyWithImpl;
@override @useResult
$Res call({
 KarmaFeedTopUser? topUser, KarmaFeedTopCollege? topCollege
});


@override $KarmaFeedTopUserCopyWith<$Res>? get topUser;@override $KarmaFeedTopCollegeCopyWith<$Res>? get topCollege;

}
/// @nodoc
class __$KarmaFeedCopyWithImpl<$Res>
    implements _$KarmaFeedCopyWith<$Res> {
  __$KarmaFeedCopyWithImpl(this._self, this._then);

  final _KarmaFeed _self;
  final $Res Function(_KarmaFeed) _then;

/// Create a copy of KarmaFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topUser = freezed,Object? topCollege = freezed,}) {
  return _then(_KarmaFeed(
topUser: freezed == topUser ? _self.topUser : topUser // ignore: cast_nullable_to_non_nullable
as KarmaFeedTopUser?,topCollege: freezed == topCollege ? _self.topCollege : topCollege // ignore: cast_nullable_to_non_nullable
as KarmaFeedTopCollege?,
  ));
}

/// Create a copy of KarmaFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KarmaFeedTopUserCopyWith<$Res>? get topUser {
    if (_self.topUser == null) {
    return null;
  }

  return $KarmaFeedTopUserCopyWith<$Res>(_self.topUser!, (value) {
    return _then(_self.copyWith(topUser: value));
  });
}/// Create a copy of KarmaFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KarmaFeedTopCollegeCopyWith<$Res>? get topCollege {
    if (_self.topCollege == null) {
    return null;
  }

  return $KarmaFeedTopCollegeCopyWith<$Res>(_self.topCollege!, (value) {
    return _then(_self.copyWith(topCollege: value));
  });
}
}

// dart format on
