class ImageAssets {
  const ImageAssets._();

  //:::::::::::::::::: IMAGE SETS ::::::::::::::::::
  static String get imgEmptyProfile => 'user_profile'.png;
  static String get imgProfile => 'profile'.jpg;
  static String get icLogo => 'logo'.png;
  static String get imgPlaceholder => 'placeholder'.png;

  static String get imgModule1 => 'Illustrator_Module_1'.png;
  static String get imgModule2 => 'Illustrator_Module_2'.png;
  static String get imgModule3 => 'Illustrator_Module_3'.png;
  static String get imgModule4 => 'Illustrator_Module_4'.png;
  static String get imgAssignment => 'assignment'.png;

  static String get imgQuestion => 'question_image'.png;
  static String get imgOption1 => 'option_1'.png;
  static String get imgOption2 => 'option_2'.png;
  static String get imgOption3 => 'option_3'.png;

  static String get leaderImage => 'leadarImage'.png;
  static String get imgWebinar => 'webinar'.png;
  static String get imgPdf => 'pdf'.png;
  static String get imgDoc => 'doc'.png;

  static String get imgTraineeCard1 => 'trainee_card'.svg;
  static String get imgTraineeCard2 => 'trainee_card2'.svg;
  static String get imgTraineeCard3 => 'trainee_card3'.svg;
  static String get imgTraineeCard4 => 'trainee_card4'.svg;
  static String get imgRunningCourse => 'running_course'.svg;

  static String get icBook => 'book'.svg;
  static String get icSocialLearning => 'social_learning'.svg;
  static String get icLockOpenRight => 'lock_open_right'.svg;
  static String get icDownload => 'download'.svg;
  static String get icEdit => 'edit'.svg;
  static String get icEditorChoice => 'editor_choice'.svg;
  static String get icEditSquare => 'edit_square'.svg;
  static String get icAlarm => 'alarm'.svg;
  static String get icDictionary => 'dictionary'.svg;
  static String get icWebinar => 'webinar'.svg;
  static String get icBarChart => 'bar_chart'.svg;
  static String get icTwoPager => 'two_pager'.svg;
  static String get icCircular => 'brand_awareness'.svg;
  static String get masterTrainerIc => 'master_trainer'.svg;
  static String get calendarMonth => 'calendar_month'.svg;
  static String get trophyIcon => 'trophy'.svg;
  static String get shieldPerson => 'shield_person'.svg;

  static String get animEmpty => 'Animation - 1706009676891'.json;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get svg => 'assets/images/icons/$this.svg';
  String get json => 'assets/$this.json';
}
