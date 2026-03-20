import 'package:pressure_diary/core/blood_pressure/bp_category.dart';

final class BpClassifier {
  const BpClassifier();

  BpCategory classify({
    required int systolic,
    required int diastolic,
  }) {
    return switch ((systolic, diastolic)) {
      (>= 180, _) || (_, >= 110) => BpCategory.hypertension3,
      (>= 160, _) || (_, >= 100) => BpCategory.hypertension2,
      (>= 140, _) || (_, >= 90) => BpCategory.hypertension1,
      (>= 130, _) || (_, >= 85) => BpCategory.highNormal,
      (>= 120, _) || (_, >= 80) => BpCategory.normal,
      (< 90, _) || (_, < 60) => BpCategory.hypotension,
      _ => BpCategory.optimal,
    };
  }
}
