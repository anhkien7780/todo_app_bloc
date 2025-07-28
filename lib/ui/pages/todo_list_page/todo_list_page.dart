import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_cubit.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_state.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/widgets/todos_screen_header.dart';
import 'package:todo_app_bloc/ui/widgets/common/todo_item.dart';

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
          if (state.loadTodoStatus == LoadStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.loadTodoStatus == LoadStatus.success) {
            return TodoListBody();
          } else {
            return const Center(child: Text("Failed to load todos"));
          }
        },
      ),
    );
  }
}

class TodoListBody extends StatelessWidget {
  const TodoListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F5F9),
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
                        return TodoList(
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
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            TodoList(
                              todoList: state.completedTodos,
                              onToggleCheckBox: (todo) {
                                context.read<TodoListCubit>().toggleCheckBox(todo);
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
                  backgroundColor: WidgetStatePropertyAll(Color(0xff4A3780)),
                  fixedSize: WidgetStatePropertyAll(Size(358, 56)),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return AddTodo(onAddButtonPressed: (todo) {});
                    },
                  );
                },
                child: Text(
                  "Add New Task",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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

class TodoList extends StatelessWidget {
  final List<Todo> todoList;
  final Function(Todo todo) onToggleCheckBox;

  const TodoList({
    super.key,
    required this.todoList,
    required this.onToggleCheckBox,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(todoList[index].id),
            onDismissed: (direction) {},
            child: TodoItem(
              todo: todoList[index],
              onToggleCheckBox: onToggleCheckBox,
            ),
          );
        },
        separatorBuilder: (_, _) =>
            Divider(height: 1, color: Color(0xffE5E9ED)),
        itemCount: todoList.length,
      ),
    );
  }
}
