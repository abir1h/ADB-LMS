import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../feature/dashboard/data/data_sources/remote/dashboard_data_source.dart';
import '../../feature/dashboard/data/repositories/dashboard_repository_imp.dart';
import '../../feature/dashboard/domain/repositories/dashboard_repository.dart';
import '../../feature/profile/data/data_sources/remote/profile_data_source.dart';
import '../../feature/profile/data/repositories/profile_repository_imp.dart';
import '../../feature/profile/domain/repositories/profile_repository.dart';
import '../../feature/authentication/data/data_sources/remote/auth_data_source.dart';
import '../../feature/authentication/data/repositories/auth_repository_imp.dart';
import '../../feature/authentication/domain/repositories/auth_repository.dart';
import '../../feature/authentication/domain/use_cases/auth_use_case.dart';
import '../config/local_storage_services.dart';
import '../network/http_client.dart';

GetIt locator = GetIt.instance;

void setup() {
  Get.lazyPut(() => AuthUseCase(authRepository: locator.get()));

  locator.registerSingleton(BaseHttpClient());
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()),
  );
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImp(
        profileRemoteDataSource: ProfileRemoteDataSourceImp()),
  );
  locator.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImp(
        dashboardRemoteDataSource: DashboardRemoteDataSourceImp()),
  );
}

initLocalServices() async {
  await Get.putAsync(() => LocalStorageServiceWithGetX.initialize());
  // await Get.putAsync(() => LocalStorageService.initialize());
}
