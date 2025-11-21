bool validateEmail(String input) {
  return RegExp(r"^(\+?\d{11,12}|\w+@\w+\.\w+)$").hasMatch(input);
}
