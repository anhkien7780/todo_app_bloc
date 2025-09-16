import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/configs/app_env_config.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';

abstract class AuthRepository {
  Future<AuthResponse> login({required String email, required String password});

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  });

  Future<UserResponse> changePassword({
    required String newPassword,
  });

  Future<void> logout();
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return SupabaseServices.supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await SupabaseServices.logout();
  }

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await SupabaseServices.supabaseClient.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: Environment.prod.redirectUrl,
    );
  }

  @override
  Future<UserResponse> changePassword({
    required String newPassword,
  }) async {
    return await SupabaseServices.supabaseClient.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }
}
