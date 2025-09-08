import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/ui/pages/sign_up_page/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository repository;

  SignUpCubit({required this.repository}) : super(SignUpState());

  final accountTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  Future<void> onSignUpButtonPressed() async {
    log(
      "account: ${accountTextController.text}\n"
          "password: ${passwordTextController.text}\n"
          "confirm password: ${confirmPasswordTextController.text}",
    );
    final AuthResponse response = await repository.signUp(
      email: accountTextController.text,
      password: passwordTextController.text,
    );
    final Session? session = response.session;
    final User? user = response.user;
  }
}
