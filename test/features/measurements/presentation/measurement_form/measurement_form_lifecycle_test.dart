import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/blood_pressure/bp_classifier.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/core/db/daos/measurements_dao.dart';
import 'package:pressure_diary/features/measurements/data/measurement_repository.dart';
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;
import 'package:pressure_diary/features/measurements/presentation/measurement_form/measurement_form.dart';

class _ControlledRepository extends MeasurementRepository {
  _ControlledRepository({required super.dao});

  Completer<void>? gate;
  int creates = 0;
  int updates = 0;

  @override
  Future<int> create({
    required int systolic,
    required int diastolic,
    required int pulse,
    required DateTime timestamp,
    int? mood,
    String? comment,
    List<String> tags = const [],
    required BpCategory category,
  }) async {
    creates++;
    await gate?.future;
    return super.create(
      systolic: systolic,
      diastolic: diastolic,
      pulse: pulse,
      timestamp: timestamp,
      mood: mood,
      comment: comment,
      tags: tags,
      category: category,
    );
  }

  @override
  Future<void> update(domain.Measurement measurement) async {
    updates++;
    await gate?.future;
    await super.update(measurement);
  }
}

Future<void> send(MeasurementFormBloc bloc, MeasurementFormEvent event) async {
  bloc.add(event);
  await Future<void>.delayed(Duration.zero);
}

Future<void> save(MeasurementFormBloc bloc, {bool fails = false}) async {
  final settled = bloc.stream.firstWhere((s) => fails ? s.formError != null : s.isSubmitSuccess);
  bloc.add(const MeasurementFormEvent.submitted());
  await settled;
}

