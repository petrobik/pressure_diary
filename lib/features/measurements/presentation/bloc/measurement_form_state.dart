part of 'measurement_form.dart';

@freezed
abstract class MeasurementFormState with _$MeasurementFormState {
  const factory MeasurementFormState({
    @Default('') String systolicInput,
    @Default('') String diastolicInput,
    @Default('') String pulseInput,
    int? mood,
    @Default('') String commentInput,
    @Default(<String>[]) List<String> tags,
    required DateTime timestamp,
    String? formError,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSubmitSuccess,
  }) = _MeasurementFormState;

  factory MeasurementFormState.initial({
    required DateTime timestamp,
  }) => MeasurementFormState(timestamp: timestamp);
}
