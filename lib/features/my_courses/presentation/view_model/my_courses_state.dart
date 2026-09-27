import 'package:e_learning/features/home/data/models/course_model.dart';

abstract class MyCoursesState {}

class MyCoursesInitial extends MyCoursesState {}

class MyCoursesLoading extends MyCoursesState {}

class MyCoursesSuccess extends MyCoursesState {
  MyCoursesSuccess(this.courses);

  final List<CourseModel> courses;
}

class MyCoursesFailure extends MyCoursesState {
  MyCoursesFailure(this.message);

  final String message;
}
