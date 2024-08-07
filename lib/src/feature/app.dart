import 'package:adb_mobile/src/feature/authentication/data/data_sources/remote/auth_data_source.dart';
import 'package:adb_mobile/src/feature/authentication/data/repositories/auth_repository_imp.dart';
import 'package:adb_mobile/src/feature/authentication/domain/entities/auth_data_entity.dart';
import 'package:adb_mobile/src/feature/authentication/domain/use_cases/auth_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/routes/app_route.dart';
import '../core/constants/strings.dart';
import '../core/constants/app_theme.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with AppTheme{
  final AuthUseCase _authUseCase = AuthUseCase(
      authRepository: AuthRepositoryImp(
          authRemoteDataSource: AuthRemoteDataSourceImp()));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _test();
  }

  _test() async{
    AuthDataEntity authDataEntity = await _authUseCase.userLoginUseCase("bacbon", "123456789");
    print(authDataEntity.email);

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'LMS',
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(primary: clr.appPrimaryColorBlue),
                scaffoldBackgroundColor: clr.scaffoldBackgroundColor,
                dividerColor: Colors.transparent,
                fontFamily: StringData.fontFamilyRoboto,
                canvasColor: Colors.transparent),
            // initialRoute: AppRoutes.splash,
            // getPages: AppPages.pages,
            navigatorKey: AppRoute.navigatorKey,
            onGenerateRoute: RouteGenerator.generate,
          );
        });
  }
}
