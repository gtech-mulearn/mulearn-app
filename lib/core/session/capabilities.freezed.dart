// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capabilities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Capabilities {

 bool get isLearner; bool get isMentor; bool get isMentorApproved; bool get isEnabler; bool get isCampusLead; bool get isCompany; bool get needsDiscord;
/// Create a copy of Capabilities
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapabilitiesCopyWith<Capabilities> get copyWith => _$CapabilitiesCopyWithImpl<Capabilities>(this as Capabilities, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Capabilities&&(identical(other.isLearner, isLearner) || other.isLearner == isLearner)&&(identical(other.isMentor, isMentor) || other.isMentor == isMentor)&&(identical(other.isMentorApproved, isMentorApproved) || other.isMentorApproved == isMentorApproved)&&(identical(other.isEnabler, isEnabler) || other.isEnabler == isEnabler)&&(identical(other.isCampusLead, isCampusLead) || other.isCampusLead == isCampusLead)&&(identical(other.isCompany, isCompany) || other.isCompany == isCompany)&&(identical(other.needsDiscord, needsDiscord) || other.needsDiscord == needsDiscord));
}


@override
int get hashCode => Object.hash(runtimeType,isLearner,isMentor,isMentorApproved,isEnabler,isCampusLead,isCompany,needsDiscord);

@override
String toString() {
  return 'Capabilities(isLearner: $isLearner, isMentor: $isMentor, isMentorApproved: $isMentorApproved, isEnabler: $isEnabler, isCampusLead: $isCampusLead, isCompany: $isCompany, needsDiscord: $needsDiscord)';
}


}

/// @nodoc
abstract mixin class $CapabilitiesCopyWith<$Res>  {
  factory $CapabilitiesCopyWith(Capabilities value, $Res Function(Capabilities) _then) = _$CapabilitiesCopyWithImpl;
@useResult
$Res call({
 bool isLearner, bool isMentor, bool isMentorApproved, bool isEnabler, bool isCampusLead, bool isCompany, bool needsDiscord
});




}
/// @nodoc
class _$CapabilitiesCopyWithImpl<$Res>
    implements $CapabilitiesCopyWith<$Res> {
  _$CapabilitiesCopyWithImpl(this._self, this._then);

  final Capabilities _self;
  final $Res Function(Capabilities) _then;

/// Create a copy of Capabilities
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLearner = null,Object? isMentor = null,Object? isMentorApproved = null,Object? isEnabler = null,Object? isCampusLead = null,Object? isCompany = null,Object? needsDiscord = null,}) {
  return _then(_self.copyWith(
isLearner: null == isLearner ? _self.isLearner : isLearner // ignore: cast_nullable_to_non_nullable
as bool,isMentor: null == isMentor ? _self.isMentor : isMentor // ignore: cast_nullable_to_non_nullable
as bool,isMentorApproved: null == isMentorApproved ? _self.isMentorApproved : isMentorApproved // ignore: cast_nullable_to_non_nullable
as bool,isEnabler: null == isEnabler ? _self.isEnabler : isEnabler // ignore: cast_nullable_to_non_nullable
as bool,isCampusLead: null == isCampusLead ? _self.isCampusLead : isCampusLead // ignore: cast_nullable_to_non_nullable
as bool,isCompany: null == isCompany ? _self.isCompany : isCompany // ignore: cast_nullable_to_non_nullable
as bool,needsDiscord: null == needsDiscord ? _self.needsDiscord : needsDiscord // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Capabilities].
extension CapabilitiesPatterns on Capabilities {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Capabilities value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Capabilities() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Capabilities value)  $default,){
final _that = this;
switch (_that) {
case _Capabilities():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Capabilities value)?  $default,){
final _that = this;
switch (_that) {
case _Capabilities() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLearner,  bool isMentor,  bool isMentorApproved,  bool isEnabler,  bool isCampusLead,  bool isCompany,  bool needsDiscord)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Capabilities() when $default != null:
return $default(_that.isLearner,_that.isMentor,_that.isMentorApproved,_that.isEnabler,_that.isCampusLead,_that.isCompany,_that.needsDiscord);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLearner,  bool isMentor,  bool isMentorApproved,  bool isEnabler,  bool isCampusLead,  bool isCompany,  bool needsDiscord)  $default,) {final _that = this;
switch (_that) {
case _Capabilities():
return $default(_that.isLearner,_that.isMentor,_that.isMentorApproved,_that.isEnabler,_that.isCampusLead,_that.isCompany,_that.needsDiscord);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLearner,  bool isMentor,  bool isMentorApproved,  bool isEnabler,  bool isCampusLead,  bool isCompany,  bool needsDiscord)?  $default,) {final _that = this;
switch (_that) {
case _Capabilities() when $default != null:
return $default(_that.isLearner,_that.isMentor,_that.isMentorApproved,_that.isEnabler,_that.isCampusLead,_that.isCompany,_that.needsDiscord);case _:
  return null;

}
}

}

