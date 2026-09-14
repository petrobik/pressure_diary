import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pressure_diary/app/app.dart';
import 'package:pressure_diary/app/app_bootstrap.dart';
import 'package:pressure_diary/core/db/app_database.dart';
import 'package:pressure_diary/features/measurements/data/measurement_repository.dart';

class _TrackingDatabase extends AppDatabase {
  _TrackingDatabase() : super(NativeDatabase.memory());

  int closeCalls = 0;
  bool isClosed = false;

  @override
  Future<void> close() async {
    closeCalls++;
    await super.close();
    isClosed = true;
  }
}

void main() {
  testWidgets('bootstrap provides one repository and closes its database', (tester) async {
    final database = _TrackingDatabase();
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    });

    await tester.pumpWidget(AppBootstrap(database: database));
    expect(find.byType(PressureDiaryApp), findsOneWidget);
    final repository = tester.element(find.byType(PressureDiaryApp)).read<MeasurementRepository>();
    await tester.runAsync(() async {
      expect(await repository.getLatest(), isNull);
    });

    await tester.pumpWidget(AppBootstrap(database: database));
    expect(tester.element(find.byType(PressureDiaryApp)).read<MeasurementRepository>(), same(repository));
    expect(database.closeCalls, 0);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    expect(database.closeCalls, 1);
    expect(database.isClosed, isTrue);
  });

  testWidgets('another database mounts a new bootstrap with its own lifetime', (tester) async {
    final firstDatabase = _TrackingDatabase();
    final secondDatabase = _TrackingDatabase();
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    });

    await tester.pumpWidget(AppBootstrap(database: firstDatabase));
    final firstState = tester.state(find.byType(AppBootstrap));
    final firstRepository = tester.element(find.byType(PressureDiaryApp)).read<MeasurementRepository>();

    await tester.pumpWidget(AppBootstrap(database: secondDatabase));
    await tester.pumpAndSettle();
    final secondRepository = tester.element(find.byType(PressureDiaryApp)).read<MeasurementRepository>();
    expect(tester.state(find.byType(AppBootstrap)), isNot(same(firstState)));
    expect(secondRepository, isNot(same(firstRepository)));
    expect(firstDatabase.closeCalls, 1);
    expect(firstDatabase.isClosed, isTrue);
    expect(secondDatabase.closeCalls, 0);
    await tester.runAsync(() async {
      expect(await secondRepository.getLatest(), isNull);
    });

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    expect(firstDatabase.closeCalls, 1);
    expect(secondDatabase.closeCalls, 1);
    expect(secondDatabase.isClosed, isTrue);
  });
}
