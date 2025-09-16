import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';

class SplashState extends Equatable {
  final LoadStatus fetchTodoStatus;

  const SplashState({this.fetchTodoStatus = LoadStatus.initial});

  SplashState copyWith({LoadStatus? fetchTodoStatus}) {
    return SplashState(
      fetchTodoStatus: fetchTodoStatus ?? this.fetchTodoStatus,
    );
  }

  @override
  List<Object?> get props => [fetchTodoStatus];
}
