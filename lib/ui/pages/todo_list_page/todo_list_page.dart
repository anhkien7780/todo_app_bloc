import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/global_blocs/settings/app_setting_cubit.dart';
import 'package:todo_app_bloc/model/enums/language.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_cubit.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_navigator.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_state.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/widgets/todo_list_view.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/widgets/todos_screen_header.dart';
import 'package:todo_app_bloc/ui/widgets/buttons/custom_button.dart';
import 'package:todo_app_bloc/ui/widgets/loadings/full_screen_loading.dart';

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
      child: const TodoListChildPage(),
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<TodoListCubit, TodoListState>(
        buildWhen: (prev, current) {
          return prev.loadTodoStatus != current.loadTodoStatus;
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: TodosScreenHeader(
                  onChangeButtonPressed: () {
                    final appCubit = context.read<AppSettingCubit>();
                    final language = appCubit.state.language;
                    appCubit.changeLanguage(
                      language: language == Language.english
                          ? Language.vietnamese
                          : Language.english,
                    );
                  },
                ),
              ),
              _buildTodoList(),
              _buildAddNewTaskButton(context),
              if (_cubit.taskIsEmpty())
                Positioned.fill(
                  child: Center(
                    child: Text(
                      S.of(context).taskIsEmpty,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.blackS16Medium,
                    ),
                  ),
                ),
              if (state.loadTodoStatus == LoadStatus.loading)
                FullScreenLoading(),
            ],
          );
        },
      ),
    );
  }

  Positioned _buildTodoList() {
    return Positioned.fill(
      top: (AppDimens.todoListPageHeaderHeight / 2) + AppDimens.marginLarge,
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
                    _cubit.toggleCheckBox(todo);
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
                        _cubit.toggleCheckBox(todo);
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
      child: CustomOutlinedButton(
        onPressed: () async {
          final result = await cubit.navigator.showEditTodoPage();
          cubit.handleResultFromEditTodoPage(result);
        },
        text: S.of(context).addNewTask,
      ),

      // SizedBox(
      //   height: AppDimens.buttonHeight,
      //   child: OutlinedButton(
      //     style: ButtonStyle(
      //       backgroundColor: WidgetStatePropertyAll(AppColors.primary),
      //     ),
      //     onPressed: () async {
      //       final result = await cubit.navigator.showEditTodoPage();
      //       cubit.handleResultFromEditTodoPage(result);
      //     },
      //     child: Text(
      //       S.of(context).addNewTask,
      //       style: AppTextStyles.whiteS16Bold,
      //     ),
      //   ),
      // ),
    );
  }
}
