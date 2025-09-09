import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';

class LoginState extends Equatable {
  const LoginState({this.loadStatus = LoadStatus.initial});

  final LoadStatus loadStatus;

  LoginState copyWith({
    LoadStatus? loadStatus,
  }) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  @override
  List<Object?> get props => [loadStatus];
}
