import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_cubit.dart';
import 'package:todo_app_bloc/ui/widgets/common/todo_item.dart';

class TodoListView extends StatelessWidget {
  final List<Todo> todoList;
  final Function(Todo todo) onToggleCheckBox;

  const TodoListView({
    super.key,
    required this.todoList,
    required this.onToggleCheckBox,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodoListCubit>();
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.cornerRadiusNormal),
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              final result = await cubit.navigator.showEditTodoPage(
                todo: todoList[index],
              );
              if (result == true) {
                cubit.fetchTodos();
              }
            },
            child: Dismissible(
              key: Key(todoList[index].id),
              onDismissed: (direction) {
                cubit.deleteTodo(todoList[index]);
              },
              child: TodoItem(
                todo: todoList[index],
                onToggleCheckBox: onToggleCheckBox,
              ),
            ),
          );
        },
        separatorBuilder: (_, _) => Divider(
          height: AppDimens.dividerSize,
          color: AppColors.horizontalDivider,
        ),
        itemCount: todoList.length,
      ),
    );
  }
}
