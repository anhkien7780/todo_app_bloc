class AppValidator {
  AppValidator._();

  static bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static _isValidPassword(String password) {
    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\\$%^&*(),.?":{}|<>]).{8,}$',
    );
    return regex.hasMatch(password);
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Please enter your email.";
    } else if (!AppValidator._isValidEmail(email)) {
      return "Please enter valid email.";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter your password.";
    } else if (!_isValidPassword(password)) {
      return "Password must be at least 8 characters, include 1 uppercase letter, 1 number, and 1 special character.";
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Please enter your password again.";
    } else if(password != confirmPassword){
      print("password: $password, confirmPassword: $confirmPassword");
      return "Password not match";
    }
    return null;
  }
}
