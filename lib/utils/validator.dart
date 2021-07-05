emailValidator(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) {
    return "Enter a valid Email Id";
  }
  return null;
}

passwordValidator(String password) {
  if (lengthValidator(password, 8) != null) {
    return lengthValidator(password, 8);
  }
  return null;
}

lengthValidator(String value, int n) {
  if (value.length < n) {
    return "Should be of length $n";
  }
  return null;
}
