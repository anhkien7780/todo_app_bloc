import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      child: IconButton(
        onPressed: onPressed,
        icon: _buildIcon(),
      ),
    );
  }

  Widget _buildIcon() {
    String path;
    switch (category) {
      case Category.task:
        path = "lib/assets/icons/ic_task.svg";
        break;
      case Category.event:
        path = "lib/assets/icons/ic_event.svg";
        break;
      case Category.goal:
        path = "lib/assets/icons/ic_goal.svg";
        break;
    }
    return Center(
      child: SvgPicture.asset(width: 24, height: 24, path, fit: BoxFit.contain),
    );
  }

  Color _buildColor() {
    switch (category) {
      case Category.task:
        return Color(0xffDBECF6);
      case Category.event:
        return Color(0xffE7E2F3);
      case Category.goal:
        return Color(0xffFEF5D3);
    }
  }
}
