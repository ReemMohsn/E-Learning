import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/core/extensions/snack_bar_context_extension.dart';
import 'package:e_learning/core/themes/app_theme.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:e_learning/features/home/presentation/views/widgets/course_image.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/course_enrollment_cubit.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/course_enrollment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.courseDetails)),
      body: SafeArea(
        child: BlocConsumer<CourseEnrollmentCubit, CourseEnrollmentState>(
          listener: (context, state) {
            if (state is CourseEnrollmentSuccess) {
              context.showSuccessSnackBar(AppStrings.enrolledSuccessfully);
            } else if (state is CourseEnrollmentFailure) {
              context.showErrorSnackBar(state.message);
            }
          },
          builder: (context, state) {
            final cubit = context.read<CourseEnrollmentCubit>();
            final isLoading =
                state is CourseEnrollmentLoading ||
                state is CourseEnrollmentChecking;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppTheme.courseDetailsMaxWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CourseImage(imageUrl: course.imageUrl),
                      ),
                      const SizedBox(height: 24),
                      Text(course.title, style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text(
                        course.formattedPrice,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        AppStrings.description,
                        style: theme.textTheme.titleMedium,
                      ),
                      const Divider(height: 20),
                      Text(
                        course.description.trim().isEmpty
                            ? AppStrings.noCourseDescription
                            : course.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 56),
                      FilledButton(
                        onPressed: isLoading || cubit.isEnrolled
                            ? null
                            : () => cubit.startCourse(course.id),
                        child: isLoading
                            ? const SizedBox.square(
                                dimension: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                cubit.isEnrolled
                                    ? AppStrings.enrolled
                                    : AppStrings.startCourse,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
