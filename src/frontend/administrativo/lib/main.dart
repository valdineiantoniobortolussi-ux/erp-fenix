import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/provider/drift/platform/platform.dart';
import 'package:administrativo/app/page/shared_page/splash_screen_page.dart';
import 'package:administrativo/app/routes/app_pages.dart';
import 'package:administrativo/app/translations/app_translation.dart';
import 'app/data/provider/drift/database/database.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	
  Get.lazyPut(() => AppDatabase(Platform.createDatabaseConnection('administrativo')));
  final ThemeController themeController = Get.put(ThemeController(), permanent: true);
  final ThemeMode themeMode = await themeController.getTheme();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.blumineBlue, useMaterial3: false,),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blumineBlue, useMaterial3: false,),
      themeMode: themeMode,      
      defaultTransition: Transition.fade,
      getPages: AppPages.pages, 
      home: const SplashScreenPage(), 
      locale: AppTranslation.locale, 
      translations: AppTranslation(),
    )
  );
}

