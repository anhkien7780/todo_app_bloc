import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';

class SettingState extends Equatable {
  final LoadStatus loadStatus;

  const SettingState({
    this.loadStatus = LoadStatus.initial,
  });

  SettingState copyWith({
    LoadStatus? loadStatus,
  }) {
    return SettingState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }


  @override
  List<Object?> get props => [loadStatus];
}
