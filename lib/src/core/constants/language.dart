mixin Language {
  LanguageEn get en => LanguageEn.instance;
  LanguageBn get bn => LanguageBn.instance;
}

class LanguageEn {
  LanguageEn._();
  static LanguageEn? _instance;
  static LanguageEn get instance => _instance ?? (_instance = LanguageEn._());

  String appNameText = "CLMS";
  String appBarText = "LMS Home";

  String splashScreenText = "Supporting Post-COVID-19 Small-Scale Employment Creation Project (SPCSSECP)";
  String authScreenHeaderText = "About HSEP";
  String authScreenContentText =
      "CLMS is a self-contained large-scale learning management system. It includes LMS,eLibrary, eTeacher guide, social learning platform or PLC  the entire system is designed in such a way that it can play an effective role in improving the professional quality of teachers.";
  String authScreenContentText2 =
      "This system is designed only to improve the professional quality of teachers, apart from teachers it will also play an effective role in providing training to head teachers and assistant head teachers.";
  String authScreenContentText3 =
      "The main objective of the system is to improve the quality of secondary and higher secondary education in Bangladesh through the professional development of teachers.";
  String authScreenLoginText = "Login with your e-MIS ID password";
  String loginText = "Login";
  String logoutText = "Logout";
  String copyRightText = "Copyright © 2023 ";
  String copyRightText2 = "CLMS";
  String copyRightText3 = "All rights reserved";
  String copyRightText4 = "Privacy Policy";
  String copyRightText5 = "Conditions";

  String homeText = "Home";
  String coursesText = "Courses";
  String notesText = "Notes";
  String profileText = "My Profile";

  String cancelText = "Cancel";
  String exitText = "Logout";
  String logoutWarningText = "Do you want to log out?";
  String noFileFoundText = "File not Found";
  String backToHomeText = "Return to Home";
  String noInternetText = "No Internet Connection";
  String noInternetContentText = "Try Again to Regain Connection";
  String noInternetStepText = "Check Your Internet Connection";
  String pageReloadText = "Reload The Page";

  String learningManagementSystem = "Learning Management System (LMS)";
  String teachersGuide = "Instructional Guide for Teachers";
  String eLibrary = "eLibrary";
  String formativeAssessment = "Formative Assessment System";
  String socialLearningPlatform = "Professional Learning Community";

  String aboutUs = "About Us";
  String lms = "Learning Management System";
  String tutorial = "Tutorial";
  String messageText = "Message";
  String accessibilityText = "Accessibility";
  String monochromeText = "Monochrome";
  String textSizeText = "Text Size";

  String circular = "Circular";
  String circularDetails = "Circular Details";
  String referenceNumber = "Reference Number";
  // String referenceNumber = "আসন্ন বিজ্ঞপ্তির তালিকা";
  // String referenceNumber = "রেফারেন্স নম্বর";

  String profileAppBarText = "LMS My Profile";
  String userNameText = "Mynul Islam"; //"User Name";
  String phoneNumberText = "+0123456789"; //"Phone Number";
  String emailText = "mynulislam@gmail.com"; //"Email";
  String regNoText = "2016810150"; //"Reg.No";
  String currentOrganizationNameText =
      "Dhaka College"; //"Name of the working organization";
  String positionNameText = "Professor"; //"Your Title";
  String certificateText = "Certificate";
  String masterTrainerText = "Master Trainer";
  String acknowledgment = "Acknowledgment";
  String emisId = "EMIS Id: ";

  String ongoingModule = "Ongoing Module";
  String ongoingWeek = "Ongoing Week";
  String completed = "Completed";
  String ongoingCurriculum = "Ongoing Curriculum";
  String completedCurriculum = "Completed curriculum";
  String allCourse = "All Course";
  String upcomingCurriculum = "Upcoming Curriculum";
  String notification = "Notification";
  String effectivePeriod = "Effective Period";
  String noticeBoard = "Notice Board";
  String leaderboard = "Leaderboard";
  String seeAll = "See All";

