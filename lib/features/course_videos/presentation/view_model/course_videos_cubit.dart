import 'package:e_learning/features/course_videos/data/repositories/course_videos_repository.dart';
import 'package:e_learning/features/course_videos/presentation/view_model/course_videos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseVideosCubit extends Cubit<CourseVideosState> {
  CourseVideosCubit(this._repository) : super(CourseVideosInitial());

  final CourseVideosRepository _repository;

  Future<void> getCourseVideos(String courseId) async {
    emit(CourseVideosLoading());
    final response = await _repository.getCourseVideos(courseId);
    if (isClosed) return;
    response.fold(
      (failure) => emit(CourseVideosFailure(failure.message)),
      (videos) => emit(CourseVideosSuccess(videos)),
    );
  }
}
