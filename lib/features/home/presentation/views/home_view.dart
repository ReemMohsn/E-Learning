import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/core/themes/app_theme.dart';
import 'package:e_learning/features/home/presentation/view_model/home_cubit.dart';
import 'package:e_learning/features/home/presentation/view_model/home_state.dart';
import 'package:e_learning/features/home/presentation/views/widgets/courses_grid.dart';
import 'package:e_learning/features/home/presentation/views/widgets/home_header.dart';
import 'package:e_learning/features/home/presentation/views/widgets/home_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return SafeArea(
      top: false,
      bottom: false,
      child: RefreshIndicator(
        onRefresh: cubit.getCourses,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              HomeHeader(
                fullName: cubit.fullName,
                searchController: _searchController,
                onSearchChanged: cubit.searchCourses,
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppTheme.homeMaxWidth,
                  ),
                  child: Padding(
                    padding: AppTheme.homePadding,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeFailure) {
                          return HomeStatus(
                            icon: Icons.cloud_off_outlined,
                            message: state.errorMessage,
                            onRetry: cubit.getCourses,
                          );
                        }
                        if (state is HomeSuccess) {
                          if (state.courses.isEmpty) {
                            return HomeStatus(
                              icon: state.query.isEmpty
                                  ? Icons.school_outlined
                                  : Icons.search_off,
                              message: state.query.isEmpty
                                  ? AppStrings.noCoursesYet
                                  : AppStrings.noMatchingCourses,
                            );
                          }
                          return CoursesGrid(courses: state.courses);
                        }
                        return const Padding(
                          padding: EdgeInsets.all(64),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
