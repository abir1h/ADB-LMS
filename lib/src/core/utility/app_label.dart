import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/common_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common_widgets/custom_toasty.dart';
import 'color_tools.dart';

///App Language
enum AppLanguage { english, bangla }

String label({required String e, required String b}) {
  return App.currentAppLanguage == AppLanguage.english
      ? (e.isNotEmpty ? e : b)
      : (b.isNotEmpty ? b : e);
}

class App {
  App._();
  static App? _app;
  static App get instance => _app ?? (_app = App._());

  //App Language
  static AppLanguage _appLanguage = AppLanguage.bangla;
  static AppLanguage get currentAppLanguage => _appLanguage;

  ///Set current language
  static Future<bool> setAppLanguage(int index) async {
    Completer<bool> completer = Completer();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("appLanguage", index).then((x) async {
        _appLanguage = index == 1 ? AppLanguage.english : AppLanguage.bangla;
        completer.complete(true);
        await getCurrentLanguage();
      }).catchError((x) {
        completer.completeError("Not storred !");
      });
    } catch (e) {
      completer.completeError("Not storred !");
    }
    return completer.future;
  }

  ///Get current language
  static Future<AppLanguage> getCurrentLanguage() async {
    Completer<AppLanguage> completer = Completer();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? index = prefs.getInt("appLanguage");
      AppLanguage language =
          index == 1 ? AppLanguage.english : AppLanguage.bangla;
      _appLanguage = language;
      completer.complete(language);
    } catch (e) {
      //print(e);
      completer.complete(AppLanguage.bangla);
    }
    return completer.future;
  }
}

String replaceEnglishNumberWithBengali(String inputString) {
  Map<String, String> numberMap = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  String result = '';
  for (int i = 0; i < inputString.length; i++) {
    String char = inputString[i];
    String replacement = numberMap[char] ?? char;
    result += replacement;
  }

  return result;
}

