import 'package:get/get.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';
import 'package:tributacao/app/routes/app_routes.dart';
import 'package:tributacao/app/page/login/login_page.dart';
import 'package:tributacao/app/page/shared_page/splash_screen_page.dart';
import 'package:tributacao/app/bindings/bindings_imports.dart';
import 'package:tributacao/app/page/shared_page/shared_page_imports.dart';
import 'package:tributacao/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
		GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.tributIcmsCustomCabListPage, page:()=> const TributIcmsCustomCabListPage(), binding: TributIcmsCustomCabBindings()), 
		GetPage(name: Routes.tributIcmsCustomCabTabPage, page:()=> TributIcmsCustomCabTabPage()),
		GetPage(name: Routes.tributConfiguraOfGtListPage, page:()=> const TributConfiguraOfGtListPage(), binding: TributConfiguraOfGtBindings()), 
		GetPage(name: Routes.tributConfiguraOfGtTabPage, page:()=> TributConfiguraOfGtTabPage()),
		GetPage(name: Routes.tributGrupoTributarioListPage, page:()=> const TributGrupoTributarioListPage(), binding: TributGrupoTributarioBindings()), 
		GetPage(name: Routes.tributGrupoTributarioEditPage, page:()=> TributGrupoTributarioEditPage()),
		GetPage(name: Routes.tributOperacaoFiscalListPage, page:()=> const TributOperacaoFiscalListPage(), binding: TributOperacaoFiscalBindings()), 
		GetPage(name: Routes.tributOperacaoFiscalEditPage, page:()=> TributOperacaoFiscalEditPage()),
		GetPage(name: Routes.tributIssListPage, page:()=> const TributIssListPage(), binding: TributIssBindings()), 
		GetPage(name: Routes.tributIssEditPage, page:()=> TributIssEditPage()),
	];
}