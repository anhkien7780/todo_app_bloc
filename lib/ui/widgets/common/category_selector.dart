import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/model/enums/category.dart';
import 'category_button.dart';

class CategorySelector extends StatelessWidget {
  final Category selectedCategory;
  final Function(Category) onChange;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppDimens.marginLarge,
      children: [
        const Text(
          "Category",
          style: TextStyle(
            fontSize: AppDimens.textSmall,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        Row(
          spacing: AppDimens.marginNormal,
          children: [
            CategoryButton(
              category: Category.task,
              onPressed: () => onChange(Category.task),
              isSelected: selectedCategory == Category.task,
            ),
            CategoryButton(
              category: Category.event,
              onPressed: () => onChange(Category.event),
              isSelected: selectedCategory == Category.event,
            ),
            CategoryButton(
              category: Category.goal,
              onPressed: () => onChange(Category.goal),
              isSelected: selectedCategory == Category.goal,
            ),
          ],
        ),
      ],
    );
  }
}
