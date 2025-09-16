import 'package:flutter/material.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/ui/widgets/headers/base_header.dart';

class SettingHeader extends StatelessWidget {
  final VoidCallback onCloseButtonPressed;

  const SettingHeader({
    super.key,
    required this.onCloseButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: S.of(context).setting,
      headerHeight: AppDimens.headerHeightNormal,
      leadingButton: _buildCloseButton(),
    );
  }

  IconButton _buildCloseButton() {
    return IconButton(
      onPressed: onCloseButtonPressed,
      icon: Container(
        width: AppDimens.circleButtonSize,
        height: AppDimens.circleButtonSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
