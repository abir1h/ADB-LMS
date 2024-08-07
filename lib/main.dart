import 'package:flutter/material.dart';

import 'src/core/config/notification_client.dart';
import 'src/core/di/dependency_injection.dart';
import 'src/core/utility/app_label.dart';
import 'src/feature/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await initLocalServices();
  setup();
  await App.getCurrentLanguage();
  await LocalDatabase.instance.initDatabase();
  ///Init notification
  NotificationClient.instance.preInit();
  runApp(const Application());
}
