import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app_bloc/global_blocs/settings/app_setting_cubit.dart';
import 'package:todo_app_bloc/model/enums/language.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/router/router_config.dart';
import 'package:todo_app_bloc/ui/widgets/loading/app_loading_indicator.dart';

import 'generated/l10n.dart';
import 'global_blocs/settings/app_setting_state.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TodoRepository>(
      create: (BuildContext context) {
        return TodoRepositoryImpl();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppSettingCubit>(create: (context) => AppSettingCubit()),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (pre, current) {
            return pre.language != current.language;
          },
          builder: (BuildContext context, state) {
            return GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: GlobalLoaderOverlay(
                overlayWidgetBuilder: (_) {
                  return Center(
                    child: Container(
                      color: Colors.grey,
                      width: 40,
                      height: 40,
                      child: const Center(
                        child: AppCircularProgressIndicator(),
                      ),
                    ),
                  );
                },
                child: _buildMaterialApp(locale: state.language.local),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMaterialApp({required Locale locale}) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
