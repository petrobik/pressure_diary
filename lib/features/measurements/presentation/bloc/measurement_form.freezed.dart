// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeasurementFormEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeasurementFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MeasurementFormEvent()';
}


}

/// @nodoc
class $MeasurementFormEventCopyWith<$Res>  {
$MeasurementFormEventCopyWith(MeasurementFormEvent _, $Res Function(MeasurementFormEvent) __);
}


/// Adds pattern-matching-related methods to [MeasurementFormEvent].
extension MeasurementFormEventPatterns on MeasurementFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SystolicChanged value)?  systolicChanged,TResult Function( _DiastolicChanged value)?  diastolicChanged,TResult Function( _PulseChanged value)?  pulseChanged,TResult Function( _MoodChanged value)?  moodChanged,TResult Function( _CommentChanged value)?  commentChanged,TResult Function( _TagsChanged value)?  tagsChanged,TResult Function( _TimestampChanged value)?  timestampChanged,TResult Function( _Submitted value)?  submitted,TResult Function( _SubmitFeedbackCleared value)?  submitFeedbackCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SystolicChanged() when systolicChanged != null:
return systolicChanged(_that);case _DiastolicChanged() when diastolicChanged != null:
return diastolicChanged(_that);case _PulseChanged() when pulseChanged != null:
return pulseChanged(_that);case _MoodChanged() when moodChanged != null:
return moodChanged(_that);case _CommentChanged() when commentChanged != null:
return commentChanged(_that);case _TagsChanged() when tagsChanged != null:
return tagsChanged(_that);case _TimestampChanged() when timestampChanged != null:
return timestampChanged(_that);case _Submitted() when submitted != null:
return submitted(_that);case _SubmitFeedbackCleared() when submitFeedbackCleared != null:
return submitFeedbackCleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SystolicChanged value)  systolicChanged,required TResult Function( _DiastolicChanged value)  diastolicChanged,required TResult Function( _PulseChanged value)  pulseChanged,required TResult Function( _MoodChanged value)  moodChanged,required TResult Function( _CommentChanged value)  commentChanged,required TResult Function( _TagsChanged value)  tagsChanged,required TResult Function( _TimestampChanged value)  timestampChanged,required TResult Function( _Submitted value)  submitted,required TResult Function( _SubmitFeedbackCleared value)  submitFeedbackCleared,}){
final _that = this;
switch (_that) {
case _SystolicChanged():
return systolicChanged(_that);case _DiastolicChanged():
return diastolicChanged(_that);case _PulseChanged():
return pulseChanged(_that);case _MoodChanged():
return moodChanged(_that);case _CommentChanged():
return commentChanged(_that);case _TagsChanged():
return tagsChanged(_that);case _TimestampChanged():
return timestampChanged(_that);case _Submitted():
return submitted(_that);case _SubmitFeedbackCleared():
return submitFeedbackCleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SystolicChanged value)?  systolicChanged,TResult? Function( _DiastolicChanged value)?  diastolicChanged,TResult? Function( _PulseChanged value)?  pulseChanged,TResult? Function( _MoodChanged value)?  moodChanged,TResult? Function( _CommentChanged value)?  commentChanged,TResult? Function( _TagsChanged value)?  tagsChanged,TResult? Function( _TimestampChanged value)?  timestampChanged,TResult? Function( _Submitted value)?  submitted,TResult? Function( _SubmitFeedbackCleared value)?  submitFeedbackCleared,}){
final _that = this;
switch (_that) {
case _SystolicChanged() when systolicChanged != null:
return systolicChanged(_that);case _DiastolicChanged() when diastolicChanged != null:
return diastolicChanged(_that);case _PulseChanged() when pulseChanged != null:
return pulseChanged(_that);case _MoodChanged() when moodChanged != null:
return moodChanged(_that);case _CommentChanged() when commentChanged != null:
return commentChanged(_that);case _TagsChanged() when tagsChanged != null:
return tagsChanged(_that);case _TimestampChanged() when timestampChanged != null:
return timestampChanged(_that);case _Submitted() when submitted != null:
return submitted(_that);case _SubmitFeedbackCleared() when submitFeedbackCleared != null:
return submitFeedbackCleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String value)?  systolicChanged,TResult Function( String value)?  diastolicChanged,TResult Function( String value)?  pulseChanged,TResult Function( int? mood)?  moodChanged,TResult Function( String comment)?  commentChanged,TResult Function( List<String> tags)?  tagsChanged,TResult Function( DateTime timestamp)?  timestampChanged,TResult Function()?  submitted,TResult Function()?  submitFeedbackCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SystolicChanged() when systolicChanged != null:
return systolicChanged(_that.value);case _DiastolicChanged() when diastolicChanged != null:
return diastolicChanged(_that.value);case _PulseChanged() when pulseChanged != null:
return pulseChanged(_that.value);case _MoodChanged() when moodChanged != null:
return moodChanged(_that.mood);case _CommentChanged() when commentChanged != null:
return commentChanged(_that.comment);case _TagsChanged() when tagsChanged != null:
return tagsChanged(_that.tags);case _TimestampChanged() when timestampChanged != null:
return timestampChanged(_that.timestamp);case _Submitted() when submitted != null:
return submitted();case _SubmitFeedbackCleared() when submitFeedbackCleared != null:
return submitFeedbackCleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String value)  systolicChanged,required TResult Function( String value)  diastolicChanged,required TResult Function( String value)  pulseChanged,required TResult Function( int? mood)  moodChanged,required TResult Function( String comment)  commentChanged,required TResult Function( List<String> tags)  tagsChanged,required TResult Function( DateTime timestamp)  timestampChanged,required TResult Function()  submitted,required TResult Function()  submitFeedbackCleared,}) {final _that = this;
switch (_that) {
case _SystolicChanged():
return systolicChanged(_that.value);case _DiastolicChanged():
return diastolicChanged(_that.value);case _PulseChanged():
return pulseChanged(_that.value);case _MoodChanged():
return moodChanged(_that.mood);case _CommentChanged():
return commentChanged(_that.comment);case _TagsChanged():
return tagsChanged(_that.tags);case _TimestampChanged():
return timestampChanged(_that.timestamp);case _Submitted():
return submitted();case _SubmitFeedbackCleared():
return submitFeedbackCleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String value)?  systolicChanged,TResult? Function( String value)?  diastolicChanged,TResult? Function( String value)?  pulseChanged,TResult? Function( int? mood)?  moodChanged,TResult? Function( String comment)?  commentChanged,TResult? Function( List<String> tags)?  tagsChanged,TResult? Function( DateTime timestamp)?  timestampChanged,TResult? Function()?  submitted,TResult? Function()?  submitFeedbackCleared,}) {final _that = this;
switch (_that) {
case _SystolicChanged() when systolicChanged != null:
return systolicChanged(_that.value);case _DiastolicChanged() when diastolicChanged != null:
return diastolicChanged(_that.value);case _PulseChanged() when pulseChanged != null:
return pulseChanged(_that.value);case _MoodChanged() when moodChanged != null:
return moodChanged(_that.mood);case _CommentChanged() when commentChanged != null:
return commentChanged(_that.comment);case _TagsChanged() when tagsChanged != null:
return tagsChanged(_that.tags);case _TimestampChanged() when timestampChanged != null:
return timestampChanged(_that.timestamp);case _Submitted() when submitted != null:
return submitted();case _SubmitFeedbackCleared() when submitFeedbackCleared != null:
return submitFeedbackCleared();case _:
  return null;

}
}

}

