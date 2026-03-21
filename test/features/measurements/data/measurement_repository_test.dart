import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/core/db/daos/measurements_dao.dart';
import 'package:pressure_diary/features/measurements/data/measurement_repository.dart';
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;

void main() {
  group('MeasurementRepository', () {
    test('update clears nullable fields in database', () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      final dao = MeasurementsDao(database);
      final repository = MeasurementRepository(dao: dao);

      await repository.add(
        domain.Measurement(
          systolic: 128,
          diastolic: 84,
          pulse: 70,
          timestamp: DateTime(2026, 3, 21, 8, 0),
          mood: 5,
          comment: 'before update',
          tags: const ['morning'],
          category: BpCategory.normal,
        ),
      );

      final inserted = await dao.getLatest();
      expect(inserted, isNotNull);
      expect(inserted!.mood, isNotNull);
      expect(inserted.comment, isNotNull);

      final id = inserted.id;

      await repository.update(
        id: id,
        measurement: domain.Measurement(
          systolic: 128,
          diastolic: 84,
          pulse: 70,
          timestamp: DateTime(2026, 3, 21, 8, 0),
          mood: null,
          comment: null,
          tags: const ['morning'],
          category: BpCategory.normal,
        ),
      );

      final updated = await (database.select(database.measurements)
            ..where((t) => t.id.equals(id)))
          .getSingle();

      expect(updated.mood, isNull);
      expect(updated.comment, isNull);
      expect(updated.systolic, 128);
      expect(updated.tagsJson, '["morning"]');
      expect(updated.category, BpCategory.normal.index);
    });
  });
}
