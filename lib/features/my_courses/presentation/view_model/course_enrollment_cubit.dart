import 'package:e_learning/features/my_courses/data/repositories/my_courses_repository.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/course_enrollment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseEnrollmentCubit extends Cubit<CourseEnrollmentState> {
  CourseEnrollmentCubit(this._repository) : super(CourseEnrollmentInitial());

  final MyCoursesRepository _repository;
  bool isEnrolled = false;

  Future<void> checkEnrollment(String courseId) async {
    emit(CourseEnrollmentChecking());
    final response = await _repository.isEnrolled(courseId);
    if (isClosed) return;
    response.fold((failure) => emit(CourseEnrollmentFailure(failure.message)), (
      enrolled,
    ) {
      isEnrolled = enrolled;
      emit(CourseEnrollmentReady(isEnrolled: enrolled));
    });
  }

  Future<void> startCourse(String courseId) async {
    if (isEnrolled || state is CourseEnrollmentLoading) return;
    emit(CourseEnrollmentLoading());
    final response = await _repository.startCourse(courseId);
    if (isClosed) return;
    response.fold(
      (failure) {
        if (failure.code == '23505') {
          isEnrolled = true;
          emit(CourseEnrollmentSuccess());
        } else {
          emit(CourseEnrollmentFailure(failure.message));
        }
      },
      (_) {
        isEnrolled = true;
        emit(CourseEnrollmentSuccess());
      },
    );
  }
}
