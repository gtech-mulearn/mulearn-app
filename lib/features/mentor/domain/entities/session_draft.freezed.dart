// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionTarget {

 SessionType get type; String get entityId; String get label;
/// Create a copy of SessionTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionTargetCopyWith<SessionTarget> get copyWith => _$SessionTargetCopyWithImpl<SessionTarget>(this as SessionTarget, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionTarget&&(identical(other.type, type) || other.type == type)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,type,entityId,label);

@override
String toString() {
  return 'SessionTarget(type: $type, entityId: $entityId, label: $label)';
}


}

/// @nodoc
abstract mixin class $SessionTargetCopyWith<$Res>  {
  factory $SessionTargetCopyWith(SessionTarget value, $Res Function(SessionTarget) _then) = _$SessionTargetCopyWithImpl;
@useResult
$Res call({
 SessionType type, String entityId, String label
});




}
/// @nodoc
class _$SessionTargetCopyWithImpl<$Res>
    implements $SessionTargetCopyWith<$Res> {
  _$SessionTargetCopyWithImpl(this._self, this._then);

  final SessionTarget _self;
  final $Res Function(SessionTarget) _then;

/// Create a copy of SessionTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? entityId = null,Object? label = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionTarget].
extension SessionTargetPatterns on SessionTarget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionTarget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionTarget() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionTarget value)  $default,){
final _that = this;
switch (_that) {
case _SessionTarget():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionTarget value)?  $default,){
final _that = this;
switch (_that) {
case _SessionTarget() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SessionType type,  String entityId,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionTarget() when $default != null:
return $default(_that.type,_that.entityId,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SessionType type,  String entityId,  String label)  $default,) {final _that = this;
switch (_that) {
case _SessionTarget():
return $default(_that.type,_that.entityId,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SessionType type,  String entityId,  String label)?  $default,) {final _that = this;
switch (_that) {
case _SessionTarget() when $default != null:
return $default(_that.type,_that.entityId,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _SessionTarget implements SessionTarget {
  const _SessionTarget({required this.type, required this.entityId, required this.label});
  

@override final  SessionType type;
@override final  String entityId;
@override final  String label;

/// Create a copy of SessionTarget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionTargetCopyWith<_SessionTarget> get copyWith => __$SessionTargetCopyWithImpl<_SessionTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionTarget&&(identical(other.type, type) || other.type == type)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,type,entityId,label);

@override
String toString() {
  return 'SessionTarget(type: $type, entityId: $entityId, label: $label)';
}


}

/// @nodoc
abstract mixin class _$SessionTargetCopyWith<$Res> implements $SessionTargetCopyWith<$Res> {
  factory _$SessionTargetCopyWith(_SessionTarget value, $Res Function(_SessionTarget) _then) = __$SessionTargetCopyWithImpl;
@override @useResult
$Res call({
 SessionType type, String entityId, String label
});




}
/// @nodoc
class __$SessionTargetCopyWithImpl<$Res>
    implements _$SessionTargetCopyWith<$Res> {
  __$SessionTargetCopyWithImpl(this._self, this._then);

  final _SessionTarget _self;
  final $Res Function(_SessionTarget) _then;

/// Create a copy of SessionTarget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? entityId = null,Object? label = null,}) {
  return _then(_SessionTarget(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$IgOption {

 String get id; String get name;
/// Create a copy of IgOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IgOptionCopyWith<IgOption> get copyWith => _$IgOptionCopyWithImpl<IgOption>(this as IgOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IgOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'IgOption(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $IgOptionCopyWith<$Res>  {
  factory $IgOptionCopyWith(IgOption value, $Res Function(IgOption) _then) = _$IgOptionCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$IgOptionCopyWithImpl<$Res>
    implements $IgOptionCopyWith<$Res> {
  _$IgOptionCopyWithImpl(this._self, this._then);

  final IgOption _self;
  final $Res Function(IgOption) _then;

/// Create a copy of IgOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IgOption].
extension IgOptionPatterns on IgOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IgOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IgOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IgOption value)  $default,){
final _that = this;
switch (_that) {
case _IgOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IgOption value)?  $default,){
final _that = this;
switch (_that) {
case _IgOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IgOption() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _IgOption():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _IgOption() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _IgOption implements IgOption {
  const _IgOption({required this.id, required this.name});
  

@override final  String id;
@override final  String name;

/// Create a copy of IgOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IgOptionCopyWith<_IgOption> get copyWith => __$IgOptionCopyWithImpl<_IgOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IgOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'IgOption(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$IgOptionCopyWith<$Res> implements $IgOptionCopyWith<$Res> {
  factory _$IgOptionCopyWith(_IgOption value, $Res Function(_IgOption) _then) = __$IgOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$IgOptionCopyWithImpl<$Res>
    implements _$IgOptionCopyWith<$Res> {
  __$IgOptionCopyWithImpl(this._self, this._then);

  final _IgOption _self;
  final $Res Function(_IgOption) _then;

/// Create a copy of IgOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_IgOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SessionDraft {

 String get title; String get description; SessionMode get mode; String get meetingLink; String get venue; SessionTarget? get target; DateTime? get startsLocal; DateTime? get endsLocal; int? get maxParticipants; bool get isRecurring; RecurrenceType? get recurrenceType; int get recurrenceInterval; DateTime? get recurrenceEndDate;
/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionDraftCopyWith<SessionDraft> get copyWith => _$SessionDraftCopyWithImpl<SessionDraft>(this as SessionDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.target, target) || other.target == target)&&(identical(other.startsLocal, startsLocal) || other.startsLocal == startsLocal)&&(identical(other.endsLocal, endsLocal) || other.endsLocal == endsLocal)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.recurrenceType, recurrenceType) || other.recurrenceType == recurrenceType)&&(identical(other.recurrenceInterval, recurrenceInterval) || other.recurrenceInterval == recurrenceInterval)&&(identical(other.recurrenceEndDate, recurrenceEndDate) || other.recurrenceEndDate == recurrenceEndDate));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,mode,meetingLink,venue,target,startsLocal,endsLocal,maxParticipants,isRecurring,recurrenceType,recurrenceInterval,recurrenceEndDate);

@override
String toString() {
  return 'SessionDraft(title: $title, description: $description, mode: $mode, meetingLink: $meetingLink, venue: $venue, target: $target, startsLocal: $startsLocal, endsLocal: $endsLocal, maxParticipants: $maxParticipants, isRecurring: $isRecurring, recurrenceType: $recurrenceType, recurrenceInterval: $recurrenceInterval, recurrenceEndDate: $recurrenceEndDate)';
}


}

/// @nodoc
abstract mixin class $SessionDraftCopyWith<$Res>  {
  factory $SessionDraftCopyWith(SessionDraft value, $Res Function(SessionDraft) _then) = _$SessionDraftCopyWithImpl;
@useResult
$Res call({
 String title, String description, SessionMode mode, String meetingLink, String venue, SessionTarget? target, DateTime? startsLocal, DateTime? endsLocal, int? maxParticipants, bool isRecurring, RecurrenceType? recurrenceType, int recurrenceInterval, DateTime? recurrenceEndDate
});


$SessionTargetCopyWith<$Res>? get target;

}
/// @nodoc
class _$SessionDraftCopyWithImpl<$Res>
    implements $SessionDraftCopyWith<$Res> {
  _$SessionDraftCopyWithImpl(this._self, this._then);

  final SessionDraft _self;
  final $Res Function(SessionDraft) _then;

/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? mode = null,Object? meetingLink = null,Object? venue = null,Object? target = freezed,Object? startsLocal = freezed,Object? endsLocal = freezed,Object? maxParticipants = freezed,Object? isRecurring = null,Object? recurrenceType = freezed,Object? recurrenceInterval = null,Object? recurrenceEndDate = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SessionMode,meetingLink: null == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as SessionTarget?,startsLocal: freezed == startsLocal ? _self.startsLocal : startsLocal // ignore: cast_nullable_to_non_nullable
as DateTime?,endsLocal: freezed == endsLocal ? _self.endsLocal : endsLocal // ignore: cast_nullable_to_non_nullable
as DateTime?,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,recurrenceType: freezed == recurrenceType ? _self.recurrenceType : recurrenceType // ignore: cast_nullable_to_non_nullable
as RecurrenceType?,recurrenceInterval: null == recurrenceInterval ? _self.recurrenceInterval : recurrenceInterval // ignore: cast_nullable_to_non_nullable
as int,recurrenceEndDate: freezed == recurrenceEndDate ? _self.recurrenceEndDate : recurrenceEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionTargetCopyWith<$Res>? get target {
    if (_self.target == null) {
    return null;
  }

  return $SessionTargetCopyWith<$Res>(_self.target!, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionDraft].
extension SessionDraftPatterns on SessionDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionDraft value)  $default,){
final _that = this;
switch (_that) {
case _SessionDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionDraft value)?  $default,){
final _that = this;
switch (_that) {
case _SessionDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  SessionMode mode,  String meetingLink,  String venue,  SessionTarget? target,  DateTime? startsLocal,  DateTime? endsLocal,  int? maxParticipants,  bool isRecurring,  RecurrenceType? recurrenceType,  int recurrenceInterval,  DateTime? recurrenceEndDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionDraft() when $default != null:
return $default(_that.title,_that.description,_that.mode,_that.meetingLink,_that.venue,_that.target,_that.startsLocal,_that.endsLocal,_that.maxParticipants,_that.isRecurring,_that.recurrenceType,_that.recurrenceInterval,_that.recurrenceEndDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  SessionMode mode,  String meetingLink,  String venue,  SessionTarget? target,  DateTime? startsLocal,  DateTime? endsLocal,  int? maxParticipants,  bool isRecurring,  RecurrenceType? recurrenceType,  int recurrenceInterval,  DateTime? recurrenceEndDate)  $default,) {final _that = this;
switch (_that) {
case _SessionDraft():
return $default(_that.title,_that.description,_that.mode,_that.meetingLink,_that.venue,_that.target,_that.startsLocal,_that.endsLocal,_that.maxParticipants,_that.isRecurring,_that.recurrenceType,_that.recurrenceInterval,_that.recurrenceEndDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  SessionMode mode,  String meetingLink,  String venue,  SessionTarget? target,  DateTime? startsLocal,  DateTime? endsLocal,  int? maxParticipants,  bool isRecurring,  RecurrenceType? recurrenceType,  int recurrenceInterval,  DateTime? recurrenceEndDate)?  $default,) {final _that = this;
switch (_that) {
case _SessionDraft() when $default != null:
return $default(_that.title,_that.description,_that.mode,_that.meetingLink,_that.venue,_that.target,_that.startsLocal,_that.endsLocal,_that.maxParticipants,_that.isRecurring,_that.recurrenceType,_that.recurrenceInterval,_that.recurrenceEndDate);case _:
  return null;

}
}

}

/// @nodoc


class _SessionDraft extends SessionDraft {
  const _SessionDraft({required this.title, required this.description, required this.mode, required this.meetingLink, required this.venue, this.target, this.startsLocal, this.endsLocal, this.maxParticipants, this.isRecurring = false, this.recurrenceType, this.recurrenceInterval = 1, this.recurrenceEndDate}): super._();
  

@override final  String title;
@override final  String description;
@override final  SessionMode mode;
@override final  String meetingLink;
@override final  String venue;
@override final  SessionTarget? target;
@override final  DateTime? startsLocal;
@override final  DateTime? endsLocal;
@override final  int? maxParticipants;
@override@JsonKey() final  bool isRecurring;
@override final  RecurrenceType? recurrenceType;
@override@JsonKey() final  int recurrenceInterval;
@override final  DateTime? recurrenceEndDate;

/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionDraftCopyWith<_SessionDraft> get copyWith => __$SessionDraftCopyWithImpl<_SessionDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.target, target) || other.target == target)&&(identical(other.startsLocal, startsLocal) || other.startsLocal == startsLocal)&&(identical(other.endsLocal, endsLocal) || other.endsLocal == endsLocal)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.recurrenceType, recurrenceType) || other.recurrenceType == recurrenceType)&&(identical(other.recurrenceInterval, recurrenceInterval) || other.recurrenceInterval == recurrenceInterval)&&(identical(other.recurrenceEndDate, recurrenceEndDate) || other.recurrenceEndDate == recurrenceEndDate));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,mode,meetingLink,venue,target,startsLocal,endsLocal,maxParticipants,isRecurring,recurrenceType,recurrenceInterval,recurrenceEndDate);

@override
String toString() {
  return 'SessionDraft(title: $title, description: $description, mode: $mode, meetingLink: $meetingLink, venue: $venue, target: $target, startsLocal: $startsLocal, endsLocal: $endsLocal, maxParticipants: $maxParticipants, isRecurring: $isRecurring, recurrenceType: $recurrenceType, recurrenceInterval: $recurrenceInterval, recurrenceEndDate: $recurrenceEndDate)';
}


}

/// @nodoc
abstract mixin class _$SessionDraftCopyWith<$Res> implements $SessionDraftCopyWith<$Res> {
  factory _$SessionDraftCopyWith(_SessionDraft value, $Res Function(_SessionDraft) _then) = __$SessionDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, SessionMode mode, String meetingLink, String venue, SessionTarget? target, DateTime? startsLocal, DateTime? endsLocal, int? maxParticipants, bool isRecurring, RecurrenceType? recurrenceType, int recurrenceInterval, DateTime? recurrenceEndDate
});


