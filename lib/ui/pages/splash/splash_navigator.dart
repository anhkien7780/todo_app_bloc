import 'package:todo_app_bloc/common/app_navigator.dart';
import 'package:todo_app_bloc/router/router_config.dart';

class SplashNavigator extends AppNavigator{
  SplashNavigator({required super.context});

  Future<void> openTodoListPage(){
    return pushNamed(AppRouter.todoList);
  }
}