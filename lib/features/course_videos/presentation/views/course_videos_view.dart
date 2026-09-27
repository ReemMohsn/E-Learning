import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/course_videos/presentation/view_model/course_videos_cubit.dart';
import 'package:e_learning/features/course_videos/presentation/view_model/course_videos_state.dart';
import 'package:e_learning/features/course_videos/presentation/views/widgets/course_video_card.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:e_learning/features/home/presentation/views/widgets/home_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseVideosView extends StatelessWidget {
  const CourseVideosView({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.courseVideos)),
      body: SafeArea(
        child: BlocBuilder<CourseVideosCubit, CourseVideosState>(
          builder: (context, state) {
            if (state is CourseVideosFailure) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  HomeStatus(
                    icon: Icons.cloud_off_outlined,
                    message: state.message,
                    onRetry: () => context
                        .read<CourseVideosCubit>()
                        .getCourseVideos(course.id),
                  ),
                ],
              );
            }
            if (state is CourseVideosSuccess) {
              if (state.videos.isEmpty) {
                return const HomeStatus(
                  icon: Icons.video_library_outlined,
                  message: AppStrings.noCourseVideos,
                );
              }
              return RefreshIndicator(
                onRefresh: () => context
                    .read<CourseVideosCubit>()
                    .getCourseVideos(course.id),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.videos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      CourseVideoCard(video: state.videos[index]),
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
