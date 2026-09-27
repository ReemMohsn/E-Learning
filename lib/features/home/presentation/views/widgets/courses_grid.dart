import 'dart:math' as math;

import 'package:e_learning/core/themes/app_theme.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:e_learning/features/home/presentation/views/widgets/course_card.dart';
import 'package:flutter/material.dart';

class CoursesGrid extends StatelessWidget {
  const CoursesGrid({super.key, required this.courses});

  final List<CourseModel> courses;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScaler = MediaQuery.textScalerOf(context);
        final scale = math.max(1.0, textScaler.scale(14) / 14);
        final minimumWidth = 150 * scale;
        final columns =
            ((constraints.maxWidth + AppTheme.homeSpacing) /
                    (minimumWidth + AppTheme.homeSpacing))
                .floor()
                .clamp(1, 4)
                .toInt();
        final cardWidth =
            (constraints.maxWidth - AppTheme.homeSpacing * (columns - 1)) /
            columns;
        final imageHeight = math.min((cardWidth - 16) * 0.57, 180.0);
        final textHeight =
            textScaler.scale(14) * 1.5 + textScaler.scale(12) * 1.5;
        final buttonHeight = math.max(48.0, textScaler.scale(14) * 1.5 + 24);

        return GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: courses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: AppTheme.homeSpacing,
            mainAxisSpacing: AppTheme.homeSpacing,
            mainAxisExtent: imageHeight + textHeight + buttonHeight + 42,
          ),
          itemBuilder: (context, index) => CourseCard(
            key: ValueKey(courses[index].id),
            course: courses[index],
            imageHeight: imageHeight,
          ),
        );
      },
    );
  }
}
