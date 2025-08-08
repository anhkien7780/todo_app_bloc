import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_navigator.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/edit_todo_page_mode.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/edit_todo_page.dart';

class TodoListNavigator extends AppNavigator {
  TodoListNavigator({required super.context});

  Future<bool?> showEditTodoPage({Todo? todo}) async {
    final pageMode = todo == null
        ? EditTodoPageMode.add
        : EditTodoPageMode.edit;
    return await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) {
        return EditTodoPage(todo: todo, mode: pageMode);
      },
    );
  }
}
