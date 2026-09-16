import 'package:flutter_test/flutter_test.dart';
import 'package:pressure_diary/core/blood_pressure/bp_category.dart';
import 'package:pressure_diary/core/blood_pressure/bp_classifier.dart';

void main() {
  const classifier = BpClassifier();
  // Characterizes current precedence, including mixed low/high readings.
  final cases = <(int, int, BpCategory)>[
    (89, 70, BpCategory.hypotension),
    (110, 59, BpCategory.hypotension),
    (90, 60, BpCategory.optimal),
    (119, 79, BpCategory.optimal),
    (120, 70, BpCategory.normal),
    (110, 80, BpCategory.normal),
    (129, 84, BpCategory.normal),
    (130, 70, BpCategory.highNormal),
    (110, 85, BpCategory.highNormal),
    (139, 89, BpCategory.highNormal),
    (140, 70, BpCategory.hypertension1),
    (110, 90, BpCategory.hypertension1),
    (159, 99, BpCategory.hypertension1),
    (160, 70, BpCategory.hypertension2),
    (110, 100, BpCategory.hypertension2),
    (179, 109, BpCategory.hypertension2),
    (180, 70, BpCategory.hypertension3),
    (110, 110, BpCategory.hypertension3),
    (80, 80, BpCategory.normal),
    (120, 50, BpCategory.normal),
    (80, 110, BpCategory.hypertension3),
    (180, 50, BpCategory.hypertension3),
  ];
  for (final (systolic, diastolic, expected) in cases) {
    test('$systolic/$diastolic → $expected', () {
      expect(classifier.classify(systolic: systolic, diastolic: diastolic), expected);
    });
  }
}
