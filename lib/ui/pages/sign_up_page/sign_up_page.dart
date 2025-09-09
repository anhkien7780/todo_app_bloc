import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_keys.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/ui/pages/sign_up_page/sign_up_cubit.dart';
import 'package:todo_app_bloc/ui/pages/sign_up_page/sign_up_navigator.dart';
import 'package:todo_app_bloc/ui/pages/sign_up_page/sign_up_state.dart';
import 'package:todo_app_bloc/ui/widgets/buttons/custom_outlined_button.dart';
import 'package:todo_app_bloc/ui/widgets/logo/todo_logo.dart';
import 'package:todo_app_bloc/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:todo_app_bloc/utils/app_validator.dart';
import 'package:todo_app_bloc/utils/utils.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) {
        return SignUpCubit(
          repository: context.read<AuthRepository>(),
          navigator: SignUpNavigator(context: context),
        );
      },
      child: const SignUpChildPage(),
    );
  }
}

class SignUpChildPage extends StatelessWidget {
  const SignUpChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (BuildContext context, state) {
          if (state.loadStatus == LoadStatus.success) {
            AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
              Utils.buildSnackBar(S.of(context).signUpSuccess),
            );
            context.read<SignUpCubit>().navigator.openLoginPage();
          } else if (state.loadStatus == LoadStatus.failure) {
            AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
              Utils.buildSnackBar(S.of(context).emailIsAlreadyRegistered),
            );
          }
        },
        builder: (BuildContext context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.padding100,
                ),
                child: const TodoLogo(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingNormal,
                ),
                child: Column(
                  spacing: AppDimens.paddingNormal,
                  children: [_buildSignInForm(context)],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    final formKey = cubit.formKey;
    return Form(
      key: formKey,
      child: Column(
        spacing: AppDimens.paddingNormal,
        children: [
          CustomTextFormField(
            validator: (email) {
              return AppValidator.validateEmail(email);
            },
            controller: cubit.accountTextController,
            hint: S.of(context).account,
            title: S.of(context).account,
          ),
          CustomTextFormField(
            validator: (password) {
              return AppValidator.validatePassword(password);
            },
            controller: cubit.passwordTextController,
            obscureText: true,
            hint: S.of(context).password,
            title: S.of(context).password,
          ),
          CustomTextFormField(
            validator: (confirmPassword) {
              final password = cubit.passwordTextController.text;
              return AppValidator.validateConfirmPassword(
                password,
                confirmPassword,
              );
            },
            controller: cubit.confirmPasswordTextController,
            obscureText: true,
            hint: S.of(context).confirmPassword,
            title: S.of(context).confirmPassword,
          ),
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (pre, current) {
              return pre.loadStatus != current.loadStatus;
            },
            builder: (BuildContext context, state) {
              return state.loadStatus == LoadStatus.loading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: AppDimens.buttonHeight,
                      child: CustomOutlinedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            cubit.onSignUpButtonPressed();
                          }
                        },
                        text: S.of(context).signUp,
                      ),
                    );
            },
          ),
          InkWell(
            onTap: () {
              cubit.navigator.openLoginPage();
            },
            child: Text(
              S.of(context).iAlreadyHaveAccount,
              style: AppTextStyles.blackS16.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
