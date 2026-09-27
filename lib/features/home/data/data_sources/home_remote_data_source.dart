import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRemoteDataSource {
  const HomeRemoteDataSource(this._client);

  final SupabaseClient _client;

  String get fullName {
    final metadata = _client.auth.currentUser?.userMetadata;
    return (metadata?['full_name'] ?? metadata?['name'] ?? '')
        .toString()
        .trim();
  }

  Future<List<CourseModel>> getCourses() async {
    const pageSize = 50;
    final courses = <CourseModel>[];
    var offset = 0;

    while (true) {
      final response = await _client
          .from('courses')
          .select('id, title, description, price, image_url')
          .order('created_at', ascending: false)
          .order('id')
          .range(offset, offset + pageSize - 1)
          .timeout(const Duration(seconds: 20));

      courses.addAll(response.map(CourseModel.fromJson));
      if (response.length < pageSize) break;
      offset += pageSize;
    }

    return courses;
  }
}
