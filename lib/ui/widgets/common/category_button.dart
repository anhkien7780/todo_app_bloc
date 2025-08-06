import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app_bloc/common/app_colors.dart';

import '../../../model/enums/category.dart';

class CategoryButton extends StatelessWidget {
  final Category category;
  final VoidCallback? onPressed;
  final bool isSelected;

  const CategoryButton({
    super.key,
    required this.category,
    this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _buildColor(),
        border: isSelected
            ? Border.fromBorderSide(BorderSide(color: Colors.grey, width: 2))
            : null,
      ),
      child: IconButton(onPressed: onPressed, icon: _buildIcon()),
    );
  }

  Widget _buildIcon() {
    String path;
    switch (category) {
      case Category.task:
        path = "assets/images/ic_task.svg";
        break;
      case Category.event:
        path = "assets/images/ic_event.svg";
        break;
      case Category.goal:
        path = "assets/images/ic_goal.svg";
        break;
    }
    return Center(
      child: SvgPicture.asset(width: 24, height: 24, path, fit: BoxFit.contain),
    );
  }

  Color _buildColor() {
    switch (category) {
      case Category.task:
        return AppColors.categoryTaskButton;
      case Category.event:
        return AppColors.categoryEventButton;
      case Category.goal:
        return AppColors.categoryGoalButton;
    }
  }
}
