import 'package:drift/drift.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/core/db/tables/measurements_table.dart';

part 'measurements_dao.g.dart';

@DriftAccessor(tables: [Measurements])
class MeasurementsDao extends DatabaseAccessor<AppDatabase> with _$MeasurementsDaoMixin {
  MeasurementsDao(super.db);

  Future<int> insertMeasurement(MeasurementsCompanion entry) {
    return into(measurements).insert(entry);
  }

  Future<bool> updateMeasurement(Measurement entry) {
    return update(measurements).replace(entry);
  }

  Future<void> updateById(int id, MeasurementsCompanion entry) {
    return (update(measurements)..where((t) => t.id.equals(id))).write(
      entry.copyWith(updatedAt: Value(DateTime.now())),
    );
  }

  Future<int> deleteById(int id) {
    return (delete(measurements)..where((t) => t.id.equals(id))).go();
  }

  Stream<List<Measurement>> watchAll() {
    return (select(measurements)..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).watch();
  }

  Future<Measurement?> getLatest() {
    return (select(measurements)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<Measurement?> watchLatest() {
    return (select(measurements)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Future<List<Measurement>> getByPeriod(
    DateTime from,
    DateTime to,
  ) {
    return (select(measurements)
          ..where((t) => t.timestamp.isBiggerOrEqualValue(from) & t.timestamp.isSmallerOrEqualValue(to))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
  }
}
