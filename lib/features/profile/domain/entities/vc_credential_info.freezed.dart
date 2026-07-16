// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vc_credential_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VcCredentialInfo {

 String get courseName; String get name; String get description; List<String> get tags;
/// Create a copy of VcCredentialInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VcCredentialInfoCopyWith<VcCredentialInfo> get copyWith => _$VcCredentialInfoCopyWithImpl<VcCredentialInfo>(this as VcCredentialInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VcCredentialInfo&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,courseName,name,description,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'VcCredentialInfo(courseName: $courseName, name: $name, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $VcCredentialInfoCopyWith<$Res>  {
  factory $VcCredentialInfoCopyWith(VcCredentialInfo value, $Res Function(VcCredentialInfo) _then) = _$VcCredentialInfoCopyWithImpl;
@useResult
$Res call({
 String courseName, String name, String description, List<String> tags
});




}
/// @nodoc
class _$VcCredentialInfoCopyWithImpl<$Res>
    implements $VcCredentialInfoCopyWith<$Res> {
  _$VcCredentialInfoCopyWithImpl(this._self, this._then);

  final VcCredentialInfo _self;
  final $Res Function(VcCredentialInfo) _then;

/// Create a copy of VcCredentialInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseName = null,Object? name = null,Object? description = null,Object? tags = null,}) {
  return _then(_self.copyWith(
courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [VcCredentialInfo].
extension VcCredentialInfoPatterns on VcCredentialInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VcCredentialInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VcCredentialInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VcCredentialInfo value)  $default,){
final _that = this;
switch (_that) {
case _VcCredentialInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VcCredentialInfo value)?  $default,){
final _that = this;
switch (_that) {
case _VcCredentialInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseName,  String name,  String description,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VcCredentialInfo() when $default != null:
return $default(_that.courseName,_that.name,_that.description,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseName,  String name,  String description,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _VcCredentialInfo():
return $default(_that.courseName,_that.name,_that.description,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseName,  String name,  String description,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _VcCredentialInfo() when $default != null:
return $default(_that.courseName,_that.name,_that.description,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _VcCredentialInfo implements VcCredentialInfo {
  const _VcCredentialInfo({required this.courseName, required this.name, required this.description, final  List<String> tags = const []}): _tags = tags;
  

@override final  String courseName;
@override final  String name;
@override final  String description;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of VcCredentialInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VcCredentialInfoCopyWith<_VcCredentialInfo> get copyWith => __$VcCredentialInfoCopyWithImpl<_VcCredentialInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VcCredentialInfo&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,courseName,name,description,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'VcCredentialInfo(courseName: $courseName, name: $name, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$VcCredentialInfoCopyWith<$Res> implements $VcCredentialInfoCopyWith<$Res> {
  factory _$VcCredentialInfoCopyWith(_VcCredentialInfo value, $Res Function(_VcCredentialInfo) _then) = __$VcCredentialInfoCopyWithImpl;
@override @useResult
$Res call({
 String courseName, String name, String description, List<String> tags
});




}
/// @nodoc
class __$VcCredentialInfoCopyWithImpl<$Res>
    implements _$VcCredentialInfoCopyWith<$Res> {
  __$VcCredentialInfoCopyWithImpl(this._self, this._then);

  final _VcCredentialInfo _self;
  final $Res Function(_VcCredentialInfo) _then;

/// Create a copy of VcCredentialInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseName = null,Object? name = null,Object? description = null,Object? tags = null,}) {
  return _then(_VcCredentialInfo(
courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
