import 'package:todo_app_bloc/common/app_navigator.dart';
import 'package:todo_app_bloc/router/router_config.dart';

class LoginNavigator extends AppNavigator{
  LoginNavigator({required super.context});

  Future<void> openSignUpPage(){
    return pushReplacementNamed(AppRouter.signUp);
  }
}