import 'package:todo_app_bloc/common/app_navigator.dart';

class SettingNavigator extends AppNavigator{
  SettingNavigator({required super.context});

  void onBackButtonPressed(){
    pop();
  }

}