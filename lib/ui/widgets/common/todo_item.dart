import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';

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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.buttonBGWhite),
      height: 80,
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CategoryButton(category: todo.category, isSelected: false),
              Container(
                height: 48,
                width: 48,
                color: todo.isCompleted
                    ? AppColors.buttonBGDisable
                    : Colors.transparent,
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  todo.taskTitle,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: AppColors.textBlack.withAlpha(
                      todo.isCompleted ? 170 : 250,
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
                      fontSize: 14,
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: AppColors.textBlack.withAlpha(170),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          Checkbox(
            checkColor: AppColors.primary,
            value: todo.isCompleted,
            onChanged: (_) {
              onToggleCheckBox(todo);
            },
          ),
        ],
      ),
    );
  }
}
