# Project Structure

Recommended Flutter structure for the application.

---

## Top Level

```text
lib/
  app/
  core/
  features/
  shared/
  main.dart
```

---

## app/

Application bootstrap and app-level wiring.

Example:

```text
app/
  app.dart
  router.dart
```

---

## core/

Shared business logic and infrastructure.

Example:

```text
core/
  blood_pressure/
    bp_category.dart
    bp_classifier.dart

  db/
    app_database.dart
    tables/
      measurements_table.dart
    daos/
      measurements_dao.dart

  services/
  utils/
```

Rules:

- `core` is only for logic shared across multiple features
- do not put feature-specific UI or bloc code here
- `bp_classifier` is not a util; keep it in `core/blood_pressure/`

---

## features/

All user-facing functionality is split by feature.

Example:

```text
features/
  measurements/
    domain/
      measurement.dart
    data/
      measurement_mapper.dart
      measurement_repository.dart
    presentation/
      bloc/
        measurement_form_bloc.dart
        measurement_form_event.dart
        measurement_form_state.dart
      screens/
        add_measurement_screen.dart

  history/
  home/
  statistics/
  ai_analysis/
  reminders/
  export/
```

Rules:

- feature owns its logic
- domain model for measurement lives in `features/measurements/domain/`
- mappers and repositories live in `features/<feature>/data/`
- do not create extra layers without a real need

---

## shared/

Reusable UI only.

Example:

```text
shared/
  widgets/
  theme/
```

Rules:

- shared is for reusable presentation code
- no business logic in `shared/`

---

## tests/

Test structure mirrors `lib/` at a practical level.

Example:

```text
test/
  core/
    blood_pressure/
      bp_classifier_test.dart

  features/
    measurements/
      data/
        measurement_mapper_test.dart
        measurement_repository_test.dart
      presentation/
        bloc/
          measurement_form_bloc_test.dart
```

---

## General Rule

Start simple, evolve when needed.
