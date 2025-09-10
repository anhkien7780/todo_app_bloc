import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/database/shared_preferences_helper.dart';

class SecureStorageHelper {
  static const _fcmToken = 'fcm_token';
  static const _session = 'session';
  static const _user = 'user';

  final FlutterSecureStorage _storage;

  String _userID = "";
  String get userID => _userID;

  SecureStorageHelper._(this._storage);

  static final SecureStorageHelper _instance = SecureStorageHelper._(
    FlutterSecureStorage(),
  );

  static SecureStorageHelper get instance => _instance;

  void saveFCMToken(String fcmToken) async {
    await _storage.write(key: _fcmToken, value: fcmToken);
  }

  void saveSession(Session session) async {
    await _storage.write(key: _session, value: jsonEncode(session.toJson()));
  }

  void saveUser(User user) async {
    _userID = user.id;
    await _storage.write(key: _user, value: jsonEncode(user.toJson()));
  }

  void removeSession() async {
    await _storage.delete(key: _session);
  }

  void removeFCMToken() async {
    await _storage.delete(key: _fcmToken);
  }

  void removeUser() async {
    _userID = "";
    await _storage.delete(key: _user);
  }

  Future<String?> getFCMToken() async {
    try {
      final isFirstTime = await SharedPreferencesHelper.isFirstRun();
      if (isFirstTime) {
        firstTimeSetup();
        return null;
      }
      final fcmToken = await _storage.read(key: _fcmToken);
      return fcmToken;
    } catch (e) {
      return null;
    }
  }

  Future<Session?> getSession() async {
    try {
      final isFirstTime = await SharedPreferencesHelper.isFirstRun();
      if (isFirstTime) {
        firstTimeSetup();
        return null;
      }
      final sessionJson = await _storage.read(key: _session);
      if (sessionJson == null) {
        return null;
      }
      return Session.fromJson(jsonDecode(sessionJson));
    } catch (e) {
      return null;
    }
  }

  Future<User?> getUser() async {
    try {
      final isFirstTime = await SharedPreferencesHelper.isFirstRun();
      if (isFirstTime) {
        firstTimeSetup();
        return null;
      }
      final userJson = await _storage.read(key: _user);
      if (userJson == null) {
        return null;
      }
      return User.fromJson(jsonDecode(userJson));
    } catch (e) {
      return null;
    }
  }

  void firstTimeSetup() {
    removeFCMToken();
    removeSession();
    removeUser();
  }
}