void main() {
  late AppDatabase database;
  late _ControlledRepository repository;
  const classifier = BpClassifier();

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = _ControlledRepository(dao: MeasurementsDao(database));
    addTearDown(database.close);
  });

  MeasurementFormBloc build({domain.Measurement? original}) {
    final bloc = MeasurementFormBloc(repository: repository, classifier: classifier, initialMeasurement: original);
    addTearDown(bloc.close);
    return bloc;
  }

  Future<domain.Measurement> stored() async {
    await repository.create(
      systolic: 120,
      diastolic: 80,
      pulse: 70,
      timestamp: DateTime(2026, 3, 21, 8, 12, 37),
      mood: 2,
      comment: 'original',
      tags: ['home', 'rest'],
      // Deliberately differs from the current classifier to test preservation.
      category: BpCategory.optimal,
    );
    repository.creates = 0;
    return (await repository.getLatest())!;
  }

  test('Create starts empty and clean with opening timestamp; errors do not make it dirty', () async {
    final before = DateTime.now();
    final bloc = build();
    expect(bloc.state.timestamp.isBefore(before), isFalse);
    expect(bloc.state.timestamp.isAfter(DateTime.now()), isFalse);
    expect(bloc.state.systolicInput, '');
    expect(bloc.state.diastolicInput, '');
    expect(bloc.state.pulseInput, '');
    expect(bloc.state.isEditing, isFalse);
    expect(bloc.state.isDirty, isFalse);
    await save(bloc, fails: true);
    expect(bloc.state.isDirty, isFalse);
    await send(bloc, const MeasurementFormEvent.submitFeedbackCleared());
    expect(bloc.state.isDirty, isFalse);
    expect(repository.creates, 0);
  });

  test('Edit prefills every field and preserves identity, seconds and category on save', () async {
    final original = await stored();
    final bloc = build(original: original);
    expect(bloc.state.isEditing, isTrue);
    expect(bloc.state.isDirty, isFalse);
    expect(bloc.state.systolicInput, '120');
    expect(bloc.state.diastolicInput, '80');
    expect(bloc.state.pulseInput, '70');
    expect(bloc.state.timestamp, original.timestamp);
    expect(bloc.state.mood, 2);
    expect(bloc.state.commentInput, 'original');
    expect(bloc.state.tags, ['home', 'rest']);
    await save(bloc);
    expect(await repository.getLatest(), original);
    expect(repository.updates, 1);
    expect(repository.creates, 0);
    expect(bloc.state.isDirty, isFalse);
  });

  test('each editable field becomes dirty and returning its original value becomes clean', () async {
    final original = await stored();
    final bloc = build(original: original);
    final changes = <(MeasurementFormEvent, MeasurementFormEvent)>[
      (const MeasurementFormEvent.systolicChanged('121'), const MeasurementFormEvent.systolicChanged('120')),
      (const MeasurementFormEvent.diastolicChanged('81'), const MeasurementFormEvent.diastolicChanged('80')),
      (const MeasurementFormEvent.pulseChanged('71'), const MeasurementFormEvent.pulseChanged('70')),
      (const MeasurementFormEvent.moodChanged(null), const MeasurementFormEvent.moodChanged(2)),
      (const MeasurementFormEvent.commentChanged('changed'), const MeasurementFormEvent.commentChanged('original')),
      (
        const MeasurementFormEvent.tagsChanged(['rest', 'home']),
        const MeasurementFormEvent.tagsChanged(['home', 'rest']),
      ),
      (
        MeasurementFormEvent.timestampChanged(original.timestamp.add(const Duration(seconds: 1))),
        MeasurementFormEvent.timestampChanged(original.timestamp),
      ),
    ];
    for (final (change, revert) in changes) {
      await send(bloc, change);
      expect(bloc.state.isDirty, isTrue);
      await send(bloc, revert);
      expect(bloc.state.isDirty, isFalse);
    }
  });

  test('Edit normalizes optional values and keeps category when only other fields change', () async {
    final original = await stored();
    final bloc = build(original: original);
    await send(bloc, const MeasurementFormEvent.pulseChanged('77'));
    await send(bloc, const MeasurementFormEvent.moodChanged(null));
    await send(bloc, const MeasurementFormEvent.commentChanged('   '));
    await send(bloc, const MeasurementFormEvent.tagsChanged([' home ', '', 'home', 'Home', ' rest ', '   ']));
    final timestamp = original.timestamp.add(const Duration(days: 1));
    await send(bloc, MeasurementFormEvent.timestampChanged(timestamp));
    await save(bloc);
    expect(
      await repository.getLatest(),
      original.copyWith(pulse: 77, mood: null, comment: null, tags: ['home', 'Home', 'rest'], timestamp: timestamp),
    );
  });

  for (final event in [
    const MeasurementFormEvent.systolicChanged('160'),
    const MeasurementFormEvent.diastolicChanged('100'),
  ]) {
    test('changed pressure is classified on Edit: $event', () async {
      final original = await stored();
      final bloc = build(original: original);
      await send(bloc, event);
      await save(bloc);
      expect((await repository.getLatest())!.category, BpCategory.hypertension2);
    });
  }

  test('missing Edit row fails without falling back to create', () async {
    final original = await stored();
    await repository.delete(original.id);
    final bloc = build(original: original);
    await send(bloc, const MeasurementFormEvent.commentChanged('keep input'));
    await save(bloc, fails: true);
    expect(repository.creates, 0);
    expect(repository.updates, 1);
    expect(bloc.state.commentInput, 'keep input');
    expect(bloc.state.isLocked, isFalse);
    expect(await repository.watchAll().first, isEmpty);
  });

  for (final editing in [false, true]) {
    test('save locks all events, failure retains input, retry and success lock (editing=$editing)', () async {
      final original = editing ? await stored() : null;
      final bloc = build(original: original);
      await send(bloc, const MeasurementFormEvent.systolicChanged('130'));
      await send(bloc, const MeasurementFormEvent.diastolicChanged('85'));
      await send(bloc, const MeasurementFormEvent.pulseChanged('75'));
      await send(bloc, const MeasurementFormEvent.moodChanged(1));
      await send(bloc, const MeasurementFormEvent.commentChanged('  saved  '));
      await send(bloc, const MeasurementFormEvent.tagsChanged([' x ', 'x', 'X', '']));
      await send(bloc, MeasurementFormEvent.timestampChanged(DateTime(2026, 3, 21, 9, 10, 11)));
      final input = bloc.state;
      final blockedEvents = [
        const MeasurementFormEvent.submitted(),
        const MeasurementFormEvent.systolicChanged('200'),
        const MeasurementFormEvent.diastolicChanged('110'),
        const MeasurementFormEvent.pulseChanged('90'),
        const MeasurementFormEvent.moodChanged(null),
        const MeasurementFormEvent.commentChanged('lost'),
        const MeasurementFormEvent.tagsChanged([]),
        MeasurementFormEvent.timestampChanged(DateTime(2000)),
        const MeasurementFormEvent.submitFeedbackCleared(),
      ];
      repository.gate = Completer<void>();
      await send(bloc, const MeasurementFormEvent.submitted());
      expect(bloc.state.isSubmitting, isTrue);
      expect(bloc.state.isLocked, isTrue);
      final saving = bloc.state;
      for (final event in blockedEvents) {
        await send(bloc, event);
      }
      expect(bloc.state, saving);
      expect(repository.creates + repository.updates, 1);
      final failed = bloc.stream.firstWhere((s) => s.formError != null);
      repository.gate!.completeError(StateError('write failed'));
      await failed;
      expect(bloc.state.copyWith(formError: null), input);
      expect(bloc.state.isLocked, isFalse);
      repository.gate = null;
      await save(bloc);
      expect(repository.creates, editing ? 0 : 2);
      expect(repository.updates, editing ? 2 : 0);
      final success = bloc.state;
      expect(success.isLocked, isTrue);
      expect(success.isDirty, isTrue);
      for (final event in blockedEvents) {
        await send(bloc, event);
      }
      expect(bloc.state, success);
      expect(repository.creates + repository.updates, 2);
      final result = (await repository.getLatest())!;
      expect(result.category, BpCategory.highNormal);
      expect(result.comment, 'saved');
      expect(result.tags, ['x', 'X']);
      expect(result.timestamp, input.timestamp);
      if (original != null) expect(result.id, original.id);
    });
  }
}
