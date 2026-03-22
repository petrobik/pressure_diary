import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/blood_pressure/bp_classifier.dart';
import 'package:pressure_diary/features/measurements/data/measurement_repository.dart';
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;
import 'package:pressure_diary/features/measurements/presentation/bloc/measurement_form.dart';

class _MeasurementRepositoryMock extends Mock implements MeasurementRepository {}

class _MeasurementFake extends Fake implements domain.Measurement {}

void main() {
  late _MeasurementRepositoryMock repository;
  late BpClassifier classifier;

  setUpAll(() {
    registerFallbackValue(_MeasurementFake());
  });

  setUp(() {
    repository = _MeasurementRepositoryMock();
    classifier = const BpClassifier();

    when(() => repository.add(any())).thenAnswer((_) async {});
  });

  MeasurementFormBloc buildBloc() {
    return MeasurementFormBloc(
      repository: repository,
      classifier: classifier,
    );
  }

  test('initial state uses DateTime.now()', () {
    final before = DateTime.now();
    final bloc = buildBloc();
    final after = DateTime.now();

    expect(bloc.state.timestamp.isBefore(before), isFalse);
    expect(bloc.state.timestamp.isAfter(after), isFalse);
    expect(bloc.state.isSubmitting, isFalse);
    expect(bloc.state.isSubmitSuccess, isFalse);
    expect(bloc.state.formError, isNull);
  });

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'updates mood, timestamp, comment and tags through events',
    build: buildBloc,
    act: (bloc) {
      bloc
        ..add(const MeasurementFormEvent.moodChanged(4))
        ..add(MeasurementFormEvent.timestampChanged(DateTime(2026, 3, 21, 8, 15)))
        ..add(const MeasurementFormEvent.commentChanged('after walk'))
        ..add(const MeasurementFormEvent.tagsChanged(['morning', 'walk']));
    },
    expect:
        () => [
          isA<MeasurementFormState>().having((s) => s.mood, 'mood', 4),
          isA<MeasurementFormState>().having(
            (s) => s.timestamp,
            'timestamp',
            DateTime(2026, 3, 21, 8, 15),
          ),
          isA<MeasurementFormState>().having(
            (s) => s.commentInput,
            'commentInput',
            'after walk',
          ),
          isA<MeasurementFormState>().having(
            (s) => s.tags,
            'tags',
            ['morning', 'walk'],
          ),
        ],
  );

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'does not call repository when required numeric fields are empty',
    build: buildBloc,
    act: (bloc) => bloc.add(const MeasurementFormEvent.submitted()),
    expect:
        () => [
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNotNull),
        ],
    verify: (_) {
      verifyNever(() => repository.add(any()));
    },
  );

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'does not call repository when required numeric fields cannot be parsed',
    build: buildBloc,
    seed:
        () => MeasurementFormState.initial(
          timestamp: DateTime(2026, 3, 22, 12, 0),
        ).copyWith(
          systolicInput: 'abc',
          diastolicInput: '80',
          pulseInput: '70',
        ),
    act: (bloc) => bloc.add(const MeasurementFormEvent.submitted()),
    expect:
        () => [
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNotNull),
        ],
    verify: (_) {
      verifyNever(() => repository.add(any()));
    },
  );

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'submits successfully and emits submitting state first',
    build: buildBloc,
    seed:
        () => MeasurementFormState.initial(
          timestamp: DateTime(2026, 3, 20, 19, 30),
        ).copyWith(
          systolicInput: '120',
          diastolicInput: '80',
          pulseInput: '65',
          mood: 3,
          commentInput: 'evening',
          tags: const ['home'],
        ),
    act: (bloc) => bloc.add(const MeasurementFormEvent.submitted()),
    expect:
        () => [
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitting, 'isSubmitting', true)
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNull),
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitting, 'isSubmitting', false)
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', true)
              .having((s) => s.formError, 'formError', isNull),
        ],
    verify: (_) {
      final captured = verify(() => repository.add(captureAny())).captured.single;
      final measurement = captured as domain.Measurement;

      expect(measurement.systolic, 120);
      expect(measurement.diastolic, 80);
      expect(measurement.pulse, 65);
      expect(measurement.mood, 3);
      expect(measurement.comment, 'evening');
      expect(measurement.tags, ['home']);
      expect(measurement.timestamp, DateTime(2026, 3, 20, 19, 30));
      expect(measurement.category, BpCategory.normal);
    },
  );

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'trims comment before save',
    build: buildBloc,
    seed:
        () => MeasurementFormState.initial(
          timestamp: DateTime(2026, 3, 20, 19, 30),
        ).copyWith(
          systolicInput: '120',
          diastolicInput: '80',
          pulseInput: '65',
          commentInput: '  evening  ',
        ),
    act: (bloc) => bloc.add(const MeasurementFormEvent.submitted()),
    verify: (_) {
      final captured = verify(() => repository.add(captureAny())).captured.single;
      final measurement = captured as domain.Measurement;
      expect(measurement.comment, 'evening');
    },
  );

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'allows submit for values outside advisory ranges',
    build: buildBloc,
    act: (bloc) {
      bloc
        ..add(const MeasurementFormEvent.systolicChanged('400'))
        ..add(const MeasurementFormEvent.diastolicChanged('20'))
        ..add(const MeasurementFormEvent.pulseChanged('5'))
        ..add(const MeasurementFormEvent.submitted());
    },
    verify: (_) {
      verify(() => repository.add(any())).called(1);
    },
  );

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'sets failure when repository throws',
    build: () {
      when(() => repository.add(any())).thenThrow(Exception('db fail'));
      return buildBloc();
    },
    seed:
        () => MeasurementFormState.initial(
          timestamp: DateTime(2026, 3, 22, 12, 0),
        ).copyWith(
          systolicInput: '120',
          diastolicInput: '80',
          pulseInput: '70',
        ),
    act: (bloc) => bloc.add(const MeasurementFormEvent.submitted()),
    expect:
        () => [
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitting, 'isSubmitting', true)
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNull),
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitting, 'isSubmitting', false)
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNotNull),
        ],
  );

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'clears formError and keeps isSubmitSuccess false on any changed event after failed submit',
    build: () {
      when(() => repository.add(any())).thenThrow(Exception('db fail'));
      return buildBloc();
    },
    seed:
        () => MeasurementFormState.initial(
          timestamp: DateTime(2026, 3, 22, 12, 0),
        ).copyWith(
          systolicInput: '120',
          diastolicInput: '80',
          pulseInput: '70',
        ),
    act: (bloc) {
      bloc
        ..add(const MeasurementFormEvent.submitted())
        ..add(const MeasurementFormEvent.commentChanged('new value'));
    },
    expect:
        () => [
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitting, 'isSubmitting', true)
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNull),
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitting, 'isSubmitting', false)
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNotNull),
          isA<MeasurementFormState>()
              .having((s) => s.commentInput, 'commentInput', 'new value')
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNull),
        ],
  );

  blocTest<MeasurementFormBloc, MeasurementFormState>(
    'submitFeedbackCleared clears submit feedback only',
    build: buildBloc,
    seed:
        () => MeasurementFormState.initial(
          timestamp: DateTime(2026, 3, 22, 12, 0),
        ).copyWith(
          isSubmitSuccess: true,
          formError: 'error',
          systolicInput: '123',
        ),
    act: (bloc) => bloc.add(const MeasurementFormEvent.submitFeedbackCleared()),
    expect:
        () => [
          isA<MeasurementFormState>()
              .having((s) => s.isSubmitSuccess, 'isSubmitSuccess', false)
              .having((s) => s.formError, 'formError', isNull)
              .having((s) => s.systolicInput, 'systolicInput', '123'),
        ],
  );
}
