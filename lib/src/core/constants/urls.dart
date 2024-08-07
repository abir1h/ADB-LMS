class ApiCredential {
  const ApiCredential._();

  static String baseUrl = "http://10.10.100.8"; // Development Server
  // static String baseUrl = "http://10.10.100.10"; // Testing Server

  static String mediaBaseUrl = "http://116.204.155.53/";

  static String eMISLink =
      "http://103.69.149.41/SSO/Account/Login?MerchantId=000010&token=obA5ijGMXHoQEiOtEYTlw34tyKVqM9pUVFcqaPNlC5e1reRojM&RETURNURL=$baseUrl/auth-service/api/auth/emis-login";
  static String getToken =
      "$baseUrl/auth-service/api/auth/emis-login";
  static String refreshToken = "/auth/dev/token/refresh";

  static String userDashboard = "/circular-service/api/mobile/dashboard";

  static String getCourse = "/circular-service/api/mobile/courses";
  static String getScript = "/circular-service/api/mobile/scripts";
  static String getBlendedClass =
      "/circular-service/api/mobile/blended-classes";
  static String getVideo = "/video-service/mobile/videos";
  static String videoActivity = "/video-service/mobile/video_activities";

  static String getCircular = "/circular-service/api/mobile/circulars";

  static String discussion = "/circular-service/api/mobile/discussion";
  static String getAllDiscussion = "/circular-service/api/mobile/discussions";
  static String getWeakWiseDiscussion =
      "/circular-service/api/web/discussion-module-wise";
  static String getWeakWiseDiscussionDetails =
      "/circular-service/api/web/discussion-module-wise-details";
  static String getDiscussion =
      "/circular-service/api/mobile/discussion-content-wise";
  static String getDiscussionComments =
      "/circular-service/api/mobile/discussion-comments/";
  static String voteDiscussion = "/circular-service/api/mobile/vote-discussion";
  static String reportDiscussion =
      "/circular-service/api/mobile/report-discussion";

  static String createComment = "/circular-service/api/mobile/comment";
  static String voteComment = "/circular-service/api/mobile/vote-comment";
  static String reportComment = "/circular-service/api/mobile/report-comment";

  static String getAssessment = "/assessment-service/mobile/assessment-details";
  static String getAssessmentQuestionType =
      "/assessment-service/admin/quiz-types";
  static String startExam = "/assessment-service/mobile/exam/start";
  static String submitExam = "/assessment-service/mobile/exam/submit";
  static String requestExam =
      "/assessment-service/mobile/exam/permission-request";

  static String getAssignment = "/assignment-service/api/mobile/assignments";
  static String createAssignment =
      "/assignment-service/api/mobile/assignment-submissions";
  static String requestAssignment =
      "/assignment-service/api/mobile/assignment-request";

  static String acceptReview =
      "/assignment-service/api/mobile/collaborative-accept-review";
  static String reviewResultSubmit =
      "/assignment-service/api/mobile/collaborative-assignment-result";

  static String getNotes = "/circular-service/api/mobile/notes";
  static String createNotes = "/circular-service/api/mobile/notes";
  static String getNotesByContent =
      "/circular-service/api/mobile/notes-by-content";
  static String contentRead = "/circular-service/api/mobile/content-read";

  static String getProfile = "/circular-service/api/mobile/profile";
  static String imageUrl = "$baseUrl/circular-service/uploads/";

  static String getCertificate = "/circular-service/api/mobile/generate-certificate";
  static String fcmUpdate = "/notification-service/api/fcm-update";
  static String fcmUpdateUser = "/user-service/trainee";
}
