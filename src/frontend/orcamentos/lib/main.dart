import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/controller/controller_imports.dart';
import 'package:orcamentos/app/data/provider/drift/platform/platform.dart';
import 'package:orcamentos/app/page/shared_page/splash_screen_page.dart';
import 'package:orcamentos/app/routes/app_pages.dart';
import 'package:orcamentos/app/translations/app_translation.dart';
import 'app/data/provider/drift/database/database.dart';

void main() async {
  Get.lazyPut(() => AppDatabase(Platform.createDatabaseConnection('orcamentos')));
  Get.lazyPut(() => ThemeController(), permanent: true);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.blumineBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blumineBlue),
      themeMode: await Get.find<ThemeController>().getTheme(),      
      defaultTransition: Transition.fade,
      getPages: AppPages.pages, 
      home: const SplashScreenPage(), 
      locale: AppTranslation.locale, 
      translations: AppTranslation(),
    )
  );
}

