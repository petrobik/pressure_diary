import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/core/db/daos/measurements_dao.dart';
import 'package:pressure_diary/features/measurements/data/measurement_repository.dart';

void main() {
  late AppDatabase database;
  late MeasurementRepository repository;
  final timestamp = DateTime(2026, 3, 21, 8);

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = MeasurementRepository(dao: MeasurementsDao(database));
    addTearDown(database.close);
  });

  Future<int> create({int? mood = 3, DateTime? time}) => repository.create(
    systolic: 128,
    diastolic: 84,
    pulse: 70,
    timestamp: time ?? timestamp,
    mood: mood,
    comment: 'before update',
    tags: ['morning'],
    category: BpCategory.normal,
  );

  test('create returns stored ID and update preserves identity and clears nullable fields', () async {
    final id = await create();
    final inserted = (await repository.getLatest())!;
    expect(id, greaterThan(0));
    expect(inserted.id, id);
    expect(inserted.mood, 3);
    final edited = inserted.copyWith(mood: null, comment: null, pulse: 75);
    await repository.update(edited);
    expect(await repository.getLatest(), edited);
    final row = await database.select(database.measurements).getSingle();
    expect(row.id, id);
    expect(row.mood, isNull);
    expect(row.comment, isNull);
    expect(row.tagsJson, '["morning"]');
    expect(row.category, BpCategory.normal.index);
  });

  test('update of missing ID fails without inserting or modifying other rows', () async {
    await create();
    final existing = (await repository.getLatest())!;
    await expectLater(repository.update(existing.copyWith(id: existing.id + 1)), throwsStateError);
    expect(await repository.watchAll().first, [existing]);
    await repository.delete(existing.id);
    await expectLater(repository.update(existing), throwsStateError);
    expect(await repository.watchAll().first, isEmpty);
  });

  for (final mood in <int?>[null, 0, 1, 2, 3, -1, 4, 5]) {
    test('reads mood $mood without rewriting the stored row', () async {
      final id = await MeasurementsDao(database).insertMeasurement(
        MeasurementsCompanion.insert(
          systolic: 120,
          diastolic: 80,
          pulse: 70,
          timestamp: timestamp,
          mood: Value(mood),
          category: BpCategory.normal.index,
        ),
      );
      final before = await database.select(database.measurements).getSingle();
      final expected = mood != null && mood >= 0 && mood <= 3 ? mood : null;
      expect((await repository.getLatest())!.mood, expected);
      expect((await repository.watchLatest().first)!.mood, expected);
      expect((await repository.watchAll().first).single.mood, expected);
      final period = await repository.getByPeriod(timestamp, timestamp);
      expect(period.single.id, id);
      expect(period.single.mood, expected);
      expect(await database.select(database.measurements).getSingle(), before);
    });
  }

  test('watchAll follows CRUD and sorts timestamp then ID descending without deduplication', () async {
    final stream = StreamIterator(repository.watchAll());
    addTearDown(stream.cancel);
    expect(await stream.moveNext(), isTrue);
    expect(stream.current, isEmpty);

    var next = stream.moveNext();
    final firstId = await create();
    expect(await next, isTrue);
    final first = stream.current.single;
    expect(first.id, firstId);

    next = stream.moveNext();
    final secondId = await create();
    expect(await next, isTrue);
    expect(secondId, greaterThan(firstId));
    expect(stream.current.map((m) => m.id), [secondId, firstId]);
    expect(stream.current.first.copyWith(id: firstId), first);

    next = stream.moveNext();
    final thirdId = await create(time: timestamp.subtract(const Duration(days: 1)));
    expect(await next, isTrue);
    expect(stream.current.map((m) => m.id), [secondId, firstId, thirdId]);

    next = stream.moveNext();
    final edited = first.copyWith(timestamp: timestamp.add(const Duration(days: 1)), pulse: 77);
    await repository.update(edited);
    expect(await next, isTrue);
    expect(stream.current.map((m) => m.id), [firstId, secondId, thirdId]);
    expect(stream.current.first, edited);

    next = stream.moveNext();
    await repository.delete(secondId);
    expect(await next, isTrue);
    expect(stream.current.map((m) => m.id), [firstId, thirdId]);
  });
}
