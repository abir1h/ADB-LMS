import 'dart:io';

import 'src/core/service/local_database_service.dart';
import 'package:flutter/material.dart';

import 'src/core/utility/app_label.dart';
import 'src/feature/app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await initLocalServices();
  // setup();
  await App.getCurrentLanguage();
  await LocalDatabase.instance.initDatabase();

  ///Init notification
  // NotificationClient.instance.preInit();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const Application());
}
