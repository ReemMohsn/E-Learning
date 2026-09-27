import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyCoursesRemoteDataSource {
  const MyCoursesRemoteDataSource(this._client);

  final SupabaseClient _client;

  String get _userId {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException(AppStrings.pleaseSignInAgainToContinue);
    }
    return user.id;
  }

  Future<List<CourseModel>> getMyCourses() async {
    final response = await _client
        .from('enrollments')
        .select(
          'enrolled_at, course:courses(id, title, description, price, image_url)',
        )
        .eq('user_id', _userId)
        .order('enrolled_at', ascending: false)
        .timeout(const Duration(seconds: 20));

    return response
        .map((row) => row['course'])
        .whereType<Map>()
        .map(
          (course) => CourseModel.fromJson(Map<String, dynamic>.from(course)),
        )
        .toList(growable: false);
  }

  Future<bool> isEnrolled(String courseId) async {
    final response = await _client
        .from('enrollments')
        .select('course_id')
        .eq('user_id', _userId)
        .eq('course_id', courseId)
        .maybeSingle()
        .timeout(const Duration(seconds: 20));
    return response != null;
  }

  Future<void> startCourse(String courseId) async {
    await _client
        .from('enrollments')
        .insert({'user_id': _userId, 'course_id': courseId})
        .timeout(const Duration(seconds: 20));
  }
}
