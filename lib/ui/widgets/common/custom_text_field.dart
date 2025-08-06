import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';

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
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: AppColors.textFieldBGEnable,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChange,
              maxLines: maxLines,
              clipBehavior: Clip.hardEdge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12, right: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: borderColor ?? AppColors.textFieldEnableBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: borderColor ?? AppColors.textFieldEnableBorder,
                  ),
                ),
                hint: Text(
                  hint,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textFieldHint,
                  ),
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
