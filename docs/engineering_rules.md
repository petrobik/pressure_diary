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

## Bloc Event Handling

For Freezed union events in Bloc:

- register a single handler with `on<FeatureEvent>(...)`
- dispatch with Dart `switch (event)`
- keep per-event logic in private methods
- do not use `when`, `map`, `maybeWhen`, or `maybeMap`
- do not register separate handlers like `on<_Foo>()`, `on<_Bar>()`, etc.
- do not introduce `_onEvent` wrapper methods
- do not create helper methods for trivial `emit(copyWith(...))` calls

Preferred style:

```dart
on<MeasurementFormEvent>(
  (event, emit) => switch (event) {
    _SystolicChanged(:final value) => _systolicChanged(value, emit),
    _DiastolicChanged(:final value) => _diastolicChanged(value, emit),
    _PulseChanged(:final value) => _pulseChanged(value, emit),
    _MoodChanged(:final mood) => _moodChanged(mood, emit),
    _CommentChanged(:final comment) => _commentChanged(comment, emit),
    _TagsChanged(:final tags) => _tagsChanged(tags, emit),
    _TimestampChanged(:final timestamp) => _timestampChanged(timestamp, emit),
    _Submitted() => _submitted(emit),
    _SubmitFeedbackCleared() => _submitFeedbackCleared(emit),
    _ => null,
  },
);
```

---

## Bloc File Structure

For Bloc + Freezed, use a single library split across files with `part` / `part of`.

Preferred structure:

```text
measurement_form/
  measurement_form.dart
  measurement_form_bloc.dart
  measurement_form_event.dart
  measurement_form_state.dart
```

`measurement_form.dart` contains:

- imports
- `part 'measurement_form.freezed.dart';`
- `part 'measurement_form_bloc.dart';`
- `part 'measurement_form_event.dart';`
- `part 'measurement_form_state.dart';`

Other files must use:

```dart
part of 'measurement_form.dart';
```

Rules:

- keep bloc/event/state in one library
- use one `measurement_form.freezed.dart` file
- do NOT generate separate `event.freezed.dart` and `state.freezed.dart`
- do NOT use generic file names like `bloc.dart`, `event.dart`, `state.dart`
- always use feature-prefixed file names:
  - `measurement_form_bloc.dart`
  - `measurement_form_event.dart`
  - `measurement_form_state.dart`

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

## Tests

Test structure mirrors `lib/` at a practical level.

Examples:

- `lib/core/blood_pressure/bp_classifier.dart`
  -> `test/core/blood_pressure/bp_classifier_test.dart`

- `lib/features/measurements/data/measurement_mapper.dart`
  -> `test/features/measurements/data/measurement_mapper_test.dart`

Prefer:

- unit tests for pure logic
- bloc tests for state management
- widget tests only where they add real value

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
