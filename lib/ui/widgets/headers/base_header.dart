import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/ui/widgets/images/svg_image.dart';

class BaseHeader extends StatelessWidget {
  final String? title;
  final Widget? leadingButton;
  final double? headerHeight;

  const BaseHeader({
    super.key,
    this.title,
    this.leadingButton,
    this.headerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: headerHeight ?? AppDimens.headerHeightSmall,
          color: AppColors.primary,
        ),
        _buildEllipse1(),
        _buildEllipse2(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leadingButton ?? const SizedBox.shrink(),
            Text(title ?? "", style: AppTextStyles.whiteS16SemiBold),
            const SizedBox(width: AppDimens.circleButtonSize),
          ],
        ),
      ],
    );
  }

  Positioned _buildEllipse1() {
    return Positioned(
      top: -48,
      left: -191,
      child: SVGImage(imageUri: AppSvgs.icEllipse1),
    );
  }

  Positioned _buildEllipse2() {
    return Positioned(
      top: -27,
      right: -82,
      child: SVGImage(imageUri: AppSvgs.icEllipse2),
    );
  }
}
