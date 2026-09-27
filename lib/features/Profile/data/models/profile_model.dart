class ProfileModel {
  const ProfileModel({required this.fullName, required this.email});

  final String fullName;
  final String email;

  ProfileModel copyWith({String? fullName, String? email}) {
    return ProfileModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }
}
