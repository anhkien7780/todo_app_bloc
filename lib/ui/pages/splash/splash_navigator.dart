import 'package:todo_app_bloc/common/app_navigator.dart';
import 'package:todo_app_bloc/router/router_config.dart';

class SplashNavigator extends AppNavigator{
  SplashNavigator({required super.context});

  @override
  Future<void> openTodoListPage() async {
    return pushReplacementNamed(AppRouter.todoList);
  }

  Future<void> openLoginPage() async {
    return pushReplacementNamed(AppRouter.login);
  }
}