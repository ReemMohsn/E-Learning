import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/auth/data/repositories/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(AuthInitial());

  final AuthRepository _repository;

  Future<void> signIn({required String email, required String password}) async {
    emit(LoginLoading());
    final response = await _repository.signIn(email: email, password: password);

    response.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.message)),
      (authResult) =>
          emit(LoginSuccess(message: AppStrings.loggedInSuccessfully)),
    );
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    final response = await _repository.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );

    response.fold(
      (failure) => emit(SignUpFailure(errorMessage: failure.message)),
      (authResult) =>
          emit(SignUpSuccess(message: AppStrings.accountCreatedSuccessfully)),
    );
  }

  Future<void> signOut() async {
    emit(SignOutLoading());
    final response = await _repository.signOut();

    response.fold(
      (failure) => emit(SignOutFailure(errorMessage: failure.message)),
      (_) => emit(SignOutSuccess(message: AppStrings.loggedOutSuccessfully)),
    );
  }
}
