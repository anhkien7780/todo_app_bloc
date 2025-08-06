import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_cubit.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_state.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/widgets/todo_list_body.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = TodoListCubit();
        cubit.fetchTodos();
        return cubit;
      },
      child: BlocBuilder<TodoListCubit, TodoListState>(
        builder: (context, state) {
          final Widget body;
          if (state.loadTodoStatus == LoadStatus.loading) {
            body = const Center(child: CircularProgressIndicator());
          } else if (state.loadTodoStatus == LoadStatus.success) {
            body = TodoListBody();
          } else {
            body = const Center(child: Text("Failed to load todos"));
          }
          return Scaffold(backgroundColor: AppColors.background, body: body);
        },
      ),
    );
  }
}
