import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.buttonHeight,
      width: double.infinity,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.primary),
        ),
        onPressed: onPressed,
        child: Text(text, style: AppTextStyles.whiteS16Bold),
      ),
    );
  }
}
