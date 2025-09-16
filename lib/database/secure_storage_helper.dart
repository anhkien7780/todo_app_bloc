import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app_bloc/database/shared_preferences_helper.dart';

class SecureStorageHelper {
  static const _fcmTokenKey = 'fcm_token';

  late final String _fcmToken;

  String get fcmToken => _fcmToken;

  final FlutterSecureStorage _storage;

  SecureStorageHelper._(this._storage);

  static final SecureStorageHelper _instance = SecureStorageHelper._(
    FlutterSecureStorage(),
  );

  static SecureStorageHelper get instance => _instance;

  void saveFCMToken(String fcmToken) async {
    _fcmToken = fcmToken;
    await _storage.write(key: _fcmTokenKey, value: fcmToken);
  }

  void removeFCMToken() async {
    await _storage.delete(key: _fcmTokenKey);
  }

  Future<String?> getFCMToken() async {
    try {
      final isFirstTime = await SharedPreferencesHelper.isFirstRun();
      if (isFirstTime) {
        firstTimeSetup();
        return null;
      }
      final fcmToken = await _storage.read(key: _fcmTokenKey);
      return fcmToken;
    } catch (e) {
      return null;
    }
  }

  void firstTimeSetup() {
    removeFCMToken();
  }
}
