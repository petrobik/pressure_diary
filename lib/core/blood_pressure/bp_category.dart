enum BpCategory {
  hypotension,
  optimal,
  normal,
  highNormal,
  hypertension1,
  hypertension2,
  hypertension3;

  bool get isHypertension => switch (this) {
    hypertension1 || hypertension2 || hypertension3 => true,
    _ => false,
  };

  bool get isCriticalHigh => this == hypertension3;
}
