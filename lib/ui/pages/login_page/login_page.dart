import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/ui/pages/login_page/login_cubit.dart';
import 'package:todo_app_bloc/ui/widgets/buttons/custom_button.dart';
import 'package:todo_app_bloc/ui/widgets/images/svg_image.dart';
import 'package:todo_app_bloc/ui/widgets/logo/app_logo.dart';
import 'package:todo_app_bloc/ui/widgets/text_fields/custom_text_field.dart';

import 'login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: LoginPageChild(),
    );
  }
}

class LoginPageChild extends StatefulWidget {
  const LoginPageChild({super.key});

  @override
  State<LoginPageChild> createState() => _LoginPageChildState();
}

class _LoginPageChildState extends State<LoginPageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingNormal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimens.margin100,
                    ),
                    child: const AppLogo(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AppDimens.marginNormal,
                    children: [
                      CustomTextField(
                        hint: S.of(context).account,
                        title: S.of(context).account,
                      ),
                      CustomTextField(
                        hint: S.of(context).password,
                        title: S.of(context).password,
                      ),
                      CustomOutlinedButton(
                        onPressed: () {},
                        text: S.of(context).login,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          S.of(context).registerNewAccount,
                          style: AppTextStyles.blackS16.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Text(S.of(context).orConnectWith),
                      Row(
                        spacing: AppDimens.paddingNormal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: SVGImage(imageUri: AppSvgs.icFacebook),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SVGImage(imageUri: AppSvgs.icGoogle),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
