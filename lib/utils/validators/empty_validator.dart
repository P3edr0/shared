class EmptyValidator {
  static bool emptyValidator(String? field) {
    if (field == null) return false;

    final bool isValid = field.trim().isNotEmpty;
    if (isValid) {
      return true;
    }
    return false;
  }
}
