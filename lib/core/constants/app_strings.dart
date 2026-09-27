abstract final class AppStrings {
  static const home = 'Home';
  static const myCourses = 'My Courses';
  static const profile = 'Profile';
  static const welcomeToAcademy = 'welcome to CS Academy';
  static const searchCourses = 'what are you looking for?';
  static const clearSearch = 'Clear search';
  static const showDetails = 'Show Details';
  static const courseDetails = 'Course Details';
  static const description = 'Description';
  static const aboutCourse = 'About this course';
  static const noCourseDescription = 'A description will be available soon.';
  static const noCoursesYet = 'No courses available yet. Check back soon.';
  static const noMatchingCourses =
      'No courses match your search. Try another keyword.';
  static const coursesUnavailable =
      'Courses are not available yet. Please try again later.';
  static const tryAgain = 'Try Again';
  static const startCourse = 'Start Course';
  static const enrolled = 'Enrolled';
  static const enrolledSuccessfully = 'Course added to My Courses.';
  static const openCourse = 'Open Course';
  static const noEnrolledCourses =
      'You have not started a course yet. Open a course from Home and press Start Course.';
  static const courseVideos = 'Course Videos';
  static const noCourseVideos = 'No videos have been added to this course yet.';
  static const playVideo = 'Play video';
  static const pauseVideo = 'Pause video';
  static const videoCouldNotLoad = 'The video could not be loaded.';

  static const student = 'Student';
  static const academyMember = 'Academy Member';
  static const accountSettings = 'ACCOUNT SETTINGS';
  static const editProfile = 'Edit Profile';
  static const changePassword = 'Change Password';
  static const logOut = 'Log Out';
  static const confirmLogOut = 'Are you sure you want to log out?';
  static const cancel = 'Cancel';
  static const profileUpdated = 'Profile updated successfully.';
  static const fullName = 'Name';
  static const enterFullName = 'Enter your full name';
  static const enterEmail = 'Enter your email';
  static const newPassword = 'New password';
  static const leavePasswordEmpty = 'Leave empty to keep your password';
  static const saveChanges = 'Save Changes';

  static String homeGreeting(String name) =>
      name.isEmpty ? 'Hi, welcome!' : 'Hi, $name';

  static const noSessionReturned = 'Please sign in again to continue.';
  static const loggedInSuccessfully = 'Logged in successfully.';
  static const loggedOutSuccessfully = 'Logged out successfully.';
  static const accountCreatedSuccessfully =
      'Account created. Check your email to confirm your account before signing in.';

  static const fullNameField = 'Full name';
  static const email = 'Email';
  static const username = 'Username';
  static const phoneNumber = 'Phone number';
  static const password = 'Password';
  static const confirmPassword = 'Confirm password';
  static const thisField = 'This field';
  static const enterYourFullName = 'Enter your full name.';
  static const fullNameMustBeAtMost80Characters =
      'Full name must be at most 80 characters.';
  static const enterAValidEmailAddress = 'Enter a valid email address.';
  static const usernameMustBeAtLeast3Characters =
      'Username must be at least 3 characters.';
  static const enterAValidPhoneNumber = 'Enter a valid phone number.';
  static const passwordMustBeAtLeast8Characters =
      'Password must be at least 8 characters.';
  static const passwordMustContainAtLeastOneUppercaseLetter =
      'Password must contain an uppercase letter.';
  static const passwordMustContainAtLeastOneLowercaseLetter =
      'Password must contain a lowercase letter.';
  static const passwordMustContainAtLeastOneNumber =
      'Password must contain a number.';
  static const passwordMustContainAtLeastOneSpecialCharacter =
      'Password must contain a special character.';
  static const passwordsDoNotMatch = 'Passwords do not match.';

  static String requiredField(String field) => '$field is required.';
  static String requestFailed(Type type) => 'Request failed: $type';

  static const theSignInDetailsAreIncorrect =
      'The sign-in details are incorrect.';
  static const pleaseConfirmYourEmailBeforeSigningIn =
      'Please confirm your email before signing in.';
  static const pleaseConfirmYourPhoneNumberBeforeSigningIn =
      'Please confirm your phone number before signing in.';
  static const anAccountWithThisEmailAlreadyExists =
      'An account with this email already exists.';
  static const anAccountWithTheseDetailsAlreadyExists =
      'An account with these details already exists.';
  static const pleaseChooseAStrongerPassword =
      'Please choose a stronger password.';
  static const pleaseChooseAPasswordDifferentFromYourCurrentOne =
      'Please choose a password different from your current one.';
  static const theVerificationLinkOrCodeHasExpiredRequestANewOne =
      'The verification link or code has expired. Request a new one.';
  static const pleaseSignInAgainToContinue =
      'Please sign in again to continue.';
  static const yourSessionHasExpiredPleaseSignInAgain =
      'Your session has expired. Please sign in again.';
  static const tooManyAttemptsPleaseTryAgainLater =
      'Too many attempts. Please try again later.';
  static const tooManyEmailsRequestedPleaseTryAgainLater =
      'Too many emails requested. Please try again later.';
  static const tooManyVerificationMessagesRequestedPleaseTryAgainLater =
      'Too many verification messages requested. Please try again later.';
  static const theRequestTimedOutPleaseTryAgain =
      'The request timed out. Please try again.';
  static const thisRecordAlreadyExists = 'This record already exists.';
  static const thisActionCouldNotBeCompletedBecauseOfRelatedRecords =
      'This action could not be completed because of related records.';
  static const someRequiredInformationIsMissing =
      'Some required information is missing.';
  static const someProvidedInformationIsInvalid =
      'Some provided information is invalid.';
  static const someProvidedInformationHasAnInvalidFormat =
      'Some provided information has an invalid format.';
  static const youDoNotHavePermissionToPerformThisAction =
      'You do not have permission to perform this action.';
  static const theRequestedDataCouldNotBeRetrievedAsExpected =
      'The requested data could not be retrieved as expected.';
  static const unableToReachTheServicePleaseTryAgain =
      'Unable to reach the service. Check your connection and try again.';
  static const unableToCompleteAuthenticationPleaseTryAgain =
      'Unable to complete authentication. Please try again.';
  static const unableToLoadOrSaveDataPleaseTryAgain =
      'Unable to load or save data. Please try again.';
  static const unableToCompleteTheFileOperationPleaseTryAgain =
      'Unable to complete the file operation. Please try again.';
  static const unableToCompleteTheOperationPleaseTryAgain =
      'Unable to complete the operation. Please try again.';
  static const theReturnedDataCouldNotBeProcessedPleaseTryAgain =
      'The returned data could not be processed. Please try again.';
  static const anUnexpectedErrorOccurredPleaseTryAgain =
      'An unexpected error occurred. Please try again.';
  static const theRequestedItemCouldNotBeFound =
      'The requested item could not be found.';
  static const thisActionConflictsWithExistingData =
      'This action conflicts with existing data.';
  static const theSubmittedDataIsTooLarge = 'The submitted data is too large.';
  static const tooManyRequestsPleaseTryAgainLater =
      'Too many requests. Please try again later.';
  static const theServiceIsTemporarilyUnavailablePleaseTryAgainLater =
      'The service is temporarily unavailable. Please try again later.';
}
