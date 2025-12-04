class EmailValidator {
  static bool validEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final bool isValid = emailRegex.hasMatch(email);
    if (isValid) {
      return true;
    }
    return false;
  }
}
