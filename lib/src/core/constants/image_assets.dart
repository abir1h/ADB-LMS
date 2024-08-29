class ImageAssets {
  const ImageAssets._();

  //:::::::::::::::::: IMAGE SETS ::::::::::::::::::
  static String get icLogo => 'logo'.png;
  static String get emptyProfile => 'img'.png;
  static String get animEmpty => 'Animation - 1706009676891'.json;
  static String get emptyAnimation => 'empty'.json;
  static String get passwordAnimation => 'password'.json;


}

extension on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get svg => 'assets/images/icons/$this.svg';
  String get json => 'assets/images/$this.json';
}
