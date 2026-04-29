import 'package:get/get.dart';
import 'package:gondolas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:gondolas/app/routes/app_routes.dart';
import 'package:gondolas/app/page/login/login_page.dart';
import 'package:gondolas/app/page/shared_page/splash_screen_page.dart';
import 'package:gondolas/app/bindings/bindings_imports.dart';
import 'package:gondolas/app/page/shared_page/shared_page_imports.dart';
import 'package:gondolas/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.gondolaCaixaListPage, page:()=> const GondolaCaixaListPage(), binding: GondolaCaixaBindings()), 
		GetPage(name: Routes.gondolaCaixaTabPage, page:()=> GondolaCaixaTabPage()),
		GetPage(name: Routes.gondolaRuaListPage, page:()=> const GondolaRuaListPage(), binding: GondolaRuaBindings()), 
		GetPage(name: Routes.gondolaRuaEditPage, page:()=> GondolaRuaEditPage()),
		GetPage(name: Routes.gondolaEstanteListPage, page:()=> const GondolaEstanteListPage(), binding: GondolaEstanteBindings()), 
		GetPage(name: Routes.gondolaEstanteEditPage, page:()=> GondolaEstanteEditPage()),
	];
}