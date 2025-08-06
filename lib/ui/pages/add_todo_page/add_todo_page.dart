import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_cubit.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/widgets/add_todo_body.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/widgets/add_todo_header.dart';

class AddTodo extends StatelessWidget {
  final Function(Todo todo) onAddButtonPressed;

  const AddTodo({super.key, required this.onAddButtonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
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
                          AddNewTaskScreenHeader(
                            onCloseButtonPressed: () => Navigator.pop(context),
                          ),
                          SizedBox(height: AppDimens.marginLarge),
                          AddTodoBody(),
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
          onPressed: () {
            final todo = context.read<AddTodoCubit>().getTodo();
            if (todo.taskTitle.trim().isEmpty) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text("Task title is empty")),
                );
            } else {
              onAddButtonPressed(todo);
              Navigator.of(context).pop();
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.buttonBGPrimary),
          ),
          child: const Text(
            "Save",
            style: TextStyle(
              fontSize: AppDimens.textMedium,
              fontWeight: FontWeight.w700,
              color: AppColors.textWhite,
            ),
          ),
        ),
      ),
    );
  }
}
