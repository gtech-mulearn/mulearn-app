// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ig_related.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IgCircleRef {

 String get id; String get title; int? get totalMembers;
/// Create a copy of IgCircleRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IgCircleRefCopyWith<IgCircleRef> get copyWith => _$IgCircleRefCopyWithImpl<IgCircleRef>(this as IgCircleRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IgCircleRef&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,totalMembers);

@override
String toString() {
  return 'IgCircleRef(id: $id, title: $title, totalMembers: $totalMembers)';
}


}

/// @nodoc
abstract mixin class $IgCircleRefCopyWith<$Res>  {
  factory $IgCircleRefCopyWith(IgCircleRef value, $Res Function(IgCircleRef) _then) = _$IgCircleRefCopyWithImpl;
@useResult
$Res call({
 String id, String title, int? totalMembers
});




}
/// @nodoc
class _$IgCircleRefCopyWithImpl<$Res>
    implements $IgCircleRefCopyWith<$Res> {
  _$IgCircleRefCopyWithImpl(this._self, this._then);

  final IgCircleRef _self;
  final $Res Function(IgCircleRef) _then;

/// Create a copy of IgCircleRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? totalMembers = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalMembers: freezed == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [IgCircleRef].
extension IgCircleRefPatterns on IgCircleRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IgCircleRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IgCircleRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IgCircleRef value)  $default,){
final _that = this;
switch (_that) {
case _IgCircleRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IgCircleRef value)?  $default,){
final _that = this;
switch (_that) {
case _IgCircleRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int? totalMembers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IgCircleRef() when $default != null:
return $default(_that.id,_that.title,_that.totalMembers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int? totalMembers)  $default,) {final _that = this;
switch (_that) {
case _IgCircleRef():
return $default(_that.id,_that.title,_that.totalMembers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int? totalMembers)?  $default,) {final _that = this;
switch (_that) {
case _IgCircleRef() when $default != null:
return $default(_that.id,_that.title,_that.totalMembers);case _:
  return null;

}
}

}

/// @nodoc


class _IgCircleRef implements IgCircleRef {
  const _IgCircleRef({required this.id, required this.title, this.totalMembers});
  

@override final  String id;
@override final  String title;
@override final  int? totalMembers;

/// Create a copy of IgCircleRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IgCircleRefCopyWith<_IgCircleRef> get copyWith => __$IgCircleRefCopyWithImpl<_IgCircleRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IgCircleRef&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,totalMembers);

@override
String toString() {
  return 'IgCircleRef(id: $id, title: $title, totalMembers: $totalMembers)';
}


}

/// @nodoc
abstract mixin class _$IgCircleRefCopyWith<$Res> implements $IgCircleRefCopyWith<$Res> {
  factory _$IgCircleRefCopyWith(_IgCircleRef value, $Res Function(_IgCircleRef) _then) = __$IgCircleRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int? totalMembers
});




}
/// @nodoc
class __$IgCircleRefCopyWithImpl<$Res>
    implements _$IgCircleRefCopyWith<$Res> {
  __$IgCircleRefCopyWithImpl(this._self, this._then);

  final _IgCircleRef _self;
  final $Res Function(_IgCircleRef) _then;

/// Create a copy of IgCircleRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? totalMembers = freezed,}) {
  return _then(_IgCircleRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalMembers: freezed == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$IgEventRef {

 String get id; String get title; DateTime? get startsAt;
/// Create a copy of IgEventRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IgEventRefCopyWith<IgEventRef> get copyWith => _$IgEventRefCopyWithImpl<IgEventRef>(this as IgEventRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IgEventRef&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt);

@override
String toString() {
  return 'IgEventRef(id: $id, title: $title, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class $IgEventRefCopyWith<$Res>  {
  factory $IgEventRefCopyWith(IgEventRef value, $Res Function(IgEventRef) _then) = _$IgEventRefCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime? startsAt
});




}
/// @nodoc
class _$IgEventRefCopyWithImpl<$Res>
    implements $IgEventRefCopyWith<$Res> {
  _$IgEventRefCopyWithImpl(this._self, this._then);

  final IgEventRef _self;
  final $Res Function(IgEventRef) _then;

/// Create a copy of IgEventRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [IgEventRef].
extension IgEventRefPatterns on IgEventRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IgEventRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IgEventRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IgEventRef value)  $default,){
final _that = this;
switch (_that) {
case _IgEventRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IgEventRef value)?  $default,){
final _that = this;
switch (_that) {
case _IgEventRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime? startsAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IgEventRef() when $default != null:
return $default(_that.id,_that.title,_that.startsAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime? startsAt)  $default,) {final _that = this;
switch (_that) {
case _IgEventRef():
return $default(_that.id,_that.title,_that.startsAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime? startsAt)?  $default,) {final _that = this;
switch (_that) {
case _IgEventRef() when $default != null:
return $default(_that.id,_that.title,_that.startsAt);case _:
  return null;

}
}

}

/// @nodoc


class _IgEventRef implements IgEventRef {
  const _IgEventRef({required this.id, required this.title, this.startsAt});
  

@override final  String id;
@override final  String title;
@override final  DateTime? startsAt;

/// Create a copy of IgEventRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IgEventRefCopyWith<_IgEventRef> get copyWith => __$IgEventRefCopyWithImpl<_IgEventRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IgEventRef&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt);

@override
String toString() {
  return 'IgEventRef(id: $id, title: $title, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class _$IgEventRefCopyWith<$Res> implements $IgEventRefCopyWith<$Res> {
  factory _$IgEventRefCopyWith(_IgEventRef value, $Res Function(_IgEventRef) _then) = __$IgEventRefCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime? startsAt
});




}
/// @nodoc
class __$IgEventRefCopyWithImpl<$Res>
    implements _$IgEventRefCopyWith<$Res> {
  __$IgEventRefCopyWithImpl(this._self, this._then);

  final _IgEventRef _self;
  final $Res Function(_IgEventRef) _then;

/// Create a copy of IgEventRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,}) {
  return _then(_IgEventRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
