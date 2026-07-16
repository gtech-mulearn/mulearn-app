// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interest_group_list_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterestGroupListItemDto {

 String get id; String get name; String? get category;
/// Create a copy of InterestGroupListItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterestGroupListItemDtoCopyWith<InterestGroupListItemDto> get copyWith => _$InterestGroupListItemDtoCopyWithImpl<InterestGroupListItemDto>(this as InterestGroupListItemDto, _$identity);

  /// Serializes this InterestGroupListItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterestGroupListItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category);

@override
String toString() {
  return 'InterestGroupListItemDto(id: $id, name: $name, category: $category)';
}


}

/// @nodoc
abstract mixin class $InterestGroupListItemDtoCopyWith<$Res>  {
  factory $InterestGroupListItemDtoCopyWith(InterestGroupListItemDto value, $Res Function(InterestGroupListItemDto) _then) = _$InterestGroupListItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? category
});




}
/// @nodoc
class _$InterestGroupListItemDtoCopyWithImpl<$Res>
    implements $InterestGroupListItemDtoCopyWith<$Res> {
  _$InterestGroupListItemDtoCopyWithImpl(this._self, this._then);

  final InterestGroupListItemDto _self;
  final $Res Function(InterestGroupListItemDto) _then;

/// Create a copy of InterestGroupListItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InterestGroupListItemDto].
extension InterestGroupListItemDtoPatterns on InterestGroupListItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterestGroupListItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterestGroupListItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterestGroupListItemDto value)  $default,){
final _that = this;
switch (_that) {
case _InterestGroupListItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterestGroupListItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _InterestGroupListItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterestGroupListItemDto() when $default != null:
return $default(_that.id,_that.name,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? category)  $default,) {final _that = this;
switch (_that) {
case _InterestGroupListItemDto():
return $default(_that.id,_that.name,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? category)?  $default,) {final _that = this;
switch (_that) {
case _InterestGroupListItemDto() when $default != null:
return $default(_that.id,_that.name,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterestGroupListItemDto extends InterestGroupListItemDto {
  const _InterestGroupListItemDto({required this.id, required this.name, this.category}): super._();
  factory _InterestGroupListItemDto.fromJson(Map<String, dynamic> json) => _$InterestGroupListItemDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? category;

/// Create a copy of InterestGroupListItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterestGroupListItemDtoCopyWith<_InterestGroupListItemDto> get copyWith => __$InterestGroupListItemDtoCopyWithImpl<_InterestGroupListItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterestGroupListItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterestGroupListItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category);

@override
String toString() {
  return 'InterestGroupListItemDto(id: $id, name: $name, category: $category)';
}


}

/// @nodoc
abstract mixin class _$InterestGroupListItemDtoCopyWith<$Res> implements $InterestGroupListItemDtoCopyWith<$Res> {
  factory _$InterestGroupListItemDtoCopyWith(_InterestGroupListItemDto value, $Res Function(_InterestGroupListItemDto) _then) = __$InterestGroupListItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? category
});




}
/// @nodoc
class __$InterestGroupListItemDtoCopyWithImpl<$Res>
    implements _$InterestGroupListItemDtoCopyWith<$Res> {
  __$InterestGroupListItemDtoCopyWithImpl(this._self, this._then);

  final _InterestGroupListItemDto _self;
  final $Res Function(_InterestGroupListItemDto) _then;

/// Create a copy of InterestGroupListItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = freezed,}) {
  return _then(_InterestGroupListItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
