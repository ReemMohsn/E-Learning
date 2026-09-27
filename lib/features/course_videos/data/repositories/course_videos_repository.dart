import 'package:dartz/dartz.dart';
import 'package:e_learning/core/services/errors/failure.dart';
import 'package:e_learning/core/services/request_handler.dart';
import 'package:e_learning/features/course_videos/data/data_sources/course_videos_remote_data_source.dart';
import 'package:e_learning/features/course_videos/data/models/course_video_model.dart';

class CourseVideosRepository {
  const CourseVideosRepository(this._remote);

  final CourseVideosRemoteDataSource _remote;

  Future<Either<Failure, List<CourseVideoModel>>> getCourseVideos(
    String courseId,
  ) => requestHandler(() => _remote.getCourseVideos(courseId));
}
