import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/home/presentation/views/widgets/home_status.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/my_courses_cubit.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/my_courses_state.dart';
import 'package:e_learning/features/my_courses/presentation/views/widgets/my_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCoursesView extends StatelessWidget {
  const MyCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyCoursesCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.myCourses)),
      body: SafeArea(
        child: BlocBuilder<MyCoursesCubit, MyCoursesState>(
          builder: (context, state) {
            if (state is MyCoursesFailure) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  HomeStatus(
                    icon: Icons.cloud_off_outlined,
                    message: state.message,
                    onRetry: cubit.getMyCourses,
                  ),
                ],
              );
            }
            if (state is MyCoursesSuccess) {
              if (state.courses.isEmpty) {
                return const HomeStatus(
                  icon: Icons.library_books_outlined,
                  message: AppStrings.noEnrolledCourses,
                );
              }
              return RefreshIndicator(
                onRefresh: cubit.getMyCourses,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final horizontalPadding = constraints.maxWidth > 700
                        ? (constraints.maxWidth - 700) / 2
                        : 16.0;
                    return ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        20,
                        horizontalPadding,
                        24,
                      ),
                      itemCount: state.courses.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, index) =>
                          MyCourseCard(course: state.courses[index]),
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
