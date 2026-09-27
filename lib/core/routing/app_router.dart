import 'package:e_learning/core/dependency_injection/injection_container.dart';
import 'package:e_learning/features/Profile/data/models/profile_model.dart';
import 'package:e_learning/features/Profile/presentation/view/edit_profile_screen.dart';
import 'package:e_learning/features/Profile/presentation/view_model/profile_cubit.dart';
import 'package:e_learning/features/course_videos/data/models/course_video_model.dart';
import 'package:e_learning/features/course_videos/presentation/view_model/course_videos_cubit.dart';
import 'package:e_learning/features/course_videos/presentation/views/course_videos_view.dart';
import 'package:e_learning/features/course_videos/presentation/views/video_player_view.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:e_learning/features/home/presentation/view_model/home_cubit.dart';
import 'package:e_learning/features/home/presentation/views/course_details_view.dart';
import 'package:e_learning/features/main_home/presentation/view_model/main_home_cubit.dart';
import 'package:e_learning/features/main_home/presentation/views/main_home_view.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/course_enrollment_cubit.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/my_courses_cubit.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/views/login_view.dart';
import 'package:e_learning/features/auth/presentation/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
      case Routes.signUp:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: settings.name == Routes.login
                ? const LoginView()
                : const SignUpView(),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<MainHomeCubit>()),
              BlocProvider(create: (_) => sl<AuthCubit>()),
              BlocProvider(create: (_) => sl<HomeCubit>()..getCourses()),
              BlocProvider(create: (_) => sl<MyCoursesCubit>()..getMyCourses()),
              BlocProvider(create: (_) => sl<ProfileCubit>()..getProfile()),
            ],
            child: const MainHomeView(),
          ),
        );

      case Routes.courseDetails:
        final course = settings.arguments;
        if (course is CourseModel) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) =>
                  sl<CourseEnrollmentCubit>()..checkEnrollment(course.id),
              child: CourseDetailsView(course: course),
            ),
          );
        }
        return _notFound(settings);

      case Routes.courseVideos:
        final course = settings.arguments;
        if (course is CourseModel) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) =>
                  sl<CourseVideosCubit>()..getCourseVideos(course.id),
              child: CourseVideosView(course: course),
            ),
          );
        }
        return _notFound(settings);

      case Routes.videoPlayer:
        final video = settings.arguments;
        if (video is CourseVideoModel) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => VideoPlayerView(video: video),
          );
        }
        return _notFound(settings);

      case Routes.editProfile:
        final profile = settings.arguments;
        if (profile is ProfileModel) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => sl<ProfileCubit>(),
              child: EditProfileScreen(profile: profile),
            ),
          );
        }
        return _notFound(settings);

      default:
        return _notFound(settings);
    }
  }

  Route<dynamic> _notFound(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        body: Center(child: Text('Page not found: ${settings.name}')),
      ),
    );
  }
}
