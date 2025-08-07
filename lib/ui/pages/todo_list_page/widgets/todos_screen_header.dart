import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/configs/app_configs.dart';
import 'package:todo_app_bloc/ui/widgets/common/svg_image.dart';

class TodosScreenHeader extends StatelessWidget {
  const TodosScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String date = DateFormat(AppConfigs.dateDisplayFormat).format(dateTime);
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            Container(
              height: AppDimens.listTodoPageHeaderHeight,
              decoration: BoxDecoration(color: AppColors.primary),
            ),
            _buildEllipse1(),
            _buildEllipse2(),
            _buildDateText(date: date),
            _buildCenterTitle(title: "My Todo List"),
          ],
        ),
      ],
    );
  }

  Positioned _buildEllipse1() {
    return Positioned(
      top: 78,
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

  Positioned _buildDateText({required String date}) {
    return Positioned(
      top: 34,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.paddingNormal,
          horizontal: 110,
        ),
        child: Text(date, style: AppTextStyles.whiteS16SemiBold),
      ),
    );
  }

  Text _buildCenterTitle({required String title}) {
    return Text(title, style: AppTextStyles.whiteS30Bold);
  }
}
