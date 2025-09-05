import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/ui/pages/sign_up_page/sign_up_cubit.dart';
import 'package:todo_app_bloc/ui/widgets/buttons/custom_outlined_button.dart';
import 'package:todo_app_bloc/ui/widgets/logo/todo_logo.dart';
import 'package:todo_app_bloc/ui/widgets/text_fields/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) {
        return SignUpCubit();
      },
      child: SignUpChildPage(),
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
    final cubit = context.read<SignUpCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.padding100),
            child: const TodoLogo(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingNormal,
            ),
            child: Column(
              spacing: AppDimens.paddingNormal,
              children: [
                CustomTextField(
                  controller: cubit.accountTextController,
                  hint: S.of(context).account,
                  title: S.of(context).account,
                ),
                CustomTextField(
                  controller: cubit.passwordTextController,
                  obscureText: true,
                  hint: S.of(context).password,
                  title: S.of(context).password,
                ),
                CustomTextField(
                  controller: cubit.confirmPasswordTextController,
                  obscureText: true,
                  hint: S.of(context).confirmPassword,
                  title: S.of(context).confirmPassword,
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppDimens.buttonHeight,
                  child: CustomOutlinedButton(
                    onPressed: () {},
                    text: S.of(context).signUp,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    S.of(context).iAlreadyHaveAccount,
                    style: AppTextStyles.blackS16.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
