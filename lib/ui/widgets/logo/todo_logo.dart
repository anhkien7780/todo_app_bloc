import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';

class TodoLogo extends StatelessWidget {
  const TodoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.cornerRadiusNormal),
        border: Border.all(color: AppColors.logoBorderColor, width: 2),
      ),
      child: SvgPicture.asset(
        AppSvgs.todoLogoPSvg,
        width: AppDimens.appLogoSize,
        fit: BoxFit.cover,
      ),
    );
  }
}
