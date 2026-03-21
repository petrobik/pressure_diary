import 'package:drift/drift.dart';
import 'package:pressure_diary/core/db/daos/measurements_dao.dart';
import 'package:pressure_diary/features/measurements/data/measurement_mapper.dart';
import 'package:pressure_diary/features/measurements/domain/measurement.dart' as domain;

class MeasurementRepository {
  MeasurementRepository({
    required MeasurementsDao dao,
  }) : _dao = dao;

  final MeasurementsDao _dao;

  Future<void> add(domain.Measurement measurement) async {
    await _dao.insertMeasurement(mapMeasurementToCompanion(measurement));
  }

  Future<void> update({
    required int id,
    required domain.Measurement measurement,
  }) async {
    final companion = mapMeasurementToCompanion(measurement).copyWith(
      mood: Value(measurement.mood),
      comment: Value(measurement.comment),
    );

    await _dao.updateById(id, companion);
  }

  Future<void> delete(int id) async {
    await _dao.deleteById(id);
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
