import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/database/shared_preferences_helper.dart';
import 'package:todo_app_bloc/global_blocs/settings/app_setting_state.dart';
import 'package:todo_app_bloc/model/enums/language.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(const AppSettingState());

  Future<void> getInitialSetting() async {
    final currentLanguage = await SharedPreferencesHelper.getCurrentLanguage();
    emit(state.copyWith(language: currentLanguage));
  }

  void changeLanguage({required Language language}) async {
    await SharedPreferencesHelper.setCurrentLanguage(language);
    emit(state.copyWith(language: language));
  }
}
