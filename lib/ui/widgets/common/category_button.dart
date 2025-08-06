import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_images.dart';

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
      width: AppDimens.circleButtonSize,
      height: AppDimens.circleButtonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _buildColor(),
        border: isSelected
            ? Border.fromBorderSide(
                BorderSide(
                  color: Colors.grey,
                  width: AppDimens.categoryButtonBorderWidth,
                ),
              )
            : null,
      ),
      child: IconButton(onPressed: onPressed, icon: _buildIcon()),
    );
  }

  Widget _buildIcon() {
    String path;
    switch (category) {
      case Category.task:
        path = AppImages.icTask;
        break;
      case Category.event:
        path = AppImages.icEvent;
        break;
      case Category.goal:
        path = AppImages.icGoal;
        break;
    }
    return Center(
      child: SvgPicture.asset(
        width: AppDimens.iconNormalSize,
        height: AppDimens.iconNormalSize,
        path,
        fit: BoxFit.contain,
      ),
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
