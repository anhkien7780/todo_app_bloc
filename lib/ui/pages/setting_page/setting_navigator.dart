import 'package:todo_app_bloc/common/app_navigator.dart';
import 'package:todo_app_bloc/router/router_config.dart';

class SettingNavigator extends AppNavigator {
  SettingNavigator({required super.context});

  void onBackButtonPressed() {
    pushReplacementNamed(AppRouter.todoList);
  }

  void openChangePasswordPage() {
    pushNamed(AppRouter.changePassword);
  }
}
