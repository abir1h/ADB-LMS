mixin Validator {
  static bool isValidMobile(String mobileNo) {
    return RegExp(r'^\+?(88)?01[3456789][0-9]{8}\b')
            .allMatches(mobileNo)
            .length ==
        1;
  }

  static String isValidMobileExact(String mobileNo) {
    var r = RegExp(r'^\+?(88)?01[3456789][0-9]{8}\b').allMatches(mobileNo);
    return r.length == 1 ? r.elementAt(0).group(0) ?? "" : "";
  }

  static bool isValidMobileNo(String mobileNo) {
    var r = RegExp(r'^\+?(88)?01[3456789][0-9]{8}\b').allMatches(mobileNo);
    return r.length == 1;
  }

  static bool isValidMobileNumber(String mobileNo) {
    return RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
        .hasMatch(mobileNo);
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r"^[-!#$%&'*+/0-9=?A-Z^_a-z{|}~](\.?[-!#$%&'*+/0-9=?A-Z^_a-z{|}~])*@[a-zA-Z](-?[a-zA-Z0-9])*(\.[a-zA-Z](-?[a-zA-Z0-9])*)+$")
        .hasMatch(email);
  }

  static bool isEmpty(String? value) {
    return value == null || value.isEmpty || value.trim().isEmpty;
  }

  static bool isValidLength(String value, int minLength, int maxLength) {
    return value.length >= minLength && value.length <= maxLength;
  }
}
