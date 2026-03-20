import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';

part 'measurement.freezed.dart';

@freezed
abstract class Measurement with _$Measurement {
  const factory Measurement({
    required int systolic,
    required int diastolic,
    required int pulse,
    required DateTime timestamp,
    int? mood,
    String? comment,
    @Default([]) List<String> tags,
    required BpCategory category,
  }) = _Measurement;
}
