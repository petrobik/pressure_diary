import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/core/db/daos/measurements_dao.dart';
import 'package:pressure_diary/features/measurements/data/measurement_mapper.dart';
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;

class MeasurementRepository {
  MeasurementRepository({
    required MeasurementsDao dao,
  }) : _dao = dao;

  final MeasurementsDao _dao;

  Future<int> create({
    required int systolic,
    required int diastolic,
    required int pulse,
    required DateTime timestamp,
    int? mood,
    String? comment,
    List<String> tags = const [],
    required BpCategory category,
  }) {
    return _dao.insertMeasurement(
      MeasurementsCompanion.insert(
        systolic: systolic,
        diastolic: diastolic,
        pulse: pulse,
        timestamp: timestamp,
        mood: Value(mood),
        comment: Value(comment),
        tagsJson: Value(jsonEncode(tags)),
        category: category.index,
      ),
    );
  }

  Future<void> update(domain.Measurement measurement) async {
    final updatedRows = await _dao.updateById(
      measurement.id,
      mapMeasurementToCompanion(measurement),
    );
    if (updatedRows == 0) {
      throw StateError('Measurement ${measurement.id} does not exist');
    }
  }

  Future<void> delete(int id) async {
    await _dao.deleteById(id);
  }

  Future<void> restore(domain.Measurement measurement) async {
    await _dao.insertMeasurement(
      mapMeasurementToCompanion(measurement).copyWith(id: Value(measurement.id)),
    );
  }

  Stream<List<domain.Measurement>> watchAll() {
    return _dao.watchAll().map(
      (rows) => rows.map(mapMeasurementRowToDomain).toList(growable: false),
    );
  }

  Future<domain.Measurement?> getLatest() async {
    final row = await _dao.getLatest();
    return row == null ? null : mapMeasurementRowToDomain(row);
  }

  Stream<domain.Measurement?> watchLatest() {
    return _dao.watchLatest().map(
      (row) => row == null ? null : mapMeasurementRowToDomain(row),
    );
  }

  Future<List<domain.Measurement>> getByPeriod(DateTime from, DateTime to) async {
    final rows = await _dao.getByPeriod(from, to);
    return rows.map(mapMeasurementRowToDomain).toList(growable: false);
  }
}
