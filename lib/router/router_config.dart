import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_bloc/ui/pages/login_page/login_page.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_page.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_page.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    routes: _routes,
    debugLogDiagnostics: true,
    navigatorKey: navigationKey,
  );

  static const String splash = "/";
  static const String login = "/login";
  static const String todoList = "/todo_list";

  static final _routes = <RouteBase>[
    GoRoute(
      path: splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: login,
      name: login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: todoList,
      name: todoList,
      builder: (context, state) => const TodoListPage(),
    ),
  ];
}
