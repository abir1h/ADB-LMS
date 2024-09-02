import 'package:adb_mobile/src/feature/discussion/data/repositories/discussion_repository_imp.dart';
import 'package:adb_mobile/src/feature/discussion/domain/entities/discussion_data_entity.dart';
import 'package:adb_mobile/src/feature/discussion/domain/entities/video_dropdown_data_entity.dart';
import 'package:adb_mobile/src/feature/discussion/domain/use_cases/discussion_use_case.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/network/api_service.dart';
import '../../../course/data/data_sources/remote/course_data_source.dart';
import '../../../course/data/repositories/course_repository_imp.dart';
import '../../../course/domain/entities/course_overview_data_entity.dart';
import '../../../course/domain/use_cases/course_use_case.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/discussion_remote_data_source.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin DiscussionScreenService implements _ViewModel {
  late _ViewModel _view;

  final CourseUseCase _courseUseCase = CourseUseCase(
    courseRepository: CourseRepositoryImp(
        courseRemoteDataSource: CourseRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getCourseOverView(
      String userId, String courseId) async {
    return _courseUseCase.courseOverViewInformationUseCase(userId, courseId);
  }

  final DiscussionUseCase _discussionUseCase = DiscussionUseCase(
    discussionRepository: DiscussionRepositoryImp(
        discussionRemoteDataSource: DiscussionRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getDiscussionList(
      String userId, String courseId) async {
    return _discussionUseCase.discussionInformationUseCase(userId, courseId);
  }

  Future<ResponseEntity> getVideoDropdown(
      String userId, String courseId, String type, String topicId) async {
    return _discussionUseCase.discussionVideoDropDownInformationUseCase(
        userId, courseId, type, topicId);
  }

  ///Stream controllers

  final AppStreamController<List<DiscussionDataEntity>>
      discussionStreamController = AppStreamController();

  void loadDiscussion(String courseId) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    discussionStreamController.add(LoadingState());
    getDiscussionList(userId!, courseId).then((value) {
      print(value);
      if (value.data != null && value.data.isNotEmpty) {
        discussionStreamController
            .add(DataLoadedState<List<DiscussionDataEntity>>(value.data));
      } else if (value.data != null && value.data.isEmpty) {
        discussionStreamController
            .add(EmptyState(message: "No Discussions Found"));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  Future<List<DropDownItem>> fetchFirstDropdownItemsFromApi(
      String courseId) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);

    if (userId != null) {
      final response = await getCourseOverView(userId, courseId);

      if (response.data != null) {
        CourseOverViewDataEntity result = response.data;

        // Mapping the topics to a list of DropDownItem
        List<DropDownItem> items = result.topics.map((topic) {
          return DropDownItem(id: topic.id, value: topic.title);
        }).toList();

        return items;
      } else {
        _view.showWarning(response.message!);
      }
    }

    return [];
  }

  Future<List<DropDownItem>> fetchThirdDropdownItemsFromApi(
      String courseId, String type, String topicId) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);

    if (userId != null) {
      final response = await getVideoDropdown(userId, courseId, type, topicId);

      if (response.data != null) {
        // Mapping the topics to a list of DropDownItem
        List<VideoDropdownDataEntity> result = response.data;

        List<DropDownItem> items = result.map((topic) {
          return DropDownItem(id: topic.id, value: topic.title);
        }).toList();

        return items;
      } else {
        _view.showWarning(response.message!);
      }
    }

    return [];
  }

  ///Post Comments
  Future uploadComments(String comment, String courseId, String topicId,
      String materialId, int type, BuildContext context) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    Map<String, dynamic> data = {
      "Id": null,
      "DiscussionType": type,
      "Comment": comment,
      "CourseId": courseId,
      "TopicId": topicId,
      "MaterialId": materialId,
      "ExamId": null,
      "PrePostTestId": null,
      "MockTestId": null,
      "CourseDiscussionId": null,
      "ResourceId": null
    };

    Server.instance
        .postRequest(
            url: "${ApiCredential.postComment}?userId=$userId", postData: data)
        .then((v) {
      if (v['Status'] == 1) {
        loadDiscussion(courseId);

        Navigator.pop(context);
      }
      return v;
    });
  }
}

class DropDownItem {
  final String? id;
  final String? value;
  DropDownItem({required this.id, required this.value});
  @override
  String toString() {
    return value ?? '';
  }
}
