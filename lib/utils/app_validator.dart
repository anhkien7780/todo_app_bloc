import 'package:todo_app_bloc/generated/l10n.dart';

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
      return S.current.pleaseEnterYourEmail;
    } else if (!AppValidator._isValidEmail(email)) {
      return S.current.pleaseEnterValidEmail;
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return S.current.pleaseEnterYourPassword;
    } else if (!_isValidPassword(password)) {
      return S.current.passwordRuleError;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return S.current.pleaseEnterPasswordAgain;
    } else if(password != confirmPassword){
      return S.current.passwordNotMatch;
    }
    return null;
  }
}
