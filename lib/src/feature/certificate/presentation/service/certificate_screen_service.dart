import 'dart:convert';

import 'package:adb_mobile/src/core/routes/app_route.dart';
import 'package:adb_mobile/src/core/routes/app_route_args.dart';
import 'package:adb_mobile/src/feature/certificate/data/data_sources/remote/certificate_remote_data_source.dart';
import 'package:adb_mobile/src/feature/certificate/data/repositories/certificate_repository_imp.dart';
import 'package:adb_mobile/src/feature/certificate/domain/use_cases/certificate_use_case.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/network/api_service.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../profile/data/data_sources/remote/user_data_source.dart';
import '../../../profile/data/repositories/profile_repository_imp.dart';
import '../../../profile/domain/entities/user_data_entity.dart';
import '../../../profile/domain/use_cases/profile_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/certificate_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin CertificateListScreenService implements _ViewModel {
  late _ViewModel _view;
  final CertificateUseCase _certificateUseCase = CertificateUseCase(
    certificateRepository: CertificateRepositoryImp(
        certificateRemoteDataSource: CertificateRemoteDataSourceImp()),
  );
  final UserUseCase _profileUseCase = UserUseCase(
    userRepository: ProfileRepositoryImp(
        profileRemoteDataSource: ProfileRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getProfileInformation(String userId) async {
    return _profileUseCase.userProfileInformationUseCase(userId);
  }

  Future<ResponseEntity> getCertificateList(String userId) async {
    return _certificateUseCase.certificateInformationUseCase(userId);
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  ///Service configurations
  @override
  void initState() {
    _view = this;
    _loadCertificates();
    _loadProfileData();
  }

  ///Stream controllers

  final AppStreamController<List<CertificateDataEntity>>
      certificateStreamController = AppStreamController();

  final AppStreamController<UserDataEntity> profileDataStreamController =
      AppStreamController();

  ///Load Profile data
  void _loadProfileData() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    print(userId);
    profileDataStreamController.add(LoadingState());
    getProfileInformation(userId!).then((value) {
      print(value);
      if (value.data != null) {
        firstName.text = value.data.firstName;
        lastName.text = value.data.lastName;
        profileDataStreamController
            .add(DataLoadedState<UserDataEntity>(value.data));
      } else if (value.data.isEmpty) {
        profileDataStreamController.add(EmptyState(message: 'No Data Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void _loadCertificates() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    certificateStreamController.add(LoadingState());
    getCertificateList(userId!).then((value) {
      print(value);
      if (value.data != null) {
        certificateStreamController
            .add(DataLoadedState<List<CertificateDataEntity>>(value.data.data));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///DownloadCertificate
  downloadCertificate(String courseId, BuildContext context) async {
    CustomToasty.of(context).lockUI();

    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.downloadCertificate}$courseId?userId=$userId");
    print(responseJson['Data']);
    if (responseJson['Data'] != null) {
      CustomToasty.of(context).releaseUI();
      Navigator.pushNamed(context, AppRoute.certificateViewScreen,
          arguments: CertificateViewScreenArgs(data: responseJson['Data']));
    } else {
      CustomToasty.of(context).releaseUI();
      _view.showWarning(responseJson["Message"]);
    }
  }

  ///Name change
  changeName(BuildContext context) async {
    CustomToasty.of(context).lockUI();
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);

    Map<String, String> fields = {
      "Model": jsonEncode({
        "FirstName": firstName.text.trim(),
        "LastName": lastName.text.trim()
      })
    };

    Server.instance
        .postRequestFormData(
            url: "${ApiCredential.updateProfile}?userId=$userId",
            fields: fields)
        .then((value) {
      if (value['data'] == null && value['Status'] == 1) {
        _loadProfileData();
        CustomToasty.of(context).showSuccess(value['Message']);

        CustomToasty.of(context).releaseUI();
        Navigator.pop(context);
      } else {
        CustomToasty.of(context).showSuccess(value['Message']);
        Navigator.pop(context);

        CustomToasty.of(context).releaseUI();
      }
    });
  }
}
