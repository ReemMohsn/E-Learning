import 'package:dartz/dartz.dart';
import 'package:e_learning/core/services/errors/failure.dart';
import 'package:e_learning/core/services/request_handler.dart';
import 'package:e_learning/features/Profile/data/data_source/profile_remote_data_source.dart';
import 'package:e_learning/features/Profile/data/models/profile_model.dart';

class ProfileRepository {
  const ProfileRepository(this._remote);

  final ProfileRemoteDataSource _remote;

  Future<Either<Failure, ProfileModel>> getProfile() =>
      requestHandler(_remote.getProfile);

  Future<Either<Failure, ProfileModel>> updateProfile({
    required String fullName,
    required String email,
    String? password,
  }) => requestHandler(
    () => _remote.updateProfile(
      fullName: fullName,
      email: email,
      password: password,
    ),
  );
}
