import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/Profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<ProfileModel> getProfile() async {
    return _profileFromUser(_currentUser);
  }

  Future<ProfileModel> updateProfile({
    required String fullName,
    required String email,
    String? password,
  }) async {
    final currentUser = _currentUser;
    final normalizedEmail = email.trim();
    final response = await _client.auth.updateUser(
      UserAttributes(
        email: normalizedEmail == currentUser.email ? null : normalizedEmail,
        password: password == null || password.isEmpty ? null : password,
        data: {
          ...(currentUser.userMetadata ?? const <String, dynamic>{}),
          'full_name': fullName.trim(),
        },
      ),
    );
    return _profileFromUser(response.user ?? _currentUser);
  }

  User get _currentUser {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException(AppStrings.pleaseSignInAgainToContinue);
    }
    return user;
  }

  ProfileModel _profileFromUser(User user) {
    final metadata = user.userMetadata ?? const <String, dynamic>{};
    return ProfileModel(
      fullName: (metadata['full_name'] ?? metadata['name'] ?? '')
          .toString()
          .trim(),
      email: user.email ?? '',
    );
  }
}
