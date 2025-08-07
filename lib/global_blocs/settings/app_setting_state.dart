import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/configs/app_configs.dart';
import 'package:todo_app_bloc/model/enums/language.dart';

class AppSettingState extends Equatable {
  final Language language;

  const AppSettingState({this.language = AppConfigs.defaultLanguage});

  AppSettingState copyWith({Language? language}) {
    return AppSettingState(language: language ?? this.language);
  }

  @override
  List<Object?> get props => [language];
}
