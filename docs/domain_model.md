# Domain Model

This document defines the core domain entities and rules.

---

## Measurement

`Measurement` represents a single blood pressure measurement recorded by the user.

Fields:

- `systolic` (`int`) — SBP
- `diastolic` (`int`) — DBP
- `pulse` (`int`)
- `timestamp` (`DateTime`)
- `mood` (`int?`)
- `comment` (`String?`)
- `tags` (`List<String>`)
- `category` (`BpCategory`)

Domain model should be immutable.

Example:

```dart
@freezed
abstract class Measurement with _$Measurement {
  const factory Measurement({
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

Note:
`MeasurementDraft` is not required by default.
Form draft state can live inside bloc state until a real separate draft model is justified.

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

Enum order must stay stable.

---

## Classification Rule

Category is determined by the worst value (SBP or DBP).

Rules:

- Hypotension: `SBP < 90` or `DBP < 60`
- Optimal: `SBP < 120` and `DBP < 80`
- Normal: `SBP 120–129` or `DBP 80–84`
- High Normal: `SBP 130–139` or `DBP 85–89`
- Hypertension 1: `SBP 140–159` or `DBP 90–99`
- Hypertension 2: `SBP 160–179` or `DBP 100–109`
- Hypertension 3: `SBP >= 180` or `DBP >= 110`

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

Tags are stored as non-null JSON string in database with default `'[]'` and mapped to `List<String>` in domain.
