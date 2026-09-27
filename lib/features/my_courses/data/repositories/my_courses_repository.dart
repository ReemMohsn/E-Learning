import 'package:dartz/dartz.dart';
import 'package:e_learning/core/services/errors/failure.dart';
import 'package:e_learning/core/services/request_handler.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:e_learning/features/my_courses/data/data_sources/my_courses_remote_data_source.dart';

class MyCoursesRepository {
  const MyCoursesRepository(this._remote);

  final MyCoursesRemoteDataSource _remote;

  Future<Either<Failure, List<CourseModel>>> getMyCourses() =>
      requestHandler(_remote.getMyCourses);

  Future<Either<Failure, bool>> isEnrolled(String courseId) =>
      requestHandler(() => _remote.isEnrolled(courseId));

  Future<Either<Failure, void>> startCourse(String courseId) =>
      requestHandler(() => _remote.startCourse(courseId));
}
