import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/router/router_config.dart';
import 'package:todo_app_bloc/ui/pages/setting_page/setting_navigator.dart';
import 'package:todo_app_bloc/ui/pages/setting_page/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit({required this.authRepository, required this.navigator})
    : super(SettingState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final SettingNavigator navigator;
  final AuthRepository authRepository;

  void onBackButtonPressed() {
    navigator.onBackButtonPressed();
  }

  void onLogoutButtonPressed() async {
    await authRepository.logout();
    navigator.pushReplacementNamed(AppRouter.login);
  }

  void onChangePasswordButtonPressed() {
    navigator.openChangePasswordPage();
  }
}
