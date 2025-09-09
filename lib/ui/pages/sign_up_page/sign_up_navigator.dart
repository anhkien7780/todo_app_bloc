import 'package:todo_app_bloc/common/app_navigator.dart';
import 'package:todo_app_bloc/router/router_config.dart';

class SignUpNavigator extends AppNavigator{
  SignUpNavigator({required super.context});

  Future<void> openLoginPage(){
    return pushReplacementNamed(AppRouter.login);
  }
}