# Domain Model

This document defines the core domain entities and rules.

---

## Measurement

`Measurement` represents a persisted blood pressure measurement recorded by the user.

Fields:

- `id` (`int`) - persistent identity of the stored measurement
- `systolic` (`int`) - SBP
- `diastolic` (`int`) - DBP
- `pulse` (`int`)
- `timestamp` (`DateTime`)
- `mood` (`int?`)
- `comment` (`String?`)
- `tags` (`List<String>`)
- `category` (`BpCategory`)

Domain model should be immutable.

Example target shape:

```dart
@freezed
abstract class Measurement with _$Measurement {
  const factory Measurement({
    required int id,
    required int systolic,
    required int diastolic,
    required int pulse,
    required DateTime timestamp,
    int? mood,
    String? comment,
    @Default([]) List<String> tags,
    required BpCategory category,
  }) = _Measurement;
}
```

### Identity

Persisted measurements must have stable identity because History supports edit and delete flows.

Do not use a fake ID for a new unsaved measurement and do not make `Measurement.id` nullable only to support form drafts.

The create-flow may keep user input inside Bloc state until persistence. The concrete repository/create contract is resolved when implementing the Measurement flow.

### Form Draft

`MeasurementDraft` is not required by default.

Form draft state can live inside Bloc state until a real separate draft model is justified.

---

## Mood

`mood` is optional and stored as `int?`.

Supported values:

- `0` - excellent
- `1` - normal
- `2` - so-so
- `3` - bad
- `null` - not specified

Values outside `0..3` are not part of the product contract.

The integer representation is retained for the MVP. Introducing a domain enum or a database migration requires separate justification.

---

## BpCategory

Categories:

- `hypotension`
- `optimal`
- `normal`
- `highNormal`
- `hypertension1`
- `hypertension2`
- `hypertension3`

Enum order must stay stable because categories are persisted as integers.

---

## Classification Thresholds

The product uses the following adult blood-pressure thresholds:

- Hypotension: `SBP < 90` or `DBP < 60`
- Optimal: `SBP < 120` and `DBP < 80`
- Normal: `SBP 120-129` or `DBP 80-84`
- High Normal: `SBP 130-139` or `DBP 85-89`
- Hypertension 1: `SBP 140-159` or `DBP 90-99`
- Hypertension 2: `SBP 160-179` or `DBP 100-109`
- Hypertension 3: `SBP >= 180` or `DBP >= 110`

### Conflict Resolution

The threshold table alone does not fully define mixed cases where SBP and DBP fall into categories with different semantics, especially combinations involving hypotension and an elevated value.

Do not infer a new priority rule from the phrase "worst value".

The exact deterministic conflict-resolution contract must be explicitly approved before changing `BpClassifier`. Until then, the existing classifier implementation and its tests are the implementation baseline, while this case remains an open domain contract.

Classification is a deterministic application rule and is not delegated to AI.

---

## Database Mapping

In database `category` is stored as integer:

- `hypotension` -> `0`
- `optimal` -> `1`
- `normal` -> `2`
- `highNormal` -> `3`
- `hypertension1` -> `4`
- `hypertension2` -> `5`
- `hypertension3` -> `6`

Measurement identity maps to the persisted auto-increment database row ID.

Tags are stored as non-null JSON string in database with default `'[]'` and mapped to `List<String>` in domain.
