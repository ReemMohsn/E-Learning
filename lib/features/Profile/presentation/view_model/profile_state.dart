import 'package:e_learning/features/Profile/data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  ProfileSuccess(this.profile);

  final ProfileModel profile;
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  ProfileUpdateSuccess(this.profile);

  final ProfileModel profile;
}

class ProfileFailure extends ProfileState {
  ProfileFailure(this.message);

  final String message;
}
