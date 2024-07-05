// input_validation_service.dart
// containing functions only

String? validatePaddockNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a Paddock Number';
  }
  final n = int.tryParse(value);
  if (n == null || n <= 0) {
    return 'Please enter a valid positive number';
  }
  return null;
}

String? validateText(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return 'Please enter a $fieldName';
  }
  return null;
}

String? validatePropertyAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a Property Address';
  }
  // Example regex for address validation (you might want to adjust this for your specific needs)
  final RegExp addressRegExp = RegExp(r'^[a-zA-Z0-9\s,.\-]+$');
  if (!addressRegExp.hasMatch(value)) {
    return 'Please enter a valid Property Address';
  }
  return null;
}

String? validateMobName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a Mob Name';
  }
  // Example regex for name validation (you might want to adjust this for your specific needs)
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegExp.hasMatch(value)) {
    return 'Please enter a valid Mob Name';
  }
  return null;
}