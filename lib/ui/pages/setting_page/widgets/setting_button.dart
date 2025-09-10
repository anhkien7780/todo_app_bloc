import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';

class SettingButton extends StatelessWidget {
  final Widget leadingIcon;
  final Widget? trailingIcon;
  final String title;
  final VoidCallback onPressed;

  const SettingButton({
    super.key,
    required this.leadingIcon,
    this.trailingIcon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: AppDimens.buttonHeight,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.marginNormal),
          child: Row(
            spacing: AppDimens.paddingSmallest,
            children: [
              leadingIcon,
              Text(title, style: AppTextStyles.blackS16SemiBold),
              const Spacer(),
              if (trailingIcon != null) trailingIcon!,
            ],
          ),
        ),
      ),
    );
  }
}
