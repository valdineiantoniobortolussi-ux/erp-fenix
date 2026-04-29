import 'package:get/get.dart';
import 'package:ordem_servico/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ordem_servico/app/routes/app_routes.dart';
import 'package:ordem_servico/app/page/login/login_page.dart';
import 'package:ordem_servico/app/page/shared_page/splash_screen_page.dart';
import 'package:ordem_servico/app/bindings/bindings_imports.dart';
import 'package:ordem_servico/app/page/shared_page/shared_page_imports.dart';
import 'package:ordem_servico/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.osAberturaListPage, page:()=> const OsAberturaListPage(), binding: OsAberturaBindings()), 
		GetPage(name: Routes.osAberturaTabPage, page:()=> OsAberturaTabPage()),
		GetPage(name: Routes.osStatusListPage, page:()=> const OsStatusListPage(), binding: OsStatusBindings()), 
		GetPage(name: Routes.osStatusEditPage, page:()=> OsStatusEditPage()),
		GetPage(name: Routes.osEquipamentoListPage, page:()=> const OsEquipamentoListPage(), binding: OsEquipamentoBindings()), 
		GetPage(name: Routes.osEquipamentoEditPage, page:()=> OsEquipamentoEditPage()),
	];
}