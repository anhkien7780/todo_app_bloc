import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';

class LoginState extends Equatable {
  final LoadStatus loginStatus;
  final String account;
  final String password;

  const LoginState({
    this.loginStatus = LoadStatus.initial,
    this.account = '',
    this.password = '',
  });

  @override
  List<Object?> get props => [loginStatus, account, password];
}
