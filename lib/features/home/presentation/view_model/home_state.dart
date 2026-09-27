import 'package:e_learning/features/home/data/models/course_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  HomeSuccess({
    required this.courses,
    required this.query,
    this.isRefreshing = false,
    this.refreshError,
  });

  final List<CourseModel> courses;
  final String query;
  final bool isRefreshing;
  final String? refreshError;
}

class HomeFailure extends HomeState {
  HomeFailure({required this.errorMessage});

  final String errorMessage;
}
