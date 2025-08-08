import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_navigator.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/widgets/edit_todo_body.dart';

class TodoListNavigator extends AppNavigator {
  TodoListNavigator({required super.context});

  void showAddTodoPage({required Function(bool?) onDismissed}) async {
    final flag = await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) {
        return EditTodoBody();
      },
    );
    onDismissed(flag);
  }
}
