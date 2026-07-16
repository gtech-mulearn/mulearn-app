// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSearchPage {

 List<UserSearchResult> get results; int get pageIndex; int get totalPages;
/// Create a copy of UserSearchPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchPageCopyWith<UserSearchPage> get copyWith => _$UserSearchPageCopyWithImpl<UserSearchPage>(this as UserSearchPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchPage&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results),pageIndex,totalPages);

@override
String toString() {
  return 'UserSearchPage(results: $results, pageIndex: $pageIndex, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $UserSearchPageCopyWith<$Res>  {
  factory $UserSearchPageCopyWith(UserSearchPage value, $Res Function(UserSearchPage) _then) = _$UserSearchPageCopyWithImpl;
@useResult
$Res call({
 List<UserSearchResult> results, int pageIndex, int totalPages
});




}
/// @nodoc
class _$UserSearchPageCopyWithImpl<$Res>
    implements $UserSearchPageCopyWith<$Res> {
  _$UserSearchPageCopyWithImpl(this._self, this._then);

  final UserSearchPage _self;
  final $Res Function(UserSearchPage) _then;

/// Create a copy of UserSearchPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,Object? pageIndex = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<UserSearchResult>,pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchPage].
extension UserSearchPagePatterns on UserSearchPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchPage value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchPage value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserSearchResult> results,  int pageIndex,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchPage() when $default != null:
return $default(_that.results,_that.pageIndex,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserSearchResult> results,  int pageIndex,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _UserSearchPage():
return $default(_that.results,_that.pageIndex,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserSearchResult> results,  int pageIndex,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchPage() when $default != null:
return $default(_that.results,_that.pageIndex,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc


class _UserSearchPage extends UserSearchPage {
  const _UserSearchPage({required final  List<UserSearchResult> results, required this.pageIndex, required this.totalPages}): _results = results,super._();
  

 final  List<UserSearchResult> _results;
@override List<UserSearchResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  int pageIndex;
@override final  int totalPages;

/// Create a copy of UserSearchPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchPageCopyWith<_UserSearchPage> get copyWith => __$UserSearchPageCopyWithImpl<_UserSearchPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchPage&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),pageIndex,totalPages);

@override
String toString() {
  return 'UserSearchPage(results: $results, pageIndex: $pageIndex, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$UserSearchPageCopyWith<$Res> implements $UserSearchPageCopyWith<$Res> {
  factory _$UserSearchPageCopyWith(_UserSearchPage value, $Res Function(_UserSearchPage) _then) = __$UserSearchPageCopyWithImpl;
@override @useResult
$Res call({
 List<UserSearchResult> results, int pageIndex, int totalPages
});




}
/// @nodoc
class __$UserSearchPageCopyWithImpl<$Res>
    implements _$UserSearchPageCopyWith<$Res> {
  __$UserSearchPageCopyWithImpl(this._self, this._then);

  final _UserSearchPage _self;
  final $Res Function(_UserSearchPage) _then;

/// Create a copy of UserSearchPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,Object? pageIndex = null,Object? totalPages = null,}) {
  return _then(_UserSearchPage(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<UserSearchResult>,pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
