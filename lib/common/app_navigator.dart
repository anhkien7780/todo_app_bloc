import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_app_bloc/router/router_config.dart';

class AppNavigator {
  BuildContext context;

  AppNavigator({required this.context});

  void pop<T extends Object?>([T? result]) {
    GoRouter.of(context).pop(result);
  }

  void navigatorPop<T extends Object?>([T? result]) {
    Navigator.of(context).pop(result);
  }

  void popUntilNamed(String name) {
    Navigator.popUntil(context, ModalRoute.withName(name));
  }

  Future<dynamic> pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<dynamic> pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return GoRouter.of(context).pushReplacementNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return GoRouter.of(context).goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void showLoadingOverlay() {
    context.loaderOverlay.show();
  }

  void hideLoadingOverlay() {
    context.loaderOverlay.hide();
  }

  Future<void> openTodoListPage() {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    return GoRouter.of(context).pushNamed(AppRouter.todoList);
  }
}
