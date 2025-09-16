import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_navigator.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;

  SplashCubit({required this.navigator}) : super(const SplashState());

  void openTodoListPage() {
    navigator.openTodoListPage();
  }

  void openLoginPage() {
    navigator.openLoginPage();
  }

  bool isSignIn() {
    final session = SupabaseServices.supabaseClient.auth.currentSession;
    if (session != null) {
      return true;
    }
    return false;
  }
}
