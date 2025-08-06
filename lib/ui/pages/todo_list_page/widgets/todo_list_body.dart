import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_cubit.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_page.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_cubit.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_state.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/widgets/todo_list_view.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/widgets/todos_screen_header.dart';

class TodoListBody extends StatelessWidget {
  const TodoListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(child: TodosScreenHeader()),
            Positioned.fill(
              top: 158,
              child: Padding(
                padding: EdgeInsets.only(bottom: 100, right: 16, left: 16),
                child: ListView(
                  children: [
                    BlocBuilder<TodoListCubit, TodoListState>(
                      builder: (context, state) {
                        return TodoListView(
                          todoList: state.unCompletedTodos,
                          onToggleCheckBox: (todo) {
                            context.read<TodoListCubit>().toggleCheckBox(todo);
                          },
                        );
                      },
                    ),
                    BlocBuilder<TodoListCubit, TodoListState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.completedTodos.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: Text(
                                  "Completed",
                                  style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            TodoListView(
                              todoList: state.completedTodos,
                              onToggleCheckBox: (todo) {
                                context.read<TodoListCubit>().toggleCheckBox(
                                  todo,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              right: 16,
              left: 16,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                  fixedSize: WidgetStatePropertyAll(Size(358, 56)),
                ),
                onPressed: () {
                  final cubit = context.read<TodoListCubit>();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return BlocProvider(
                        create: (context) {
                          return AddTodoCubit();
                        },
                        child: AddTodo(
                          onAddButtonPressed: (todo) {
                            cubit.addTodo(todo);
                          },
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Add New Task",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
