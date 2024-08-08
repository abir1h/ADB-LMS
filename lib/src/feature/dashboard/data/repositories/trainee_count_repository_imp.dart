import 'package:adb_mobile/src/feature/dashboard/data/mapper/trainee_count_data_mapper.dart';
import 'package:adb_mobile/src/feature/dashboard/data/models/trainee_count_data_model.dart';
import 'package:adb_mobile/src/feature/dashboard/domain/entities/trainee_count_data_entity.dart';
import 'package:adb_mobile/src/feature/dashboard/domain/repositories/trainee_count_repository.dart';
import 'package:adb_mobile/src/feature/profile/data/data_sources/remote/user_data_source.dart';
import 'package:adb_mobile/src/feature/profile/data/mapper/user_data_mapper.dart';
import 'package:adb_mobile/src/feature/profile/domain/entities/user_data_entity.dart';
import 'package:adb_mobile/src/feature/profile/domain/repositories/profile_repository.dart';

import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../data_sources/remote/trainee_count_data_source.dart';

class TraineeCountRepositoryImp extends TraineeCountRepository {
  final TraineeCountRemoteDataSource traineeCountRemoteDataSource;
  TraineeCountRepositoryImp({required this.traineeCountRemoteDataSource});

  @override
  Future<ResponseEntity> traineeCountInformation(String userId) async {
    ResponseModel responseModel =
        (await traineeCountRemoteDataSource.traineeCountAction(userId));
    return ResponseModelToEntityMapper<TraineeCountDataEntity,
            TraineeCountDataModel>()
        .toEntityFromModel(responseModel,
            (TraineeCountDataModel model) => model.toTraineeCountDataEntity);
  }
}
