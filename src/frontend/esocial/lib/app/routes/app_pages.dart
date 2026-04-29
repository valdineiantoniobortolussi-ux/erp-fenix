import 'package:get/get.dart';
import 'package:esocial/app/page/shared_widget/shared_widget_imports.dart';
import 'package:esocial/app/routes/app_routes.dart';
import 'package:esocial/app/page/login/login_page.dart';
import 'package:esocial/app/page/shared_page/splash_screen_page.dart';
import 'package:esocial/app/bindings/bindings_imports.dart';
import 'package:esocial/app/page/shared_page/shared_page_imports.dart';
import 'package:esocial/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.esocialNaturezaJuridicaListPage, page:()=> const EsocialNaturezaJuridicaListPage(), binding: EsocialNaturezaJuridicaBindings()), 
		GetPage(name: Routes.esocialNaturezaJuridicaEditPage, page:()=> EsocialNaturezaJuridicaEditPage()),
		GetPage(name: Routes.esocialRubricaListPage, page:()=> const EsocialRubricaListPage(), binding: EsocialRubricaBindings()), 
		GetPage(name: Routes.esocialRubricaEditPage, page:()=> EsocialRubricaEditPage()),
		GetPage(name: Routes.esocialTipoAfastamentoListPage, page:()=> const EsocialTipoAfastamentoListPage(), binding: EsocialTipoAfastamentoBindings()), 
		GetPage(name: Routes.esocialTipoAfastamentoEditPage, page:()=> EsocialTipoAfastamentoEditPage()),
		GetPage(name: Routes.esocialMotivoDesligamentoListPage, page:()=> const EsocialMotivoDesligamentoListPage(), binding: EsocialMotivoDesligamentoBindings()), 
		GetPage(name: Routes.esocialMotivoDesligamentoEditPage, page:()=> EsocialMotivoDesligamentoEditPage()),
		GetPage(name: Routes.esocialClassificacaoTributListPage, page:()=> const EsocialClassificacaoTributListPage(), binding: EsocialClassificacaoTributBindings()), 
		GetPage(name: Routes.esocialClassificacaoTributEditPage, page:()=> EsocialClassificacaoTributEditPage()),
	];
}