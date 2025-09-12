import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';

class ChangePasswordState extends Equatable {
  final LoadStatus loadStatus;

  const ChangePasswordState({this.loadStatus = LoadStatus.initial});

  ChangePasswordState copyWith({LoadStatus? loadStatus}) {
    return ChangePasswordState(loadStatus: loadStatus ?? this.loadStatus);
  }

  @override
  List<Object?> get props => [loadStatus];
}
