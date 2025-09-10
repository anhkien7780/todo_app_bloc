import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_keys.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/ui/pages/login_page/login_navigator.dart';
import 'package:todo_app_bloc/ui/widgets/buttons/custom_outlined_button.dart';
import 'package:todo_app_bloc/ui/widgets/logo/todo_logo.dart';
import 'package:todo_app_bloc/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:todo_app_bloc/utils/app_validator.dart';
import 'package:todo_app_bloc/utils/utils.dart';

import 'login_cubit.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) {
        return LoginCubit(
          navigator: LoginNavigator(context: context),
          repository: context.read<AuthRepository>(),
        );
      },
      child: const LoginPageChild(),
    );
  }
}

class LoginPageChild extends StatelessWidget {
  const LoginPageChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (BuildContext context, state) {
            if (state.loadStatus == LoadStatus.success) {
              AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
                Utils.buildSnackBar(S.of(context).loginSuccess),
              );
            } else if (state.loadStatus == LoadStatus.failure) {
              AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
                Utils.buildSnackBar(S.of(context).loginFailure),
              );
            }
          },
          builder: (BuildContext context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppDimens.paddingNormal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimens.padding100,
                    ),
                    child: const TodoLogo(),
                  ),
                  _buildLoginForm(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final formKey = cubit.formKey;
    return Form(
      key: formKey,
      child: Column(
        spacing: AppDimens.paddingNormal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextFormField(
            controller: cubit.accountTextController,
            validator: (email) {
              return AppValidator.validateEmail(email);
            },
            title: S.of(context).account,
            hint: S.of(context).account,
          ),
          CustomTextFormField(
            controller: cubit.passwordTextController,
            obscureText: true,
            validator: (password) {
              return AppValidator.validatePassword(password);
            },
            title: S.of(context).password,
            hint: S.of(context).password,
          ),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (pre, current) {
              return pre.loadStatus != current.loadStatus;
            },
            builder: (BuildContext context, LoginState state) {
              return state.loadStatus == LoadStatus.loading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: AppDimens.buttonHeight,
                      child: CustomOutlinedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.onLoginButtonPressed();
                          }
                        },
                        text: S.of(context).login,
                      ),
                    );
            },
          ),
          InkWell(
            onTap: () {
              cubit.navigator.openSignUpPage();
            },
            child: Text(
              S.of(context).registerNewAccount,
              style: AppTextStyles.blackS16,
            ),
          ),
        ],
      ),
    );
  }
}
