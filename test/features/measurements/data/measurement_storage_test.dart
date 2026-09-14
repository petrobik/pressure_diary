import 'dart:async';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/core/db/daos/measurements_dao.dart';
import 'package:pressure_diary/features/measurements/data/measurement_repository.dart';
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;

domain.Measurement _measurement() => domain.Measurement(
  systolic: 128,
  diastolic: 84,
  pulse: 70,
  timestamp: DateTime.utc(2026, 9, 14, 20, 15, 30, 456),
  mood: 0,
  comment: 'После прогулки',
  tags: const ['вечер', 'прогулка'],
  category: BpCategory.normal,
);

void _expectStored(domain.Measurement actual, domain.Measurement original) {
  // The existing Drift schema stores timestamps as whole Unix seconds.
  final storedTimestamp = DateTime.fromMillisecondsSinceEpoch(
    original.timestamp.millisecondsSinceEpoch ~/ 1000 * 1000,
  );
  expect(actual.timestamp.isAtSameMomentAs(storedTimestamp), isTrue);
  expect(actual.copyWith(timestamp: original.timestamp), original);
}

void main() {
  test('watchAll emits an added measurement with all fields', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = MeasurementRepository(dao: MeasurementsDao(database));
    final measurements = StreamIterator(repository.watchAll());
    addTearDown(measurements.cancel);

    expect(await measurements.moveNext(), isTrue);
    expect(measurements.current, isEmpty);

    final measurement = _measurement();
    final nextEmission = measurements.moveNext();
    await repository.add(measurement);
    expect(await nextEmission, isTrue);
    expect(measurements.current, hasLength(1));
    _expectStored(measurements.current.single, measurement);
  });

  test('file database preserves measurement after closing and reopening', () async {
    final directory = await Directory.systemTemp.createTemp('pressure_diary_storage_');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/measurements.sqlite');
    final measurement = _measurement();

    final database = AppDatabase(NativeDatabase(file));
    try {
      await MeasurementRepository(dao: MeasurementsDao(database)).add(measurement);
    } finally {
      await database.close();
    }

    final reopened = AppDatabase(NativeDatabase(file));
    addTearDown(reopened.close);
    final stored = await MeasurementRepository(dao: MeasurementsDao(reopened)).getLatest();
    expect(stored, isNotNull);
    _expectStored(stored!, measurement);
  });
}
