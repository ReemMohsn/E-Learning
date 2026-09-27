import 'package:e_learning/features/course_videos/data/models/course_video_model.dart';

abstract class CourseVideosState {}

class CourseVideosInitial extends CourseVideosState {}

class CourseVideosLoading extends CourseVideosState {}

class CourseVideosSuccess extends CourseVideosState {
  CourseVideosSuccess(this.videos);

  final List<CourseVideoModel> videos;
}

class CourseVideosFailure extends CourseVideosState {
  CourseVideosFailure(this.message);

  final String message;
}
