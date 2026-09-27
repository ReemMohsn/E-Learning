class CourseVideoModel {
  const CourseVideoModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoPath,
    required this.videoUrl,
    required this.position,
    this.thumbnailUrl,
  });

  final String id;
  final String courseId;
  final String title;
  final String description;
  final String videoPath;
  final String videoUrl;
  final int position;
  final String? thumbnailUrl;

  factory CourseVideoModel.fromJson(
    Map<String, dynamic> json, {
    required String videoUrl,
  }) {
    return CourseVideoModel(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      videoPath: json['video_path'] as String,
      videoUrl: videoUrl,
      position: (json['position'] as num?)?.toInt() ?? 1,
      thumbnailUrl: json['thumbnail_url'] as String?,
    );
  }
}
