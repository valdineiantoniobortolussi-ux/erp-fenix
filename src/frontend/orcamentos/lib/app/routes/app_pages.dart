import 'package:get/get.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:orcamentos/app/routes/app_routes.dart';
import 'package:orcamentos/app/page/login/login_page.dart';
import 'package:orcamentos/app/page/shared_page/splash_screen_page.dart';
import 'package:orcamentos/app/bindings/bindings_imports.dart';
import 'package:orcamentos/app/page/shared_page/shared_page_imports.dart';
import 'package:orcamentos/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.orcamentoFluxoCaixaListPage, page:()=> const OrcamentoFluxoCaixaListPage(), binding: OrcamentoFluxoCaixaBindings()), 
		GetPage(name: Routes.orcamentoFluxoCaixaTabPage, page:()=> OrcamentoFluxoCaixaTabPage()),
		GetPage(name: Routes.orcamentoEmpresarialListPage, page:()=> const OrcamentoEmpresarialListPage(), binding: OrcamentoEmpresarialBindings()), 
		GetPage(name: Routes.orcamentoEmpresarialTabPage, page:()=> OrcamentoEmpresarialTabPage()),
		GetPage(name: Routes.orcamentoFluxoCaixaPeriodoListPage, page:()=> const OrcamentoFluxoCaixaPeriodoListPage(), binding: OrcamentoFluxoCaixaPeriodoBindings()), 
		GetPage(name: Routes.orcamentoFluxoCaixaPeriodoEditPage, page:()=> OrcamentoFluxoCaixaPeriodoEditPage()),
		GetPage(name: Routes.orcamentoPeriodoListPage, page:()=> const OrcamentoPeriodoListPage(), binding: OrcamentoPeriodoBindings()), 
		GetPage(name: Routes.orcamentoPeriodoEditPage, page:()=> OrcamentoPeriodoEditPage()),
	];
}