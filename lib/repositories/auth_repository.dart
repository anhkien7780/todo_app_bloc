import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/model/enums/oauth_mode.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';

abstract class AuthRepository {
  Future<void> login({required String email, required String password});

  Future<void> signUp({required String email, required String password});

  Future<void> loginWithOAuth({required OAuthMode mode});

  Future<void> logout();
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> login({required String email, required String password}) async {
    final AuthResponse res = await SupabaseServices.supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> loginWithOAuth({required OAuthMode mode}) {
    // TODO: implement loginWithOAuth
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}