/// @nodoc


class _SystolicChanged implements MeasurementFormEvent {
  const _SystolicChanged(this.value);
  

 final  String value;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystolicChangedCopyWith<_SystolicChanged> get copyWith => __$SystolicChangedCopyWithImpl<_SystolicChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystolicChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'MeasurementFormEvent.systolicChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SystolicChangedCopyWith<$Res> implements $MeasurementFormEventCopyWith<$Res> {
  factory _$SystolicChangedCopyWith(_SystolicChanged value, $Res Function(_SystolicChanged) _then) = __$SystolicChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$SystolicChangedCopyWithImpl<$Res>
    implements _$SystolicChangedCopyWith<$Res> {
  __$SystolicChangedCopyWithImpl(this._self, this._then);

  final _SystolicChanged _self;
  final $Res Function(_SystolicChanged) _then;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SystolicChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DiastolicChanged implements MeasurementFormEvent {
  const _DiastolicChanged(this.value);
  

 final  String value;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiastolicChangedCopyWith<_DiastolicChanged> get copyWith => __$DiastolicChangedCopyWithImpl<_DiastolicChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiastolicChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'MeasurementFormEvent.diastolicChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$DiastolicChangedCopyWith<$Res> implements $MeasurementFormEventCopyWith<$Res> {
  factory _$DiastolicChangedCopyWith(_DiastolicChanged value, $Res Function(_DiastolicChanged) _then) = __$DiastolicChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$DiastolicChangedCopyWithImpl<$Res>
    implements _$DiastolicChangedCopyWith<$Res> {
  __$DiastolicChangedCopyWithImpl(this._self, this._then);

  final _DiastolicChanged _self;
  final $Res Function(_DiastolicChanged) _then;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_DiastolicChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PulseChanged implements MeasurementFormEvent {
  const _PulseChanged(this.value);
  

 final  String value;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PulseChangedCopyWith<_PulseChanged> get copyWith => __$PulseChangedCopyWithImpl<_PulseChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PulseChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'MeasurementFormEvent.pulseChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$PulseChangedCopyWith<$Res> implements $MeasurementFormEventCopyWith<$Res> {
  factory _$PulseChangedCopyWith(_PulseChanged value, $Res Function(_PulseChanged) _then) = __$PulseChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$PulseChangedCopyWithImpl<$Res>
    implements _$PulseChangedCopyWith<$Res> {
  __$PulseChangedCopyWithImpl(this._self, this._then);

  final _PulseChanged _self;
  final $Res Function(_PulseChanged) _then;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_PulseChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MoodChanged implements MeasurementFormEvent {
  const _MoodChanged(this.mood);
  

 final  int? mood;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodChangedCopyWith<_MoodChanged> get copyWith => __$MoodChangedCopyWithImpl<_MoodChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodChanged&&(identical(other.mood, mood) || other.mood == mood));
}


@override
int get hashCode => Object.hash(runtimeType,mood);

@override
String toString() {
  return 'MeasurementFormEvent.moodChanged(mood: $mood)';
}


}

/// @nodoc
abstract mixin class _$MoodChangedCopyWith<$Res> implements $MeasurementFormEventCopyWith<$Res> {
  factory _$MoodChangedCopyWith(_MoodChanged value, $Res Function(_MoodChanged) _then) = __$MoodChangedCopyWithImpl;
@useResult
$Res call({
 int? mood
});




}
/// @nodoc
class __$MoodChangedCopyWithImpl<$Res>
    implements _$MoodChangedCopyWith<$Res> {
  __$MoodChangedCopyWithImpl(this._self, this._then);

  final _MoodChanged _self;
  final $Res Function(_MoodChanged) _then;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mood = freezed,}) {
  return _then(_MoodChanged(
freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _CommentChanged implements MeasurementFormEvent {
  const _CommentChanged(this.comment);
  

 final  String comment;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentChangedCopyWith<_CommentChanged> get copyWith => __$CommentChangedCopyWithImpl<_CommentChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentChanged&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode => Object.hash(runtimeType,comment);

@override
String toString() {
  return 'MeasurementFormEvent.commentChanged(comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$CommentChangedCopyWith<$Res> implements $MeasurementFormEventCopyWith<$Res> {
  factory _$CommentChangedCopyWith(_CommentChanged value, $Res Function(_CommentChanged) _then) = __$CommentChangedCopyWithImpl;
@useResult
$Res call({
 String comment
});




}
/// @nodoc
class __$CommentChangedCopyWithImpl<$Res>
    implements _$CommentChangedCopyWith<$Res> {
  __$CommentChangedCopyWithImpl(this._self, this._then);

  final _CommentChanged _self;
  final $Res Function(_CommentChanged) _then;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? comment = null,}) {
  return _then(_CommentChanged(
null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TagsChanged implements MeasurementFormEvent {
  const _TagsChanged(final  List<String> tags): _tags = tags;
  

 final  List<String> _tags;
 List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagsChangedCopyWith<_TagsChanged> get copyWith => __$TagsChangedCopyWithImpl<_TagsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagsChanged&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'MeasurementFormEvent.tagsChanged(tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TagsChangedCopyWith<$Res> implements $MeasurementFormEventCopyWith<$Res> {
  factory _$TagsChangedCopyWith(_TagsChanged value, $Res Function(_TagsChanged) _then) = __$TagsChangedCopyWithImpl;
@useResult
$Res call({
 List<String> tags
});




}
/// @nodoc
class __$TagsChangedCopyWithImpl<$Res>
    implements _$TagsChangedCopyWith<$Res> {
  __$TagsChangedCopyWithImpl(this._self, this._then);

  final _TagsChanged _self;
  final $Res Function(_TagsChanged) _then;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tags = null,}) {
  return _then(_TagsChanged(
null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _TimestampChanged implements MeasurementFormEvent {
  const _TimestampChanged(this.timestamp);
  

 final  DateTime timestamp;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimestampChangedCopyWith<_TimestampChanged> get copyWith => __$TimestampChangedCopyWithImpl<_TimestampChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimestampChanged&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp);

@override
String toString() {
  return 'MeasurementFormEvent.timestampChanged(timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$TimestampChangedCopyWith<$Res> implements $MeasurementFormEventCopyWith<$Res> {
  factory _$TimestampChangedCopyWith(_TimestampChanged value, $Res Function(_TimestampChanged) _then) = __$TimestampChangedCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp
});




}
/// @nodoc
class __$TimestampChangedCopyWithImpl<$Res>
    implements _$TimestampChangedCopyWith<$Res> {
  __$TimestampChangedCopyWithImpl(this._self, this._then);

  final _TimestampChanged _self;
  final $Res Function(_TimestampChanged) _then;

/// Create a copy of MeasurementFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timestamp = null,}) {
  return _then(_TimestampChanged(
null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class _Submitted implements MeasurementFormEvent {
  const _Submitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MeasurementFormEvent.submitted()';
}


}




/// @nodoc


class _SubmitFeedbackCleared implements MeasurementFormEvent {
  const _SubmitFeedbackCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitFeedbackCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MeasurementFormEvent.submitFeedbackCleared()';
}


}




/// @nodoc
mixin _$MeasurementFormState {

 String get systolicInput; String get diastolicInput; String get pulseInput; int? get mood; String get commentInput; List<String> get tags; DateTime get timestamp; String? get formError; bool get isSubmitting; bool get isSubmitSuccess;
/// Create a copy of MeasurementFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeasurementFormStateCopyWith<MeasurementFormState> get copyWith => _$MeasurementFormStateCopyWithImpl<MeasurementFormState>(this as MeasurementFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeasurementFormState&&(identical(other.systolicInput, systolicInput) || other.systolicInput == systolicInput)&&(identical(other.diastolicInput, diastolicInput) || other.diastolicInput == diastolicInput)&&(identical(other.pulseInput, pulseInput) || other.pulseInput == pulseInput)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.commentInput, commentInput) || other.commentInput == commentInput)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.formError, formError) || other.formError == formError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitSuccess, isSubmitSuccess) || other.isSubmitSuccess == isSubmitSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,systolicInput,diastolicInput,pulseInput,mood,commentInput,const DeepCollectionEquality().hash(tags),timestamp,formError,isSubmitting,isSubmitSuccess);

@override
String toString() {
  return 'MeasurementFormState(systolicInput: $systolicInput, diastolicInput: $diastolicInput, pulseInput: $pulseInput, mood: $mood, commentInput: $commentInput, tags: $tags, timestamp: $timestamp, formError: $formError, isSubmitting: $isSubmitting, isSubmitSuccess: $isSubmitSuccess)';
}


}

/// @nodoc
abstract mixin class $MeasurementFormStateCopyWith<$Res>  {
  factory $MeasurementFormStateCopyWith(MeasurementFormState value, $Res Function(MeasurementFormState) _then) = _$MeasurementFormStateCopyWithImpl;
@useResult
$Res call({
 String systolicInput, String diastolicInput, String pulseInput, int? mood, String commentInput, List<String> tags, DateTime timestamp, String? formError, bool isSubmitting, bool isSubmitSuccess
});




}
/// @nodoc
class _$MeasurementFormStateCopyWithImpl<$Res>
    implements $MeasurementFormStateCopyWith<$Res> {
  _$MeasurementFormStateCopyWithImpl(this._self, this._then);

  final MeasurementFormState _self;
  final $Res Function(MeasurementFormState) _then;

/// Create a copy of MeasurementFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? systolicInput = null,Object? diastolicInput = null,Object? pulseInput = null,Object? mood = freezed,Object? commentInput = null,Object? tags = null,Object? timestamp = null,Object? formError = freezed,Object? isSubmitting = null,Object? isSubmitSuccess = null,}) {
  return _then(_self.copyWith(
systolicInput: null == systolicInput ? _self.systolicInput : systolicInput // ignore: cast_nullable_to_non_nullable
as String,diastolicInput: null == diastolicInput ? _self.diastolicInput : diastolicInput // ignore: cast_nullable_to_non_nullable
as String,pulseInput: null == pulseInput ? _self.pulseInput : pulseInput // ignore: cast_nullable_to_non_nullable
as String,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int?,commentInput: null == commentInput ? _self.commentInput : commentInput // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,formError: freezed == formError ? _self.formError : formError // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitSuccess: null == isSubmitSuccess ? _self.isSubmitSuccess : isSubmitSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MeasurementFormState].
extension MeasurementFormStatePatterns on MeasurementFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeasurementFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeasurementFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeasurementFormState value)  $default,){
final _that = this;
switch (_that) {
case _MeasurementFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeasurementFormState value)?  $default,){
final _that = this;
switch (_that) {
case _MeasurementFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String systolicInput,  String diastolicInput,  String pulseInput,  int? mood,  String commentInput,  List<String> tags,  DateTime timestamp,  String? formError,  bool isSubmitting,  bool isSubmitSuccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeasurementFormState() when $default != null:
return $default(_that.systolicInput,_that.diastolicInput,_that.pulseInput,_that.mood,_that.commentInput,_that.tags,_that.timestamp,_that.formError,_that.isSubmitting,_that.isSubmitSuccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String systolicInput,  String diastolicInput,  String pulseInput,  int? mood,  String commentInput,  List<String> tags,  DateTime timestamp,  String? formError,  bool isSubmitting,  bool isSubmitSuccess)  $default,) {final _that = this;
switch (_that) {
case _MeasurementFormState():
return $default(_that.systolicInput,_that.diastolicInput,_that.pulseInput,_that.mood,_that.commentInput,_that.tags,_that.timestamp,_that.formError,_that.isSubmitting,_that.isSubmitSuccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String systolicInput,  String diastolicInput,  String pulseInput,  int? mood,  String commentInput,  List<String> tags,  DateTime timestamp,  String? formError,  bool isSubmitting,  bool isSubmitSuccess)?  $default,) {final _that = this;
switch (_that) {
case _MeasurementFormState() when $default != null:
return $default(_that.systolicInput,_that.diastolicInput,_that.pulseInput,_that.mood,_that.commentInput,_that.tags,_that.timestamp,_that.formError,_that.isSubmitting,_that.isSubmitSuccess);case _:
  return null;

}
}

}

/// @nodoc


class _MeasurementFormState implements MeasurementFormState {
  const _MeasurementFormState({this.systolicInput = '', this.diastolicInput = '', this.pulseInput = '', this.mood, this.commentInput = '', final  List<String> tags = const <String>[], required this.timestamp, this.formError, this.isSubmitting = false, this.isSubmitSuccess = false}): _tags = tags;
  

@override@JsonKey() final  String systolicInput;
@override@JsonKey() final  String diastolicInput;
@override@JsonKey() final  String pulseInput;
@override final  int? mood;
@override@JsonKey() final  String commentInput;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime timestamp;
@override final  String? formError;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isSubmitSuccess;

/// Create a copy of MeasurementFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeasurementFormStateCopyWith<_MeasurementFormState> get copyWith => __$MeasurementFormStateCopyWithImpl<_MeasurementFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeasurementFormState&&(identical(other.systolicInput, systolicInput) || other.systolicInput == systolicInput)&&(identical(other.diastolicInput, diastolicInput) || other.diastolicInput == diastolicInput)&&(identical(other.pulseInput, pulseInput) || other.pulseInput == pulseInput)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.commentInput, commentInput) || other.commentInput == commentInput)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.formError, formError) || other.formError == formError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitSuccess, isSubmitSuccess) || other.isSubmitSuccess == isSubmitSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,systolicInput,diastolicInput,pulseInput,mood,commentInput,const DeepCollectionEquality().hash(_tags),timestamp,formError,isSubmitting,isSubmitSuccess);

@override
String toString() {
  return 'MeasurementFormState(systolicInput: $systolicInput, diastolicInput: $diastolicInput, pulseInput: $pulseInput, mood: $mood, commentInput: $commentInput, tags: $tags, timestamp: $timestamp, formError: $formError, isSubmitting: $isSubmitting, isSubmitSuccess: $isSubmitSuccess)';
}


}

/// @nodoc
abstract mixin class _$MeasurementFormStateCopyWith<$Res> implements $MeasurementFormStateCopyWith<$Res> {
  factory _$MeasurementFormStateCopyWith(_MeasurementFormState value, $Res Function(_MeasurementFormState) _then) = __$MeasurementFormStateCopyWithImpl;
@override @useResult
$Res call({
 String systolicInput, String diastolicInput, String pulseInput, int? mood, String commentInput, List<String> tags, DateTime timestamp, String? formError, bool isSubmitting, bool isSubmitSuccess
});




}
/// @nodoc
class __$MeasurementFormStateCopyWithImpl<$Res>
    implements _$MeasurementFormStateCopyWith<$Res> {
  __$MeasurementFormStateCopyWithImpl(this._self, this._then);

  final _MeasurementFormState _self;
  final $Res Function(_MeasurementFormState) _then;

/// Create a copy of MeasurementFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? systolicInput = null,Object? diastolicInput = null,Object? pulseInput = null,Object? mood = freezed,Object? commentInput = null,Object? tags = null,Object? timestamp = null,Object? formError = freezed,Object? isSubmitting = null,Object? isSubmitSuccess = null,}) {
  return _then(_MeasurementFormState(
systolicInput: null == systolicInput ? _self.systolicInput : systolicInput // ignore: cast_nullable_to_non_nullable
as String,diastolicInput: null == diastolicInput ? _self.diastolicInput : diastolicInput // ignore: cast_nullable_to_non_nullable
as String,pulseInput: null == pulseInput ? _self.pulseInput : pulseInput // ignore: cast_nullable_to_non_nullable
as String,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int?,commentInput: null == commentInput ? _self.commentInput : commentInput // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,formError: freezed == formError ? _self.formError : formError // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitSuccess: null == isSubmitSuccess ? _self.isSubmitSuccess : isSubmitSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
