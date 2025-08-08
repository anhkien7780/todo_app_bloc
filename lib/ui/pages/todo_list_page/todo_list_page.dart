import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_cubit.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_navigator.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_state.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/widgets/todo_list_view.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/widgets/todos_screen_header.dart';
import 'package:todo_app_bloc/ui/widgets/common/full_screen_loading.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TodoListCubit(
          repository: context.read<TodoRepository>(),
          navigator: TodoListNavigator(context: context),
        );
      },
      child: TodoListChildPage(),
    );
  }
}

class TodoListChildPage extends StatefulWidget {
  const TodoListChildPage({super.key});

  @override
  State<TodoListChildPage> createState() => _TodoListChildPageState();
}

class _TodoListChildPageState extends State<TodoListChildPage> {
  late TodoListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<TodoListCubit>();
    _cubit.fetchTodos();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListCubit, TodoListState>(
      buildWhen: (prev, current) {
        return prev.loadTodoStatus != current.loadTodoStatus;
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: TodoListBody(loadStatus: state.loadTodoStatus),
        );
      },
    );
  }
}

class TodoListBody extends StatelessWidget {
  const TodoListBody({super.key, required this.loadStatus});

  final LoadStatus loadStatus;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: TodosScreenHeader()),
        _buildTodoList(),
        _buildAddNewTaskButton(context),
        if (loadStatus == LoadStatus.loading) FullScreenLoading(),
      ],
    );
  }

  Positioned _buildTodoList() {
    return Positioned.fill(
      top: 158,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.marginNormal,
        ).copyWith(bottom: AppDimens.buttonHeight + AppDimens.marginLarge),
        child: ListView(
          children: [
            BlocBuilder<TodoListCubit, TodoListState>(
              buildWhen: (prev, current) {
                return prev.unCompletedTodos != current.unCompletedTodos;
              },
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
              buildWhen: (prev, current) {
                return prev.completedTodos != current.completedTodos;
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.completedTodos.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimens.marginLarge,
                        ),
                        child: Text(
                          S.of(context).completed,
                          style: AppTextStyles.blackS16SemiBold,
                        ),
                      ),
                    TodoListView(
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
    );
  }

  Positioned _buildAddNewTaskButton(BuildContext context) {
    TodoListCubit cubit = context.read<TodoListCubit>();
    return Positioned(
      bottom: AppDimens.marginLarge,
      right: AppDimens.marginNormal,
      left: AppDimens.marginNormal,
      child: SizedBox(
        height: AppDimens.buttonHeight,
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.primary),
          ),
          onPressed: () {
            //TODO: Ask mentor about that shieet
            cubit.navigator.showAddTodoPage(
              onDismissed: (result) {
                if (result != null) {
                  cubit.refetchTodo();
                }
              },
            );
          },
          child: Text(
            S.of(context).addNewTask,
            style: AppTextStyles.whiteS16Bold,
          ),
        ),
      ),
    );
  }
}
