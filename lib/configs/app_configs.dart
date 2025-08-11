import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
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
  static String get dateDisplayFormat {
    final locale = Intl.getCurrentLocale();
    if (locale == 'vi') return "dd MMMM, yyyy";
    return "MMMM dd, yyyy";
  }


  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime(3000, 1, 1);

  ///Font
  static const fontFamily = "Inter";
}

class TodoSupabaseConfig {
  static final String anonKey = dotenv.env["SUPABASE_API_KEY"] ?? "";
}
