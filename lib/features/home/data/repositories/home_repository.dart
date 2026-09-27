import 'package:dartz/dartz.dart';
import 'package:e_learning/core/services/errors/failure.dart';
import 'package:e_learning/core/services/request_handler.dart';
import 'package:e_learning/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';

class HomeRepository {
  const HomeRepository(this._remote);

  final HomeRemoteDataSource _remote;

  String get fullName => _remote.fullName;

  Future<Either<Failure, List<CourseModel>>> getCourses() =>
      requestHandler(_remote.getCourses);
}