/// @nodoc


class _Capabilities implements Capabilities {
  const _Capabilities({required this.isLearner, required this.isMentor, required this.isMentorApproved, required this.isEnabler, required this.isCampusLead, required this.isCompany, required this.needsDiscord});
  

@override final  bool isLearner;
@override final  bool isMentor;
@override final  bool isMentorApproved;
@override final  bool isEnabler;
@override final  bool isCampusLead;
@override final  bool isCompany;
@override final  bool needsDiscord;

/// Create a copy of Capabilities
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapabilitiesCopyWith<_Capabilities> get copyWith => __$CapabilitiesCopyWithImpl<_Capabilities>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Capabilities&&(identical(other.isLearner, isLearner) || other.isLearner == isLearner)&&(identical(other.isMentor, isMentor) || other.isMentor == isMentor)&&(identical(other.isMentorApproved, isMentorApproved) || other.isMentorApproved == isMentorApproved)&&(identical(other.isEnabler, isEnabler) || other.isEnabler == isEnabler)&&(identical(other.isCampusLead, isCampusLead) || other.isCampusLead == isCampusLead)&&(identical(other.isCompany, isCompany) || other.isCompany == isCompany)&&(identical(other.needsDiscord, needsDiscord) || other.needsDiscord == needsDiscord));
}


@override
int get hashCode => Object.hash(runtimeType,isLearner,isMentor,isMentorApproved,isEnabler,isCampusLead,isCompany,needsDiscord);

@override
String toString() {
  return 'Capabilities(isLearner: $isLearner, isMentor: $isMentor, isMentorApproved: $isMentorApproved, isEnabler: $isEnabler, isCampusLead: $isCampusLead, isCompany: $isCompany, needsDiscord: $needsDiscord)';
}


}

/// @nodoc
abstract mixin class _$CapabilitiesCopyWith<$Res> implements $CapabilitiesCopyWith<$Res> {
  factory _$CapabilitiesCopyWith(_Capabilities value, $Res Function(_Capabilities) _then) = __$CapabilitiesCopyWithImpl;
@override @useResult
$Res call({
 bool isLearner, bool isMentor, bool isMentorApproved, bool isEnabler, bool isCampusLead, bool isCompany, bool needsDiscord
});




}
/// @nodoc
class __$CapabilitiesCopyWithImpl<$Res>
    implements _$CapabilitiesCopyWith<$Res> {
  __$CapabilitiesCopyWithImpl(this._self, this._then);

  final _Capabilities _self;
  final $Res Function(_Capabilities) _then;

/// Create a copy of Capabilities
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLearner = null,Object? isMentor = null,Object? isMentorApproved = null,Object? isEnabler = null,Object? isCampusLead = null,Object? isCompany = null,Object? needsDiscord = null,}) {
  return _then(_Capabilities(
isLearner: null == isLearner ? _self.isLearner : isLearner // ignore: cast_nullable_to_non_nullable
as bool,isMentor: null == isMentor ? _self.isMentor : isMentor // ignore: cast_nullable_to_non_nullable
as bool,isMentorApproved: null == isMentorApproved ? _self.isMentorApproved : isMentorApproved // ignore: cast_nullable_to_non_nullable
as bool,isEnabler: null == isEnabler ? _self.isEnabler : isEnabler // ignore: cast_nullable_to_non_nullable
as bool,isCampusLead: null == isCampusLead ? _self.isCampusLead : isCampusLead // ignore: cast_nullable_to_non_nullable
as bool,isCompany: null == isCompany ? _self.isCompany : isCompany // ignore: cast_nullable_to_non_nullable
as bool,needsDiscord: null == needsDiscord ? _self.needsDiscord : needsDiscord // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
