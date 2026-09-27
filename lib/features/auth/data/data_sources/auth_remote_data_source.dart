import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/auth/data/models/auth_account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._client);
  final SupabaseClient _client;

  Future<AuthAccount> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
    if (response.session == null) {
      throw const AuthException(
        AppStrings.noSessionReturned,
        code: 'session_not_found',
      );
    }
    return AuthAccount.fromUser(response.user ?? response.session?.user)!;
  }

  Future<AuthAccount> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email.trim(),
      password: password,
      data: {'full_name': fullName.trim()},
    );
    return AuthAccount.fromUser(response.user ?? response.session?.user)!;
  }

  Future<void> signOut() => _client.auth.signOut(scope: SignOutScope.local);
}
