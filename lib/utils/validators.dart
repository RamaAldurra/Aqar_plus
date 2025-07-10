// lib/utils/validators.dart

String? validateArea(String? value, {required bool isMin, String? minText, String? maxText}) {
  if (value == null || value.isEmpty) return null; // اختياري

  final intVal = int.tryParse(value);
  if (intVal == null) return 'رقم غير صالح';

  if (intVal < 30) return 'يجب ألا تقل المساحة عن 30م';
  if (intVal > 1000) return 'الحد الأقصى 1000م';

  if (minText != null && maxText != null) {
    final min = int.tryParse(minText);
    final max = int.tryParse(maxText);
    if (min != null && max != null && max <= min) {
      return isMin ? null : 'يجب أن تكون القيمة أكبر من البداية';
    }
  }

  return null;
}

String? validatePrice(String? value, {required bool isMin, String? minText, String? maxText}) {
  if (value == null || value.isEmpty) return null; // اختياري

  final intVal = int.tryParse(value);
  if (intVal == null) return 'رقم غير صالح';

  if (intVal < 100000) return 'يجب ألا يقل السعر عن 100,000';
  if (intVal > 10000000) return 'الحد الأقصى 10,000,000';

  if (minText != null && maxText != null) {
    final min = int.tryParse(minText);
    final max = int.tryParse(maxText);
    if (min != null && max != null && max <= min) {
      return isMin ? null : 'القيمة القصوى يجب أن تكون أكبر من البداية';
    }
  }

  return null;
}
