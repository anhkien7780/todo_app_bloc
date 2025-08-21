import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';

import '../../../../model/entities/todo.dart';
import '../../../widgets/buttons/category_button.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggleCheckBox,
  });

  final Todo todo;
  final Function(Todo todo) onToggleCheckBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.marginNormal),
      decoration: BoxDecoration(color: AppColors.buttonBGWhite),
      height: AppDimens.todoItemHeight,
      child: Row(
        spacing: AppDimens.marginSmall,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTodoItemIcon(todo),
          Expanded(child: _buildTaskTitleAndTime(todo)),
          Checkbox(
            fillColor: todo.isCompleted
                ? WidgetStatePropertyAll(AppColors.primary)
                : WidgetStatePropertyAll(AppColors.buttonBGWhite),
            value: todo.isCompleted,
            onChanged: (_) {
              onToggleCheckBox(todo);
            },
          ),
        ],
      ),
    );
  }

  Column _buildTaskTitleAndTime(Todo todo) {
    Color textColor = AppColors.textBlack;
    if (todo.isCompleted == false) {
      DateTime now = DateTime.now();
      if (todo.time != null && todo.time!.isBefore(now)) {
        textColor = AppColors.textRed;
      } else if (todo.date != null &&
          todo.date!.isBefore(now) &&
          todo.time == null) {
        textColor = AppColors.textRed;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          todo.taskTitle,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: AppTextStyles.blackS16SemiBold.copyWith(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: textColor.withAlpha(
              todo.isCompleted ? AppDimens.blurAlpha : AppDimens.normalAlpha,
            ),
          ),
        ),
        if (todo.time != null)
          Text(
            DateFormat.jm().format(todo.time!),
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: AppTextStyles.blackS14Medium.copyWith(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              color: textColor.withAlpha(AppDimens.blurAlpha),
            ),
          ),
      ],
    );
  }

  Stack _buildTodoItemIcon(Todo todo) {
    return Stack(
      children: [
        CategoryButton(category: todo.category, isSelected: false),
        Container(
          height: AppDimens.circleButtonSize,
          width: AppDimens.circleButtonSize,
          color: todo.isCompleted
              ? AppColors.buttonBGDisable
              : Colors.transparent,
        ),
      ],
    );
  }
}