String timeAgoToBengali(String timeAgo) {
  // Define a map to store the mapping of English words to Bangla words
  final Map<String, String> banglaMap = {
    'january': 'জানুয়ারি',
    'february': 'ফেব্রুয়ারি',
    'march': 'মার্চ',
    'april': 'এপ্রিল',
    'may': 'মে',
    'june': 'জুন',
    'july': 'জুলাই',
    'august': 'আগস্ট',
    'september': 'সেপ্টেম্বর',
    'october': 'অক্টোবর',
    'november': 'নভেম্বর',
    'december': 'ডিসেম্বর',
    'seconds': 'সেকেন্ড',
    'minute': 'মিনিট',
    'minutes': 'মিনিট',
    'hour': 'ঘন্টা',
    'hours': 'ঘন্টা',
    'day': 'দিন',
    'days': 'দিন',
    'week': 'সপ্তাহ',
    'weeks': 'সপ্তাহ',
    'month': 'মাস',
    'months': 'মাস',
    'year': 'বছর',
    'years': 'বছর',
    'ago': 'আগে',
    'moment': 'কিছুক্ষণ',
    'about': 'প্রায়',
    'an': 'এক',
    'am': 'এম',
    'pm': 'পিএম',
    'a': '',
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  // Split the timeAgo string into words
  List<String> words = timeAgo.split(' ');

  // Replace English words with Bangla words using the map
  String banglaText = words.map((word) {
    // Check if the word is a number
    if (int.tryParse(word) != null) {
      // Convert each digit separately
      return word.split('').map((char) => banglaMap[char] ?? char).join('');
    }
    if (word == 'AM') {
      print(word);
    }
    return banglaMap[word.toLowerCase()] ?? word;
  }).join(' ');
  print(banglaText);

  return banglaText;
}

String nightDayConvertor(String timeAgo, String timstamp) {
  // Define a map to store the mapping of English words to Bangla words
  DateTime time = DateTime.parse(timstamp).toUtc();
  int hours = time.hour;

  String greeting = "";

  if (hours >= 1 && hours <= 12) {
    greeting = "সকাল";
  } else if (hours > 12 && hours <= 17) {
    greeting = "অপরাহ্ণ";
  } else if (hours > 17 && hours <= 20) {
    greeting = "সন্ধ্যা";
  } else if (hours > 20 && hours <= 24) {
    greeting = "রাত";
  }
  final Map<String, String> banglaMap = {
    'january': 'জানুয়ারি $greeting',
    'february': 'ফেব্রুয়ারি $greeting',
    'march': 'মার্চ $greeting',
    'april': 'এপ্রিল $greeting',
    'may': 'মে $greeting',
    'june': 'জুন $greeting',
    'july': 'জুলাই $greeting',
    'august': 'আগস্ট $greeting',
    'september': 'সেপ্টেম্বর $greeting',
    'october': 'অক্টোবর $greeting',
    'november': 'নভেম্বর $greeting',
    'december': 'ডিসেম্বর $greeting',
    'seconds': 'সেকেন্ড',
    'minute': 'মিনিট',
    'minutes': 'মিনিট',
    'hour': 'ঘন্টা',
    'hours': 'ঘন্টা',
    'day': 'দিন',
    'days': 'দিন',
    'week': 'সপ্তাহ',
    'weeks': 'সপ্তাহ',
    'month': 'মাস',
    'months': 'মাস',
    'year': 'বছর',
    'years': 'বছর',
    'ago': 'আগে',
    'moment': 'কিছুক্ষণ',
    'about': 'প্রায়',
    'an': 'এক',
    'am': '',
    'pm': '',
    'a': '',
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  // Split the timeAgo string into words
  List<String> words = timeAgo.split(' ');

  String banglaText = words.map((word) {
    if (int.tryParse(word) != null) {
      return word.split('').map((char) => banglaMap[char] ?? char).join('');
    }

    return banglaMap[word.toLowerCase()] ?? word;
  }).join(' ');

  return banglaText;
}

Widget stringToWidget({required String input,TextStyle? textStyle}) {
  // Check if the input string contains HTML tags
  bool containsHtmlTags(String text) {
    final htmlTagsRegExp = RegExp(r'<[^>]*>');
    return htmlTagsRegExp.hasMatch(text);
  }

  if (containsHtmlTags(input)) {
    // Return HtmlWidget if the string contains HTML tags
    return HtmlWidget(
      input,textStyle: textStyle??TextStyle(
      color: HexColor("646464"),
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
      // Optionally, you can customize the HtmlWidget properties here
    );
  } else {
    // Return Text widget if the string does not contain HTML tags
    return Text(
      input,
      style: textStyle??TextStyle(
        color: HexColor("646464"),
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      // Optionally, you can customize the Text widget properties here
    );
  }
}

bool areSameDateFast(DateTime a) {
  DateTime now = DateTime.now();
  return a.day == now.day && a.month == now.month && a.year == now.year;
}

// Delta convertStringToDelta(String text) {
//   Delta delta = Delta();
//   delta.insert('$text\n');
//   return delta;
// }

Future<void> downloadFiles(
    {required String fileUrl,
    required String filename,
    required BuildContext context, bool? openFile}) async {
  if (Platform.isIOS) {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Proceed with the file download
      downloadFile(url: fileUrl, filename: filename, context: context, openFile: openFile);
    } else {
      // Permission denied
      CustomToasty.of(context).showSuccess('Storage permission denied');
    }
  } else {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (deviceInfo.version.sdkInt > 32) {
      var status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        // Proceed with the file download
        downloadFile(url: fileUrl, filename: filename, context: context, openFile: openFile);
      } else {
        // Permission denied

        CustomToasty.of(context).showSuccess('Storage permission denied');
      }
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        // Proceed with the file download
        downloadFile(url: fileUrl, filename: filename, context: context, openFile: openFile);
      } else {
        // Permission denied
        CustomToasty.of(context).showSuccess('Storage permission denied');
      }
    }
  }
  // var status = await Permission.storage.request();
  // if (status.isGranted) {
  //   // Proceed with the file download
  //   downloadFile(url: fileUrl, filename: filename, context: context);
  // } else {
  //   // Permission denied
  //   CustomToasty.of(context).showSuccess('Storage permission denied');
  // }
}

Future<void> downloadFile({
  required String url,
  required String filename,
  required BuildContext context,
  bool? openFile
}) async {
  try {
    HttpClient client = HttpClient();
    List<int> downloadData = [];

    Directory? downloadDirectory;

    if (Platform.isIOS) {
      downloadDirectory = await getApplicationDocumentsDirectory();
    } else {
      downloadDirectory = Directory('/storage/emulated/0/Download');
      if (!await downloadDirectory.exists()) {
        downloadDirectory = (await getExternalStorageDirectory());
      }
    }

    String filePathName = "${downloadDirectory?.path}/$filename";
    File savedFile = File(filePathName);
    bool fileExists = await savedFile.exists();

    if (fileExists && context.mounted) {
      if(openFile != null && openFile){
        OpenFilex.open(savedFile.path);
      }else{
        CustomToasty.of(context).showWarning("File already downloaded");
      }
    } else {
      client.getUrl(Uri.parse(ApiCredential.mediaBaseUrl + url)).then(
        (HttpClientRequest request) {
          CustomToasty.of(context).showSuccess("Downloading file...");
          return request.close();
        },
      ).then(
        (HttpClientResponse response) {
          response.listen((d) => downloadData.addAll(d), onDone: () {
            savedFile.writeAsBytes(downloadData);
            CustomToasty.of(context)
                .showSuccess("File downloaded successfully");
            if(openFile != null && openFile){
              OpenFilex.open(savedFile.path);
            }
          });
        },
      );
    }
  } catch (error) {
    CustomToasty.of(context).showSuccess("Some error occurred -> $error");
  }
}
