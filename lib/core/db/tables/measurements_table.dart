import 'package:drift/drift.dart';

class Measurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get systolic => integer()();
  IntColumn get diastolic => integer()();
  IntColumn get pulse => integer()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get mood => integer().nullable()();
  TextColumn get comment => text().nullable()();
  TextColumn get tagsJson => text().withDefault(const Constant('[]'))();
  IntColumn get category => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  List<Set<Column>> get indexes => [
    {timestamp},
  ];
}
