import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/database/secure_storage_helper.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/router/router_config.dart';
import 'package:todo_app_bloc/ui/pages/change_password_page/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required this.authRepository})
    : super(ChangePasswordState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final AuthRepository authRepository;

  Future<void> onChangePassword() async {
    try {
      String email = "";
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final session = await SecureStorageHelper.instance.getSession();
      if (session != null) {
        email = session.user.email!;
      }
      // Re-login to check if the old password is correct
      await authRepository.login(
        email: email,
        password: oldPasswordController.text,
      );

      // Change password if the old password is correct
      final response = await authRepository.changePassword(
        newPassword: newPasswordController.text,
      );
      if (response.user != null) {
        emit(state.copyWith(loadStatus: LoadStatus.success));
      }
    } on AuthApiException catch (_) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.error));
    }
  }

  void onBackButtonPressed() {
    AppRouter.router.pop();
  }
}
