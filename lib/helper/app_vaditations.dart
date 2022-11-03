class AppValidation {
  static bool isPhoneNumberValid(String num) {
    if (num.isNotEmpty) {
      bool numberValid = RegExp(r"^[6-9][0-9]{9}$").hasMatch(num);
      bool numberValid1 = RegExp(r"(\d)(?=(?:\d*\1){9})").hasMatch(num);
      return !numberValid || numberValid1;
    }
    return true;
  }

  static bool isEmailValid(String email) {
    if (email.isNotEmpty) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      return !emailValid;
    }
    return true;
  }
}
