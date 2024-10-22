import 'dart:convert';

import 'package:adb_mobile/src/core/common_widgets/custom_toasty.dart';
import 'package:adb_mobile/src/core/routes/app_route.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/network/api_service.dart';
import '../../../discussion/presentation/service/discussion_screen_service.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/auth_data_source.dart';
import '../../data/repositories/auth_repository_imp.dart';
import '../../domain/entities/district_info_data_entity.dart';
import '../../domain/entities/institute_data_entity.dart';
import '../../domain/use_cases/auth_use_case.dart';

abstract class _ViewModel {
  void onSubmit();
  void onClose();
  void showSuccess(String message);
  void showWarning(String message);
}

mixin RegistrationScreenService implements _ViewModel {
  late _ViewModel _view;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  List<DropDownItem> districtItems = [];
  List<DropDownItem> genderItems = [
    DropDownItem(id: "Male", value: "পুরুষ"),
    DropDownItem(id: "Female", value: "মহিলা"),
    DropDownItem(id: "Other", value: "অন্যান্য"),
  ]; List<DropDownItem> loanItems = [
    DropDownItem(id: "true", value: "হ্যাঁ"),
    DropDownItem(id: "false", value: "না"),
  ];
  List<DropDownItem> institutionItems = [];

  DropDownItem? selectedDistrictItem;
  DropDownItem? selectedGenderItem;
  DropDownItem? selectedInstitutionItem;
  DropDownItem? selectedLoanItem;


  bool? gender;

  final AuthUseCase _authUseCase = AuthUseCase(
      authRepository:
          AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()));

  Future<ResponseEntity> getDistrictDropdown() async {
    return _authUseCase.getDistrictDropdownUSeCase();
  }

  Future<ResponseEntity> getInstituteDropdown() async {
    return _authUseCase.getInstituteDropdownUseCase();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
  }

  Future<List<DropDownItem>> fetchDistrictDropdown() async {
    final response = await getDistrictDropdown();

    if (response.data != null) {
      List<DistrictInfoDataEntity> result = response.data;
      List<DropDownItem> items = result.map((element) {
        return DropDownItem(id: element.id, value: element.name);
      }).toList();

      return items;
    } else {
      return [];
    }
  }

  Future<List<DropDownItem>> fetchInstitutionDropDown() async {
    final response = await getInstituteDropdown();

    if (response.data != null) {
      List<InstituteDataEntity> result = response.data;
      List<DropDownItem> items = result.map((element) {
        return DropDownItem(id: element.id, value: element.name);
      }).toList();

      return items;
    } else {
      return [];
    }
  }
  bool isCamelCase(String input) {
    final camelCaseRegExp = RegExp(r'^[a-z]+([A-Z][a-z]*)*$');
    return camelCaseRegExp.hasMatch(input);
  }

  ///userRegistration
  signUP(BuildContext context) async {
    CustomToasty.of(context).lockUI();
    Map<String, String> fields = {
      "Model": jsonEncode({
        "UserName": userName.text.trim(),
        "FirstName": firstName.text.trim(),
        "LastName": lastName.text.trim(),
        "Email": email.text.isNotEmpty?email.text.trim():null,
        "PhoneNumber": phone.text.trim(),
        "Address": address.text.isNotEmpty?address.text.trim():null,
        "DistrictId": selectedDistrictItem!.id!,
        "Password": password.text.trim(),
        "Gender": selectedGenderItem!.id!,
        "LoanReceived": true,
        "FinancialInstituteId": selectedInstitutionItem!.id!
      })
    };

    Server.instance
        .postRequestFormData(
            url: "${ApiCredential.signUp}?userId=null", fields: fields)
        .then((v) {
      if (v['data'] == null && v['Status'] == 1) {
        _view.showSuccess("Registered Successfully");
        CustomToasty.of(context).releaseUI();
        Navigator.pushNamed(context, AppRoute.landingScreen);

      } else {
        _view.showWarning(v['Message']);
        CustomToasty.of(context).releaseUI();

      }
    });
  }
}
