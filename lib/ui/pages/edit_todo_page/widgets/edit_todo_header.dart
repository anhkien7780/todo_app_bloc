import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/model/enums/edit_todo_page_mode.dart';
import 'package:todo_app_bloc/ui/widgets/headers/base_header.dart';
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
    return BaseHeader(
      title: mode == EditTodoPageMode.add
          ? S.of(context).addNewTask
          : S.of(context).editTask,
      leadingButton: _buildCloseButton(),
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