  String courseText = "Course";
  String courseDetailsText = "Course Details";
  String ongoingCourseDetailsText = "Ongoing Course Details";
  String completedCourseDetailsText = "Completed Course Details";
  String aboutCourse = "About Course";
  String upcoming = "Upcoming";
  String lastViewedLesson = "Last Viewed Lesson";
  String supportingLesson = "Supporting Lesson";
  String whatWillBeInTheCourse = "What will be in the course";
  String courseContent = "Course Content";
  String courseCode = "Course Code :";
  String courseDuration = "Duration :";
  String complete = "Complete";
  String courseCompleted = "Completed";
  String willBegin = "Will Begin";
  String check = "Check";
  String see = "See";
  String join = "Join";
  String details = "Details";
  String enroll = "Enroll";
  String courseOverallProgress = "Overall Progress of the Course";
  String yourCourseProgress = "Your Progress of the Course";
  String progressLine = "Progress Line";
  String overallProgress = "Overall Progress";
  String progressOfTheWeek = "Progress of The Week";
  String weeklyProgress = "Weekly Progress";
  String classAttendance = "Class Attendance";
  String chapterDescription = "Chapter Description:";

  String takeNotes = "Take Notes";
  String transcript = "Transcript";
  String next = "Next";
  String seeMore = " See More";
  String seeLess = " See Less";

  String blendedClass = "Blended Class";
  String inPersonClass = "In-Person Class";
  String onlineClass = "Online Class";
  String classInstructions = "Class Instructions";
  String institutionName = "Institution Name";
  String classSchedule = "Class Schedule";
  String classTime = "Class Start Time";
  String classLink = "Class Link";
  String confirmInPerson = "Confirm In-Person";
  String joinClass = "Join The Class";

  String allNotes = "All Notes";
  String noteContent =
      "জীবের মধ্যে সবচেয়ে সম্পূর্ণতা মানুষের। কিন্তু সবচেয়ে অসম্পূর্ণ হয়ে সে জন্মগ্রহণ করে। বাঘ ভালুক তার জীবনযাত্রার পনেরো- আনা মূলধন নিয়ে আসে প্রকৃতির মালখানা থেকে। জীবরঙ্গভূমিতে মানুষ এসে দেখা দেয় দুই শূন্য হাতে মুঠো বেঁধে মানুষ আসবার পূর্বেই জীবসৃষ্টিযজ্ঞে প্রকৃতির ভূরিব্যয়ের পালা শেষ হয়ে এসেছে। বিপুল মাংস, কঠিন বর্ম, প্রকাণ্ড লেজ নিয়ে জলে স্থলে পৃথুল দেহের যে অমিতাচার প্রবল হয়ে উঠেছিল তাতে ধরিত্রীকে দিলে ক্লান্ত করে। প্রমাণ হল আতিশয্যের পরাভব অনিবার্য। পরীক্ষায় এটাও স্থির হয়ে গেল যে, প্রশ্রয়ের পরিমাণ যত বেশি হয় দুর্বলতার বোঝাও তত দুর্বহ হয়ে ওঠে। নূতন পর্বে প্রকৃতি যথাসম্ভব মানুষের বরাদ্দ কম করে দিয়ে নিজে রইল নেপথ্যে।        মানুষকে দেখতে হল খুব ছোটো, কিন্তু সেটা একটা কৌশল মাত্র। এবারকার জীবযাত্রার পালায় বিপুলতাকে করা হল বহুলতায় পরিণত। মহাকায় জন্তু ছিল প্রকাণ্ড একলা, মানুষ হল দূরপ্রসারিত অনেক।";

  String discussion = "Discussion";
  String discussionArea = "Discussion Area";
  String allDiscussion = "View All Discussions";
  String newDiscussion = "New Discussion";
  String detailedDiscussion = "Detailed Discussion";
  String yourOpinion = "Your Opinion";
  String discussionTitle = "Discussion Title";
  String writeHere = "Write here...";
  String publishTheDiscussion = "Publish The Discussion";
  String reportDiscussion = "Enter the reason for reporting the discussion";
  String reportComment = "Enter the reason for reporting the comment";
  String report = "Report";
  String writeYourOpinion = "Write Your Opinion";

