import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_keys.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/ui/widgets/buttons/custom_outlined_button.dart';
import 'package:todo_app_bloc/ui/widgets/headers/base_header.dart';
import 'package:todo_app_bloc/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:todo_app_bloc/utils/app_validator.dart';
import 'package:todo_app_bloc/utils/utils.dart';

import 'change_password_cubit.dart';
import 'change_password_state.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (BuildContext context) {
        return ChangePasswordCubit(
          authRepository: context.read<AuthRepository>(),
        );
      },
      child: const ChangePasswordChildPage(),
    );
  }
}

class ChangePasswordChildPage extends StatelessWidget {
  const ChangePasswordChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (BuildContext context, state) {
            if (state.loadStatus == LoadStatus.success) {
              AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
                Utils.buildSnackBar(S.of(context).changePasswordSuccess),
              );
            } else if (state.loadStatus == LoadStatus.failure) {
              AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
                Utils.buildSnackBar(S.of(context).changePasswordFailure),
              );
            } else if (state.loadStatus == LoadStatus.error) {
              AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
                Utils.buildSnackBar(S.of(context).changePasswordError),
              );
            }
          },
          builder: (BuildContext context, state) {
            return Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: AppDimens.paddingLarge),
                _buildForm(context),
                const SizedBox(height: AppDimens.paddingNormal),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingNormal,
                  ),
                  child: _buildButtons(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BaseHeader(
      headerHeight: AppDimens.headerHeightNormal,
      title: S.of(context).changePassword,
      leadingButton: _buildCloseButton(context),
    );
  }

  IconButton _buildCloseButton(BuildContext context) {
    return IconButton(
      onPressed: context.read<ChangePasswordCubit>().onBackButtonPressed,
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

  Widget _buildForm(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingNormal),
      child: Form(
        key: cubit.formKey,
        child: Column(
          children: [
            CustomTextFormField(
              validator: (password) {
                return AppValidator.validatePassword(password);
              },
              controller: cubit.oldPasswordController,
              obscureText: true,
              title: S.of(context).password,
              hint: S.of(context).enterYourCurrentPassword,
            ),
            CustomTextFormField(
              controller: cubit.newPasswordController,
              validator: (password) {
                return AppValidator.validatePassword(password);
              },
              obscureText: true,
              title: S.of(context).newPassword,
              hint: S.of(context).enterYourNewPassword,
            ),
            CustomTextFormField(
              validator: (confirmPassword) {
                final password = cubit.newPasswordController.text;
                return AppValidator.validateConfirmPassword(
                  password,
                  confirmPassword,
                );
              },
              obscureText: true,
              title: S.of(context).confirmPassword,
              hint: S.of(context).enterYourConfirmPassword,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();
    final formKey = cubit.formKey;
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) {
        return previous.loadStatus != current.loadStatus;
      },
      builder: (BuildContext context, state) {
        return cubit.state.loadStatus == LoadStatus.loading
            ? const CircularProgressIndicator()
            : Row(
                spacing: AppDimens.paddingSmall,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                      onPressed: cubit.onBackButtonPressed,
                      child: Text(
                        S.of(context).cancel,
                        style: AppTextStyles.blackS16SemiBold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomOutlinedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.onChangePassword();
                        }
                      },
                      text: S.of(context).save,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
