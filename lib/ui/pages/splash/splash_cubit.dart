import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/ui/pages/splash/spash_state.dart';
import 'package:todo_app_bloc/ui/pages/splash/splash_navigator.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;

  SplashCubit({required this.navigator}) : super(const SplashState());

  Future<void> openTodoListPage() async {
    await Future.delayed(Duration(seconds: 3));
    navigator.openTodoListPage();
  }

  Future<void> openLoginPage() async{
    await Future.delayed(Duration(seconds: 3));
    navigator.openLoginPage();
  }
}
