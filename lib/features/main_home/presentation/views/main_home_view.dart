import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/Profile/presentation/view/profile_screen.dart';
import 'package:e_learning/features/Profile/presentation/view_model/profile_cubit.dart';
import 'package:e_learning/features/home/presentation/views/home_view.dart';
import 'package:e_learning/features/main_home/data/models/navigation_item_model.dart';
import 'package:e_learning/features/main_home/presentation/view_model/main_home_cubit.dart';
import 'package:e_learning/features/main_home/presentation/views/widgets/main_home_bottom_navigation_bar.dart';
import 'package:e_learning/features/my_courses/presentation/view_model/my_courses_cubit.dart';
import 'package:e_learning/features/my_courses/presentation/views/my_courses_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  static final List<NavigationItemModel> _items = [
    NavigationItemModel(
      label: AppStrings.home,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      page: const HomeView(),
    ),
    NavigationItemModel(
      label: AppStrings.myCourses,
      icon: Icons.library_books_outlined,
      selectedIcon: Icons.library_books_rounded,
      page: const MyCoursesView(),
    ),
    NavigationItemModel(
      label: AppStrings.profile,
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      page: const ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainHomeCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: _items.map((item) => item.page).toList(growable: false),
          ),
          bottomNavigationBar: MainHomeBottomNavigationBar(
            currentIndex: currentIndex,
            items: _items,
            onTap: (index) {
              context.read<MainHomeCubit>().changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
