import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_images.dart';
import 'package:todo_app_bloc/ui/widgets/common/svg_image.dart';

class AddNewTaskScreenHeader extends StatelessWidget {
  final VoidCallback onCloseButtonPressed;

  const AddNewTaskScreenHeader({super.key, required this.onCloseButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: AppDimens.addTodoPageHeaderHeight,
          color: AppColors.primary,
        ),
        _buildEllipse1(),
        _buildEllipse2(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCloseButton(),
            const Text(
              "Add New Task",
              style: TextStyle(
                fontSize: AppDimens.textMedium,
                fontWeight: FontWeight.w600,
                color: AppColors.textWhite,
              ),
            ),
            const SizedBox(width: AppDimens.circleButtonSize),
          ],
        ),
      ],
    );
  }

  Positioned _buildEllipse1() {
    return Positioned(
      top: -48,
      left: -191,
      child: SVGImage(imageUri: AppImages.icEllipse1),
    );
  }

  Positioned _buildEllipse2() {
    return Positioned(
      top: -27,
      right: -82,
      child: SVGImage(imageUri: AppImages.icEllipse2),
    );
  }

  IconButton _buildCloseButton() {
    return IconButton(
      onPressed: onCloseButtonPressed,
      icon: Container(
        width: AppDimens.circleButtonSize,
        height: AppDimens.circleButtonSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: SVGImage(imageUri: AppImages.icCloseX),
      ),
    );
  }
}
