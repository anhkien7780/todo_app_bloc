import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/database/secure_storage_helper.dart';
import 'package:todo_app_bloc/global_blocs/settings/app_setting_cubit.dart';
import 'package:todo_app_bloc/model/entities/profile.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_cubit.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_navigator.dart';
import 'package:todo_app_bloc/ui/widgets/logo/todo_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashCubit(navigator: SplashNavigator(context: context));
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late SplashCubit _cubit;
  late AppSettingCubit _appSettingCubit;
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SplashCubit>();
    _appSettingCubit = context.read<AppSettingCubit>();
    _setup();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  void _setup() async {
    try {
      await _appSettingCubit.getInitialSetting();
      // Deep link listener
      _authSubscription = SupabaseServices.supabaseClient.auth.onAuthStateChange
          .listen((data) async {
            final AuthChangeEvent event = data.event;
            switch (event) {
              case AuthChangeEvent.signedIn:
                final userID = data.session!.user.id;
                final fcmToken = await SecureStorageHelper.instance
                    .getFCMToken();
                SupabaseServices.addProfile(
                  Profile(id: userID, fcmToken: fcmToken!),
                );
                _cubit.openTodoListPage();
                break;
              default:
                break;
            }
          });
    } catch (e) {
      rethrow;
    }

    await Future.delayed(Duration(seconds: 3));
    final session = SupabaseServices.supabaseClient.auth.currentSession;
    if (session != null) {
      if (mounted) {
        _cubit.openTodoListPage();
      }
    } else {
      if (mounted) {
        _cubit.openLoginPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.primary)),
          Center(child: const TodoLogo()),
        ],
      ),
    );
  }
}
