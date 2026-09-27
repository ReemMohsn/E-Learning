import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/core/themes/app_theme.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:e_learning/features/home/presentation/views/widgets/course_image.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.imageHeight,
  });

  final CourseModel course;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: AppTheme.coursePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: imageHeight,
              child: CourseImage(imageUrl: course.imageUrl),
            ),
            const SizedBox(height: 10),
            Text(
              course.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              course.formattedPrice,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall,
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => Navigator.of(
                context,
              ).pushNamed(Routes.courseDetails, arguments: course),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                minimumSize: const Size(64, 40),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(AppStrings.showDetails),
            ),
          ],
        ),
      ),
    );
  }
}
