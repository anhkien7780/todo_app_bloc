import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/ui/pages/sign_up_page/sign_up_navigator.dart';
import 'package:todo_app_bloc/ui/pages/sign_up_page/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository repository;
  final SignUpNavigator navigator;

  SignUpCubit({required this.navigator, required this.repository})
      : super(SignUpState());

  final accountTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> onSignUpButtonPressed() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final AuthResponse response = await repository.signUp(
        email: accountTextController.text,
        password: passwordTextController.text,
      );
      final Session? session = response.session;
      final User? user = response.user;
      if(user != null){
        emit(state.copyWith(loadStatus: LoadStatus.success));
        emit(state.copyWith(message: "Sign up successfully, please confirm your email"));
      }
    } on AuthException catch (_, e){
      emit(state.copyWith(loadStatus: LoadStatus.failure));
      emit(state.copyWith(message: "Email is already registered"));
    }

  }
}
