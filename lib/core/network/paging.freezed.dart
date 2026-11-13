// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PageInfo {

 bool get hasNext; int get totalPages; int get count;
/// Create a copy of PageInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageInfoCopyWith<PageInfo> get copyWith => _$PageInfoCopyWithImpl<PageInfo>(this as PageInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageInfo&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,hasNext,totalPages,count);

@override
String toString() {
  return 'PageInfo(hasNext: $hasNext, totalPages: $totalPages, count: $count)';
}


}

/// @nodoc
abstract mixin class $PageInfoCopyWith<$Res>  {
  factory $PageInfoCopyWith(PageInfo value, $Res Function(PageInfo) _then) = _$PageInfoCopyWithImpl;
@useResult
$Res call({
 bool hasNext, int totalPages, int count
});




}
/// @nodoc
class _$PageInfoCopyWithImpl<$Res>
    implements $PageInfoCopyWith<$Res> {
  _$PageInfoCopyWithImpl(this._self, this._then);

  final PageInfo _self;
  final $Res Function(PageInfo) _then;

/// Create a copy of PageInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasNext = null,Object? totalPages = null,Object? count = null,}) {
  return _then(_self.copyWith(
hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PageInfo].
extension PageInfoPatterns on PageInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageInfo value)  $default,){
final _that = this;
switch (_that) {
case _PageInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PageInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasNext,  int totalPages,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageInfo() when $default != null:
return $default(_that.hasNext,_that.totalPages,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasNext,  int totalPages,  int count)  $default,) {final _that = this;
switch (_that) {
case _PageInfo():
return $default(_that.hasNext,_that.totalPages,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasNext,  int totalPages,  int count)?  $default,) {final _that = this;
switch (_that) {
case _PageInfo() when $default != null:
return $default(_that.hasNext,_that.totalPages,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _PageInfo implements PageInfo {
  const _PageInfo({required this.hasNext, required this.totalPages, required this.count});
  

@override final  bool hasNext;
@override final  int totalPages;
@override final  int count;

/// Create a copy of PageInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageInfoCopyWith<_PageInfo> get copyWith => __$PageInfoCopyWithImpl<_PageInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageInfo&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,hasNext,totalPages,count);

@override
String toString() {
  return 'PageInfo(hasNext: $hasNext, totalPages: $totalPages, count: $count)';
}


}

/// @nodoc
abstract mixin class _$PageInfoCopyWith<$Res> implements $PageInfoCopyWith<$Res> {
  factory _$PageInfoCopyWith(_PageInfo value, $Res Function(_PageInfo) _then) = __$PageInfoCopyWithImpl;
@override @useResult
$Res call({
 bool hasNext, int totalPages, int count
});




}
/// @nodoc
class __$PageInfoCopyWithImpl<$Res>
    implements _$PageInfoCopyWith<$Res> {
  __$PageInfoCopyWithImpl(this._self, this._then);

  final _PageInfo _self;
  final $Res Function(_PageInfo) _then;

/// Create a copy of PageInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasNext = null,Object? totalPages = null,Object? count = null,}) {
  return _then(_PageInfo(
hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PagedState<T> {

 List<T> get items; bool get hasMore; bool get isLoadingMore; Object? get loadMoreError;
/// Create a copy of PagedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedStateCopyWith<T, PagedState<T>> get copyWith => _$PagedStateCopyWithImpl<T, PagedState<T>>(this as PagedState<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedState<T>&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.loadMoreError, loadMoreError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),hasMore,isLoadingMore,const DeepCollectionEquality().hash(loadMoreError));

@override
String toString() {
  return 'PagedState<$T>(items: $items, hasMore: $hasMore, isLoadingMore: $isLoadingMore, loadMoreError: $loadMoreError)';
}


}

/// @nodoc
abstract mixin class $PagedStateCopyWith<T,$Res>  {
  factory $PagedStateCopyWith(PagedState<T> value, $Res Function(PagedState<T>) _then) = _$PagedStateCopyWithImpl;
@useResult
$Res call({
 List<T> items, bool hasMore, bool isLoadingMore, Object? loadMoreError
});




}
/// @nodoc
class _$PagedStateCopyWithImpl<T,$Res>
    implements $PagedStateCopyWith<T, $Res> {
  _$PagedStateCopyWithImpl(this._self, this._then);

  final PagedState<T> _self;
  final $Res Function(PagedState<T>) _then;

/// Create a copy of PagedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? hasMore = null,Object? isLoadingMore = null,Object? loadMoreError = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,loadMoreError: freezed == loadMoreError ? _self.loadMoreError : loadMoreError ,
  ));
}

}


/// Adds pattern-matching-related methods to [PagedState].
extension PagedStatePatterns<T> on PagedState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagedState<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagedState<T> value)  $default,){
final _that = this;
switch (_that) {
case _PagedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagedState<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PagedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> items,  bool hasMore,  bool isLoadingMore,  Object? loadMoreError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagedState() when $default != null:
return $default(_that.items,_that.hasMore,_that.isLoadingMore,_that.loadMoreError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> items,  bool hasMore,  bool isLoadingMore,  Object? loadMoreError)  $default,) {final _that = this;
switch (_that) {
case _PagedState():
return $default(_that.items,_that.hasMore,_that.isLoadingMore,_that.loadMoreError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> items,  bool hasMore,  bool isLoadingMore,  Object? loadMoreError)?  $default,) {final _that = this;
switch (_that) {
case _PagedState() when $default != null:
return $default(_that.items,_that.hasMore,_that.isLoadingMore,_that.loadMoreError);case _:
  return null;

}
}

}

/// @nodoc


class _PagedState<T> implements PagedState<T> {
  const _PagedState({required final  List<T> items, required this.hasMore, this.isLoadingMore = false, this.loadMoreError}): _items = items;
  

 final  List<T> _items;
@override List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
@override final  Object? loadMoreError;

/// Create a copy of PagedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedStateCopyWith<T, _PagedState<T>> get copyWith => __$PagedStateCopyWithImpl<T, _PagedState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedState<T>&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.loadMoreError, loadMoreError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),hasMore,isLoadingMore,const DeepCollectionEquality().hash(loadMoreError));

@override
String toString() {
  return 'PagedState<$T>(items: $items, hasMore: $hasMore, isLoadingMore: $isLoadingMore, loadMoreError: $loadMoreError)';
}


}

/// @nodoc
abstract mixin class _$PagedStateCopyWith<T,$Res> implements $PagedStateCopyWith<T, $Res> {
  factory _$PagedStateCopyWith(_PagedState<T> value, $Res Function(_PagedState<T>) _then) = __$PagedStateCopyWithImpl;
@override @useResult
$Res call({
 List<T> items, bool hasMore, bool isLoadingMore, Object? loadMoreError
});




}
/// @nodoc
class __$PagedStateCopyWithImpl<T,$Res>
    implements _$PagedStateCopyWith<T, $Res> {
  __$PagedStateCopyWithImpl(this._self, this._then);

  final _PagedState<T> _self;
  final $Res Function(_PagedState<T>) _then;

/// Create a copy of PagedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? hasMore = null,Object? isLoadingMore = null,Object? loadMoreError = freezed,}) {
  return _then(_PagedState<T>(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,loadMoreError: freezed == loadMoreError ? _self.loadMoreError : loadMoreError ,
  ));
}


}

// dart format on
