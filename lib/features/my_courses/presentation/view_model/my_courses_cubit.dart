import 'package:e_learning/features/my_courses/data/repositories/my_courses_repository.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/my_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCoursesCubit extends Cubit<MyCoursesState> {
  MyCoursesCubit(this._repository) : super(MyCoursesInitial());

  final MyCoursesRepository _repository;
  bool _isLoading = false;

  Future<void> getMyCourses() async {
    if (_isLoading || isClosed) return;
    _isLoading = true;
    emit(MyCoursesLoading());
    final response = await _repository.getMyCourses();
    _isLoading = false;
    if (isClosed) return;
    response.fold(
      (failure) => emit(MyCoursesFailure(failure.message)),
      (courses) => emit(MyCoursesSuccess(courses)),
    );
  }
}
