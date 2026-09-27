import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/home/data/models/course_model.dart';
import 'package:e_learning/features/home/data/repositories/home_repository.dart';
import 'package:e_learning/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(HomeInitial());

  final HomeRepository _repository;
  List<CourseModel> _courses = const [];
  String _query = '';
  bool _hasLoaded = false;
  bool _isLoading = false;

  String get fullName => _repository.fullName;

  Future<void> getCourses() async {
    if (_isLoading || isClosed) return;
    _isLoading = true;
    if (_hasLoaded) {
      _emitCourses(isRefreshing: true);
    } else {
      emit(HomeLoading());
    }

    final response = await _repository.getCourses();
    _isLoading = false;
    if (isClosed) return;

    response.fold(
      (failure) {
        final message = failure.code == 'PGRST205' || failure.code == '42P01'
            ? AppStrings.coursesUnavailable
            : failure.message;
        if (_hasLoaded) {
          _emitCourses(refreshError: message);
        } else {
          emit(HomeFailure(errorMessage: message));
        }
      },
      (courses) {
        _courses = courses;
        _hasLoaded = true;
        _emitCourses();
      },
    );
  }

  void searchCourses(String query) {
    _query = query.trim();
    if (_hasLoaded && !isClosed) {
      _emitCourses(isRefreshing: _isLoading);
    }
  }

  void _emitCourses({bool isRefreshing = false, String? refreshError}) {
    final query = _query.toLowerCase();
    final filteredCourses = _courses
        .where((course) {
          return course.title.toLowerCase().contains(query) ||
              course.description.toLowerCase().contains(query);
        })
        .toList(growable: false);

    emit(
      HomeSuccess(
        courses: List.unmodifiable(filteredCourses),
        query: _query,
        isRefreshing: isRefreshing,
        refreshError: refreshError,
      ),
    );
  }
}
