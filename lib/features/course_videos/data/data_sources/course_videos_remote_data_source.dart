import 'package:e_learning/features/course_videos/data/models/course_video_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CourseVideosRemoteDataSource {
  const CourseVideosRemoteDataSource(this._client);

  static const _bucketName = 'course-videos';
  final SupabaseClient _client;

  Future<List<CourseVideoModel>> getCourseVideos(String courseId) async {
    final response = await _client
        .from('course_videos')
        .select(
          'id, course_id, title, description, video_path, thumbnail_url, position',
        )
        .eq('course_id', courseId)
        .order('position')
        .timeout(const Duration(seconds: 20));

    return Future.wait(
      response.map((video) async {
        final path = video['video_path'] as String;
        final videoUrl = _isWebUrl(path)
            ? path
            : await _client.storage
                  .from(_bucketName)
                  .createSignedUrl(path, 60 * 60)
                  .timeout(const Duration(seconds: 20));
        return CourseVideoModel.fromJson(video, videoUrl: videoUrl);
      }),
    );
  }

  bool _isWebUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host.isNotEmpty;
  }
}
