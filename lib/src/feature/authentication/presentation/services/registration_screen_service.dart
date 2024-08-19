
import '../../../discussion/presentation/service/discussion_screen_service.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/auth_data_source.dart';
import '../../data/repositories/auth_repository_imp.dart';
import '../../domain/entities/district_info_data_entity.dart';
import '../../domain/use_cases/auth_use_case.dart';

abstract class _ViewModel {
  void onSubmit();
  void onClose();
}

mixin RegistrationScreenService implements _ViewModel {
  late _ViewModel _view;
  List<DropDownItem> districtItems = [];
  DropDownItem? selectedDistrictItem;

  final AuthUseCase _authUseCase = AuthUseCase(
      authRepository:
          AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()));

  Future<ResponseEntity> getDistrictDropdown() async {
    return _authUseCase.getDistrictDropdownUSeCase();
  }

  Future<ResponseEntity> getInstituteDropdown(
      String userId, String courseId, String type, String topicId) async {
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
}
