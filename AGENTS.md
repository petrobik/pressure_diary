# AGENTS.md
## Blood Pressure Diary (Flutter)

This repository contains a Flutter mobile application for tracking blood pressure.

This file helps AI coding agents work correctly with the project.

Detailed rules are in `/docs`.

---

# Project Summary

Offline-first mobile app for:

- recording blood pressure measurements
- viewing statistics and trends
- generating AI analysis
- reminders and export

The app does NOT provide medical diagnosis.

---

# Tech Stack

- Flutter
- Bloc
- Drift (SQLite)
- Freezed
- fl_chart
- flutter_local_notifications
- pdf / printing

---

# Core Principles

- offline-first
- local data only
- minimal and calm UI
- no medical diagnosis

---

# Architecture

Feature-first structure.

Main folders:

```text
lib/
  app/
  core/
  features/
  shared/
```

See `/docs/project_structure.md`.

---

# Domain

Main entity: `Measurement`.

See `/docs/domain_model.md`.

---

# Code Generation Rules

When generating code:

- use Bloc (not Cubit)
- use Freezed for Events and States
- use manual constructor injection
- use RepositoryProvider for repositories
- use BlocProvider for blocs
- do NOT use service locator
- do NOT use DI containers
- avoid unnecessary abstractions
- do not introduce layers "for architecture"
- keep business logic out of widgets

Always follow rules from `/docs` before generating code.

---

# Repository Design

By default:

- use concrete repositories
- do not create repository interfaces
- do not create `RepositoryImpl` classes unless abstraction gives real value
- do not add use cases by default

---

# Bloc + Freezed Rules

For Bloc + Freezed:

- use a single `on<Event>((event, emit) => switch (event) { ... })`
- dispatch each case to a private method
- use Dart pattern matching
- use private Freezed variants such as `_Submitted`, `_SystolicChanged`
- do NOT use `when` / `map` / `maybeWhen` / `maybeMap`
- do NOT use multiple `on<_Event>()`
- do NOT introduce `_onEvent` wrapper methods
- do NOT create helper methods for trivial `emit(copyWith(...))` calls

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

Use meaningful variable names in switch pattern matching when they improve readability.

Examples:

- `_MoodChanged(:final mood)`
- `_CommentChanged(:final comment)`
- `_TimestampChanged(:final timestamp)`

Avoid generic names like `value` when a semantic name is clearer.

---

# Bloc File Structure

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

# AI Analysis

AI works on aggregated data, not raw measurement lists.

See `/docs/ai_analysis_algorithm.md`.

---

# Development Approach

Build incrementally:

1. Measurements
2. History
3. Home
4. Statistics
5. AI analysis
6. Reminders
7. Export

---

# When Unsure

- follow existing patterns
- keep code simple
- avoid over-engineering
