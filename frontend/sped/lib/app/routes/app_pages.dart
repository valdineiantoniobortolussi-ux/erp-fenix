import 'package:get/get.dart';
import 'package:sped/app/page/shared_widget/shared_widget_imports.dart';
import 'package:sped/app/routes/app_routes.dart';
import 'package:sped/app/page/login/login_page.dart';
import 'package:sped/app/page/shared_page/splash_screen_page.dart';
import 'package:sped/app/bindings/bindings_imports.dart';
import 'package:sped/app/page/shared_page/shared_page_imports.dart';
import 'package:sped/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.spedContabilListPage, page:()=> const SpedContabilListPage(), binding: SpedContabilBindings()), 
		GetPage(name: Routes.spedContabilEditPage, page:()=> SpedContabilEditPage()),
		GetPage(name: Routes.spedFiscalListPage, page:()=> const SpedFiscalListPage(), binding: SpedFiscalBindings()), 
		GetPage(name: Routes.spedFiscalEditPage, page:()=> SpedFiscalEditPage()),
		GetPage(name: Routes.sintegraListPage, page:()=> const SintegraListPage(), binding: SintegraBindings()), 
		GetPage(name: Routes.sintegraEditPage, page:()=> SintegraEditPage()),
		GetPage(name: Routes.efdContribuicoesListPage, page:()=> const EfdContribuicoesListPage(), binding: EfdContribuicoesBindings()), 
		GetPage(name: Routes.efdContribuicoesEditPage, page:()=> EfdContribuicoesEditPage()),
		GetPage(name: Routes.efdReinfListPage, page:()=> const EfdReinfListPage(), binding: EfdReinfBindings()), 
		GetPage(name: Routes.efdReinfEditPage, page:()=> EfdReinfEditPage()),
	];
}