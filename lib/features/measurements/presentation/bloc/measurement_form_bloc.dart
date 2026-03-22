part of 'measurement_form.dart';

class MeasurementFormBloc extends Bloc<MeasurementFormEvent, MeasurementFormState> {

  static const _invalidRequiredFieldsMessage = 'Заполните корректно систолическое, диастолическое и пульс.';
  static const _saveFailedMessage = 'Не удалось сохранить измерение. Попробуйте снова.';

  MeasurementFormBloc({
    required MeasurementRepository repository,
    required BpClassifier classifier,
  }) : _repository = repository,
       _classifier = classifier,
       super(MeasurementFormState.initial(timestamp: DateTime.now())) {
        
    on<MeasurementFormEvent>(
      (event, emit) => switch (event) {
        _SystolicChanged(:final value) => _systolicChanged(value, emit),
        _DiastolicChanged(:final value) => _diastolicChanged(value, emit),
        _PulseChanged(:final value) => _pulseChanged(value, emit),
        _MoodChanged(:final mood) => _moodChanged(mood, emit),
        _CommentChanged(:final comment) => _commentChanged(comment, emit),
        _TagsChanged(:final tags) => _tagsChanged(tags, emit),
        _TimestampChanged(:final timestamp) => _timestampChanged(timestamp, emit),
        _Submitted() => _submitted(emit),
        _SubmitFeedbackCleared() => _submitFeedbackCleared(emit),
        _ => null,
      },
    );
  }

  final MeasurementRepository _repository;
  final BpClassifier _classifier;

  void _systolicChanged(String value, Emitter<MeasurementFormState> emit) => emit(
    state.copyWith(
      systolicInput: value,
      isSubmitSuccess: false,
      formError: null,
    ),
  );

  void _diastolicChanged(String value, Emitter<MeasurementFormState> emit) => emit(
    state.copyWith(
      diastolicInput: value,
      isSubmitSuccess: false,
      formError: null,
    ),
  );

  void _pulseChanged(String value, Emitter<MeasurementFormState> emit) => emit(
    state.copyWith(
      pulseInput: value,
      isSubmitSuccess: false,
      formError: null,
    ),
  );

  void _moodChanged(int? mood, Emitter<MeasurementFormState> emit) => emit(
    state.copyWith(
      mood: mood,
      isSubmitSuccess: false,
      formError: null,
    ),
  );

  void _commentChanged(String comment, Emitter<MeasurementFormState> emit) => emit(
    state.copyWith(
      commentInput: comment,
      isSubmitSuccess: false,
      formError: null,
    ),
  );

  void _tagsChanged(List<String> tags, Emitter<MeasurementFormState> emit) => emit(
    state.copyWith(
      tags: tags,
      isSubmitSuccess: false,
      formError: null,
    ),
  );

  void _timestampChanged(DateTime timastamp, Emitter<MeasurementFormState> emit) => emit(
    state.copyWith(
      timestamp: timastamp,
      isSubmitSuccess: false,
      formError: null,
    ),
  );

  void _submitFeedbackCleared(Emitter<MeasurementFormState> emit) => emit(
    state.copyWith(
      isSubmitSuccess: false,
      formError: null,
    ),
  );

  Future<void> _submitted(Emitter<MeasurementFormState> emit) async {
    final systolic = _parseRequiredInt(state.systolicInput);
    final diastolic = _parseRequiredInt(state.diastolicInput);
    final pulse = _parseRequiredInt(state.pulseInput);

    if (systolic == null || diastolic == null || pulse == null) {
      return emit(
        state.copyWith(
          isSubmitting: false,
          isSubmitSuccess: false,
          formError: _invalidRequiredFieldsMessage,
        ),
      );
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        isSubmitSuccess: false,
        formError: null,
      ),
    );

    try {
      final comment = state.commentInput.trim();

      final measurement = Measurement(
        systolic: systolic,
        diastolic: diastolic,
        pulse: pulse,
        timestamp: state.timestamp,
        mood: state.mood,
        comment: comment.isEmpty ? null : comment,
        tags: state.tags,
        category: _classifier.classify(
          systolic: systolic,
          diastolic: diastolic,
        ),
      );

      await _repository.add(measurement);

      emit(
        state.copyWith(
          isSubmitting: false,
          isSubmitSuccess: true,
          formError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          isSubmitSuccess: false,
          formError: _saveFailedMessage,
        ),
      );
    }
  }

  int? _parseRequiredInt(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return null;
    }

    return int.tryParse(normalized);
  }
}
