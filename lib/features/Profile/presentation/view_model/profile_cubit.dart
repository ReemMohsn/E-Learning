import 'package:e_learning/features/Profile/data/models/profile_model.dart';
import 'package:e_learning/features/Profile/data/repository/profile_repository.dart';
import 'package:e_learning/features/Profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(ProfileInitial());

  final ProfileRepository _repository;
  ProfileModel? profile;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final response = await _repository.getProfile();
    if (isClosed) return;
    response.fold((failure) => emit(ProfileFailure(failure.message)), (value) {
      profile = value;
      emit(ProfileSuccess(value));
    });
  }

  Future<void> updateProfile({
    required String fullName,
    required String email,
    String? password,
  }) async {
    emit(ProfileUpdating());
    final response = await _repository.updateProfile(
      fullName: fullName,
      email: email,
      password: password,
    );
    if (isClosed) return;
    response.fold((failure) => emit(ProfileFailure(failure.message)), (value) {
      profile = value;
      emit(ProfileUpdateSuccess(value));
    });
  }
}
