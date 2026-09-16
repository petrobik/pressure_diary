# Project Structure

Recommended Flutter structure for the application.

The structure follows product features and should evolve only when an implemented stage creates a real need.

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

Responsibilities:

- application composition
- root navigation shell when it is introduced
- app-level dependency wiring
- lifecycle ownership of app-scoped resources

Do not move feature business logic into `app/`.

---

## core/

Shared business logic and infrastructure used by multiple features.

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
- do not put feature-specific UI or Bloc code here
- `bp_classifier` is not a util; keep it in `core/blood_pressure/`
- do not pre-create future analytics or service layers before an implemented feature needs them

---

## features/

User-facing functionality is split by product feature.

Current / planned feature areas:

```text
features/
  measurements/
    domain/
      measurement.dart
    data/
      measurement_mapper.dart
      measurement_repository.dart
    presentation/
      measurement_form/
      screens/

  history/
  home/
  statistics/
  doctor_report/
  ai_analysis/
  reminders/
  backup/
  settings/
```

Rules:

- a feature owns its feature-specific logic and presentation
- the measurement domain model lives in `features/measurements/domain/`
- measurement mapper and repository live in `features/measurements/data/`
- History owns presentation/grouping behavior for browsing stored measurements
- `doctor_report/` represents the doctor-facing PDF/report flow; do not use a generic `export/` feature name for this product scenario
- `backup/` is for versioned app backup/restore and is separate from the doctor report
- `settings/` owns settings presentation and orchestration, not business logic belonging to other features
- do not create extra layers or folders only because later roadmap stages may need them

### Future deterministic analysis

Statistics and deterministic pattern analysis must stay independent from AI narrative generation.

Do not pre-select a package/folder layout for the future pattern-analysis stage before that stage is planned against the actual codebase. Place shared logic in `core/` only if it is genuinely shared by multiple implemented features; otherwise keep it with the owning feature.

---

## shared/

Reusable presentation code only.

Example:

```text
shared/
  widgets/
  theme/
```

Rules:

- `shared` is for reusable presentation code
- no business logic in `shared/`
- accessibility behavior that belongs to a reusable UI component should be implemented with that component, not deferred to release polish

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
        measurement_form/
          measurement_form_bloc_test.dart

    history/
```

Do not mirror directories mechanically when no test file exists. Keep tests close to the structure and responsibility of the production code they verify.

---

## General Rule

Start simple and evolve when needed.

The roadmap defines product stages, not folders. Do not create code structure for a future stage until implementation requires it.