  String getStarted = "Get Started";

  String assignment = "Assignment";
  String assignmentIns = "Assignment Instructions";
  String allInfo = "All information";
  String duration = "Duration";
  String assignmentType = "Assignment Type";
  String submissionType = "Submission Type";
  String totalMark = "Total Mark";
  String passMark = "Pass Mark";
  String assignmentInstruction =
      "Please look at the picture below and answer the following questions.";
  String answerTheFollowingQuestions = "Answer the following questions.";
  String upload = "Upload";
  String uploadTheFile = "Upload the file";
  String or = "Or";
  String submit = "Submit";
  String saveAsDraft = "Save As Draft";
  String enter = "Enter";

  String assessment = "Assessment";
  String instructions = "Assessment Instructions";
  String trueText = "True";
  String falseText = "False";
  String writeOneWordAnswer = "Write the answer in one word:";
  String dropHere = "Drop Here";
  String dragAnOption = "Drag an option";
  String courseSummary = "Course Summary";
}

class LanguageBn {
  LanguageBn._();
  static LanguageBn? _instance;
  static LanguageBn get instance => _instance ?? (_instance = LanguageBn._());

  String appNameText = "এলএমএস";
  String appBarText = "এলএমএস হোম";
  String splashScreenText = "সাপোর্টিং পোস্ট কোভিড-১৯ স্মল স্কেল এমপ্লয়মেন্ট ক্রিয়েশন প্রজেক্ট (এসপিসিএসএসইসিপি)";

  String authScreenHeaderText = "HSEP সম্পর্কে";
  String authScreenContentText =
      "সিএলএমএস একটি স্বয়ংসম্পূর্ণ বৃহৎ আকারের লার্নিং ম্যানেজমেন্ট সিস্টেম। এতে রয়েছে এলএমএস, ই লাইব্রেরী, ই টিচার গাইড, সোশ্যাল লার্নিং প্ল্যাটফর্ম অথবা পিএলসি  পুরো সিস্টেমটিকে এমনভাবে তৈরি করা হয়েছে যেন এটি শিক্ষকদের পেশাগত মান উন্নয়নের ক্ষেত্রে কার্যকর ভূমিকা রাখতে পারে ।";
  String authScreenContentText2 =
      "এই সিস্টেমটি শুধুমাত্র শিক্ষকদের পেশাগত মান উন্নয়নকে লক্ষ্য করেই তৈরি করা হয়েছে, শিক্ষকদের পাশাপাশি এটি প্রধান শিক্ষক এবং সহকারী প্রধান শিক্ষকদেরকেও ট্রেনিং প্রদানে কার্যকর ভূমিকা পালন করবে ।";
  String authScreenContentText3 =
      "সিস্টেমটির মূল উদ্দেশ্য হলো শিক্ষকদের পেশাগত মানোন্নয়নের মাধ্যমে বাংলাদেশের মাধ্যমিক ও উচ্চমাধ্যমিক শিক্ষার মান উন্নয়ন ।";
  String authScreenLoginText = "আপনার ই-এমআইএস আইডি পাসওয়ার্ড দিয়ে লগইন করুন";
  String loginText = "প্রবেশ করুন";
  String logoutText = "প্রস্থান";
  String copyRightText = "কপিরাইট © ২০২৩ ";
  String copyRightText2 = "সিএলএমএস";
  String copyRightText3 = "সমস্ত অধিকার সংরক্ষিত";
  String copyRightText4 = "গোপনীয়তা নীতি";
  String copyRightText5 = "শর্তাবলী";

  String homeText = "হোম";
  String coursesText = "কোর্সেস";
  String notesText = "নোটস";
  String profileText = "আমার প্রোফাইল";

