import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key});

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
            Text(
              S.of(context).deleteDialogTitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: AppTextStyles.blackS16SemiBold,
            ),
            const SizedBox(height: AppDimens.marginNormal),
            Row(
              mainAxisSize: MainAxisSize.max,
              spacing: AppDimens.paddingNormal,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.error,
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      S.of(context).cancel,
                      style: AppTextStyles.whiteS14SemiBold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      S.of(context).delete,
                      style: AppTextStyles.whiteS14SemiBold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
