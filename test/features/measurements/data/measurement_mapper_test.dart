import 'package:flutter_test/flutter_test.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/db/app_database.dart' as db;
import 'package:pressure_diary/features/measurements/data/measurement_mapper.dart';
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;

void main() {
  group('mapMeasurementRowToDomain', () {
    test('maps drift row to domain model', () {
      final row = db.Measurement(
        id: 1,
        systolic: 128,
        diastolic: 84,
        pulse: 72,
        timestamp: DateTime(2026, 3, 21, 9, 30),
        mood: 4,
        comment: 'after walk',
        tagsJson: '["morning","walk"]',
        category: BpCategory.normal.index,
        createdAt: DateTime(2026, 3, 21, 9, 31),
        updatedAt: DateTime(2026, 3, 21, 9, 31),
      );

      final result = mapMeasurementRowToDomain(row);

      expect(result.systolic, 128);
      expect(result.diastolic, 84);
      expect(result.pulse, 72);
      expect(result.timestamp, DateTime(2026, 3, 21, 9, 30));
      expect(result.mood, 4);
      expect(result.comment, 'after walk');
      expect(result.tags, ['morning', 'walk']);
      expect(result.category, BpCategory.normal);
    });

    test('throws when category index is out of enum range', () {
      final row = db.Measurement(
        id: 1,
        systolic: 120,
        diastolic: 80,
        pulse: 70,
        timestamp: DateTime(2026, 3, 21, 9),
        mood: null,
        comment: null,
        tagsJson: '[]',
        category: 99,
        createdAt: DateTime(2026, 3, 21, 9, 1),
        updatedAt: DateTime(2026, 3, 21, 9, 1),
      );

      expect(() => mapMeasurementRowToDomain(row), throwsA(isA<StateError>()));
    });

    test('throws assertion error when tagsJson is invalid json', () {
      final row = db.Measurement(
        id: 1,
        systolic: 120,
        diastolic: 80,
        pulse: 70,
        timestamp: DateTime(2026, 3, 21, 9),
        mood: null,
        comment: null,
        tagsJson: '{broken',
        category: BpCategory.normal.index,
        createdAt: DateTime(2026, 3, 21, 9, 1),
        updatedAt: DateTime(2026, 3, 21, 9, 1),
      );

      expect(
        () => mapMeasurementRowToDomain(row),
        throwsA(isA<AssertionError>()),
      );
    });

    test('throws assertion error when tagsJson decodes to non-array', () {
      final row = db.Measurement(
        id: 1,
        systolic: 120,
        diastolic: 80,
        pulse: 70,
        timestamp: DateTime(2026, 3, 21, 9),
        mood: null,
        comment: null,
        tagsJson: '{"tag":"morning"}',
        category: BpCategory.normal.index,
        createdAt: DateTime(2026, 3, 21, 9, 1),
        updatedAt: DateTime(2026, 3, 21, 9, 1),
      );

      expect(
        () => mapMeasurementRowToDomain(row),
        throwsA(isA<AssertionError>()),
      );
    });

    test('throws assertion error when tagsJson array has non-string items', () {
      final row = db.Measurement(
        id: 1,
        systolic: 120,
        diastolic: 80,
        pulse: 70,
        timestamp: DateTime(2026, 3, 21, 9),
        mood: null,
        comment: null,
        tagsJson: '["ok", 1]',
        category: BpCategory.normal.index,
        createdAt: DateTime(2026, 3, 21, 9, 1),
        updatedAt: DateTime(2026, 3, 21, 9, 1),
      );

      expect(
        () => mapMeasurementRowToDomain(row),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('mapMeasurementToCompanion', () {
    test('maps domain model to companion with nullable values', () {
      final measurement = domain.Measurement(
        systolic: 135,
        diastolic: 88,
        pulse: 75,
        timestamp: DateTime(2026, 3, 21, 20, 15),
        mood: 3,
        comment: 'evening',
        tags: const ['home', 'rest'],
        category: BpCategory.highNormal,
      );

      final companion = mapMeasurementToCompanion(measurement);

      expect(companion.systolic.present, isTrue);
      expect(companion.systolic.value, 135);
      expect(companion.diastolic.value, 88);
      expect(companion.pulse.value, 75);
      expect(companion.timestamp.value, DateTime(2026, 3, 21, 20, 15));
      expect(companion.mood.present, isTrue);
      expect(companion.mood.value, 3);
      expect(companion.comment.present, isTrue);
      expect(companion.comment.value, 'evening');
      expect(companion.tagsJson.present, isTrue);
      expect(companion.tagsJson.value, '["home","rest"]');
      expect(companion.category.value, BpCategory.highNormal.index);
    });

    test('keeps nullable fields absent when mood/comment are null', () {
      final measurement = domain.Measurement(
        systolic: 118,
        diastolic: 76,
        pulse: 66,
        timestamp: DateTime(2026, 3, 21, 7, 45),
        mood: null,
        comment: null,
        tags: const [],
        category: BpCategory.optimal,
      );

      final companion = mapMeasurementToCompanion(measurement);

      expect(companion.mood.present, isFalse);
      expect(companion.comment.present, isFalse);
      expect(companion.tagsJson.value, '[]');
      expect(companion.category.value, BpCategory.optimal.index);
    });
  });
}
