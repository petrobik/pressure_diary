// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurements_dao.dart';

// ignore_for_file: type=lint
mixin _$MeasurementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $MeasurementsTable get measurements => attachedDatabase.measurements;
  MeasurementsDaoManager get managers => MeasurementsDaoManager(this);
}

class MeasurementsDaoManager {
  final _$MeasurementsDaoMixin _db;
  MeasurementsDaoManager(this._db);
  $$MeasurementsTableTableManager get measurements =>
      $$MeasurementsTableTableManager(_db.attachedDatabase, _db.measurements);
}