  String cancelText = "বাতিল করুন";
  String exitText = "প্রস্থান করুন";
  String logoutWarningText = "আপনি কি লগ আউট করতে চান?";
  String noFileFoundText = "ফাইল পাওয়া যায়নি";
  String backToHomeText = "হোমে ফিরে যান";
  String noInternetText = "ইন্টারনেট সংযোগ নেই";
  String noInternetContentText = "সংযোগ ফিরে পেতে আবার চেষ্টা করুন";
  String noInternetStepText = "আপনার ইন্টারনেট সংযোগ চেক করুন";
  String pageReloadText = "পেজটি রিলোড দিন";

  String learningManagementSystem = "লার্নিং ম্যানেজমেন্ট সিস্টেম (এলএমএস)";
  String teachersGuide = "ইন্সট্রাকশনাল গাইড ফর টিচার্স";
  String eLibrary = "ই লাইব্রেরি";
  String formativeAssessment = "ফরম্যাটিভ এসেসমেন্ট সিস্টেম";
  String socialLearningPlatform = "প্রফেশনাল লার্নিং কমিউনিটি";

  String aboutUs = "আমাদের সম্পর্কে";
  String lms = "লার্নিং ম্যানেজমেন্ট সিস্টেম";
  String tutorial = "টিউটোরিয়াল";
  String messageText = "বার্তা";
  String accessibilityText = "এক্সেসিবিলিটি";
  String monochromeText = "মনোক্রোম";
  String textSizeText = "টেক্সট সাইজ";
  String circular = "বিজ্ঞপ্তি";
  String circularDetails = "বিজ্ঞপ্তির বিস্তারিত";

  String profileAppBarText = "এলএমএস আমার প্রোফাইল";
  String userNameText = "মাইনুল ইসলাম"; //"ব্যবহারকারীর নাম";
  String phoneNumberText = "+০১২৩৪৫৬৭৮৯০"; //"ফোন নম্বর";
  String emailText = "mynulislam@gmail.com"; //"ইমেইল";
  String regNoText = "২০১৬৮১০১৫০"; //"রেজিঃ নং";
  String currentOrganizationNameText = "ঢাকা কলেজ"; //"কর্মরত প্রতিষ্ঠানের নাম";
  String positionNameText = "অধ্যাপক"; //"আপনার পদবী";
  String certificateText = "সনদপত্র";
  String masterTrainerText = "মাস্টার ট্রেইনার";

  String acknowledgment = "স্বীকৃতিপত্র";
  String emisId = "ইএমআইএস আইডি: ";

  String ongoingModule = "চলমান মডিউল";
  String ongoingWeek = "চলমান সপ্তাহ";
  String completed = "সম্পন্ন";
  String ongoingCurriculum = "চলমান কোর্স";
  String completedCurriculum = "সম্পন্ন কোর্স";
  String allCourse = "সকল কোর্সসমূহ";
  String upcomingCurriculum = "আসন্ন কোর্স";
  String notification = "বিজ্ঞপ্তি";
  String effectivePeriod = "কার্যক্রম সময়কাল";
  String noticeBoard = "নোটিশবোর্ড";
  String leaderboard = "লিডারবোর্ড";
  String seeAll = "সবগুলো দেখুন";

  String courseText = "কোর্স";
  String courseDetailsText = "কোর্সের বিস্তারিত";
  String ongoingCourseDetailsText = "চলমান কোর্সের বিস্তারিত";
  String completedCourseDetailsText = "সম্পন্ন কোর্সের বিস্তারিত";
  String aboutCourse = "কোর্স সম্পর্কে";
  String upcoming = "আপকামিং";
  String lastViewedLesson = "সর্বশেষ দেখা পাঠ";
  String supportingLesson = "সহায়ক পাঠ";
  String whatWillBeInTheCourse = "কোর্সে যা থাকবে";
  String courseContent = "কোর্সের বিষয়বস্তু";
  String courseCode = "কোর্সের কোড :";
  String courseDuration = "সময়কাল :";
  String complete = "সম্পন্ন";
  String courseCompleted = "সম্পন্ন হয়েছে";
  String willBegin = "শুরু হবে";
  String check = "চেক করুন";
  String see = "দেখুন";
  String join = "জয়েন করুন";
  String details = "বিস্তারিত";
  String enroll = "এনরোল";
  String courseOverallProgress = "কোর্সের সামগ্রিক অগ্রগতি";
  String yourCourseProgress = "আপনার কোর্সের অগ্রগতি";
  String progressLine = "অগ্রগতি নির্দেশক রেখা";
  String overallProgress = "সামগ্রিক অগ্রগতি";
  String progressOfTheWeek = "সপ্তাহের অগ্রগতি";
  String weeklyProgress = "Weekly Progress";
  String classAttendance = "ক্লাসের উপস্থিতি";
  String chapterDescription = "অধ্যায়ের বিবরণ:";

