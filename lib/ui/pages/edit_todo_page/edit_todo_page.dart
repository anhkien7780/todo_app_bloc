import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/edit_todo_cubit.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/edit_todo_navigator.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/widgets/edit_todo_body.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/widgets/edit_todo_header.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditTodoCubit>(
      create: (BuildContext context) {
        return EditTodoCubit(
          repository: context.read<TodoRepository>(),
          navigator: EditTodoNavigator(context: context),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(
                          AppDimens.cornerRadiusNormal,
                        ),
                      ),
                      child: Column(
                        children: [
                          EditTodoHeader(
                            onCloseButtonPressed: () => context
                                .read<EditTodoCubit>()
                                .onCloseButtonPressed(),
                          ),
                          SizedBox(height: AppDimens.marginLarge),
                          EditTodoBody(),
                          Spacer(),
                          _buildSaveButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.marginNormal),
      child: SizedBox(
        width: double.infinity,
        height: AppDimens.buttonHeight,
        child: OutlinedButton(
          onPressed: () async {
            await context.read<EditTodoCubit>().onSaveButtonPressed();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.buttonBGPrimary),
          ),
          child: Text(S.of(context).save, style: AppTextStyles.whiteS16Bold),
        ),
      ),
    );
  }
}