@override $SessionTargetCopyWith<$Res>? get target;

}
/// @nodoc
class __$SessionDraftCopyWithImpl<$Res>
    implements _$SessionDraftCopyWith<$Res> {
  __$SessionDraftCopyWithImpl(this._self, this._then);

  final _SessionDraft _self;
  final $Res Function(_SessionDraft) _then;

/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? mode = null,Object? meetingLink = null,Object? venue = null,Object? target = freezed,Object? startsLocal = freezed,Object? endsLocal = freezed,Object? maxParticipants = freezed,Object? isRecurring = null,Object? recurrenceType = freezed,Object? recurrenceInterval = null,Object? recurrenceEndDate = freezed,}) {
  return _then(_SessionDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SessionMode,meetingLink: null == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as SessionTarget?,startsLocal: freezed == startsLocal ? _self.startsLocal : startsLocal // ignore: cast_nullable_to_non_nullable
as DateTime?,endsLocal: freezed == endsLocal ? _self.endsLocal : endsLocal // ignore: cast_nullable_to_non_nullable
as DateTime?,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,recurrenceType: freezed == recurrenceType ? _self.recurrenceType : recurrenceType // ignore: cast_nullable_to_non_nullable
as RecurrenceType?,recurrenceInterval: null == recurrenceInterval ? _self.recurrenceInterval : recurrenceInterval // ignore: cast_nullable_to_non_nullable
as int,recurrenceEndDate: freezed == recurrenceEndDate ? _self.recurrenceEndDate : recurrenceEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SessionDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionTargetCopyWith<$Res>? get target {
    if (_self.target == null) {
    return null;
  }

  return $SessionTargetCopyWith<$Res>(_self.target!, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}

// dart format on
