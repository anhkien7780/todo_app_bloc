import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/global_blocs/settings/app_setting_cubit.dart';
import 'package:todo_app_bloc/model/enums/language.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/ui/pages/setting_page/setting_cubit.dart';
import 'package:todo_app_bloc/ui/pages/setting_page/setting_navigator.dart';
import 'package:todo_app_bloc/ui/pages/setting_page/widgets/setting_button.dart';
import 'package:todo_app_bloc/ui/pages/setting_page/widgets/setting_header.dart';
import 'package:todo_app_bloc/ui/widgets/images/svg_image.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (context) => SettingCubit(
        navigator: SettingNavigator(context: context),
        authRepository: context.read<AuthRepository>(),
      ),
      child: const SettingChildPage(),
    );
  }
}

class SettingChildPage extends StatelessWidget {
  const SettingChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingCubit = context.read<SettingCubit>();
    final appCubit = context.read<AppSettingCubit>();
    final language = appCubit.state.language;
    return SafeArea(
      child: Scaffold(
        body: Column(
          spacing: AppDimens.paddingSmallest,
          children: [
            SettingHeader(
              onCloseButtonPressed: () {
                settingCubit.onBackButtonPressed();
              },
            ),
            SettingButton(
              leadingIcon: Icon(Icons.lock),
              title: S.of(context).changePassword,
              onPressed: () {
                //TODO: Implement change password
              },
            ),
            SettingButton(
              leadingIcon: Icon(Icons.language),
              title: S.of(context).changeLanguage,
              onPressed: () {
                appCubit.changeLanguage();
              },
              trailingIcon: SVGImage(
                imageUri: language == Language.english
                    ? AppSvgs.icUSFlag
                    : AppSvgs.icVNFlag,
              ),
            ),
            SettingButton(
              leadingIcon: Icon(Icons.logout),
              title: S.of(context).logout,
              onPressed: () {
                // TODO: fix bux - back button back to todo list page after logout
                settingCubit.onLogoutButtonPressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}
