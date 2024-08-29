import 'package:adb_mobile/src/feature/certificate/data/data_sources/remote/certificate_remote_data_source.dart';
import 'package:adb_mobile/src/feature/certificate/data/mapper/certificate_list_data_mapper.dart';
import 'package:adb_mobile/src/feature/certificate/data/models/certificate_list_data_model.dart';
import 'package:adb_mobile/src/feature/certificate/domain/entities/certificate_list_data_entity.dart';
import 'package:adb_mobile/src/feature/certificate/domain/repositories/certificate_repository.dart';

import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';

class CertificateRepositoryImp extends CertificateRepository {
  final CertificateRemoteDataSource certificateRemoteDataSource;
  CertificateRepositoryImp({required this.certificateRemoteDataSource});

  @override
  Future<ResponseEntity> certificateInformation(String userId) async {
    ResponseModel responseModel =
        (await certificateRemoteDataSource.getCertificateAction(userId));
    return ResponseModelToEntityMapper<CertificateListDataEntity,
            CertificateListDataModel>()
        .toEntityFromModel(
            responseModel,
            (CertificateListDataModel model) =>
                model.toCertificateListDataEntity);
  }
}
