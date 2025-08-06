import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';

import '../../../model/entities/todo.dart';
import 'category_button.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          todo.taskTitle,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: TextStyle(
            fontSize: AppDimens.textMedium,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: AppColors.textBlack.withAlpha(
              todo.isCompleted ? AppDimens.blurAlpha : AppDimens.normalAlpha,
            ),
            fontWeight: FontWeight.w600,
          ),
        ),
        if (todo.time != null && todo.time!.isNotEmpty)
          Text(
            todo.time!,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(
              fontSize: AppDimens.textSmall,
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              color: AppColors.textBlack.withAlpha(AppDimens.blurAlpha),
              fontWeight: FontWeight.w500,
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
