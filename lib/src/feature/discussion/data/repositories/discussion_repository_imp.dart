import 'package:adb_mobile/src/feature/discussion/data/mapper/discussion_data_mapper.dart';
import 'package:adb_mobile/src/feature/discussion/data/mapper/video_dropdown_data_mapper.dart';
import 'package:adb_mobile/src/feature/discussion/data/models/discussion_data_model.dart';
import 'package:adb_mobile/src/feature/discussion/data/models/video_dropdown_data_model.dart';
import 'package:adb_mobile/src/feature/discussion/domain/entities/discussion_data_entity.dart';
import 'package:adb_mobile/src/feature/discussion/domain/entities/video_dropdown_data_entity.dart';
import 'package:adb_mobile/src/feature/discussion/domain/repositories/discussion_repository.dart';
import 'package:adb_mobile/src/feature/faq/domain/repositories/faq_repository.dart';

import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../data_sources/remote/discussion_remote_data_source.dart';

class DiscussionRepositoryImp extends DiscussionRepository {
  final DiscussionRemoteDataSource discussionRemoteDataSource;
  DiscussionRepositoryImp({required this.discussionRemoteDataSource});

  @override
  Future<ResponseEntity> discussionInformation(
      String userId, String courseId) async {
    ResponseModel responseModel =
        (await discussionRemoteDataSource.getDiscussion(userId, courseId));
    return ResponseModelToEntityMapper<List<DiscussionDataEntity>,
            List<DiscussionDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<DiscussionDataModel> models) =>
                List<DiscussionDataModel>.from(models)
                    .map((e) => e.toDiscussionDataEntity)
                    .toList());
  }

  @override
  Future<ResponseEntity> discussionVideoDropdownInformation(
      String userId, String courseId, String type, String topicId) async {
    ResponseModel responseModel = (await discussionRemoteDataSource
        .getVideoDropDown(userId, courseId, type, topicId));
    return ResponseModelToEntityMapper<List<VideoDropdownDataEntity>,
            List<VideoDropdownDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<VideoDropdownDataModel> models) =>
                List<VideoDropdownDataModel>.from(models)
                    .map((e) => e.toVideoDropdownDataEntity)
                    .toList());
  }
}
