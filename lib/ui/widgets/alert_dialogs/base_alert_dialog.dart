import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';

class BaseAlertDialog extends StatelessWidget {
  const BaseAlertDialog({super.key, this.title, this.buttons});

  final Widget? title;
  final Widget? buttons;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: AppDimens.dialogWidth,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingSmall,
          vertical: AppDimens.paddingNormal,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) title!,
            const SizedBox(height: AppDimens.marginNormal),
            if (buttons != null) buttons!,
          ],
        ),
      ),
    );
  }
}
