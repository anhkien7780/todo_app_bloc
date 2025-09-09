import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';

class SignUpState extends Equatable {
  final LoadStatus loadStatus;

  const SignUpState({this.loadStatus = LoadStatus.initial});

  SignUpState copyWith({LoadStatus? loadStatus, String? message}) {
    return SignUpState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  @override
  List<Object?> get props => [loadStatus];
}
