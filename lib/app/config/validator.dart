class Validator {
  final String errorText;
  Validator({required this.errorText});

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorText != "" ? errorText : 'Invalid Email';
    } else {
      return null;
    }
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorText != "" ? errorText : 'Invalid Password';
    } else {
      return null;
    }
  }

  String? zip(String? value) {
    String pattern = r"^[0-9]{6}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorText != "" ? errorText : 'Invalid Zip Code';
    } else {
      return null;
    }
  }

  String? mobile(String? value) {
    String pattern = r'^-?[0-9]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorText != "" ? errorText : 'Invalid Mobile Number';
    } else {
      return null;
    }
  }

  String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return errorText != "" ? errorText : "Can't be empty";
    } else {
      return null;
    }
  }

  String? optional(String? value) {
    return null;
  }
}
