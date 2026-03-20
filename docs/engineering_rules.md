# Engineering Rules

This document defines implementation rules for the project.

The goal is to keep code:

- simple
- explicit
- predictable
- easy to refactor

---

## State Management

Use Bloc.

Do not use Cubit.

Each feature should have:

- `FeatureBloc`
- `FeatureEvent`
- `FeatureState`

---

## Freezed

Use Freezed for:

- domain models
- bloc events
- bloc states

Example:

```dart
@freezed
class MeasurementFormEvent with _$MeasurementFormEvent {
  const factory MeasurementFormEvent.systolicChanged(String value) = _SystolicChanged;
  const factory MeasurementFormEvent.diastolicChanged(String value) = _DiastolicChanged;
  const factory MeasurementFormEvent.pulseChanged(String value) = _PulseChanged;
  const factory MeasurementFormEvent.submitted() = _Submitted;
}
```

---

## Dependency Injection

Use manual constructor injection.

Allowed:

- create dependencies explicitly in `main.dart` or app composition layer
- pass repositories through widget tree using `RepositoryProvider`
- pass blocs through `BlocProvider`
- inject dependencies into blocs via constructor

Not allowed:

- service locator
- GetIt
- DI containers
- global registries
- hidden dependency resolution

Dependencies must stay explicit.

Example:

```dart
RepositoryProvider(
  create: (_) => MeasurementRepository(
    dao: database.measurementsDao,
  ),
  child: const PressureDiaryApp(),
)
```

Example bloc creation:

```dart
BlocProvider(
  create: (context) => MeasurementFormBloc(
    repository: context.read<MeasurementRepository>(),
    classifier: classifier,
  ),
  child: const AddMeasurementScreen(),
)
```

---

## Repository Design

This project does NOT enforce repository abstractions by default.

Use simple, concrete classes.

Example:

```dart
class MeasurementRepository {
  MeasurementRepository({
    required MeasurementsDao dao,
  }) : _dao = dao;

  final MeasurementsDao _dao;
}
```

No interface is required unless needed.

### When Abstraction Is Justified

Introduce abstractions only if there is a clear benefit:

- multiple implementations are required
- complex business logic needs isolation
- feature becomes large and hard to manage
- clear testing benefit

### Avoid

Do not introduce abstractions:

- just in case
- for architectural purity
- because of patterns or templates
- because AI suggests it

---

## UI Rules

Widgets must:

- render state
- send events

Widgets must NOT:

- contain business logic
- access database
- create repositories

---

## Mapping

Do not expose Drift models to UI.

Always map:

`Drift -> Domain -> UI`

---

## Validation

Validation must live in:

- bloc
- helpers

Not in widgets.

---

## General Rule

Prefer:

- simple code
- explicit dependencies
- minimal layers

Avoid:

- magic
- hidden state
- over-engineering
