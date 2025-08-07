import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_images.dart';
import 'package:todo_app_bloc/global_blocs/settings/app_setting_cubit.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_cubit.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_navigator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashCubit(navigator: SplashNavigator(context: context));
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late SplashCubit _cubit;
  late AppSettingCubit _appSettingCubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SplashCubit>();
    _appSettingCubit = context.read<AppSettingCubit>();
    _setup();
  }

  void _setup() async {
    await _appSettingCubit.getInitialSetting();
    await _cubit.openTodoListPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.primary)),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.cornerRadiusNormal),
                border: Border.all(color: AppColors.logoBorderColor, width: 2),
              ),
              child: SvgPicture.asset(
                AppImages.todoLogoPSvg,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
