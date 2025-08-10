import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/model/enums/edit_todo_page_mode.dart';
import 'package:todo_app_bloc/ui/widgets/images/svg_image.dart';

class EditTodoHeader extends StatelessWidget {
  final VoidCallback onCloseButtonPressed;
  final EditTodoPageMode mode;

  const EditTodoHeader({
    super.key,
    required this.onCloseButtonPressed,
    required this.mode,
  });

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
            Text(
              mode == EditTodoPageMode.add
                  ? S.of(context).addNewTask
                  : S.of(context).editTask,
              style: AppTextStyles.whiteS16SemiBold,
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
      child: SVGImage(imageUri: AppSvgs.icEllipse1),
    );
  }

  Positioned _buildEllipse2() {
    return Positioned(
      top: -27,
      right: -82,
      child: SVGImage(imageUri: AppSvgs.icEllipse2),
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
        child: SVGImage(imageUri: AppSvgs.icCloseX),
      ),
    );
  }
}
