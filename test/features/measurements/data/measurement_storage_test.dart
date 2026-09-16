import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/core/db/daos/measurements_dao.dart';
import 'package:pressure_diary/features/measurements/data/measurement_repository.dart';
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;

void main() {
  test('file database preserves Create/Edit IDs and fields and Delete across reopen', () async {
    final directory = await Directory.systemTemp.createTemp('pressure_diary_storage_');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/measurements.sqlite');
    final timestamp = DateTime.utc(2026, 9, 14, 20, 15, 30, 456);
    late int id;

    var database = AppDatabase(NativeDatabase(file));
    try {
      id = await MeasurementRepository(dao: MeasurementsDao(database)).create(
        systolic: 128,
        diastolic: 84,
        pulse: 70,
        timestamp: timestamp,
        mood: 0,
        comment: 'После прогулки',
        tags: ['вечер', 'прогулка'],
        category: BpCategory.normal,
      );
    } finally {
      await database.close();
    }

    late domain.Measurement edited;
    database = AppDatabase(NativeDatabase(file));
    try {
      final repository = MeasurementRepository(dao: MeasurementsDao(database));
      final stored = (await repository.getLatest())!;
      expect(stored.id, id);
      expect(stored.timestamp.isAtSameMomentAs(DateTime.utc(2026, 9, 14, 20, 15, 30)), isTrue);
      expect(
        stored.copyWith(timestamp: timestamp),
        domain.Measurement(
          id: id,
          systolic: 128,
          diastolic: 84,
          pulse: 70,
          timestamp: timestamp,
          mood: 0,
          comment: 'После прогулки',
          tags: ['вечер', 'прогулка'],
          category: BpCategory.normal,
        ),
      );
      edited = stored.copyWith(
        systolic: 115,
        diastolic: 75,
        pulse: 65,
        mood: null,
        comment: null,
        tags: ['утро'],
        category: BpCategory.optimal,
        timestamp: DateTime(2026, 9, 15, 7, 10, 25),
      );
      await repository.update(edited);
    } finally {
      await database.close();
    }

    database = AppDatabase(NativeDatabase(file));
    try {
      final repository = MeasurementRepository(dao: MeasurementsDao(database));
      expect(await repository.getLatest(), edited);
      await repository.delete(id);
    } finally {
      await database.close();
    }

    database = AppDatabase(NativeDatabase(file));
    try {
      expect(await MeasurementRepository(dao: MeasurementsDao(database)).watchAll().first, isEmpty);
    } finally {
      await database.close();
    }
  });
}
