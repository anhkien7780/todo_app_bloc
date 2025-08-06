import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final Widget? suffixIcon;
  final int? maxLines;
  final Color? borderColor;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.title,
    this.width,
    this.height,
    this.onChange,
    this.suffixIcon,
    this.maxLines,
    this.controller,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        spacing: AppDimens.marginSmaller,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.blackS14SemiBold,
          ),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: AppColors.textFieldBGEnable,
              borderRadius: BorderRadius.circular(AppDimens.cornerRadiusSmall),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChange,
              maxLines: maxLines,
              clipBehavior: Clip.hardEdge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppDimens.marginNormal,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimens.cornerRadiusSmall,
                  ),
                  borderSide: BorderSide(
                    color: borderColor ?? AppColors.textFieldEnableBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimens.cornerRadiusSmall,
                  ),
                  borderSide: BorderSide(
                    color: borderColor ?? AppColors.textFieldEnableBorder,
                  ),
                ),
                hint: Text(
                  hint,
                  style: AppTextStyles.blackS16,
                ),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
