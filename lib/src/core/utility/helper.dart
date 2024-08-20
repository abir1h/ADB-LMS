import 'file_signature.dart';

class Helper {
  Helper._();
  static Helper? _helper;
  static Helper get instance => _helper ?? (_helper = Helper._());

  static getFileExtension(List<int> headerBytes) async {
    // final bytes = await file.readAsBytes();
    final matcher = FileSignatureMatcher();
    final List<FileExtension>? matchedExtensions =
        matcher.getFileExtension(headerBytes: headerBytes);
    // Some file formats shares the same extensions, such as doc and docx
    print('Matched extensions: ${matchedExtensions.toString()}');
  }

  static String secondToMin(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = secTime % 60;

    String parsedTime =
        "${getParsedTime(min.toString())} : ${getParsedTime(sec.toString())}";

    return parsedTime;
  }
}
