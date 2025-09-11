import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/ui/widgets/alert_dialogs/base_alert_dialog.dart';

class ConfirmLogoutDialog extends StatelessWidget {
  const ConfirmLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAlertDialog(
      title: Text(
        S.of(context).confirmLogout,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: AppTextStyles.blackS16SemiBold,
      ),
      buttons: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: AppDimens.paddingNormal,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                S.of(context).no,
                style: AppTextStyles.whiteS14SemiBold.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                S.of(context).yes,
                style: AppTextStyles.whiteS14SemiBold,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
