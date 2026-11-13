// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeetingPage {

 List<Meeting> get meetings; bool get hasNext;
/// Create a copy of MeetingPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingPageCopyWith<MeetingPage> get copyWith => _$MeetingPageCopyWithImpl<MeetingPage>(this as MeetingPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingPage&&const DeepCollectionEquality().equals(other.meetings, meetings)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(meetings),hasNext);

@override
String toString() {
  return 'MeetingPage(meetings: $meetings, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class $MeetingPageCopyWith<$Res>  {
  factory $MeetingPageCopyWith(MeetingPage value, $Res Function(MeetingPage) _then) = _$MeetingPageCopyWithImpl;
@useResult
$Res call({
 List<Meeting> meetings, bool hasNext
});




}
/// @nodoc
class _$MeetingPageCopyWithImpl<$Res>
    implements $MeetingPageCopyWith<$Res> {
  _$MeetingPageCopyWithImpl(this._self, this._then);

  final MeetingPage _self;
  final $Res Function(MeetingPage) _then;

/// Create a copy of MeetingPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetings = null,Object? hasNext = null,}) {
  return _then(_self.copyWith(
meetings: null == meetings ? _self.meetings : meetings // ignore: cast_nullable_to_non_nullable
as List<Meeting>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingPage].
extension MeetingPagePatterns on MeetingPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingPage value)  $default,){
final _that = this;
switch (_that) {
case _MeetingPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingPage value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Meeting> meetings,  bool hasNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingPage() when $default != null:
return $default(_that.meetings,_that.hasNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Meeting> meetings,  bool hasNext)  $default,) {final _that = this;
switch (_that) {
case _MeetingPage():
return $default(_that.meetings,_that.hasNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Meeting> meetings,  bool hasNext)?  $default,) {final _that = this;
switch (_that) {
case _MeetingPage() when $default != null:
return $default(_that.meetings,_that.hasNext);case _:
  return null;

}
}

}

/// @nodoc


class _MeetingPage implements MeetingPage {
  const _MeetingPage({required final  List<Meeting> meetings, required this.hasNext}): _meetings = meetings;
  

 final  List<Meeting> _meetings;
@override List<Meeting> get meetings {
  if (_meetings is EqualUnmodifiableListView) return _meetings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meetings);
}

@override final  bool hasNext;

/// Create a copy of MeetingPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingPageCopyWith<_MeetingPage> get copyWith => __$MeetingPageCopyWithImpl<_MeetingPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingPage&&const DeepCollectionEquality().equals(other._meetings, _meetings)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_meetings),hasNext);

@override
String toString() {
  return 'MeetingPage(meetings: $meetings, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class _$MeetingPageCopyWith<$Res> implements $MeetingPageCopyWith<$Res> {
  factory _$MeetingPageCopyWith(_MeetingPage value, $Res Function(_MeetingPage) _then) = __$MeetingPageCopyWithImpl;
@override @useResult
$Res call({
 List<Meeting> meetings, bool hasNext
});




}
/// @nodoc
class __$MeetingPageCopyWithImpl<$Res>
    implements _$MeetingPageCopyWith<$Res> {
  __$MeetingPageCopyWithImpl(this._self, this._then);

  final _MeetingPage _self;
  final $Res Function(_MeetingPage) _then;

/// Create a copy of MeetingPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetings = null,Object? hasNext = null,}) {
  return _then(_MeetingPage(
meetings: null == meetings ? _self._meetings : meetings // ignore: cast_nullable_to_non_nullable
as List<Meeting>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
