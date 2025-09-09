import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/configs/app_env_config.dart';
import 'package:todo_app_bloc/model/enums/oauth_mode.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';

abstract class AuthRepository {
  Future<AuthResponse> login({required String email, required String password});

  Future<AuthResponse> signUp({
    required String email,
    required String password,
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
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
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
}
