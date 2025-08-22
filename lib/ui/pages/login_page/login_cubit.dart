import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/ui/pages/login_page/login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginState());

}