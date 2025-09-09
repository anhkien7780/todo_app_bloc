import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/repositories/auth_repository.dart';
import 'package:todo_app_bloc/ui/pages/login_page/login_navigator.dart';
import 'package:todo_app_bloc/ui/widgets/buttons/custom_outlined_button.dart';
import 'package:todo_app_bloc/ui/widgets/images/svg_image.dart';
import 'package:todo_app_bloc/ui/widgets/logo/todo_logo.dart';
import 'package:todo_app_bloc/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:todo_app_bloc/utils/app_validator.dart';

import 'login_cubit.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingNormal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppDimens.padding100),
                child: const TodoLogo(),
              ),
              _buildLoginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final formKey = GlobalKey<FormState>();
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
          SizedBox(
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
          Text(
            S.of(context).orConnectWith,
            style: AppTextStyles.blackS14SemiBold,
          ),
          Row(
            spacing: AppDimens.paddingNormal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // Todo: Handle facebook login
                },
                child: SVGImage(imageUri: AppSvgs.icFacebook),
              ),
              InkWell(
                onTap: () {
                  // Todo: Handle google login
                },
                child: SVGImage(imageUri: AppSvgs.icGoogle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
