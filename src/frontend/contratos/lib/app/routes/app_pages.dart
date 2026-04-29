import 'package:get/get.dart';
import 'package:contratos/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contratos/app/routes/app_routes.dart';
import 'package:contratos/app/page/login/login_page.dart';
import 'package:contratos/app/page/shared_page/splash_screen_page.dart';
import 'package:contratos/app/bindings/bindings_imports.dart';
import 'package:contratos/app/page/shared_page/shared_page_imports.dart';
import 'package:contratos/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.contratoListPage, page:()=> const ContratoListPage(), binding: ContratoBindings()), 
		GetPage(name: Routes.contratoTabPage, page:()=> ContratoTabPage()),
		GetPage(name: Routes.tipoContratoListPage, page:()=> const TipoContratoListPage(), binding: TipoContratoBindings()), 
		GetPage(name: Routes.tipoContratoEditPage, page:()=> TipoContratoEditPage()),
		GetPage(name: Routes.contratoTipoServicoListPage, page:()=> const ContratoTipoServicoListPage(), binding: ContratoTipoServicoBindings()), 
		GetPage(name: Routes.contratoTipoServicoEditPage, page:()=> ContratoTipoServicoEditPage()),
		GetPage(name: Routes.contratoSolicitacaoServicoListPage, page:()=> const ContratoSolicitacaoServicoListPage(), binding: ContratoSolicitacaoServicoBindings()), 
		GetPage(name: Routes.contratoSolicitacaoServicoEditPage, page:()=> ContratoSolicitacaoServicoEditPage()),
		GetPage(name: Routes.contratoTemplateListPage, page:()=> const ContratoTemplateListPage(), binding: ContratoTemplateBindings()), 
		GetPage(name: Routes.contratoTemplateEditPage, page:()=> ContratoTemplateEditPage()),
	];
}