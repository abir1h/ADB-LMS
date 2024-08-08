
import 'package:adb_mobile/src/feature/profile/data/data_sources/remote/user_data_source.dart';
import 'package:adb_mobile/src/feature/profile/data/mapper/user_data_mapper.dart';
import 'package:adb_mobile/src/feature/profile/domain/entities/user_data_entity.dart';
import 'package:adb_mobile/src/feature/profile/domain/repositories/profile_repository.dart';

import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../models/user_data_model.dart';


class ProfileRepositoryImp extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImp({required this.profileRemoteDataSource});

  @override
  Future<ResponseEntity> userProfileInformation(String userId) async {
    ResponseModel responseModel =
    (await profileRemoteDataSource.userProfileInformationAction(userId));
    return ResponseModelToEntityMapper<UserDataEntity, UserDataModel>()
        .toEntityFromModel(responseModel,
            (UserDataModel model) => model.toUserDataEntity);
  }
}
