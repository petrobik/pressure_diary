import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/db/app_database.dart' as db;
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;

domain.Measurement mapMeasurementRowToDomain(db.Measurement row) {
  final categoryIndex = row.category;

  if (categoryIndex < 0 || categoryIndex >= BpCategory.values.length) {
    throw StateError('Unknown blood pressure category index: $categoryIndex');
  }

  return domain.Measurement(
    systolic: row.systolic,
    diastolic: row.diastolic,
    pulse: row.pulse,
    timestamp: row.timestamp,
    mood: row.mood,
    comment: row.comment,
    tags: _decodeTags(row.tagsJson),
    category: BpCategory.values[categoryIndex],
  );
}

db.MeasurementsCompanion mapMeasurementToCompanion(
  domain.Measurement measurement,
) {
  return db.MeasurementsCompanion.insert(
    systolic: measurement.systolic,
    diastolic: measurement.diastolic,
    pulse: measurement.pulse,
    timestamp: measurement.timestamp,
    mood: measurement.mood == null ? const Value.absent() : Value(measurement.mood),
    comment: measurement.comment == null ? const Value.absent() : Value(measurement.comment),
    tagsJson: Value(jsonEncode(measurement.tags)),
    category: measurement.category.index,
  );
}

List<String> _decodeTags(String tagsJson) {
  List<String> invalid(String message) {
    assert(false, message);
    return const [];
  }

  if (tagsJson.isEmpty) {
    return const [];
  }

  late final Object? decoded;

  try {
    decoded = jsonDecode(tagsJson);
  } on FormatException {
    return invalid('tagsJson is not valid JSON');
  }

  if (decoded is! List) {
    return invalid('tagsJson must decode to a JSON array');
  }

  final tags = <String>[];

  for (final item in decoded) {
    if (item is! String) {
      return invalid('tagsJson array must contain only strings');
    }
    tags.add(item);
  }

  return tags;
}