  String takeNotes = "নোট নিন";
  String transcript = "প্রতিলিপি";
  String next = "পরবর্তী";
  String seeMore = " আরো দেখুন";
  String seeLess = " সংক্ষিপ্ত করুন";

  String blendedClass = "ব্লেন্ডেড ক্লাস";
  String inPersonClass = "ইন - পারসন ক্লাস";
  String onlineClass = "অনলাইন ক্লাস";
  String classInstructions = "ক্লাসের নির্দেশাবলী";
  String institutionName = "প্রতিষ্টানের নাম";
  String classSchedule = "ক্লাসের সময়সূচী";
  String classTime = "ক্লাস শুরুর সময়";
  String classLink = "ক্লাসের লিংক";
  String confirmInPerson = "কর্নফার্ম ইন পার্সন";
  String joinClass = "জয়েন অনলাইন";

  String allNotes = "সকল নোটস";
  String noteContent = "";

  String discussion = "আলোচনা";
  String discussionArea = "আলোচনা ক্ষেত্র";
  String allDiscussion = "সকল আলোচনা দেখুন";
  String newDiscussion = "নতুন আলোচনা";
  String detailedDiscussion = "বিস্তারিত আলোচনা";
  String yourOpinion = "আপনার মতামত";
  String discussionTitle = "আলোচনার শিরোনাম";
  String writeHere = "এখানে লিখুন...";
  String publishTheDiscussion = "আলোচনা প্রকাশ করুন";
  String reportDiscussion = "আলোচনাটি রিপোর্ট করার কারণ লিখুন";
  String reportComment = "মন্তব্যটি রিপোর্ট করার কারণ লিখুন";
  String report = "রিপোর্ট";
  String writeYourOpinion = "আপনার মতামত লিখুন";

  String getStarted = "শুরু করুন";

  String assignment = "অ্যাসাইনমেন্ট";
  String assignmentIns = "অ্যাসাইনমেন্টের নির্দেশাবলী";
  String allInfo = "যাবতীয় তথ্যাবলি";
  String duration = "সময়কাল";
  String assignmentType = "এসাইনমেন্ট টাইপ";
  String submissionType = "সাবমিশন টাইপ";
  String totalMark = "সর্বমোট নম্বর";
  String passMark = "পাস নম্বর";
  String assignmentInstruction =
      "অনুগ্রহ করে নিচের ছবিটি দেখুন এবং নিম্নলিখিত প্রশ্নের উত্তর দিন।";
  String answerTheFollowingQuestions = "নিচের প্রশ্নগুলোর উত্তর দিন.";
  String upload = "আপলোড";
  String uploadTheFile = "ফাইল আপলোড করুন";
  String or = "অথবা";
  String submit = "জমা দিন";
  String saveAsDraft = "সেভ এস ড্রাফট";
  String enter = "প্রবেশ করুন";

  String assessment = "মূল্যায়ন";
  String instructions = "এসেসমেন্টের নির্দেশাবলী";
  String trueText = "সত্য";
  String falseText = "মিথ্যা";
  String writeOneWordAnswer = "এক কথায় উত্তর লিখুন:";
  String dropHere = "এখানে ড্রপ করুন";
  String dragAnOption = "একটি বিকল্প টেনে আনুন";
  String courseSummary = "কোর্সের সারসংক্ষেপ";
}
