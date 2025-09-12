import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/database/secure_storage_helper.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/ui/pages/login_page/login_state.dart';

import 'login_navigator.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.navigator, required this.repository})
    : super(LoginState());
  final AuthRepository repository;
  final LoginNavigator navigator;

  final accountTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> onLoginButtonPressed() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await repository.login(
        email: accountTextController.text,
        password: passwordTextController.text,
      );
      final Session? session = response.session;
      final User? user = response.user;

      if (user != null && session != null) {
        SecureStorageHelper.instance.saveSession(session);
        emit(state.copyWith(loadStatus: LoadStatus.success));
        navigator.openTodoListPage();
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
