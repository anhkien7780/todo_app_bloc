import 'package:todo_app_bloc/configs/app_env_config.dart';
import 'package:todo_app_bloc/model/enums/language.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = "Todo App";
  static Environment env = Environment.prod;

  ///API Env
  static String get baseUrl => env.baseUrl;

  static String get envName => env.envName;

  ///Local
  static const defaultLanguage = Language.english;

  ///DateFormat
  static const dateDisplayFormat = "MMMM dd, yyyy";

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();

  ///Font
  static const fontFamily = "Inter";
}
