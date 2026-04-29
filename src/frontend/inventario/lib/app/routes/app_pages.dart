import 'package:get/get.dart';
import 'package:inventario/app/page/shared_widget/shared_widget_imports.dart';
import 'package:inventario/app/routes/app_routes.dart';
import 'package:inventario/app/page/login/login_page.dart';
import 'package:inventario/app/page/shared_page/splash_screen_page.dart';
import 'package:inventario/app/bindings/bindings_imports.dart';
import 'package:inventario/app/page/shared_page/shared_page_imports.dart';
import 'package:inventario/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.inventarioContagemCabListPage, page:()=> const InventarioContagemCabListPage(), binding: InventarioContagemCabBindings()), 
		GetPage(name: Routes.inventarioContagemCabTabPage, page:()=> InventarioContagemCabTabPage()),
		GetPage(name: Routes.inventarioAjusteCabListPage, page:()=> const InventarioAjusteCabListPage(), binding: InventarioAjusteCabBindings()), 
		GetPage(name: Routes.inventarioAjusteCabTabPage, page:()=> InventarioAjusteCabTabPage()),
	];
}