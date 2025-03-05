class Validator {
  Validator._();
  // Validates that the value is not empty
  static String? validateRequired(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateNumber(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return '$fieldName must be a number.';
    }
    return null;
  }
}
