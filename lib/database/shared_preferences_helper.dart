import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_bloc/model/enums/language.dart';

class SharedPreferencesHelper {
  static const _currentLanguageKey = "current_language";

  static Future<Language?> getCurrentLanguage() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final languageCode = preferences.getString(_currentLanguageKey) ?? "";
      return LanguageExt.languageFromCode(languageCode);
    } catch (e) {
      return null;
    }
  }

  static Future<void> setCurrentLanguage(Language language) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_currentLanguageKey, language.code);
  }
}
