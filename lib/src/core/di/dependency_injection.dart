// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
//
// import '../network/http_client.dart';
//
// GetIt locator = GetIt.instance;
//
// void setup() {
//   Get.lazyPut(() => AuthUseCase(authRepository: locator.get()));
//
//   locator.registerSingleton(BaseHttpClient());
//   locator.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()),
//   );
//   locator.registerLazySingleton<ProfileRepository>(
//     () => ProfileRepositoryImp(
//         profileRemoteDataSource: ProfileRemoteDataSourceImp()),
//   );
//   locator.registerLazySingleton<DashboardRepository>(
//     () => DashboardRepositoryImp(
//         dashboardRemoteDataSource: DashboardRemoteDataSourceImp()),
//   );
// }
//
// initLocalServices() async {
//   await Get.putAsync(() => LocalStorageServiceWithGetX.initialize());
//   // await Get.putAsync(() => LocalStorageService.initialize());
// }
