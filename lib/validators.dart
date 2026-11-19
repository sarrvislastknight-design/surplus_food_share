// Shared validator functions used by TextFormField(validator: ...).
// A validator returns an error message (String) or null when the value is OK.

String? validateRequired(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter $fieldName';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your email';
  }
  final emailPattern = RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
  if (!emailPattern.hasMatch(value.trim())) {
    return 'Enter a valid email (e.g. name@mail.com)';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}
