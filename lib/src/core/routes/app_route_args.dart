import 'dart:ui';

import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';

//
//
// class DocumentViewScreenArgs {
//   final String url;
//   DocumentViewScreenArgs({required this.url});
// }
class CourseDetailsScreenArgs {
  final CourseInfoDataEntity? data;
  CourseDetailsScreenArgs({this.data});
}