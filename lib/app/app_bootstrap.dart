import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressure_diary/app/app.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/core/db/daos/measurements_dao.dart';
import 'package:pressure_diary/features/measurements/data/measurement_repository.dart';

/// Owns [database] for its mounted lifetime and closes it on disposal.
/// Database identity defines the bootstrap lifetime: another database mounts
/// a new bootstrap and disposes the previous one.
class AppBootstrap extends StatefulWidget {
  AppBootstrap({required this.database}) : super(key: ObjectKey(database));

  final AppDatabase database;

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  late final AppDatabase _database;
  late final MeasurementRepository _repository;

  @override
  void initState() {
    super.initState();

    _database = widget.database;

    _repository = MeasurementRepository(dao: MeasurementsDao(_database));
  }

  @override
  void dispose() {
    unawaited(_database.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _repository,
      child: const PressureDiaryApp(),
    );
  }
}
