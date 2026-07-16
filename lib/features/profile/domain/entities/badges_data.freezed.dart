// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badges_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BadgesData {

 String get fullName; List<String> get completedTasks;
/// Create a copy of BadgesData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadgesDataCopyWith<BadgesData> get copyWith => _$BadgesDataCopyWithImpl<BadgesData>(this as BadgesData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadgesData&&(identical(other.fullName, fullName) || other.fullName == fullName)&&const DeepCollectionEquality().equals(other.completedTasks, completedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,const DeepCollectionEquality().hash(completedTasks));

@override
String toString() {
  return 'BadgesData(fullName: $fullName, completedTasks: $completedTasks)';
}


}

/// @nodoc
abstract mixin class $BadgesDataCopyWith<$Res>  {
  factory $BadgesDataCopyWith(BadgesData value, $Res Function(BadgesData) _then) = _$BadgesDataCopyWithImpl;
@useResult
$Res call({
 String fullName, List<String> completedTasks
});




}
/// @nodoc
class _$BadgesDataCopyWithImpl<$Res>
    implements $BadgesDataCopyWith<$Res> {
  _$BadgesDataCopyWithImpl(this._self, this._then);

  final BadgesData _self;
  final $Res Function(BadgesData) _then;

/// Create a copy of BadgesData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? completedTasks = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BadgesData].
extension BadgesDataPatterns on BadgesData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BadgesData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BadgesData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BadgesData value)  $default,){
final _that = this;
switch (_that) {
case _BadgesData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BadgesData value)?  $default,){
final _that = this;
switch (_that) {
case _BadgesData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  List<String> completedTasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BadgesData() when $default != null:
return $default(_that.fullName,_that.completedTasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  List<String> completedTasks)  $default,) {final _that = this;
switch (_that) {
case _BadgesData():
return $default(_that.fullName,_that.completedTasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  List<String> completedTasks)?  $default,) {final _that = this;
switch (_that) {
case _BadgesData() when $default != null:
return $default(_that.fullName,_that.completedTasks);case _:
  return null;

}
}

}

/// @nodoc


class _BadgesData implements BadgesData {
  const _BadgesData({required this.fullName, final  List<String> completedTasks = const []}): _completedTasks = completedTasks;
  

@override final  String fullName;
 final  List<String> _completedTasks;
@override@JsonKey() List<String> get completedTasks {
  if (_completedTasks is EqualUnmodifiableListView) return _completedTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedTasks);
}


/// Create a copy of BadgesData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BadgesDataCopyWith<_BadgesData> get copyWith => __$BadgesDataCopyWithImpl<_BadgesData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BadgesData&&(identical(other.fullName, fullName) || other.fullName == fullName)&&const DeepCollectionEquality().equals(other._completedTasks, _completedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,const DeepCollectionEquality().hash(_completedTasks));

@override
String toString() {
  return 'BadgesData(fullName: $fullName, completedTasks: $completedTasks)';
}


}

/// @nodoc
abstract mixin class _$BadgesDataCopyWith<$Res> implements $BadgesDataCopyWith<$Res> {
  factory _$BadgesDataCopyWith(_BadgesData value, $Res Function(_BadgesData) _then) = __$BadgesDataCopyWithImpl;
@override @useResult
$Res call({
 String fullName, List<String> completedTasks
});




}
/// @nodoc
class __$BadgesDataCopyWithImpl<$Res>
    implements _$BadgesDataCopyWith<$Res> {
  __$BadgesDataCopyWithImpl(this._self, this._then);

  final _BadgesData _self;
  final $Res Function(_BadgesData) _then;

/// Create a copy of BadgesData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? completedTasks = null,}) {
  return _then(_BadgesData(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,completedTasks: null == completedTasks ? _self._completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
