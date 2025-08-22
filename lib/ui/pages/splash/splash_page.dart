import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/global_blocs/settings/app_setting_cubit.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_cubit.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_navigator.dart';
import 'package:todo_app_bloc/ui/widgets/logo/app_logo.dart';

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
    // await _cubit.openTodoListPage();
    await _cubit.openLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.primary)),
          Center(
            child: const AppLogo(),
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
