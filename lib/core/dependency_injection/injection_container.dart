import 'package:e_learning/core/services/shared_preferences_service.dart';
import 'package:e_learning/features/Profile/data/data_source/profile_remote_data_source.dart';
import 'package:e_learning/features/Profile/data/repository/profile_repository.dart';
import 'package:e_learning/features/Profile/presentation/view_model/profile_cubit.dart';
import 'package:e_learning/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:e_learning/features/auth/data/repositories/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:e_learning/features/course_videos/data/data_sources/course_videos_remote_data_source.dart';
import 'package:e_learning/features/course_videos/data/repositories/course_videos_repository.dart';
import 'package:e_learning/features/course_videos/presentation/view_model/course_videos_cubit.dart';
import 'package:e_learning/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:e_learning/features/home/data/repositories/home_repository.dart';
import 'package:e_learning/features/home/presentation/view_model/home_cubit.dart';
import 'package:e_learning/features/main_home/presentation/view_model/main_home_cubit.dart';
import 'package:e_learning/features/my_courses/data/data_sources/my_courses_remote_data_source.dart';
import 'package:e_learning/features/my_courses/data/repositories/my_courses_repository.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/course_enrollment_cubit.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/my_courses_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External & Core Services
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  sl.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(),
  );

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(sl<AuthRemoteDataSource>()),
  );
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepository>()));

  // Main home
  sl.registerFactory<MainHomeCubit>(() => MainHomeCubit());

  // Home
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(sl<HomeRemoteDataSource>()),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<HomeRepository>()));

  // My courses & enrollment
  sl.registerLazySingleton<MyCoursesRemoteDataSource>(
    () => MyCoursesRemoteDataSource(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<MyCoursesRepository>(
    () => MyCoursesRepository(sl<MyCoursesRemoteDataSource>()),
  );
  sl.registerFactory<MyCoursesCubit>(
    () => MyCoursesCubit(sl<MyCoursesRepository>()),
  );
  sl.registerFactory<CourseEnrollmentCubit>(
    () => CourseEnrollmentCubit(sl<MyCoursesRepository>()),
  );

  // Course videos
  sl.registerLazySingleton<CourseVideosRemoteDataSource>(
    () => CourseVideosRemoteDataSource(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<CourseVideosRepository>(
    () => CourseVideosRepository(sl<CourseVideosRemoteDataSource>()),
  );
  sl.registerFactory<CourseVideosCubit>(
    () => CourseVideosCubit(sl<CourseVideosRepository>()),
  );

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(sl<ProfileRemoteDataSource>()),
  );
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl<ProfileRepository>()));
}
