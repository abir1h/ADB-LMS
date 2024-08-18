class ApiCredential {
  const ApiCredential._();

  static String baseUrl =
      "https://bbadb.bacbonltd.net/core/api"; // Development Server
  static String mediaBaseUrl =
      "https://bbadb.bacbonltd.net/core"; // Development Server

  static String login = "/account/trainee/login";
  static String getProfile = "/trainee/get-profile";
  static String uploadPhoto = "/account/update-photo";
  static String getTraineeCount = "/dashboard/get-count-for-trainee";
  static String getDashboardCourses = "/course/get-my-courses/";
  static String getCourse = "/course/get-my-courses";
  static String getCourseOverview = "/course/get-course-overview";
  static String getFaq = "/course/get-faqs";
  static String getDiscussion = "/course/get-course-discussions/";
  static String getVideoDropdown = "/course/topic-contents/dropdown-list";
  static String postComment = "/course/discussion-save";
  static String getCertificates = "/exam/get-trainee-certificates";
  static String downloadCertificate = "/course/download-training-certificate/";
  static String updateProfile = "/trainee/update-trainee-profile";
  static String changePassword = "/account/change-password";
}
