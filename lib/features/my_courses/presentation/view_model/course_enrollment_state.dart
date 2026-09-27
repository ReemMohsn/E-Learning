abstract class CourseEnrollmentState {}

class CourseEnrollmentInitial extends CourseEnrollmentState {}

class CourseEnrollmentChecking extends CourseEnrollmentState {}

class CourseEnrollmentReady extends CourseEnrollmentState {
  CourseEnrollmentReady({required this.isEnrolled});

  final bool isEnrolled;
}

class CourseEnrollmentLoading extends CourseEnrollmentState {}

class CourseEnrollmentSuccess extends CourseEnrollmentState {}

class CourseEnrollmentFailure extends CourseEnrollmentState {
  CourseEnrollmentFailure(this.message);

  final String message;
}
