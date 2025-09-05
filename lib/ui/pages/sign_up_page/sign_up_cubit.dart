import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/ui/pages/sign_up_page/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  final accountTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void onSignUpButtonPressed() {
    log(
      "account: ${accountTextController.text}\n"
      "password: ${passwordTextController.text}\n"
      "confirm password: ${confirmPasswordTextController.text}",
    );
  }
}
