// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Measurement {

 int get systolic; int get diastolic; int get pulse; DateTime get timestamp; int? get mood; String? get comment; List<String> get tags; BpCategory get category;
/// Create a copy of Measurement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeasurementCopyWith<Measurement> get copyWith => _$MeasurementCopyWithImpl<Measurement>(this as Measurement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Measurement&&(identical(other.systolic, systolic) || other.systolic == systolic)&&(identical(other.diastolic, diastolic) || other.diastolic == diastolic)&&(identical(other.pulse, pulse) || other.pulse == pulse)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,systolic,diastolic,pulse,timestamp,mood,comment,const DeepCollectionEquality().hash(tags),category);

@override
String toString() {
  return 'Measurement(systolic: $systolic, diastolic: $diastolic, pulse: $pulse, timestamp: $timestamp, mood: $mood, comment: $comment, tags: $tags, category: $category)';
}


}

/// @nodoc
abstract mixin class $MeasurementCopyWith<$Res>  {
  factory $MeasurementCopyWith(Measurement value, $Res Function(Measurement) _then) = _$MeasurementCopyWithImpl;
@useResult
$Res call({
 int systolic, int diastolic, int pulse, DateTime timestamp, int? mood, String? comment, List<String> tags, BpCategory category
});




}
/// @nodoc
class _$MeasurementCopyWithImpl<$Res>
    implements $MeasurementCopyWith<$Res> {
  _$MeasurementCopyWithImpl(this._self, this._then);

  final Measurement _self;
  final $Res Function(Measurement) _then;

/// Create a copy of Measurement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? systolic = null,Object? diastolic = null,Object? pulse = null,Object? timestamp = null,Object? mood = freezed,Object? comment = freezed,Object? tags = null,Object? category = null,}) {
  return _then(_self.copyWith(
systolic: null == systolic ? _self.systolic : systolic // ignore: cast_nullable_to_non_nullable
as int,diastolic: null == diastolic ? _self.diastolic : diastolic // ignore: cast_nullable_to_non_nullable
as int,pulse: null == pulse ? _self.pulse : pulse // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as BpCategory,
  ));
}

}


/// Adds pattern-matching-related methods to [Measurement].
extension MeasurementPatterns on Measurement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Measurement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Measurement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Measurement value)  $default,){
final _that = this;
switch (_that) {
case _Measurement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Measurement value)?  $default,){
final _that = this;
switch (_that) {
case _Measurement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int systolic,  int diastolic,  int pulse,  DateTime timestamp,  int? mood,  String? comment,  List<String> tags,  BpCategory category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Measurement() when $default != null:
return $default(_that.systolic,_that.diastolic,_that.pulse,_that.timestamp,_that.mood,_that.comment,_that.tags,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int systolic,  int diastolic,  int pulse,  DateTime timestamp,  int? mood,  String? comment,  List<String> tags,  BpCategory category)  $default,) {final _that = this;
switch (_that) {
case _Measurement():
return $default(_that.systolic,_that.diastolic,_that.pulse,_that.timestamp,_that.mood,_that.comment,_that.tags,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int systolic,  int diastolic,  int pulse,  DateTime timestamp,  int? mood,  String? comment,  List<String> tags,  BpCategory category)?  $default,) {final _that = this;
switch (_that) {
case _Measurement() when $default != null:
return $default(_that.systolic,_that.diastolic,_that.pulse,_that.timestamp,_that.mood,_that.comment,_that.tags,_that.category);case _:
  return null;

}
}

}

/// @nodoc


class _Measurement implements Measurement {
  const _Measurement({required this.systolic, required this.diastolic, required this.pulse, required this.timestamp, this.mood, this.comment, final  List<String> tags = const [], required this.category}): _tags = tags;
  

@override final  int systolic;
@override final  int diastolic;
@override final  int pulse;
@override final  DateTime timestamp;
@override final  int? mood;
@override final  String? comment;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  BpCategory category;

/// Create a copy of Measurement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeasurementCopyWith<_Measurement> get copyWith => __$MeasurementCopyWithImpl<_Measurement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Measurement&&(identical(other.systolic, systolic) || other.systolic == systolic)&&(identical(other.diastolic, diastolic) || other.diastolic == diastolic)&&(identical(other.pulse, pulse) || other.pulse == pulse)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,systolic,diastolic,pulse,timestamp,mood,comment,const DeepCollectionEquality().hash(_tags),category);

@override
String toString() {
  return 'Measurement(systolic: $systolic, diastolic: $diastolic, pulse: $pulse, timestamp: $timestamp, mood: $mood, comment: $comment, tags: $tags, category: $category)';
}


}

/// @nodoc
abstract mixin class _$MeasurementCopyWith<$Res> implements $MeasurementCopyWith<$Res> {
  factory _$MeasurementCopyWith(_Measurement value, $Res Function(_Measurement) _then) = __$MeasurementCopyWithImpl;
@override @useResult
$Res call({
 int systolic, int diastolic, int pulse, DateTime timestamp, int? mood, String? comment, List<String> tags, BpCategory category
});




}
/// @nodoc
class __$MeasurementCopyWithImpl<$Res>
    implements _$MeasurementCopyWith<$Res> {
  __$MeasurementCopyWithImpl(this._self, this._then);

  final _Measurement _self;
  final $Res Function(_Measurement) _then;

/// Create a copy of Measurement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? systolic = null,Object? diastolic = null,Object? pulse = null,Object? timestamp = null,Object? mood = freezed,Object? comment = freezed,Object? tags = null,Object? category = null,}) {
  return _then(_Measurement(
systolic: null == systolic ? _self.systolic : systolic // ignore: cast_nullable_to_non_nullable
as int,diastolic: null == diastolic ? _self.diastolic : diastolic // ignore: cast_nullable_to_non_nullable
as int,pulse: null == pulse ? _self.pulse : pulse // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as BpCategory,
  ));
}


}

// dart format on
