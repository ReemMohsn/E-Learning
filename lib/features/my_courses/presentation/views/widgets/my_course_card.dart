import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:e_learning/features/home/presentation/views/widgets/course_image.dart';
import 'package:flutter/material.dart';

class MyCourseCard extends StatelessWidget {
  const MyCourseCard({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(
          context,
        ).pushNamed(Routes.courseVideos, arguments: course),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              SizedBox(
                width: 120,
                height: 82,
                child: CourseImage(imageUrl: course.imageUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => Navigator.of(
                        context,
                      ).pushNamed(Routes.courseVideos, arguments: course),
                      child: const Text(AppStrings.openCourse),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
