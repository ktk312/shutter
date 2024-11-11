class customValidations {
  // name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    if (value.length < 3) {
      return 'Name must be atleast 3 characters';
    }

    return null;
  }

  // custom validation
  static String? validateEmptyText(String? filedname, String? value) {
    if (value == null || value.isEmpty) {
      return '$filedname is required';
    }

    return null;
  }

  // validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email adress';
    }
    return null;
  }

  // validate email
  static String? validateMacAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'MAC Address is required';
    }

    if (value.length != 12) {
      return 'MAC Address must be exactly 12 characters';
    }
    return null;
  }

  // validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  // validate confirm password
  static String? validateConfirmPassword(
      String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    }

    if (confirmPassword != password) {
      return 'Passwords does not match';
    }

    return null;
  }

  // validate phoneNumber
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    final phoneRegExp = RegExp(r'^\d{11}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (11 digits required)';
    }
    return null;
  }
}
