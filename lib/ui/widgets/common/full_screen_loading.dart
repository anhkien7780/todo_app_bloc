import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';

class FullScreenLoading extends StatelessWidget {
  const FullScreenLoading({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.withAlpha(AppDimens.blurAlpha),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.circleLoading),
          if (title != null) Text(title!, style: AppTextStyles.whiteS16Medium),
        ],
      ),
    );
  }
}
