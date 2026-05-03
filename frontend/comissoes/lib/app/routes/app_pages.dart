import 'package:get/get.dart';
import 'package:comissoes/app/page/shared_widget/shared_widget_imports.dart';
import 'package:comissoes/app/routes/app_routes.dart';
import 'package:comissoes/app/page/login/login_page.dart';
import 'package:comissoes/app/page/shared_page/splash_screen_page.dart';
import 'package:comissoes/app/bindings/bindings_imports.dart';
import 'package:comissoes/app/page/shared_page/shared_page_imports.dart';
import 'package:comissoes/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.comissaoPerfilListPage, page:()=> const ComissaoPerfilListPage(), binding: ComissaoPerfilBindings()), 
		GetPage(name: Routes.comissaoPerfilEditPage, page:()=> ComissaoPerfilEditPage()),
		GetPage(name: Routes.comissaoObjetivoListPage, page:()=> const ComissaoObjetivoListPage(), binding: ComissaoObjetivoBindings()), 
		GetPage(name: Routes.comissaoObjetivoEditPage, page:()=> ComissaoObjetivoEditPage()),
	];
}