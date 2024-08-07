import 'dart:io';

import 'file_signature.dart';

class Helper {
  Helper._();
  static Helper? _helper;
  static Helper get instance => _helper ?? (_helper = Helper._());

  static getFileExtension(List<int> headerBytes) async{
    // final bytes = await file.readAsBytes();
    final matcher = FileSignatureMatcher();
    final List<FileExtension>? matchedExtensions =
        matcher.getFileExtension(headerBytes: headerBytes);
    // Some file formats shares the same extensions, such as doc and docx
    print('Matched extensions: ${matchedExtensions.toString()}');
  }
}
