import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do/db/db_helper.dart';
import 'package:to_do/services/notification_services.dart';
import 'package:to_do/services/theme_services.dart';
import 'package:to_do/ui/pages/notification_screen.dart';
import 'package:to_do/ui/theme.dart';
import 'ui/pages/home_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  //NotifyHelper().initializeNotification();
  await DBHelper.initdb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().thememode,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
