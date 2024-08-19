import 'package:adb_mobile/src/feature/authentication/data/mapper/district_dropdown_data_mapper.dart';
import 'package:adb_mobile/src/feature/authentication/data/mapper/district_info_data_mapper.dart';
import 'package:adb_mobile/src/feature/authentication/data/mapper/institute_data_mapper.dart';
import 'package:adb_mobile/src/feature/authentication/data/mapper/institute_list_data_mapper.dart';
import 'package:adb_mobile/src/feature/authentication/data/models/district_dropdown_data_model.dart';
import 'package:adb_mobile/src/feature/authentication/data/models/district_info_data_model.dart';
import 'package:adb_mobile/src/feature/authentication/data/models/institute_data_model.dart';
import 'package:adb_mobile/src/feature/authentication/data/models/institute_list_data_model.dart';
import 'package:adb_mobile/src/feature/authentication/domain/entities/district_dropdown_data_entity.dart';
import 'package:adb_mobile/src/feature/authentication/domain/entities/district_info_data_entity.dart';
import 'package:adb_mobile/src/feature/authentication/domain/entities/institute_data_entity.dart';
import 'package:adb_mobile/src/feature/authentication/domain/entities/institute_list_data_entity.dart';

import '../../../course/domain/entities/course_list_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../mapper/auth_data_mapper.dart';
import '../models/auth_data_model.dart';
import '../../domain/entities/auth_data_entity.dart';
import '../data_sources/remote/auth_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp({required this.authRemoteDataSource});

  @override
  Future<AuthDataEntity> userLogin(String username, String password) async {
    AuthDataModel authDataModel =
        (await authRemoteDataSource.userLoginAction(username, password));
    return authDataModel.toAuthDataEntity;
  }

  @override
  Future<ResponseEntity> getDistrictDropdown() async {
    ResponseModel responseModel =
        (await authRemoteDataSource.getDistrictDropdownAction());
    return ResponseModelToEntityMapper<List<DistrictInfoDataEntity>,
            List<DistrictInfoDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<DistrictInfoDataModel> models) =>
                List<DistrictInfoDataModel>.from(models)
                    .map((e) => e.toDistrictInfoDataEntity)
                    .toList());
  }

  @override
  Future<ResponseEntity> getInstituteDropdown() async {
    ResponseModel responseModel =
    (await authRemoteDataSource.getInstituteDropdownAction());
    return ResponseModelToEntityMapper<List<InstituteDataEntity>,
        List<InstituteDataModel>>()
        .toEntityFromModel(
        responseModel,
            (List<InstituteDataModel> models) =>
            List<InstituteDataModel>.from(models)
                .map((e) => e.toInstituteDataEntity)
                .toList());
  }
}
