import 'package:app_links/app_links.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/database/secure_storage_helper.dart';
import 'package:todo_app_bloc/router/router_config.dart';

class AuthDeepLinkHandler {
  final _appLinks = AppLinks();

  void init() {
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    });

    _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  Future<void> _handleUri(Uri uri) async {
    try {
      final res = await Supabase.instance.client.auth.getSessionFromUrl(uri);
      SecureStorageHelper.instance.saveSession(res.session);
      AppRouter.router.goNamed(AppRouter.todoList);
    } catch (e) {
      rethrow;
    }
  }
}
