part of 'measurement_form.dart';

class MeasurementFormBloc extends Bloc<MeasurementFormEvent, MeasurementFormState> {
  static const _invalidRequiredFieldsMessage = 'Заполните корректно систолическое, диастолическое и пульс.';
  static const _saveFailedMessage = 'Не удалось сохранить измерение. Попробуйте снова.';

  MeasurementFormBloc({
    required MeasurementRepository repository,
    required BpClassifier classifier,
    Measurement? initialMeasurement,
  }) : _repository = repository,
       _classifier = classifier,
       _initialMeasurement = initialMeasurement,
       super(
         initialMeasurement == null
             ? MeasurementFormState.initial(timestamp: DateTime.now())
             : MeasurementFormState(
               isEditing: true,
               systolicInput: initialMeasurement.systolic.toString(),
               diastolicInput: initialMeasurement.diastolic.toString(),
               pulseInput: initialMeasurement.pulse.toString(),
               timestamp: initialMeasurement.timestamp,
               mood: initialMeasurement.mood,
               commentInput: initialMeasurement.comment ?? '',
               tags: List.of(initialMeasurement.tags),
             ),
       ) {
    _initialState = state;
    on<MeasurementFormEvent>(
      (event, emit) => switch (event) {
        _ when state.isLocked => null,
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
  final Measurement? _initialMeasurement;
  late final MeasurementFormState _initialState;

  void _inputChanged(MeasurementFormState next, Emitter<MeasurementFormState> emit) {
    final initial = _initialState;
    final dirty =
        next.systolicInput != initial.systolicInput ||
        next.diastolicInput != initial.diastolicInput ||
        next.pulseInput != initial.pulseInput ||
        next.mood != initial.mood ||
        next.commentInput != initial.commentInput ||
        !listEquals(next.tags, initial.tags) ||
        next.timestamp != initial.timestamp;
    emit(next.copyWith(isDirty: dirty));
  }

  void _systolicChanged(String value, Emitter<MeasurementFormState> emit) => _inputChanged(
    state.copyWith(
      systolicInput: value,
      isSubmitSuccess: false,
      formError: null,
    ),
    emit,
  );

  void _diastolicChanged(String value, Emitter<MeasurementFormState> emit) => _inputChanged(
    state.copyWith(
      diastolicInput: value,
      isSubmitSuccess: false,
      formError: null,
    ),
    emit,
  );

  void _pulseChanged(String value, Emitter<MeasurementFormState> emit) => _inputChanged(
    state.copyWith(
      pulseInput: value,
      isSubmitSuccess: false,
      formError: null,
    ),
    emit,
  );

  void _moodChanged(int? mood, Emitter<MeasurementFormState> emit) => _inputChanged(
    state.copyWith(
      mood: mood,
      isSubmitSuccess: false,
      formError: null,
    ),
    emit,
  );

  void _commentChanged(String comment, Emitter<MeasurementFormState> emit) => _inputChanged(
    state.copyWith(
      commentInput: comment,
      isSubmitSuccess: false,
      formError: null,
    ),
    emit,
  );

  void _tagsChanged(List<String> tags, Emitter<MeasurementFormState> emit) => _inputChanged(
    state.copyWith(
      tags: List.of(tags),
      isSubmitSuccess: false,
      formError: null,
    ),
    emit,
  );

  void _timestampChanged(DateTime timestamp, Emitter<MeasurementFormState> emit) => _inputChanged(
    state.copyWith(
      timestamp: timestamp,
      isSubmitSuccess: false,
      formError: null,
    ),
    emit,
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

      final original = _initialMeasurement;
      final category =
          original != null && systolic == original.systolic && diastolic == original.diastolic
              ? original.category
              : _classifier.classify(systolic: systolic, diastolic: diastolic);
      final tags = state.tags.map((tag) => tag.trim()).where((tag) => tag.isNotEmpty).toSet().toList();
      if (original == null) {
        await _repository.create(
          systolic: systolic,
          diastolic: diastolic,
          pulse: pulse,
          timestamp: state.timestamp,
          mood: state.mood,
          comment: comment.isEmpty ? null : comment,
          tags: tags,
          category: category,
        );
      } else {
        await _repository.update(
          original.copyWith(
            systolic: systolic,
            diastolic: diastolic,
            pulse: pulse,
            timestamp: state.timestamp,
            mood: state.mood,
            comment: comment.isEmpty ? null : comment,
            tags: tags,
            category: category,
          ),
        );
      }
      if (emit.isDone) return;

      emit(
        state.copyWith(
          isSubmitting: false,
          isSubmitSuccess: true,
          formError: null,
        ),
      );
    } catch (error) {
      if (emit.isDone) return;
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
