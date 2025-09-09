import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';

class Utils {
  static SnackBar buildSnackBar(String message) {
    return SnackBar(
      content: Text(message, style: AppTextStyles.whiteS14Medium),
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.cornerRadiusNormal),
      ),
    );
  }

}
