part of 'measurement_form.dart';

@freezed
abstract class MeasurementFormEvent with _$MeasurementFormEvent {
  const factory MeasurementFormEvent.systolicChanged(String value) = _SystolicChanged;
  const factory MeasurementFormEvent.diastolicChanged(String value) = _DiastolicChanged;
  const factory MeasurementFormEvent.pulseChanged(String value) = _PulseChanged;
  const factory MeasurementFormEvent.moodChanged(int? mood) = _MoodChanged;
  const factory MeasurementFormEvent.commentChanged(String comment) = _CommentChanged;
  const factory MeasurementFormEvent.tagsChanged(List<String> tags) = _TagsChanged;
  const factory MeasurementFormEvent.timestampChanged(DateTime timestamp) = _TimestampChanged;
  const factory MeasurementFormEvent.submitted() = _Submitted;
  const factory MeasurementFormEvent.submitFeedbackCleared() = _SubmitFeedbackCleared;
}
