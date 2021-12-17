import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'app/common/resource/_index.dart';
import 'app/repository/local/database.dart';
import 'app/routes/app_pages.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();

  // Shared Pref
  await GetStorage.init();

  // Dependency
  await _injectDependency();
  logI('All Dependency is ready...');

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((value) => runApp(MyApp()));
  logI('App is ready ...');
}

Future<void> _injectDependency() async {
  // Services are injected only when needed .
  // Get.lazyPut<HttpService>(() => HttpService());
  Get.put<MyDatabase>(MyDatabase(), permanent: true);
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.theme(),
      darkTheme: AppThemes.darktheme(),
      themeMode: AppThemes().init(),
      // locale: AppTranslations.locale,
      // fallbackLocale: AppTranslations.fallbackLocale,
      // translations: AppTranslations(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
